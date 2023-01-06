//
//  TermsViewController.m
//  MEONG
//
//  Created by CNKANG on 2020/10/19.
//  Copyright © 2020 NOTEGG. All rights reserved.
//

#import "TermsViewController.h"
#import "Common.h"

@interface TermsViewController ()

@end

@implementation TermsViewController

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (id)initWithDic:(NSMutableDictionary *)dic {
    self.initialDic = dic;
    NSLog(@"self.initialDic  : %@",self.initialDic);
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    screenBounds = [[UIScreen mainScreen] bounds];
    ratioVal = Common.ratioVal;
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    self.topView = [[UIView alloc] init];
    CGFloat topH = [Common topHeight];
    
    [self.topView setFrame:CGRectMake(0, 0, screenBounds.size.width, topH)];
    [self.view addSubview:self.topView];
    [self.topView setBackgroundColor:[UIColor clearColor]];
    
    
    CGFloat margin = 26.0;
    CGFloat btnSize = 50.0;
    UIButton *closeBtn = [[UIButton alloc] initWithFrame:CGRectMake(margin, self.topView.frame.size.height - (btnSize), btnSize, btnSize)];
    closeBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [closeBtn setImage:[UIImage imageNamed:@"top_home_btn"] forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(home) forControlEvents:UIControlEventTouchUpInside];
    [closeBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [self.topView addSubview:closeBtn];
    
    CGSize titSize = CGSizeMake(200.0, btnSize);
    UILabel *tit = [[UILabel alloc] initWithFrame:CGRectMake(screenBounds.size.width / 2 - titSize.width / 2, closeBtn.frame.origin.y, titSize.width, titSize.height)];
    [tit setText:@""];
    [tit setFont:[Common kFontWithSize:@"BOLD" :20.0]];
    [tit setTextAlignment:NSTextAlignmentCenter];
    [tit setTextColor:[Common pointColor1]];
    [self.topView addSubview:tit];
    
    
    CGFloat bSize = screenBounds.size.width;
    UIImageView *logoBg = [[UIImageView alloc] initWithFrame:CGRectMake(screenBounds.size.width/2 - bSize/2, screenBounds.size.height-bSize, bSize, bSize)];
    [logoBg setImage:[UIImage imageNamed:@"bg_login_btn"]];
    [logoBg setContentMode:UIViewContentModeScaleAspectFit];
    [self.view addSubview:logoBg];
    
    
    
    CGFloat rH =(screenBounds.size.width - (margin*2))/6;
    UIButton *startBtn = [[UIButton alloc] initWithFrame:CGRectMake(margin, screenBounds.size.height - (screenBounds.size.width/4+rH), screenBounds.size.width - (margin*2), rH)];


    CGSize sLblSize = CGSizeMake(screenBounds.size.width, 18.0);
    UILabel *sLbl = [[UILabel alloc] initWithFrame:CGRectMake(screenBounds.size.width/2 - sLblSize.width/2, startBtn.frame.origin.y+startBtn.frame.size.height + 20.0, sLblSize.width, sLblSize.height)];
    [sLbl setText:@"FIND YOUR WAY"];
    [sLbl setTextAlignment:NSTextAlignmentCenter];
    [sLbl setTextColor:[Common pointColor1]];
    [sLbl setFont:[Common kFontWithSize:@"BOLD" :18.0]];
    [self.view addSubview:sLbl];
    

    
    self.agreeBtn = [[UIButton alloc] initWithFrame:CGRectMake(margin, sLbl.frame.origin.y - (rH+20.0), screenBounds.size.width - (margin*2), rH)];
    [self.agreeBtn setTitle:@"동의" forState:UIControlStateNormal];
    [self.agreeBtn.titleLabel setFont:[Common kFontWithSize:@"SEMIBOLD" :18.0]];
    [self.agreeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.agreeBtn setBackgroundColor:[Common pointColor1]];
    [self.agreeBtn.layer setCornerRadius:8.0];
    [self.agreeBtn setClipsToBounds:YES];
    [self.agreeBtn addTarget:self action:@selector(agree:) forControlEvents:UIControlEventTouchUpInside];
    [self.agreeBtn setUserInteractionEnabled:YES];
    [self.view addSubview:self.agreeBtn];
    
    [Common makeShadowView:self.agreeBtn];
    

    CGSize cLblSize = CGSizeMake(200.0, 10.0);
    UILabel *cLbl = [[UILabel alloc] initWithFrame:CGRectMake(screenBounds.size.width/2 - cLblSize.width/2, screenBounds.size.height - (cLblSize.height+20.0), cLblSize.width, cLblSize.height)];
    [cLbl setText:@"ⓒTov&Banah"];
    [cLbl setTextAlignment:NSTextAlignmentCenter];
    [cLbl setTextColor:[Common darkGray]];
    [cLbl setFont:[Common kFontWithSize:@"LIGHT" :10.0]];
    [self.view addSubview:cLbl];
    
//    self.scrlView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.topView.frame.size.height, screenBounds.size.width, screenBounds.size.height -(self.topView.frame.size.height+self.bottomView.frame.size.height))];
    self.txtView = [[UITextView alloc] init];
    [self.txtView setBackgroundColor:[UIColor clearColor]];
    [self.txtView setIndicatorStyle:UIScrollViewIndicatorStyleWhite];
    [self.txtView setTintColor:[Common darkGray]];
    
    CGFloat sideMargin = 18.0;
    CGFloat tBottomMargin = screenBounds.size.height - (self.agreeBtn.frame.origin.y);
    [self.txtView setFrame:CGRectMake(sideMargin, self.topView.frame.size.height, screenBounds.size.width - (sideMargin*2), screenBounds.size.height - (self.topView.frame.size.height+(tBottomMargin+20.0)))];
    
    if ([[self.initialDic valueForKey:@"term_type"] isEqualToString:@"1"]) {
        [self.txtView setText:[Common getLocalizableString:@"TERM_TXT1"]];
    }else if ([[self.initialDic valueForKey:@"term_type"] isEqualToString:@"2"]) {
        
        [self.txtView setText:[Common getLocalizableString:@"TERM_TXT2"]];
    }else {
        [self.txtView setText:[Common getLocalizableString:@"TERM_TXT3"]];
    }
    
    [self.txtView setEditable:NO];
    [self.txtView setSelectable:NO];
    [self.txtView setTextContainerInset:UIEdgeInsetsMake(80.0, 0, [Common bottomHeight]/2, 0)];
    
    UILabel *tTit = [[UILabel alloc] initWithFrame:CGRectMake(margin, 0, self.txtView.frame.size.width, 80.0)];
    [tTit setFont:[UIFont fontWithName:@"AppleSDGothicNeo-Bold" size:20.0]];
    [tTit setText:@"서비스 이용 약관"];
    [tTit setTextAlignment:NSTextAlignmentLeft];
    [tTit setTextColor:[Common blackColor]];
    [self.txtView addSubview:tit];
    [self.view addSubview:self.txtView];
    
    
    NSMutableParagraphStyle *txtParagraphStyle = [[NSMutableParagraphStyle  alloc] init];
    txtParagraphStyle.lineSpacing = 4.0;
    
    [txtParagraphStyle setAlignment:NSTextAlignmentLeft];
    
    
    NSMutableAttributedString *txtString = [[NSMutableAttributedString alloc] initWithString:self.txtView.text
                                                                            attributes: @{ NSParagraphStyleAttributeName : txtParagraphStyle,
                                                                                           NSFontAttributeName : [UIFont fontWithName:@"AppleSDGothicNeo-Regular" size:14.0],
                                                                                           NSForegroundColorAttributeName : [Common darkGray]}];
    [txtString addAttribute:NSKernAttributeName
                          value:[NSNumber numberWithFloat:0.8]
                          range:NSMakeRange(0, [txtString length])];
    
//    [txtString addAttribute:NSFontAttributeName
//                          value:[UIFont fontWithName:@"AppleSDGothicNeo-Bold" size:20.0]
//                          range:NSMakeRange(0, 4)];

    NSRange range;
    range = [self.txtView.text rangeOfString:@"[필수] 이용약관 동의"];  
    [txtString addAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"AppleSDGothicNeo-Bold" size:20.0]} range:range];

    range = [self.txtView.text rangeOfString:@"[필수] 개인정보 수집 및 이용 동의"];
    [txtString addAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"AppleSDGothicNeo-Bold" size:20.0]} range:range];
    
    range = [self.txtView.text rangeOfString:@"[선택] 선택적 수집 항목 동의"];
    [txtString addAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"AppleSDGothicNeo-Bold" size:20.0]} range:range];

    self.txtView.attributedText = txtString;
    
    
}

- (IBAction)agree:(id)sender {

    [[NSUserDefaults standardUserDefaults] setObject:[self.initialDic valueForKey:@"term_type"] forKey:@"term_type"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self.navigationController popViewControllerAnimated:YES];
    
}
   

- (void)close {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)showTopView {

    [UIView animateWithDuration:0.25  delay: 0.0 options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         [self.topView setFrame:CGRectMake(0, 0, self.topView.frame.size.width, self.topView.frame.size.height)];

                     } completion:^(BOOL finished){
                        
                     }];
}

- (void)hideTopView {
    [UIView animateWithDuration:0.25  delay: 0.0 options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         [self.topView setFrame:CGRectMake(0, -self.topView.frame.size.height, self.topView.frame.size.width, self.topView.frame.size.height)];
                         
                     } completion:^(BOOL finished){
                         
                     }];
}

- (void)home {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
