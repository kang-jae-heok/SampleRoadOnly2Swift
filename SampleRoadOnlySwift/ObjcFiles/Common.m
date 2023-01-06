//
//  Common.m
//  egg
//
//  Created by CNKANG on 2020/12/05.
//  Copyright © 2020 CNKANG. All rights reserved.
//

#import "Common.h"
#import "sampleroad-swift.h"
#import <AVFoundation/AVFoundation.h>
#import "COMController.h"
#import <AudioToolbox/AudioToolbox.h>

#define TIME_DATE_INTERVAL_FOR_DAY 86400
#define APP_ID @"1619444212"

@implementation Common

+ (Common *)sharedInstance {
    static dispatch_once_t once;
    static Common *sharedMyClass;
    dispatch_once(&once, ^ {
        sharedMyClass = [[self alloc] init];
    });
    return sharedMyClass;
}

+ (CGFloat)ratioVal {
    return [[UIScreen mainScreen] bounds].size.width / 390.0;
}


+ (CGFloat)topHeight {
    CGFloat ratioVal = [[UIScreen mainScreen] bounds].size.width / 390.0;
    if ([Common detectIphoneX]) {
        return [[UIScreen mainScreen] bounds].size.width/3.8;
    }else {
        return ([[UIScreen mainScreen] bounds].size.width/4)*ratioVal;
    }
    
}

+ (CGFloat)bottomHeight {
    CGFloat ratioVal = [[UIScreen mainScreen] bounds].size.width / 390.0;
    if ([Common detectIphoneX]) {
        return 94.0;
    }else {
        return 94.0*ratioVal;
    }
}

+ (UIColor *)pointColor1 {
    return [Common colorWithHexString:@"97C5E9"];
}

+ (UIColor *)pointColor2 {
    return [Common colorWithHexString:@"06942b"];
}

+ (UIColor *)blueColor {
    return [Common colorWithHexString:@"007AFF"];
}

+ (UIColor *)lightGray {
    return [Common colorWithHexString:@"e6e6e6"];
}

+ (UIColor *)lightGray2 {
    return [Common colorWithHexString:@"b1b1b1"];
}

+ (UIColor *)darkGray {
    return [Common colorWithHexString:@"6f6f6f"];
}

+ (UIColor *)blackColor {
    return [Common colorWithHexString:@"272727"];
}

+ (UIFont *)kFontWithSize:(NSString *)type :(CGFloat)fontSize {
    //11,15,30
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    CGFloat val = screenBounds.size.width / 390.0;
    fontSize *= val;
    
    NSString *fontW = [type uppercaseString];
    if ([fontW isEqualToString:@"BOLD"]) {
        return [UIFont fontWithName:@"AppleSDGothicNeo-Bold" size:fontSize];
    }else if ([fontW isEqualToString:@"EXTRABOLD"]) {
        return [UIFont fontWithName:@"AppleSDGothicNeo-ExtraBold" size:fontSize];
    }else if ([fontW isEqualToString:@"SEMIBOLD"]) {
        return [UIFont fontWithName:@"AppleSDGothicNeo-SemiBold" size:fontSize];
    }else if ([fontW isEqualToString:@"MEDIUM"]) {
        return [UIFont fontWithName:@"AppleSDGothicNeo-Medium" size:fontSize];
    }else if ([fontW isEqualToString:@"LIGHT"]) {
        return [UIFont fontWithName:@"AppleSDGothicNeo-Light" size:fontSize];
    }else {
        return [UIFont fontWithName:@"AppleSDGothicNeo-Regular" size:fontSize];
    }
    
}

+ (UIFont *)eFontWithSize:(CGFloat)fontSize {
    //13,20,40,90
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    CGFloat val = screenBounds.size.width / 390.0;
    fontSize *= val;
    return [UIFont fontWithName:@"AppleSDGothicNeo-Bold" size:fontSize];
}

+ (BOOL)detectIphoneX {
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        CGSize screenSize = [[UIScreen mainScreen] bounds].size;
        if (screenSize.height == 812.0f
            ||screenSize.height == 844.0f
            ||screenSize.height == 896.0f
            ||screenSize.height == 926.0f) {
            NSLog(@"iPhone X");
            return YES;
        }else {
            return NO;
        }
        
    }else {
        return NO;
    }
    
}

+ (CGFloat)iphoneXmargin {
    return 44.0;
}

+ (NSString *)getLocalizableString:(NSString *)key {
    return [NSString stringWithFormat:NSLocalizedString(key,nil)];
}

+ (UIColor *)colorWithHexString:(NSString *)stringToConvert
{
    NSString *noHashString = [stringToConvert stringByReplacingOccurrencesOfString:@"#" withString:@""]; // remove the #
    NSScanner *scanner = [NSScanner scannerWithString:noHashString];
    [scanner setCharactersToBeSkipped:[NSCharacterSet symbolCharacterSet]]; // remove + and $

    unsigned hex;
    if (![scanner scanHexInt:&hex]) return nil;
    int r = (hex >> 16) & 0xFF;
    int g = (hex >> 8) & 0xFF;
    int b = (hex) & 0xFF;

    return [UIColor colorWithRed:r / 255.0f green:g / 255.0f blue:b / 255.0f alpha:1.0f];
}

+ (void)alert:(NSString*)str {

    NSString *yes = @"확인";
    
    UIAlertController * alert = [UIAlertController
                    alertControllerWithTitle:@""
                                     message:str
                              preferredStyle:UIAlertControllerStyleAlert];



    UIAlertAction* yesButton = [UIAlertAction
                        actionWithTitle:yes
                                  style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action) {
                                    //Handle your yes please button action here
                                }];

    [alert addAction:yesButton];
    [[UIView appearance] setTintColor:[Common pointColor1]];

    [[self topMostController] presentViewController:alert animated:YES completion:nil];
    
}

+ (UIViewController*) topMostController
{
    UIViewController *topController = [UIApplication sharedApplication].keyWindow.rootViewController;

    while (topController.presentedViewController) {
        topController = topController.presentedViewController;
    }

    return topController;
}

+ (UITextView *)settingTxtView:(UITextView *)txtView {
    CGFloat lineVal = 2.4;
    CGFloat kernVal = 0.0;
    [txtView setTextAlignment:NSTextAlignmentLeft];
    [txtView setTextContainerInset:UIEdgeInsetsZero];
    txtView.textContainer.lineFragmentPadding = 0;
    [txtView setEditable:NO];
    [txtView setSelectable:NO];
    [txtView setScrollEnabled:NO];
    [txtView setUserInteractionEnabled:NO];
    [txtView setBackgroundColor:[UIColor clearColor]];
    
    
    NSMutableParagraphStyle *txtParagraphStyle = [[NSMutableParagraphStyle  alloc] init];
    txtParagraphStyle.lineSpacing = lineVal;
    txtParagraphStyle.alignment = NSTextAlignmentLeft;
    txtParagraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:txtView.text
                                                                            attributes: @{ NSParagraphStyleAttributeName : txtParagraphStyle,
                                                                                           NSFontAttributeName : txtView.font,
                                                                                           NSForegroundColorAttributeName : txtView.textColor}];
    [str addAttribute:NSKernAttributeName
                          value:[NSNumber numberWithFloat:kernVal]
                          range:NSMakeRange(0, [str length])];
    
    txtView.attributedText = str;
    
    return txtView;
}

+ (UITextView *)settingCenterTxtView:(UITextView *)txtView {
    CGFloat lineVal = 2.5;
    CGFloat kernVal = 0.0;
    [txtView setTextAlignment:NSTextAlignmentCenter];
    [txtView setTextContainerInset:UIEdgeInsetsZero];
    txtView.textContainer.lineFragmentPadding = 0;
    [txtView setEditable:NO];
    [txtView setSelectable:NO];
    [txtView setScrollEnabled:NO];
    [txtView setUserInteractionEnabled:NO];
    [txtView setBackgroundColor:[UIColor clearColor]];
    
    
    NSMutableParagraphStyle *txtParagraphStyle = [[NSMutableParagraphStyle  alloc] init];
    txtParagraphStyle.lineSpacing = lineVal;
    txtParagraphStyle.alignment = NSTextAlignmentCenter;
    txtParagraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:txtView.text
                                                                            attributes: @{ NSParagraphStyleAttributeName : txtParagraphStyle,
                                                                                           NSFontAttributeName : txtView.font,
                                                                                           NSForegroundColorAttributeName : txtView.textColor}];
    [str addAttribute:NSKernAttributeName
                          value:[NSNumber numberWithFloat:kernVal]
                          range:NSMakeRange(0, [str length])];
    
    txtView.attributedText = str;
    
    return txtView;
}



+ (CGRect)getTxtViewSize:(UITextView *)txtView {
    CGFloat fixedWidth = txtView.frame.size.width;
    CGSize newSize = [txtView sizeThatFits:CGSizeMake(fixedWidth, MAXFLOAT)];
    CGRect newFrame = txtView.frame;
    newFrame.size = CGSizeMake(fmaxf(newSize.width, fixedWidth), newSize.height);
    
    return newFrame;
}


+ (BOOL)checkValidateString:(NSString *)string {
    
    if (!string) {
        return YES;
    }
    
    const char *_char = [string cStringUsingEncoding:NSUTF8StringEncoding];
        int isBackSpace = strcmp(_char, "\b");
        // 백스페이스 값 -8
        if (isBackSpace == -8) {
            NSLog(@"Backspace was pressed (-8)");
            return YES;
        }else {
//            NSString *ptn = @"^[\\sㄱ-ㅎㅏ-ㅣa-zA-Z0-9가-힣.,<>?/'\"~*&(){}|_`:;!@#$%^*+=\\-\\[\\]\\\\ㆍ]*$";
            NSString *ptn = @"^[\\sㄱ-ㅎㅏ-ㅣa-zA-Z0-9가-힣()]";
            NSRange checkRange = [string rangeOfString:ptn options:NSRegularExpressionSearch];
            
            if (checkRange.length == 0) { // 특수문자
                return NO;
            } else {
                return YES;
            }
        }
    
}


+ (void)vibrate:(int)length {

}

+ (void)safariOpenURL:(NSString *)URL
{
    
    NSURL *pUrl = [NSURL URLWithString:URL];
    if (@available(iOS 10.0, *)) {
        [[UIApplication sharedApplication] openURL:pUrl options:@{UIApplicationOpenURLOptionUniversalLinksOnly : @NO} completionHandler:^(BOOL success){

         }];
    } else {
        [[UIApplication sharedApplication] openURL:pUrl];
    }
}

+ (UIView *)nodataView:(CGRect)rect :(NSString *)msg {
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, rect.size.height)];
    [bgView setBackgroundColor:[UIColor whiteColor]];
    
    CGFloat imgSize = 80.0;
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(bgView.frame.size.width/2 - imgSize/2, bgView.frame.size.height/2 - imgSize/2-60.0, imgSize, imgSize)];
    [imgView setContentMode:UIViewContentModeScaleAspectFit];
    [imgView setImage:[UIImage imageNamed:@"180"]];
    [bgView addSubview:imgView];
    
    UITextView *desc = [[UITextView alloc] initWithFrame:CGRectMake(0, imgView.frame.origin.y+imgView.frame.size.height+12.0, bgView.frame.size.width, 60.0)];

    [desc setFont:[Common kFontWithSize:@"SEMIBOLD" :18.0]];
    [desc setText:msg];

    CGFloat fixedWidth = bgView.frame.size.width;
    CGSize newSize = [desc sizeThatFits:CGSizeMake(fixedWidth, MAXFLOAT)];
    
    [desc setFrame:CGRectMake(desc.frame.origin.x, desc.frame.origin.y, desc.frame.size.width, newSize.height)];
    
    [desc setTextColor:[Common darkGray]];
    desc = [Common settingCenterTxtView:desc];
    
    NSMutableParagraphStyle *txtParagraphStyle = [[NSMutableParagraphStyle  alloc] init];
    txtParagraphStyle.lineSpacing = 3.3;
    txtParagraphStyle.alignment = NSTextAlignmentCenter;
    txtParagraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:desc.text
                                                                            attributes: @{ NSParagraphStyleAttributeName : txtParagraphStyle,
                                                                                           NSFontAttributeName : desc.font,
                                                                                           NSForegroundColorAttributeName : desc.textColor}];
    
    desc.attributedText = str;
    [bgView addSubview:desc];
    
    return bgView;
}

+ (void)makeShadowView:(UIView *)view {
    view.layer.shadowColor = [[[Common blackColor] colorWithAlphaComponent:0.25] CGColor];
    view.layer.borderColor = Common.lightGray.CGColor;
    view.layer.borderWidth = 1.0;
    view.layer.masksToBounds = NO;
}

+ (void)makeShadowViewShort:(UIView *)view {
    view.layer.shadowColor = [[[Common blackColor] colorWithAlphaComponent:0.25] CGColor];
    view.layer.borderColor = Common.lightGray.CGColor;
    view.layer.borderWidth = 1.0;
    view.layer.masksToBounds = NO;
}

+ (NSString *)settingWon:(int)val {
    int tPrice = 0;
    tPrice = val;
    NSString *totalStr = [NSNumberFormatter localizedStringFromNumber:[NSNumber numberWithInt:tPrice] numberStyle:NSNumberFormatterDecimalStyle];
    return [NSString stringWithFormat:@"%@원",totalStr];
}

+ (void)customAlert1:(NSString *)tit :(NSString *)str {
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    CGFloat ratioVal = Common.ratioVal;
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenBounds.size.width, screenBounds.size.height)];
    [bgView setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.7]];
    bgView.tag = 11;
    
    BOOL isAddView = NO;
    for (UIScene *scene in UIApplication.sharedApplication.connectedScenes) {
        if ([scene.delegate conformsToProtocol:@protocol(UIWindowSceneDelegate)]) {
            UIWindow *window = [(id<UIWindowSceneDelegate>)scene.delegate window];
            if (!isAddView) {
                isAddView = YES;
                [window addSubview:bgView];
            }
        }
    }
    [[[[UIApplication sharedApplication] delegate] window] addSubview:bgView];
    
    CGFloat notiW = screenBounds.size.width *0.8;
    CGFloat notiH = notiW/1.6;
    UIView *notiView = [[UIView alloc] initWithFrame:CGRectMake(screenBounds.size.width/2 - notiW/2, screenBounds.size.height/2 - notiH/2, notiW, notiH)];
    [notiView setBackgroundColor:[UIColor whiteColor]];
    [bgView addSubview:notiView];
    
    CGFloat btnH = notiH/3.5;
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, notiH-btnH, notiW, btnH)];
    [btn.titleLabel setFont:[Common kFontWithSize:@"Bold" :13.0]];
    [btn setTitleColor:[Common pointColor1] forState:UIControlStateNormal];
    [btn setTitle:@"확인" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(closeCustomAlert1) forControlEvents:UIControlEventTouchUpInside];
    [notiView addSubview:btn];
    
    UIView *ud = [[UIView alloc] initWithFrame:CGRectMake(0, btn.frame.origin.y, notiW, 2.0)];
    [ud setBackgroundColor:[Common lightGray]];
    [notiView addSubview:ud];
    
    UIView *conView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, notiW, notiH-btnH)];
    [notiView addSubview:conView];
    
    CGFloat tH = 16.0;
    CGFloat tdMargin = 12.0;
    CGFloat dH = 36.0;
    CGFloat conH = (tH+tdMargin+dH);
    CGFloat tOrgY = conView.frame.size.height/2 - conH/2;
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, tOrgY, notiW, tH)];
    [title setFont:[Common kFontWithSize:@"Bold" :tH]];
    [title setTextColor:[Common pointColor1]];
    [title setTextAlignment:NSTextAlignmentCenter];
    [title setText:tit];
    [conView addSubview:title];
    
    
    CGFloat dMargin = 36.0*ratioVal;
    UITextView *desc = [[UITextView alloc] initWithFrame:CGRectMake(dMargin, title.frame.origin.y+title.frame.size.height+tdMargin, notiW - (dMargin*2), dH)];
    [desc setFont:[Common kFontWithSize:@"Bold" :13.0]];
    [desc setTextColor:[Common lightGray2]];
    [desc setText:str];
    [Common settingCenterTxtView:desc];
    
    CGRect dSize = [Common getTxtViewSize:desc];
    NSLog(@"notiview size  :  %f",conView.frame.size.height);
    NSLog(@"d size  :  %f",dSize.size.height);
    [conView addSubview:desc];
    
    
}

+ (void)closeCustomAlert1 {
    [Common vibrate:1];

    BOOL isRemove = NO;
    for (UIScene *scene in UIApplication.sharedApplication.connectedScenes) {
        if ([scene.delegate conformsToProtocol:@protocol(UIWindowSceneDelegate)]) {
            UIWindow *window = [(id<UIWindowSceneDelegate>)scene.delegate window];
            if (window&&!isRemove) {
                
                for (UIView *view in [window subviews]) {
                    if (view.tag == 11) {
                        isRemove = YES;
                        [view removeFromSuperview];
                    }
                }
            }
        }
    }
}


+ (void)customAlert2:(NSAttributedString *)str :(NSString *)yes :(NSString *)no :(id)sender :(SEL)selector {
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    CGFloat ratioVal = Common.ratioVal;
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenBounds.size.width, screenBounds.size.height)];
    [bgView setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.7]];
    bgView.tag = 11;
    BOOL isAddView = NO;
    for (UIScene *scene in UIApplication.sharedApplication.connectedScenes) {
        if ([scene.delegate conformsToProtocol:@protocol(UIWindowSceneDelegate)]) {
            UIWindow *window = [(id<UIWindowSceneDelegate>)scene.delegate window];
            if (!isAddView) {
                isAddView = YES;
                [window addSubview:bgView];
            }
        }
    }
//    [[[[UIApplication sharedApplication] delegate] window] addSubview:bgView];
    
    CGFloat notiW = screenBounds.size.width *0.8;
    CGFloat notiH = notiW/1.8;
    UIView *notiView = [[UIView alloc] initWithFrame:CGRectMake(screenBounds.size.width/2 - notiW/2, screenBounds.size.height/2 - notiH/2, notiW, notiH)];
    [notiView setBackgroundColor:[UIColor whiteColor]];
    [bgView addSubview:notiView];
    
    CGFloat btnH = notiH/3.5;
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, notiH-btnH, notiW/2, btnH)];
    [btn.titleLabel setFont:[Common kFontWithSize:@"Bold" :13.0]];
    [btn setTitleColor:[Common pointColor1] forState:UIControlStateNormal];
    [btn setTitle:yes forState:UIControlStateNormal];
    [btn addTarget:sender action:selector forControlEvents:UIControlEventTouchUpInside];
    [notiView addSubview:btn];
    
    UIButton *btn2 = [[UIButton alloc] initWithFrame:CGRectMake(btn.frame.origin.x+btn.frame.size.width, notiH-btnH, notiW/2, btnH)];
    [btn2.titleLabel setFont:[Common kFontWithSize:@"Bold" :13.0]];
    [btn2 setTitleColor:[Common lightGray2] forState:UIControlStateNormal];
    [btn2 setTitle:no forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(closeCustomAlert2) forControlEvents:UIControlEventTouchUpInside];
    [notiView addSubview:btn2];
    
    UIView *ud = [[UIView alloc] initWithFrame:CGRectMake(0, btn.frame.origin.y, notiW, 2.0)];
    [ud setBackgroundColor:[Common lightGray]];
    [notiView addSubview:ud];
    
    UIView *ud2 = [[UIView alloc] initWithFrame:CGRectMake(notiW/2, btn.frame.origin.y, 2.0, btn.frame.size.height)];
    [ud2 setBackgroundColor:[Common lightGray]];
    [notiView addSubview:ud2];
    
    UIView *conView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, notiW, notiH-btnH)];
    [notiView addSubview:conView];
    
    CGFloat tdMargin = 12.0;
    CGFloat dH = 36.0;
    CGFloat conH = (tdMargin+dH);

    CGFloat dMargin = 36.0*ratioVal;
    UITextView *desc = [[UITextView alloc] initWithFrame:CGRectMake(dMargin, 0, notiW - (dMargin*2), dH)];
    [desc setFont:[Common kFontWithSize:@"Bold" :13.0]];
    [desc setTextColor:[Common lightGray2]];
    [Common settingCenterTxtView:desc];
    CGRect newSize = [Common getTxtViewSize:desc];
    [desc setFrame:CGRectMake(desc.frame.origin.x, conView.frame.size.height/2 - newSize.size.height/2, desc.frame.size.width, newSize.size.height)];
    [desc setAttributedText:str];
    
    [conView addSubview:desc];
    
    
}

+ (void)closeCustomAlert2 {
    [Common vibrate:1];
//    SceneDelegate *appDelegate = (SceneDelegate*)[[UIApplication sharedApplication] delegate];
    BOOL isRemove = NO;
    for (UIScene *scene in UIApplication.sharedApplication.connectedScenes) {
        if ([scene.delegate conformsToProtocol:@protocol(UIWindowSceneDelegate)]) {
            UIWindow *window = [(id<UIWindowSceneDelegate>)scene.delegate window];
            if (window&&!isRemove) {
                
                for (UIView *view in [window subviews]) {
                    if (view.tag == 11) {
                        isRemove = YES;
                        [view removeFromSuperview];
                    }
                }
            }
        }
    }
//    for (UIView *view in [[appDelegate window] subviews]) {
//        if (view.tag == 11) {
//            [view removeFromSuperview];
//        }
//    }
    
}


- (CGSize)getImageSize:(CGFloat)width height:(CGFloat)height {
    
    CGFloat ratio = 0.0;
    if (height >= width) {
        ratio =  (float)(height / width);
    }else {
        ratio =  (float)(height / width);
        
    }
    
    CGFloat margin = 26.0;
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    CGFloat w = screenBounds.size.width - (margin*2);
    
    return CGSizeMake(w, w * ratio);
    
}

+ (void)goMain {
    UINavigationController *navController;
    NSMutableArray *navigationArray = [[NSMutableArray alloc] init];
    for (UIScene *scene in UIApplication.sharedApplication.connectedScenes) {
        if ([scene.delegate conformsToProtocol:@protocol(UIWindowSceneDelegate)]) {
            UIWindow *window = [(id<UIWindowSceneDelegate>)scene.delegate window];
            navController = (UINavigationController *)window.rootViewController;
        }
    }
    
    for(UIViewController *viewController in navController.viewControllers){
        if ([viewController isKindOfClass:[MainContentViewController class]]) {
            [navigationArray addObject:viewController];
        }

    }
    
    navController.viewControllers = navigationArray;
}

+ (NSDictionary*) parseQueryString:(NSString *)_query
{
    NSMutableDictionary* pDic = [NSMutableDictionary dictionary];
    NSArray* pairs = [_query componentsSeparatedByString:@"&"];
    for (NSString* sObj in pairs) {
        NSArray* elements = [sObj componentsSeparatedByString:@"="];
        NSString* key =     [[elements objectAtIndex:0] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSString* value =   [[elements objectAtIndex:1] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        [pDic setObject:value forKey:key];
    }
    
    return pDic;
}

+ (NSString *)calculateDate:(NSDate *)date {
    
    NSString *interval;
    int diffSecond = (int)[date timeIntervalSinceNow];
    
    if (diffSecond < 0) { //입력날짜가 과거
        
        //날짜 차이부터 체크
        int valueInterval;
        int valueOfToday, valueOfTheDate;
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSArray *languages = [defaults objectForKey:@"AppleLanguages"];
        NSString *currentLanguage = [languages objectAtIndex:0];
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:currentLanguage]];
        
        [formatter setDateFormat:@"yyyyMMdd"];
        
        NSDate *now = [NSDate date];
        valueOfToday = [[formatter stringFromDate:now] intValue]; //오늘날짜
        valueOfTheDate = [[formatter stringFromDate:date] intValue]; //입력날짜
        valueInterval = valueOfToday - valueOfTheDate; //두 날짜 차이
        
        
        if(valueInterval == 1)
            interval = @"어제";
        else if(valueInterval == 2)
            interval = @"2일전";
        else if(valueInterval == 3)
            interval = @"3일전";
        else if(valueInterval > 3) { //4일 이상일때는 그냥 요일, 날짜 표시
            //    [formatter setDateFormat:@"yyyy년 MM월 dd일 EEEE"];
            [formatter setDateFormat:@"yyyy년 MM월 dd일"];
            interval = [formatter stringFromDate:date];
        }
        else { //날짜가 같은경우 시간 비교
            
            [formatter setDateFormat:@"HH"];
            
            valueOfToday = [[formatter stringFromDate:now] intValue]; //오늘시간
            valueOfTheDate = [[formatter stringFromDate:date] intValue]; //입력시간
            valueInterval = valueOfToday - valueOfTheDate; //두 시간 차이
            
            if(valueInterval == 1)
                interval = @"1시간전";
            else if(valueInterval >= 2)
                interval = [NSString stringWithFormat:@"%i시간전", valueInterval];
            else { //시간이 같은 경우 분 비교
                
                [formatter setDateFormat:@"mm"];
                
                valueOfToday = [[formatter stringFromDate:now] intValue]; //오늘분
                valueOfTheDate = [[formatter stringFromDate:date] intValue]; //입력분
                valueInterval = valueOfToday - valueOfTheDate; //두 분 차이
                
                if(valueInterval == 1)
                    interval = @"1분전";
                else if(valueInterval >= 2)
                    interval = [NSString stringWithFormat:@"%i분전", valueInterval];
                else //분이 같은 경우 차이가 1분 이내
                    interval = @"지금 등록";
                
            }
            
        }
        
    }
    else { //입력날짜가 미래
        NSLog(@"%s, 입력된 날짜가 미래임", __func__);
        interval = @"지금 등록";
    }
    
    
    return interval;
    
}

+ (NSString *)objectToJsonString:(id)obj {
    NSData* jsonData;
    if ([obj isKindOfClass:[NSDictionary class]]) {
        NSDictionary *objDic = (NSDictionary *)obj;
        jsonData = [NSJSONSerialization dataWithJSONObject:objDic options:NSJSONWritingPrettyPrinted error:nil];
    }else {
        NSArray *objArr = (NSArray *)obj;
        jsonData = [NSJSONSerialization dataWithJSONObject:objArr options:NSJSONWritingPrettyPrinted error:nil];
    }
    
    NSString* jsonDataStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    return jsonDataStr;
}

+ (NSString *)urlEncode:(NSString *)str { /* Percent 인코딩 범위에 주의, URLHostAllowedCharacterSet 등 범위에 맞춰서 사용. */
    return [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLPathAllowedCharacterSet]]; }
+ (NSString *)urlDecode:(NSString *)str {
    return [str stringByRemovingPercentEncoding];
}

+ (CGRect)labelFitRect:(UILabel *)lbl {
    CGSize labelSize = (CGSize){CGFLOAT_MAX, lbl.frame.size.height};
    CGRect requiredSize = [lbl.text boundingRectWithSize:labelSize  options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: lbl.font} context:nil];
    return requiredSize;
}

+ (id)getCurrentViewClass {
    
    UINavigationController *navController;
    NSMutableArray *navigationArray = [[NSMutableArray alloc] init];
    for (UIScene *scene in UIApplication.sharedApplication.connectedScenes) {
        if ([scene.delegate conformsToProtocol:@protocol(UIWindowSceneDelegate)]) {
            UIWindow *window = [(id<UIWindowSceneDelegate>)scene.delegate window];
            navController = (UINavigationController *)window.rootViewController;
        }
    }
    
    UIViewController *viewController = [[navController viewControllers] lastObject];
    return viewController.class;
}

+ (void)makeShortUrl:(NSString *)orgUrl :(SEL)selector {

    NSString *url =[NSString stringWithFormat:@"https://naveropenapi.apigw.ntruss.com/util/v1/shorturl?url=%@",orgUrl];
    [COMController sendRequestGet:url :[self getCurrentViewClass] :self :selector];
}



@end
