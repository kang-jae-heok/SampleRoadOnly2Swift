//
//  ComWebViewController.m
//  paran
//
//  Created by kcn on 2021/11/15.
//  Copyright © 2021 CNKANG. All rights reserved.
//

#import "ComWebViewController.h"
#import "Common.h"
#import "COMController.h"

@interface ComWebViewController ()

@end

@implementation ComWebViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)close {

    [self.navigationController popViewControllerAnimated:YES];
}

- (id)initWithUrl:(NSString *)url {
    self.initialUrl = url;

    return self;
}

- (id)initWithDic:(NSMutableDictionary *)dic {
    self.initialDic = dic;
    NSString *SERVER_URL = [[NSUserDefaults standardUserDefaults] valueForKey:@"SERVER_URL"];
    if ([[self.initialDic valueForKey:@"NAVI"] hasPrefix:@"CERT"]) {
        NSURL *rUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",SERVER_URL,@"payments/cert.html"]];
        self.initialUrl = [rUrl absoluteString];
    }else {

    }

    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    screenBounds = [[UIScreen mainScreen] bounds];
    [self.view setBackgroundColor:[UIColor whiteColor]];
   
    self.topView = [[UIView alloc] init];
    if (![self.initialUrl containsString:@"typeform"]) {
        CGFloat topH = [Common topHeight];
        [self.topView setFrame:CGRectMake(0, 0, screenBounds.size.width, topH)];
        [self.view addSubview:self.topView];
        
        CGFloat margin = 17.0;
        CGFloat btnSize = 50.0;
        UIButton *closeBtn = [[UIButton alloc] initWithFrame:CGRectMake(margin, self.topView.frame.size.height - (btnSize+margin/2), btnSize, btnSize)];
        closeBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [closeBtn setImage:[UIImage imageNamed:@"back_btn"] forState:UIControlStateNormal];
        [closeBtn addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
        [self.topView addSubview:closeBtn];
        
        CGSize titSize = CGSizeMake(200.0, 50.0);
        UILabel *tit = [[UILabel alloc] initWithFrame:CGRectMake(screenBounds.size.width / 2 - titSize.width / 2, self.topView.frame.size.height - (titSize.height+margin/2), titSize.width, titSize.height)];
        [tit setText:@""];
        [tit setFont:[Common kFontWithSize:@"Bold" :16.0]];
        [tit setTextAlignment:NSTextAlignmentCenter];
        [tit setTextColor:[UIColor blackColor]];
        [self.topView addSubview:tit];
    }
    

   
    
    config = [[WKWebViewConfiguration alloc]init];
    jsctrl = [[WKUserContentController alloc]init];
    
    // 자바스크립트 -> ios에 사용될 핸들러 이름을 추가해줍니다.
    // 본 글에서는 핸들러 및 프로토콜을 ioscall로 통일합니다.
    [jsctrl addScriptMessageHandler:self name:@"callBackHandler"];
    // WkWebView의 configuration에 스크립트에 대한 설정을 정해줍니다.
    [config setUserContentController:jsctrl];

    CGFloat orgY = self.topView.frame.origin.y+self.topView.frame.size.height;
    
    [[WKWebsiteDataStore defaultDataStore] fetchDataRecordsOfTypes:WKWebsiteDataStore.allWebsiteDataTypes completionHandler:^(NSArray<WKWebsiteDataRecord *> * _Nonnull records) {
        [[WKWebsiteDataStore defaultDataStore] removeDataOfTypes:WKWebsiteDataStore.allWebsiteDataTypes forDataRecords:records completionHandler:^{
            NSLog(@"CACHE_CLEARED_MSG");
        }];
    }];
    
    self.wkWebView = [[WKWebView alloc] initWithFrame:CGRectMake(0, orgY, screenBounds.size.width, screenBounds.size.height - orgY) configuration:config];
    // 웹뷰의 딜리게이트들을 새로 초기화해줍니다.
    [self.wkWebView setUIDelegate:self];
    [self.wkWebView setNavigationDelegate:self];
    
    [self.wkWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.initialUrl]]];
    [self.view addSubview:self.wkWebView];
    
    NSLog(@"initialUrl : %@",self.initialUrl);
}

- (void)userContentController:(WKUserContentController *)userContentController
        didReceiveScriptMessage:(WKScriptMessage *)message {
    NSLog(@"message : %@",message.body);
    if ([[[message body] allKeys] count] > 0) {

        [[NSUserDefaults standardUserDefaults] setObject:[message.body valueForKey:@"jibunAddress"] forKey:@"address1"];
        [[NSUserDefaults standardUserDefaults] setObject:[message.body valueForKey:@"roadAddress"] forKey:@"address2"];
        [[NSUserDefaults standardUserDefaults] setObject:[message.body valueForKey:@"zonecode"] forKey:@"postcd"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [self close];
    }
}
 
#pragma mark - JS -> ios Method
 
- (void) mockup_method:(NSDictionary *)params{
    // 스크립트에서 webkit.messageHandlers.ioscall.postMessage 함수를 실행할 경우
    // 이 함수가 실행됩니다.
    NSLog(@"mockup method called ! value = [%@]" , [params objectForKey:@"value"]);
}

#pragma mark - WKNavigationDelegate Methods
/// ページ遷移前にアクセスを許可
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    
    NSLog(@"decidePolicyForNavigationAction URL：%@", navigationAction.request.URL.absoluteString);
    decisionHandler(WKNavigationActionPolicyAllow);
    
    if(navigationAction.navigationType == WKNavigationTypeOther || navigationAction.navigationType == WKNavigationTypeLinkActivated){
        NSArray *arr = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"LSApplicationQueriesSchemes"];
        for (NSString *scheme in arr) {
            if ([navigationAction.request.URL.absoluteString rangeOfString:scheme].location != NSNotFound){
            [[UIApplication sharedApplication] openURL:navigationAction.request.URL];
                //구매 카운트
                NSRange range;
                range = [navigationAction.request.URL.absoluteString rangeOfString:@"instagram"];
                if (range.location == NSNotFound) {
                   
                }
                
            }
        }
        
    }
    
    NSLog(@"decidePolicyForNavigationAction URL：%@", navigationAction.request.URL.absoluteString);

    //인증결과 url
    NSString *str = @"https://service.iamport.kr/inicis_unified_certificates/result/";
    if ([[self.initialDic valueForKey:@"NAVI"] isEqualToString:@"CERT"]&&[navigationAction.request.URL.absoluteString containsString:str]) {
        
        NSString *cert_result1 = [navigationAction.request.URL.absoluteString stringByReplacingOccurrencesOfString:str withString:@""];
        NSArray *arr = [cert_result1 componentsSeparatedByString:@"/"];
        self.impId = [arr firstObject];
        [[NSUserDefaults standardUserDefaults] setObject:self.impId forKey:@"impId"];
        [[NSUserDefaults standardUserDefaults] synchronize];
//        NSLog(@"CERT uid  :  %@",self.impId);
        [self close];
    }
    

}

- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler
{
    [Common alert:message];
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    
}

- (void)callJS:(NSString *)scriptStr {
    [self.wkWebView evaluateJavaScript:scriptStr completionHandler:nil];
}

@end
