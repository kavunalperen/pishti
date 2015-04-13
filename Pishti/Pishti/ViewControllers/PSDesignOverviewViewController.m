//
//  PSDesignOverviewViewController.m
//  Pishti
//
//  Created by Alperen Kavun on 30/03/15.
//  Copyright (c) 2015 pishti. All rights reserved.
//

#import "PSDesignOverviewViewController.h"
#import "PSAuthenticationManager.h"
#import "PSCommons.h"

#define TOP_BUTTONS_WIDTH 46.0
#define TOP_BUTTONS_HEIGHT 46.0

@interface PSDesignOverviewViewController ()

@end

@implementation PSDesignOverviewViewController
- (CGRect) backgroundViewFrame
{
    return CGRectMake(0.0, 0.0, SCREEN_SIZE.width, SCREEN_SIZE.height);
}
- (CGRect) logoFrame
{
    return CGRectMake(SCREEN_SIZE.width-84.0, 18.0, 84.0, 94.0);
}
- (CGRect) overviewHolderFrame
{
    return CGRectMake((SCREEN_SIZE.width-402.0)*0.5, 0.0, 402.0, 945.0);
}
- (CGRect) bottomInfoFrame
{
    return CGRectMake(0.0, 930.0, 402.0, 15.0);
}
- (CGRect) overviewTagFrame
{
    return CGRectMake(0.0, 0.0, 402.0, 920.0);
}
- (CGRect) designOverviewFrame
{
    return CGRectMake(14.0, 104.0, 374.0, 384.0);
}
- (CGRect) orderDetailsHolderFrame
{
    return CGRectMake(0.0, 470.0, 402.0, 240.0);
}
- (CGRect) orderDetailsTitleFrame
{
    return CGRectMake(45.0, 0.0, 312.0, 48.0);
}
- (CGRect) totalPriceHolderFrame
{
    return CGRectMake(45.0, 48.0, 312.0, 48.0);
}
- (CGRect) countHolderFrame
{
    return CGRectMake(45.0, 96.0, 312.0, 48.0);
}
- (CGRect) shippingPriceHolderFrame
{
    return CGRectMake(45.0, 144.0, 312.0, 48.0);
}
- (CGRect) generalPriceHolderFrame
{
    return CGRectMake(45.0, 192.0, 312.0, 48.0);
}
- (CGRect) detailsTitleFrame
{
    return CGRectMake(15.0, 0.0, 156.0, 48.0);
}
- (CGRect) detailsValueFrame
{
    return CGRectMake(171.0, 0.0, 126.0, 48.0);
}
- (CGRect) shippingAdressHolderFrame
{
    return CGRectMake(45.0, 772.0, 312.0, 37.0);
}
- (CGRect) shippingAddressTitleFrame
{
    return CGRectMake(0.0, 0.0, 156.0, 37.0);
}
- (CGRect) shippingAddressValueFrame
{
    return CGRectMake(156.0, 0.0, 156.0, 37.0);
}
- (CGRect) shippingAddressTextFrame
{
    return CGRectMake(0.0, 0.0, 115.0, 37.0);
}
- (CGRect) shippingAddressChangeFrame
{
    return CGRectMake(119.0, 0.0, 37.0, 37.0);
}
- (CGRect) buttonsHolderFrame
{
    return CGRectMake(45.0, 855.0, 312.0, 37.0);
}
- (CGRect) cancelButtonFrame
{
    return CGRectMake(0.0, 0.0, 156.0, 37.0);
}
- (CGRect) approveButtonFrame
{
    return CGRectMake(156.0, 0.0, 156.0, 37.0);
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initialSetups];
//    [self addTopButtons];
    [self addLogo];
    
    [self placeInitialComponents];
    
}

- (void) placeInitialComponents
{
    UIView* overviewHolder = [[UIView alloc] initWithFrame:[self overviewHolderFrame]];
    overviewHolder.backgroundColor = [UIColor clearColor];
    [self.view addSubview:overviewHolder];
    
    UIImageView* overviewTag = [[UIImageView alloc] initWithFrame:[self overviewTagFrame]];
    overviewTag.backgroundColor = [UIColor clearColor];
    overviewTag.image = [UIImage imageNamed:@"siparis_etiket_bg.png"];
    [overviewHolder addSubview:overviewTag];
    
    UIImageView* designOverview = [[UIImageView alloc] initWithFrame:[self designOverviewFrame]];
    designOverview.backgroundColor = [UIColor clearColor];
    designOverview.image = self.designOverview;
    [overviewHolder addSubview:designOverview];
    
    UIView* orderDetailsHolder = [[UIView alloc] initWithFrame:[self orderDetailsHolderFrame]];
    orderDetailsHolder.backgroundColor = [UIColor clearColor];
    [overviewHolder addSubview:orderDetailsHolder];
    
    UILabel* orderDetailsTitle = [[UILabel alloc] initWithFrame:[self orderDetailsTitleFrame]];
    orderDetailsTitle.backgroundColor = [UIColor clearColor];
    orderDetailsTitle.font = ORDER_DETAILS_TITLE_FONT;
    orderDetailsTitle.textColor = ORDER_DETAILS_TITLE_TEXT_COLOR;
    orderDetailsTitle.text = @"SİPARİŞ DETAYLARI";
    [orderDetailsHolder addSubview:orderDetailsTitle];
    
    [self addBottomBorder:orderDetailsTitle];
    
    UIView* totalPriceHolder = [[UIView alloc] initWithFrame:[self totalPriceHolderFrame]];
    totalPriceHolder.backgroundColor = [UIColor clearColor];
    [orderDetailsHolder addSubview:totalPriceHolder];
    
    [self addTitle:@"Toplam Ücret" toView:totalPriceHolder];
    [self addValue:self.totalPrice toView:totalPriceHolder];
    [self addBottomBorder:totalPriceHolder];
    
    UIView* countHolder = [[UIView alloc] initWithFrame:[self countHolderFrame]];
    countHolder.backgroundColor = [UIColor clearColor];
    [orderDetailsHolder addSubview:countHolder];
    
    [self addTitle:@"Adet" toView:countHolder];
    [self addValue:@"1" toView:countHolder];
    [self addBottomBorder:countHolder];
    
    UIView* shippingPriceHolder = [[UIView alloc] initWithFrame:[self shippingPriceHolderFrame]];
    shippingPriceHolder.backgroundColor = [UIColor clearColor];
    [orderDetailsHolder addSubview:shippingPriceHolder];
    
    NSString* shippingPrice = @"12,25";
    [self addTitle:@"Kargo Bedeli" toView:shippingPriceHolder];
    [self addValue:shippingPrice toView:shippingPriceHolder];
    [self addBottomBorder:shippingPriceHolder];
    
    UIView* generalPriceHolder = [[UIView alloc] initWithFrame:[self generalPriceHolderFrame]];
    generalPriceHolder.backgroundColor = ORDER_DETAILS_GENERAL_PRICE_BACKGROUND_COLOR;
    [orderDetailsHolder addSubview:generalPriceHolder];
    
    NSString* generalTotalPrice;
    
    shippingPrice = [shippingPrice stringByReplacingOccurrencesOfString:@"," withString:@"."];
    CGFloat shippingPriceF = [shippingPrice floatValue];
    NSString* totalPrice = self.totalPrice;
    totalPrice = [totalPrice stringByReplacingOccurrencesOfString:@"," withString:@"."];
    CGFloat totalPriceF = [totalPrice floatValue];
    
    CGFloat generalTotalPriceF = totalPriceF+shippingPriceF;
    
    generalTotalPrice = [NSString stringWithFormat:@"%.2f",generalTotalPriceF];
    generalTotalPrice = [generalTotalPrice stringByReplacingOccurrencesOfString:@"." withString:@","];
    
    [self addTitle:@"Genel Toplam" toView:generalPriceHolder];
    [self addValue:generalTotalPrice toView:generalPriceHolder];
    [self addBottomBorder:generalPriceHolder];
    
    UIView* shippingAddressHolder = [[UIView alloc] initWithFrame:[self shippingAdressHolderFrame]];
    shippingAddressHolder.backgroundColor = [UIColor clearColor];
    [overviewHolder addSubview:shippingAddressHolder];
    
    UILabel* shippingAddressTitle = [[UILabel alloc] initWithFrame:[self shippingAddressTitleFrame]];
    shippingAddressTitle.backgroundColor = [UIColor clearColor];
    shippingAddressTitle.font = ORDER_DETAILS_DETAILS_TITLE_FONT;
    shippingAddressTitle.textColor = ORDER_DETAILS_DETAILS_TITLE_TEXT_COLOR;
    shippingAddressTitle.text = @"Teslimat Adresi";
    [shippingAddressHolder addSubview:shippingAddressTitle];
    
    UIView* shippingAddressValue = [[UIView alloc] initWithFrame:[self shippingAddressValueFrame]];
    shippingAddressValue.backgroundColor = [UIColor clearColor];
    [shippingAddressHolder addSubview:shippingAddressValue];
    
    UILabel* shippingAddressText = [[UILabel alloc] initWithFrame:[self shippingAddressTextFrame]];
    shippingAddressText.backgroundColor = [UIColor clearColor];
    shippingAddressText.font = ORDER_DETAILS_DETAILS_VALUE_FONT;
    shippingAddressText.textColor = ORDER_DETAILS_DETAILS_TITLE_TEXT_COLOR;
    shippingAddressText.textAlignment = NSTextAlignmentRight;
    shippingAddressText.text = @"İş Adresi";
    [shippingAddressValue addSubview:shippingAddressText];
    
    UIButton* shippindAddressChange = [UIButton buttonWithType:UIButtonTypeCustom];
    shippindAddressChange.backgroundColor = [UIColor clearColor];
    shippindAddressChange.frame = [self shippingAddressChangeFrame];
    [shippindAddressChange setImage:[UIImage imageNamed:@"adres_edit_normal.png"] forState:UIControlStateNormal];
    [shippindAddressChange setImage:[UIImage imageNamed:@"adres_edit_highlighted.png"] forState:UIControlStateHighlighted];
    [shippindAddressChange addTarget:self action:@selector(changeAddress) forControlEvents:UIControlEventTouchUpInside];
    [shippingAddressValue addSubview:shippindAddressChange];
    
    UIView* buttonsHolder = [[UIView alloc] initWithFrame:[self buttonsHolderFrame]];
    buttonsHolder.backgroundColor = [UIColor clearColor];
    [overviewHolder addSubview:buttonsHolder];
    
    UIButton* cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelButton.backgroundColor = [UIColor clearColor];
    cancelButton.frame = [self cancelButtonFrame];
    cancelButton.titleLabel.font = ORDER_DETAILS_TITLE_FONT;
    [cancelButton setTitleColor:ORDER_DETAILS_TITLE_TEXT_COLOR forState:UIControlStateNormal];
    [cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [cancelButton setTitle:@"İPTAL" forState:UIControlStateNormal];
    [cancelButton addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    [buttonsHolder addSubview:cancelButton];
    
    UIButton* approveButton = [UIButton buttonWithType:UIButtonTypeCustom];
    approveButton.backgroundColor = [UIColor clearColor];
    approveButton.frame = [self approveButtonFrame];
    approveButton.titleLabel.font = ORDER_DETAILS_DETAILS_VALUE_FONT;
    [approveButton setTitleColor:ORDER_DETAILS_DETAILS_TITLE_TEXT_COLOR forState:UIControlStateNormal];
    [approveButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [approveButton setTitle:@"ONAYLA" forState:UIControlStateNormal];
    [approveButton addTarget:self action:@selector(approveDesign) forControlEvents:UIControlEventTouchUpInside];
    [buttonsHolder addSubview:approveButton];
    
    UILabel* bottomInfoLabel = [[UILabel alloc] initWithFrame:[self bottomInfoFrame]];
    bottomInfoLabel.backgroundColor = [UIColor clearColor];
    bottomInfoLabel.font = DESIGN_OVERVIEW_BOTTOM_INFO_FONT;
    bottomInfoLabel.textColor = DESIGN_OVERVIEW_BOTTOM_INFO_COLOR;
    bottomInfoLabel.text = @"Bir sonraki adımda kredi kartı bilgisi istenecektir.";
    bottomInfoLabel.textAlignment = NSTextAlignmentCenter;
    [overviewHolder addSubview:bottomInfoLabel];
    
}
- (void) addBottomBorder:(UIView*)view
{
    CGRect frame = view.frame;
    CALayer* bottomBorder = [CALayer layer];
    bottomBorder.borderColor = DESIGN_OVERVIEW_BORDERS_COLOR.CGColor;
    bottomBorder.borderWidth = 1;
    bottomBorder.frame = CGRectMake(0.0, frame.size.height-1.0, frame.size.width, 1.0);
    [view.layer addSublayer:bottomBorder];
}
- (void) addTitle:(NSString*)title toView:(UIView*)view
{
    UILabel* titleLabel = [[UILabel alloc] initWithFrame:[self detailsTitleFrame]];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.font = ORDER_DETAILS_DETAILS_TITLE_FONT;
    titleLabel.textColor = ORDER_DETAILS_DETAILS_TITLE_TEXT_COLOR;
    titleLabel.text = title;
    [view addSubview:titleLabel];
}
- (void) addValue:(NSString*)value toView:(UIView*)view
{
    UILabel* valueLabel = [[UILabel alloc] initWithFrame:[self detailsValueFrame]];
    valueLabel.backgroundColor = [UIColor clearColor];
    valueLabel.font = ORDER_DETAILS_DETAILS_VALUE_FONT;
    valueLabel.textColor = ORDER_DETAILS_DETAILS_TITLE_TEXT_COLOR;
    valueLabel.textAlignment = NSTextAlignmentRight;
    valueLabel.text = value;
    [view addSubview:valueLabel];
}
- (void) initialSetups
{
    UIImageView* backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mainscreen_bg.png"]];
    backgroundView.backgroundColor = [UIColor clearColor];
    backgroundView.frame = [self backgroundViewFrame];
    [self.view addSubview:backgroundView];
}
- (void) addLogo
{
    UIButton* logoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    logoButton.backgroundColor = [UIColor clearColor];
    logoButton.frame = [self logoFrame];
    [logoButton setBackgroundImage:[UIImage imageNamed:@"mainscreen_logo.png"] forState:UIControlStateNormal];
    [logoButton setBackgroundImage:[UIImage imageNamed:@"mainscreen_logo.png"] forState:UIControlStateHighlighted];
    [self.view addSubview:logoButton];
}
- (void) goBack
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void) openProfile
{
    [[PSAuthenticationManager sharedInstance] checkAuthentication];
    if ([PSAuthenticationManager sharedInstance].isAuthenticated) {
        NSLog(@"authenticated");
    } else {
        NSLog(@"not authenticated, open login view");
    }
}
- (void) changeAddress
{
    NSLog(@"change address");
    UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Not Yet!"
                                                        message:@"Profil ekrani kodlamasi tamamlaninca adres degistirebilirsiniz."
                                                       delegate:nil
                                              cancelButtonTitle:@"Tamam"
                                              otherButtonTitles:nil, nil];
    [alertView show];
}
- (void) approveDesign
{
    NSLog(@"approve design");
    UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Not Yet!"
                                                        message:@"Odeme ekrani kodlamasi tamamlaninca devam edebilirsiniz."
                                                       delegate:nil
                                              cancelButtonTitle:@"Tamam"
                                              otherButtonTitles:nil, nil];
    [alertView show];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
