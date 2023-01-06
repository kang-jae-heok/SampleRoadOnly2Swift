//
//  ComWebViewController.h
//  paran
//
//  Created by kcn on 2021/11/15.
//  Copyright © 2021 CNKANG. All rights reserved.
//

#import <UIKit/UIKit.h>
@import WebKit;

NS_ASSUME_NONNULL_BEGIN

@interface ComWebViewController : UIViewController<WKUIDelegate, WKNavigationDelegate, WKScriptMessageHandler,UIScrollViewDelegate>{
    CGRect screenBounds;
    WKWebViewConfiguration *config;
    WKUserContentController *jsctrl;
}


@property (retain, nonatomic) IBOutlet NSDictionary *initialDic;
@property (retain, nonatomic) IBOutlet NSString *initialUrl;
- (id)initWithDic:(NSMutableDictionary *)dic;
- (id)initWithUrl:(NSString *)url;

@property (nonatomic) CGFloat lastContentOffset;

//@property (retain, nonatomic) IBOutlet WKWebView *webView;
@property (retain, nonatomic) IBOutlet UIView *topView;
@property (retain, nonatomic) IBOutlet WKWebView* wkWebView;
@property (retain, nonatomic) IBOutlet NSString *impId;

@end

NS_ASSUME_NONNULL_END
