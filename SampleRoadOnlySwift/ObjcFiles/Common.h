//
//  Common.h
//  egg
//
//  Created by CNKANG on 2020/12/05.
//  Copyright © 2020 CNKANG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Common : NSObject {
    NSString *popupStartY;
}



@property(nonatomic, retain) IBOutlet NSMutableDictionary *bannerDic;
@property(nonatomic, retain) IBOutlet NSMutableArray *typeArr;
@property (nonatomic, assign) int bannerIdx;


+ (Common *)sharedInstance;

+ (CGFloat)ratioVal;
+ (CGFloat)topHeight;
+ (CGFloat)bottomHeight;
+ (UIColor *)pointColor1;
+ (UIColor *)pointColor2;
+ (UIColor *)blueColor;
+ (UIColor *)lightGray;
+ (UIColor *)lightGray2;
+ (UIColor *)darkGray;
+ (UIColor *)blackColor;

+ (UIFont *)kFontWithSize:(NSString *)type :(CGFloat)fontSize;
+ (UIFont *)eFontWithSize:(CGFloat)fontSize;

+ (BOOL)detectIphoneX;
+ (CGFloat)iphoneXmargin;
+ (NSString *)getLocalizableString:(NSString *)key;
+ (UIColor *)colorWithHexString:(NSString *)stringToConvert;
+ (void)alert:(NSString*)str;
+ (UIViewController*) topMostController;
+ (UITextView *)settingTxtView:(UITextView *)txtView;
+ (UITextView *)settingCenterTxtView:(UITextView *)txtView;
+ (CGRect)getTxtViewSize:(UITextView *)txtView;
+ (NSString *)getRandomCodeWithLength:(int)len;

+ (BOOL)checkValidateString:(NSString *)string;

+ (void)vibrate:(int)length;
+ (void)safariOpenURL:(NSString *)URL;

+ (UIView *)nodataView:(CGRect)rect :(NSString *)msg;
+ (void)makeShadowView:(UIView *)view;
+ (void)makeShadowViewShort:(UIView *)view;
+ (NSString *)settingWon:(int)val;

+ (void)customAlert1:(NSString *)tit :(NSString *)str;
+ (void)customAlert2:(NSAttributedString *)str :(NSString *)yes :(NSString *)no :(id)sender :(SEL)selector;
+ (void)closeCustomAlert2;
+ (void)goMain;
+ (NSDictionary*) parseQueryString:(NSString *)_query;
+ (NSString *)calculateDate:(NSDate *)date;
+ (NSString *)objectToJsonString:(id)obj;
+ (NSString *)urlEncode:(NSString *)str;
+ (NSString *)urlDecode:(NSString *)str;
+ (CGRect)labelFitRect:(UILabel *)lbl;
+ (id)getCurrentViewClass;

+ (void)makeShortUrl:(NSString *)orgUrl :(SEL)selector;

@end

NS_ASSUME_NONNULL_END
