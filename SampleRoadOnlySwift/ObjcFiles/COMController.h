//
//  COMController.h
//  ChatTest
//
//  Created by 구자경 on 12. 11. 16..
//  Copyright (c) 2012년 Softzam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface COMController : NSObject <NSStreamDelegate>{

    UIView *maskView;
}
@property (strong, nonatomic) UIView *maskView;


-(id)initWithData;

+ (void)sendRequest:(NSString*)url :(NSDictionary*)params :(id)sender :(SEL)selector;
+ (void)sendRequestWithMethod:(NSString *)method :(NSString*)url :(NSDictionary*)params :(id)sender :(SEL)selector;
+ (void)sendRequestGet:(NSString*)url :(NSDictionary*)params :(id)sender :(SEL)selector;
+ (void)addMaskingView;
+ (void)removeMaskingView;
+ (void)sendRequestMultipartClayFul:(NSDictionary *)param :(UIImage *)paramImage :(NSString *)paramImageName :(id)sender :(SEL)selector;
+ (void)sendRequestNcloud:(NSString*)url :(NSDictionary*)params :(id)sender :(SEL)selector;

@end
