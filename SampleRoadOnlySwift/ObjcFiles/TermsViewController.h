//
//  TermsViewController.h
//  MEONG
//
//  Created by CNKANG on 2020/10/19.
//  Copyright © 2020 NOTEGG. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TermsViewController : UIViewController {
    CGRect screenBounds;
    CGFloat ratioVal;
}

- (id)initWithDic:(NSMutableDictionary *)dic;
@property (retain, nonatomic) IBOutlet NSMutableDictionary *initialDic;

@property (retain, nonatomic) IBOutlet UIView *topView;

@property (retain, nonatomic) IBOutlet UIScrollView *scrlView;
@property (retain, nonatomic) IBOutlet UIImageView *termImgView;
@property (retain, nonatomic) IBOutlet UITextView *txtView;
@property (retain, nonatomic) IBOutlet UIButton *agreeBtn;


- (IBAction)agree:(id)sender;

@end

NS_ASSUME_NONNULL_END
