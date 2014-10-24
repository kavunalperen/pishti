//
//  PSSubmenuManager.m
//  Pishti
//
//  Created by Alperen Kavun on 14.10.2014.
//  Copyright (c) 2014 pishti. All rights reserved.
//

#import "PSSubmenuManager.h"
#import <QuartzCore/QuartzCore.h>
#import "PSCommons.h"
#import "Util.h"
#import "PSLabel.h"
#import "PSSlider.h"

#define SUBMENU_HEIGHT 255.0

static PSSubmenuManager* __sharedInstance;

@implementation PSSubmenuManager
{
#pragma mark - Variables
    UIViewController* submenuDelegate;
    
    PSSubmenuType currentSubmenuType;
    PSSubmenuType nextSubmenuType;
    UIView* currentSubmenu;
    UIView* nextSubmenu;
    
    NSMutableArray* submenuItems;
}
#pragma mark - Frames
#pragma mark - Fabric Frames
- (CGRect) titleFrame
{
    return CGRectMake(0.0, 0.0, 230.0, 17.0);
}
- (CGRect) valueFrame
{
    return CGRectMake(0.0, 17.0, 230.0, 38.0);
}
- (CGRect) indentedValueIconFrame
{
    return CGRectMake(0.0, 17.0, 56.0, 38.0);
}
- (CGRect) indentedValueFrame
{
    return CGRectMake(56.0, 20.0, 180.0, 38.0);
}
// left group
- (CGRect) firstItemHolderFrame
{
    return CGRectMake(30.0, 30.0, 230.0, 55.0);
}
- (CGRect) secondItemHolderFrame
{
    return CGRectMake(30.0, 99.0, 230.0, 55.0);
}
- (CGRect) thirdItemHolderFrame
{
    return CGRectMake(30.0, 168.0, 230.0, 55.0);
}
// middle group
- (CGRect) fourthItemHolderFrame
{
    return CGRectMake(275.0, 30.0, 236.0, 55.0);
}
- (CGRect) fifthItemHolderFrame
{
    return CGRectMake(275.0, 99.0, 236.0, 55.0);
}
- (CGRect) sixthItemHolderFrame
{
    return CGRectMake(275.0, 168.0, 236.0, 55.0);
}

#pragma mark - Text Frames
- (CGRect) textViewHolderFrame
{
    return CGRectMake(0.0, 0.0, 260.0, 156.0);
}
- (CGRect) textViewFrame
{
    return CGRectMake(30.0, 30.0, 230.0, 126.0);
}
- (CGRect) addNewtextButtonFrame
{
    return CGRectMake(30.0, 30.0, 36.0, 36.0);
}
- (CGRect) opacitySliderFrame
{
    return CGRectMake(7.0, 23.0, 216.0, 38.0);
}
- (CGRect) firstSettingFrame
{
    return CGRectMake(1.0, 17.0, 39.0, 37.0);
}
- (CGRect) secondSettingFrame
{
    return CGRectMake(40.0, 17.0, 39.0, 37.0);
}
- (CGRect) thirdSettingFrame
{
    return CGRectMake(79.0, 17.0, 39.0, 37.0);
}
- (CGRect) fourthSettingFrame
{
    return CGRectMake(118.0, 17.0, 39.0, 37.0);
}
- (CGRect) fifthSettingFrame
{
    return CGRectMake(157.0, 17.0, 39.0, 37.0);
}
- (CGRect) sixthSettingFrame
{
    return CGRectMake(196.0, 17.0, 39.0, 37.0);
}

#pragma mark - Image Frames
- (CGRect) imageGalleryHolderFrame
{
    return CGRectMake(30.0, 30.0, 480.0, 126.0);
}
- (CGRect) imageGalleryFrame
{
    return CGRectMake(0.0, 0.0, 480.0, 125.0);
}
- (CGRect) selectImageButtonFrame
{
    return CGRectMake(0.0, 0.0, 65.0, 55.0);
}
- (CGRect) captureImageButtonFrame
{
    return CGRectMake(65.0, 0.0, 65.0, 55.0);
}

#pragma mark - General Frames
- (CGRect) viewOptionsHolderFrame
{
    return CGRectMake(526.0, 30.0, 212.0, 55.0);
}
- (CGRect) frontViewFrame
{
    return CGRectMake(0.0, 0.0, 53.0, 55.0);
}
- (CGRect) rightViewFrame
{
    return CGRectMake(53.0, 0.0, 53.0, 55.0);
}
- (CGRect) backViewFrame
{
    return CGRectMake(106.0, 0.0, 53.0, 55.0);
}
- (CGRect) leftViewFrame
{
    return CGRectMake(159.0, 0.0, 53.0, 55.0);
}

- (CGRect) deleteHolderFrame
{
    return CGRectMake(526.0, 99.0, 212.0, 55.0);
}
- (CGRect) deleteLastButtonFrame
{
    return CGRectMake(112.0, 0.0, 45.0, 56.0);
}
- (CGRect) deleteAllButtonFrame
{
    return CGRectMake(167.0, 0.0, 45.0, 56.0);
}
- (CGRect) priceHolderFrame
{
    return CGRectMake(526.0, 168.0, 212.0, 55.0);
}
- (CGRect) priceLabelFrame
{
    return CGRectMake(0.0, 10.0, 157.0, 52.0);
}
- (CGRect) tlButtonFrame
{
    return CGRectMake(167.0, 10.0, 45.0, 45.0);
}
#pragma mark - Initializers
+ (PSSubmenuManager*) sharedInstance
{
    if (__sharedInstance == nil) {
        __sharedInstance = [[PSSubmenuManager alloc] init];
    }
    
    return __sharedInstance;
}
#pragma mark - Public methods
- (void) setSubmenuDelegate:(UIViewController*)viewController
{
    submenuDelegate = viewController;
}
- (void) showSubmenuWithType:(PSSubmenuType)submenuType
{
    nextSubmenuType = submenuType;
    
    if (currentSubmenuType == nextSubmenuType) {
        return;
    } else {
        nextSubmenu = [self generateSubmenuWithType:nextSubmenuType];
        [submenuDelegate.view addSubview:nextSubmenu];
        [self showNextSubmenu];
    }
}
#pragma mark - Generating submenus
- (UIView*) generateSubmenuWithType:(PSSubmenuType)submenuType
{
    CGRect frame = submenuDelegate.view.frame;
    UIView* submenu = [[UIView alloc] initWithFrame:CGRectMake(0.0, frame.size.height, frame.size.width, SUBMENU_HEIGHT)];
    submenu.backgroundColor = SUBMENU_BACKGROUND_COLOR;
    
    UIImageView* shadowView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, -9.0, 768.0, 9.0)];
    shadowView.backgroundColor = [UIColor clearColor];
    UIImage* shadowImage = [UIImage imageNamed:@"container_shadow.png"];
    shadowView.image = shadowImage;
    shadowView.alpha = 0.6;
    [submenu setClipsToBounds:NO];
    [submenu addSubview:shadowView];
    
    [self addSubviewsToSubmenu:submenu withType:submenuType];
    
    return submenu;
}

- (void) addSubviewsToSubmenu:(UIView*)submenu withType:(PSSubmenuType)submenuType
{
    switch (submenuType) {
        case SUBMENU_TYPE_FABRIC:
            [self addSubviewsToFabricSubmenu:submenu];
            break;
        case SUBMENU_TYPE_TEXT:
            [self addSubviewsToTextSubmenu:submenu];
            break;
        case SUBMENU_TYPE_IMAGE:
            [self addSubviewsToImageSubmenu:submenu];
            break;
        case SUBMENU_TYPE_NONE:
            break;
        default:
            break;
    }
}

- (void) addSubviewsToFabricSubmenu:(UIView*)submenu
{
    submenuItems = @[].mutableCopy;
    
    // first item
    
    CGRect frame = [self firstItemHolderFrame];
    
    UIView* firstHolder = [[UIView alloc] initWithFrame:frame];
    firstHolder.backgroundColor = [UIColor clearColor];
    [submenu addSubview:firstHolder];
    [submenuItems addObject:firstHolder];
    
    PSLabel* firstItemTitle = [[PSLabel alloc] initWithFrame:[self titleFrame]];
    firstItemTitle.backgroundColor = [UIColor clearColor];
    firstItemTitle.font = DESIGN_MENU_SUBMENU_TITLES_FONT;
    firstItemTitle.textColor = DESIGN_MENU_SUBMENU_TITLES_COLOR;
    firstItemTitle.text = @"Beden Seçimi";
    [firstHolder addSubview:firstItemTitle];
    
    PSLabel* firstItemValue = [[PSLabel alloc] initWithFrame:[self valueFrame]];
    firstItemValue.backgroundColor = [UIColor clearColor];
    firstItemValue.font = DESIGN_MENU_SUBMENU_VALUES_FONT;
    firstItemValue.textColor = DESIGN_MENU_SUBMENU_VALUES_COLOR;
    firstItemValue.text = @"XXLARGE";
    [firstHolder addSubview:firstItemValue];
    
    firstHolder.clipsToBounds = YES;
    CALayer *bottomBorder = [CALayer layer];
    bottomBorder.borderColor = DESIGN_MENU_SUBMENU_BORDER_BOTTOM_COLOR.CGColor;
    bottomBorder.borderWidth = 1;
    bottomBorder.frame = CGRectMake(0.0, frame.size.height-1.0, frame.size.width, 1.0);
    [firstHolder.layer addSublayer:bottomBorder];
    
    // second item
    
    CGRect frame2 = [self secondItemHolderFrame];
    
    UIView* secondHolder = [[UIView alloc] initWithFrame:frame2];
    secondHolder.backgroundColor = [UIColor clearColor];
    [submenu addSubview:secondHolder];
    [submenuItems addObject:secondHolder];
    
    PSLabel* secondItemTitle = [[PSLabel alloc] initWithFrame:[self titleFrame]];
    secondItemTitle.backgroundColor = [UIColor clearColor];
    secondItemTitle.font = DESIGN_MENU_SUBMENU_TITLES_FONT;
    secondItemTitle.textColor = DESIGN_MENU_SUBMENU_TITLES_COLOR;
    secondItemTitle.text = @"Kalıp Seçimi";
    [secondHolder addSubview:secondItemTitle];
    
    PSLabel* secondItemValue = [[PSLabel alloc] initWithFrame:[self valueFrame]];
    secondItemValue.backgroundColor = [UIColor clearColor];
    secondItemValue.font = DESIGN_MENU_SUBMENU_VALUES_FONT;
    secondItemValue.textColor = DESIGN_MENU_SUBMENU_VALUES_COLOR;
    secondItemValue.text = @"NORMAL";
    [secondHolder addSubview:secondItemValue];
    
    secondHolder.clipsToBounds = YES;
    CALayer *bottomBorder2 = [CALayer layer];
    bottomBorder2.borderColor = DESIGN_MENU_SUBMENU_BORDER_BOTTOM_COLOR.CGColor;
    bottomBorder2.borderWidth = 1;
    bottomBorder2.frame = CGRectMake(0.0, frame2.size.height-1.0, frame2.size.width, 1.0);
    [secondHolder.layer addSublayer:bottomBorder2];
    
    // third item
    
    CGRect frame3 = [self thirdItemHolderFrame];
    
    UIView* thirdHolder = [[UIView alloc] initWithFrame:frame3];
    thirdHolder.backgroundColor = [UIColor clearColor];
    [submenu addSubview:thirdHolder];
    [submenuItems addObject:thirdHolder];
    
    PSLabel* thirdItemTitle = [[PSLabel alloc] initWithFrame:[self titleFrame]];
    thirdItemTitle.backgroundColor = [UIColor clearColor];
    thirdItemTitle.font = DESIGN_MENU_SUBMENU_TITLES_FONT;
    thirdItemTitle.textColor = DESIGN_MENU_SUBMENU_TITLES_COLOR;
    thirdItemTitle.text = @"Kumaş Cinsi";
    [thirdHolder addSubview:thirdItemTitle];
    
    PSLabel* thirdItemValue = [[PSLabel alloc] initWithFrame:[self valueFrame]];
    thirdItemValue.backgroundColor = [UIColor clearColor];
    thirdItemValue.font = DESIGN_MENU_SUBMENU_VALUES_FONT;
    thirdItemValue.textColor = DESIGN_MENU_SUBMENU_VALUES_COLOR;
    thirdItemValue.text = @"MERSERİZE";
    [thirdHolder addSubview:thirdItemValue];
    
    thirdHolder.clipsToBounds = YES;
    CALayer *bottomBorder3 = [CALayer layer];
    bottomBorder3.borderColor = DESIGN_MENU_SUBMENU_BORDER_BOTTOM_COLOR.CGColor;
    bottomBorder3.borderWidth = 1;
    bottomBorder3.frame = CGRectMake(0.0, frame3.size.height-1.0, frame3.size.width, 1.0);
    [thirdHolder.layer addSublayer:bottomBorder3];
    
    // fourth item
    CGRect frame4 = [self fourthItemHolderFrame];
    
    UIView* fourthHolder = [[UIView alloc] initWithFrame:frame4];
    fourthHolder.backgroundColor = [UIColor clearColor];
    [submenu addSubview:fourthHolder];
    [submenuItems addObject:fourthHolder];
    
    PSLabel* fourthItemTitle = [[PSLabel alloc] initWithFrame:[self titleFrame]];
    fourthItemTitle.backgroundColor = [UIColor clearColor];
    fourthItemTitle.font = DESIGN_MENU_SUBMENU_TITLES_FONT;
    fourthItemTitle.textColor = DESIGN_MENU_SUBMENU_TITLES_COLOR;
    fourthItemTitle.text = @"Kumaş Renk Seçimi";
    [fourthHolder addSubview:fourthItemTitle];
    
    UIView* colorView = [[UIView alloc] initWithFrame:[self indentedValueIconFrame]];
    colorView.backgroundColor = [UIColor cyanColor];
    [fourthHolder addSubview:colorView];
    
    UIImageView* fourthItemIcon = [[UIImageView alloc] initWithFrame:[self indentedValueIconFrame]];
    fourthItemIcon.backgroundColor = [UIColor clearColor];
    fourthItemIcon.image = [UIImage imageNamed:@"color_mask.png"];
    [fourthHolder addSubview:fourthItemIcon];
    
    PSLabel* fourthItemValue = [[PSLabel alloc] initWithFrame:[self indentedValueFrame]];
    fourthItemValue.backgroundColor = [UIColor clearColor];
    fourthItemValue.font = DESIGN_MENU_SUBMENU_VALUES_FONT;
    fourthItemValue.textColor = DESIGN_MENU_SUBMENU_VALUES_COLOR;
    fourthItemValue.text = @"TURKUAZ";
    [fourthHolder addSubview:fourthItemValue];
    
    fourthHolder.clipsToBounds = YES;
    CALayer* bottomBorder4 = [CALayer layer];
    bottomBorder4.borderColor = DESIGN_MENU_SUBMENU_BORDER_BOTTOM_COLOR.CGColor;
    bottomBorder4.borderWidth = 1.0;
    bottomBorder4.frame = CGRectMake(0.0, frame4.size.height-1.0, frame4.size.width, 1.0);
    [fourthHolder.layer addSublayer:bottomBorder4];
    
    // fifth item
    
    CGRect frame5 = [self fifthItemHolderFrame];
    
    UIView* fifthHolder = [[UIView alloc] initWithFrame:frame5];
    fifthHolder.backgroundColor = [UIColor clearColor];
    [submenu addSubview:fifthHolder];
    [submenuItems addObject:fifthHolder];
    
    PSLabel* fifthItemTitle = [[PSLabel alloc] initWithFrame:[self titleFrame]];
    fifthItemTitle.backgroundColor = [UIColor clearColor];
    fifthItemTitle.font = DESIGN_MENU_SUBMENU_TITLES_FONT;
    fifthItemTitle.textColor = DESIGN_MENU_SUBMENU_TITLES_COLOR;
    fifthItemTitle.text = @"Yaka Seçimi";
    [fifthHolder addSubview:fifthItemTitle];
    
    UIView* colorView2 = [[UIView alloc] initWithFrame:[self indentedValueIconFrame]];
    colorView2.backgroundColor = [UIColor cyanColor];
    [fifthHolder addSubview:colorView2];
    
    UIImageView* fifthItemIcon = [[UIImageView alloc] initWithFrame:[self indentedValueIconFrame]];
    fifthItemIcon.backgroundColor = [UIColor clearColor];
    fifthItemIcon.image = [UIImage imageNamed:@"color_mask.png"];
    [fifthHolder addSubview:fifthItemIcon];
    
    PSLabel* fifthItemValue = [[PSLabel alloc] initWithFrame:[self indentedValueFrame]];
    fifthItemValue.backgroundColor = [UIColor clearColor];
    fifthItemValue.font = DESIGN_MENU_SUBMENU_VALUES_FONT;
    fifthItemValue.textColor = DESIGN_MENU_SUBMENU_VALUES_COLOR;
    fifthItemValue.text = @"KIRLANGIÇ";
    [fifthHolder addSubview:fifthItemValue];
    
    fifthHolder.clipsToBounds = YES;
    CALayer *bottomBorder5 = [CALayer layer];
    bottomBorder5.borderColor = DESIGN_MENU_SUBMENU_BORDER_BOTTOM_COLOR.CGColor;
    bottomBorder5.borderWidth = 1;
    bottomBorder5.frame = CGRectMake(0.0, frame5.size.height-1.0, frame5.size.width, 1.0);
    [fifthHolder.layer addSublayer:bottomBorder5];
    
    // sixth item
    
    CGRect frame6 = [self sixthItemHolderFrame];
    
    UIView* sixthHolder = [[UIView alloc] initWithFrame:frame6];
    sixthHolder.backgroundColor = [UIColor clearColor];
    [submenu addSubview:sixthHolder];
    [submenuItems addObject:sixthHolder];
    
    PSLabel* sixthItemTitle = [[PSLabel alloc] initWithFrame:[self titleFrame]];
    sixthItemTitle.backgroundColor = [UIColor clearColor];
    sixthItemTitle.font = DESIGN_MENU_SUBMENU_TITLES_FONT;
    sixthItemTitle.textColor = DESIGN_MENU_SUBMENU_TITLES_COLOR;
    sixthItemTitle.text = @"Kol Tipi Seçimi";
    [sixthHolder addSubview:sixthItemTitle];
    
    UIView* colorView3 = [[UIView alloc] initWithFrame:[self indentedValueIconFrame]];
    colorView3.backgroundColor = [UIColor cyanColor];
    [sixthHolder addSubview:colorView3];
    
    UIImageView* sixthItemIcon = [[UIImageView alloc] initWithFrame:[self indentedValueIconFrame]];
    sixthItemIcon.backgroundColor = [UIColor clearColor];
    sixthItemIcon.image = [UIImage imageNamed:@"color_mask.png"];
    [sixthHolder addSubview:sixthItemIcon];
    
    PSLabel* sixthItemValue = [[PSLabel alloc] initWithFrame:[self indentedValueFrame]];
    sixthItemValue.backgroundColor = [UIColor clearColor];
    sixthItemValue.font = DESIGN_MENU_SUBMENU_VALUES_FONT;
    sixthItemValue.textColor = DESIGN_MENU_SUBMENU_VALUES_COLOR;
    sixthItemValue.text = @"BÜZGÜLÜ";
    [sixthHolder addSubview:sixthItemValue];
    
    sixthHolder.clipsToBounds = YES;
    CALayer *bottomBorder6 = [CALayer layer];
    bottomBorder6.borderColor = DESIGN_MENU_SUBMENU_BORDER_BOTTOM_COLOR.CGColor;
    bottomBorder6.borderWidth = 1;
    bottomBorder6.frame = CGRectMake(0.0, frame6.size.height-1.0, frame6.size.width, 1.0);
    [sixthHolder.layer addSublayer:bottomBorder6];
    
    [self addViewOptionsSubviewsToSubmenu:submenu];
    
    [self addPriceSubviewsToSubmenu:submenu];
}

- (void) addSubviewsToTextSubmenu:(UIView*)submenu
{
    submenuItems = @[].mutableCopy;
    
    UIView* textViewHolder = [[UIView alloc] initWithFrame:[self textViewHolderFrame]];
    textViewHolder.backgroundColor = [UIColor clearColor];
    [submenu addSubview:textViewHolder];
    [submenuItems addObject:textViewHolder];
    
    UITextView* textView = [[UITextView alloc] initWithFrame:[self textViewFrame]];
    textView.backgroundColor = [UIColor whiteColor];
    textView.font = DESIGN_MENU_SUBMENU_TITLES_FONT;
    textView.textColor = DESIGN_MENU_SUBMENU_TITLES_COLOR;
    textView.contentInset = UIEdgeInsetsMake(10.0, 0.0, 10.0, 0.0);
    textView.textContainerInset = UIEdgeInsetsMake(10.0, 10.0, 10.0, 10.0);
    textView.contentSize = CGSizeMake(textView.frame.size.width, 1000.0);
    [textView setShowsHorizontalScrollIndicator:NO];
    textView.layer.borderWidth = 1.0;
    textView.layer.borderColor = DESIGN_MENU_SUBMENU_TEXTVIEW_BORDER_COLOR.CGColor;
    [textViewHolder addSubview:textView];
    
    UIButton* addNewButton = [UIButton buttonWithType:UIButtonTypeCustom];
    addNewButton.frame = [self addNewtextButtonFrame];
    addNewButton.center = CGPointMake(30.0, 30.0);
    addNewButton.backgroundColor = [UIColor clearColor];
    [addNewButton setBackgroundImage:[UIImage imageNamed:@"text_addnew_normal.png"] forState:UIControlStateNormal];
    [addNewButton setBackgroundImage:[UIImage imageNamed:@"text_addnew_highlighted.png"] forState:UIControlStateHighlighted];
    [textViewHolder addSubview:addNewButton];
    
    // opacity slider
    CGRect frame = [self thirdItemHolderFrame];
    
    UIView* firstHolder = [[UIView alloc] initWithFrame:frame];
    firstHolder.backgroundColor = [UIColor clearColor];
    [submenu addSubview:firstHolder];
    [submenuItems addObject:firstHolder];
    
    PSLabel* textOpacityTitle = [[PSLabel alloc] initWithFrame:[self titleFrame]];
    textOpacityTitle.backgroundColor = [UIColor clearColor];
    textOpacityTitle.font = DESIGN_MENU_SUBMENU_TITLES_FONT;
    textOpacityTitle.textColor = DESIGN_MENU_SUBMENU_TITLES_COLOR;
    textOpacityTitle.text = @"Opaklık Seçimi";
    [firstHolder addSubview:textOpacityTitle];
    
    PSSlider* opacitySlider = [[PSSlider alloc] initWithFrame:[self opacitySliderFrame]];
    [firstHolder addSubview:opacitySlider];
    [opacitySlider setSliderValue:0.5];
    
    firstHolder.clipsToBounds = YES;
    CALayer *bottomBorder = [CALayer layer];
    bottomBorder.borderColor = DESIGN_MENU_SUBMENU_BORDER_BOTTOM_COLOR.CGColor;
    bottomBorder.borderWidth = 1;
    bottomBorder.frame = CGRectMake(0.0, frame.size.height-1.0, frame.size.width, 1.0);
    [firstHolder.layer addSublayer:bottomBorder];
    
    // text font
    
    CGRect frame2 = [self fourthItemHolderFrame];
    
    UIView* secondHolder = [[UIView alloc] initWithFrame:frame2];
    secondHolder.backgroundColor = [UIColor clearColor];
    [submenu addSubview:secondHolder];
    [submenuItems addObject:secondHolder];
    
    PSLabel* textFontTitle = [[PSLabel alloc] initWithFrame:[self titleFrame]];
    textFontTitle.backgroundColor = [UIColor clearColor];
    textFontTitle.font = DESIGN_MENU_SUBMENU_TITLES_FONT;
    textFontTitle.textColor = DESIGN_MENU_SUBMENU_TITLES_COLOR;
    textFontTitle.text = @"Yazı Karakter Seçimi";
    [secondHolder addSubview:textFontTitle];
    
    PSLabel* textFontValue = [[PSLabel alloc] initWithFrame:[self valueFrame]];
    textFontValue.backgroundColor = [UIColor clearColor];
    textFontValue.font = DESIGN_MENU_SUBMENU_VALUES_FONT;
    textFontValue.textColor = DESIGN_MENU_SUBMENU_VALUES_COLOR;
    textFontValue.text = @"HELVETICA";
    [secondHolder addSubview:textFontValue];
    
    secondHolder.clipsToBounds = YES;
    CALayer *bottomBorder2 = [CALayer layer];
    bottomBorder2.borderColor = DESIGN_MENU_SUBMENU_BORDER_BOTTOM_COLOR.CGColor;
    bottomBorder2.borderWidth = 1;
    bottomBorder2.frame = CGRectMake(0.0, frame2.size.height-1.0, frame2.size.width, 1.0);
    [secondHolder.layer addSublayer:bottomBorder2];
    
    // text style
    
    CGRect frame3 = [self fifthItemHolderFrame];
    
    UIView* thirdHolder = [[UIView alloc] initWithFrame:frame3];
    thirdHolder.backgroundColor = [UIColor clearColor];
    [submenu addSubview:thirdHolder];
    [submenuItems addObject:thirdHolder];
    
    PSLabel* styleTitle = [[PSLabel alloc] initWithFrame:[self titleFrame]];
    styleTitle.backgroundColor = [UIColor clearColor];
    styleTitle.font = DESIGN_MENU_SUBMENU_TITLES_FONT;
    styleTitle.textColor = DESIGN_MENU_SUBMENU_TITLES_COLOR;
    styleTitle.text = @"Seçenekler";
    [thirdHolder addSubview:styleTitle];
    
    UIButton* boldnessButton = [UIButton buttonWithType:UIButtonTypeCustom];
    boldnessButton.frame = [self firstSettingFrame];
    boldnessButton.backgroundColor = [UIColor clearColor];
    [boldnessButton setBackgroundImage:[UIImage imageNamed:@"text_bold_normal.png"] forState:UIControlStateNormal];
    [boldnessButton setBackgroundImage:[UIImage imageNamed:@"text_bold_active.png"] forState:UIControlStateHighlighted];
    [boldnessButton setBackgroundImage:[UIImage imageNamed:@"text_bold_active.png"] forState:UIControlStateSelected];
    [thirdHolder addSubview:boldnessButton];
    
    UIButton* italicnessButton = [UIButton buttonWithType:UIButtonTypeCustom];
    italicnessButton.frame = [self secondSettingFrame];
    italicnessButton.backgroundColor = [UIColor clearColor];
    [italicnessButton setBackgroundImage:[UIImage imageNamed:@"text_italic_normal.png"] forState:UIControlStateNormal];
    [italicnessButton setBackgroundImage:[UIImage imageNamed:@"text_italic_active.png"] forState:UIControlStateHighlighted];
    [italicnessButton setBackgroundImage:[UIImage imageNamed:@"text_italic_active.png"] forState:UIControlStateSelected];
    [thirdHolder addSubview:italicnessButton];
    
    UIButton* directionButton = [UIButton buttonWithType:UIButtonTypeCustom];
    directionButton.frame = [self thirdSettingFrame];
    directionButton.backgroundColor = [UIColor clearColor];
    [directionButton setBackgroundImage:[UIImage imageNamed:@"text_ltr_active.png"] forState:UIControlStateNormal];
    [directionButton setBackgroundImage:nil forState:UIControlStateHighlighted];
    [directionButton setBackgroundImage:[UIImage imageNamed:@"text_ltr_active.png"] forState:UIControlStateSelected];
    [thirdHolder addSubview:directionButton];
    
    UIButton* leftAlignmentButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftAlignmentButton.frame = [self fourthSettingFrame];
    leftAlignmentButton.backgroundColor = [UIColor clearColor];
    [leftAlignmentButton setBackgroundImage:[UIImage imageNamed:@"text_leftalign_normal.png"] forState:UIControlStateNormal];
    [leftAlignmentButton setBackgroundImage:[UIImage imageNamed:@"text_leftalign_active.png"] forState:UIControlStateHighlighted];
    [leftAlignmentButton setBackgroundImage:[UIImage imageNamed:@"text_leftalign_active.png"] forState:UIControlStateSelected];
    [thirdHolder addSubview:leftAlignmentButton];
    
    UIButton* rightAlignmentButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightAlignmentButton.frame = [self fifthSettingFrame];
    rightAlignmentButton.backgroundColor = [UIColor clearColor];
    [rightAlignmentButton setBackgroundImage:[UIImage imageNamed:@"text_rightalign_normal.png"] forState:UIControlStateNormal];
    [rightAlignmentButton setBackgroundImage:[UIImage imageNamed:@"text_rightalign_active.png"] forState:UIControlStateHighlighted];
    [rightAlignmentButton setBackgroundImage:[UIImage imageNamed:@"text_rightalign_active.png"] forState:UIControlStateSelected];
    [thirdHolder addSubview:rightAlignmentButton];
    
    UIButton* centerAlignmentButton = [UIButton buttonWithType:UIButtonTypeCustom];
    centerAlignmentButton.frame = [self sixthSettingFrame];
    centerAlignmentButton.backgroundColor = [UIColor clearColor];
    [centerAlignmentButton setBackgroundImage:[UIImage imageNamed:@"text_centeralign_normal.png"] forState:UIControlStateNormal];
    [centerAlignmentButton setBackgroundImage:[UIImage imageNamed:@"text_centeralign_active.png"] forState:UIControlStateHighlighted];
    [centerAlignmentButton setBackgroundImage:[UIImage imageNamed:@"text_centeralign_active.png"] forState:UIControlStateSelected];
    [thirdHolder addSubview:centerAlignmentButton];
    
    thirdHolder.clipsToBounds = YES;
    CALayer *bottomBorder3 = [CALayer layer];
    bottomBorder3.borderColor = DESIGN_MENU_SUBMENU_BORDER_BOTTOM_COLOR.CGColor;
    bottomBorder3.borderWidth = 1;
    bottomBorder3.frame = CGRectMake(0.0, frame3.size.height-1.0, frame3.size.width, 1.0);
    [thirdHolder.layer addSublayer:bottomBorder3];
    
    // text color
    
    CGRect frame4 = [self sixthItemHolderFrame];
    
    UIView* fourthHolder = [[UIView alloc] initWithFrame:frame4];
    fourthHolder.backgroundColor = [UIColor clearColor];
    [submenu addSubview:fourthHolder];
    [submenuItems addObject:fourthHolder];
    
    PSLabel* textColorTitle = [[PSLabel alloc] initWithFrame:[self titleFrame]];
    textColorTitle.backgroundColor = [UIColor clearColor];
    textColorTitle.font = DESIGN_MENU_SUBMENU_TITLES_FONT;
    textColorTitle.textColor = DESIGN_MENU_SUBMENU_TITLES_COLOR;
    textColorTitle.text = @"Yazı Renk Seçimi";
    [fourthHolder addSubview:textColorTitle];
    
    UIView* colorView = [[UIView alloc] initWithFrame:[self indentedValueIconFrame]];
    colorView.backgroundColor = [UIColor cyanColor];
    [fourthHolder addSubview:colorView];
    
    UIImageView* fourthItemIcon = [[UIImageView alloc] initWithFrame:[self indentedValueIconFrame]];
    fourthItemIcon.backgroundColor = [UIColor clearColor];
    fourthItemIcon.image = [UIImage imageNamed:@"color_mask.png"];
    [fourthHolder addSubview:fourthItemIcon];
    
    PSLabel* fourthItemValue = [[PSLabel alloc] initWithFrame:[self indentedValueFrame]];
    fourthItemValue.backgroundColor = [UIColor clearColor];
    fourthItemValue.font = DESIGN_MENU_SUBMENU_VALUES_FONT;
    fourthItemValue.textColor = DESIGN_MENU_SUBMENU_VALUES_COLOR;
    fourthItemValue.text = @"TURKUAZ";
    [fourthHolder addSubview:fourthItemValue];
    
    fourthHolder.clipsToBounds = YES;
    CALayer *bottomBorder4 = [CALayer layer];
    bottomBorder4.borderColor = DESIGN_MENU_SUBMENU_BORDER_BOTTOM_COLOR.CGColor;
    bottomBorder4.borderWidth = 1;
    bottomBorder4.frame = CGRectMake(0.0, frame4.size.height-1.0, frame4.size.width, 1.0);
    [fourthHolder.layer addSublayer:bottomBorder4];
    
    [self addViewOptionsSubviewsToSubmenu:submenu];
    
    [self addDeleteSubviewsToSubmenu:submenu];
    
    [self addPriceSubviewsToSubmenu:submenu];
    
}

- (void) addSubviewsToImageSubmenu:(UIView*)submenu
{
    submenuItems = @[].mutableCopy;
    
    UIView* imageGalleryHolder = [[UIView alloc] initWithFrame:[self imageGalleryHolderFrame]];
    imageGalleryHolder.backgroundColor = [UIColor clearColor];
    [submenu addSubview:imageGalleryHolder];
    [submenuItems addObject:imageGalleryHolder];
    
    UIView* imageGallery = [[UIView alloc] initWithFrame:[self imageGalleryFrame]];
    imageGallery.backgroundColor = DESIGN_MENU_SUBMENU_IMAGE_GALLERY_BACKGROUND_COLOR;
    imageGallery.layer.borderColor = DESIGN_MENU_SUBMENU_IMAGE_GALLERY_BORDER_COLOR.CGColor;
    imageGallery.layer.borderWidth = 1.0;
    [imageGalleryHolder addSubview:imageGallery];
    [submenuItems addObject:imageGallery];
    
    CGRect frame = [self thirdItemHolderFrame];
    
    UIView* firstHolder = [[UIView alloc] initWithFrame:frame];
    firstHolder.backgroundColor = [UIColor clearColor];
    [submenu addSubview:firstHolder];
    [submenuItems addObject:firstHolder];
    
    UIButton* selectImageButton = [UIButton buttonWithType:UIButtonTypeCustom];
    selectImageButton.frame = [self selectImageButtonFrame];
    selectImageButton.backgroundColor = [UIColor clearColor];
    [selectImageButton setBackgroundImage:[UIImage imageNamed:@"image_selectphoto_normal.png"] forState:UIControlStateNormal];
    [selectImageButton setBackgroundImage:[UIImage imageNamed:@"image_selectphoto_highlighted.png"] forState:UIControlStateHighlighted];
    [firstHolder addSubview:selectImageButton];
    
    UIButton* captureImageButton = [UIButton buttonWithType:UIButtonTypeCustom];
    captureImageButton.frame = [self captureImageButtonFrame];
    captureImageButton.backgroundColor = [UIColor clearColor];
    [captureImageButton setBackgroundImage:[UIImage imageNamed:@"image_takephoto_normal.png"] forState:UIControlStateNormal];
    [captureImageButton setBackgroundImage:[UIImage imageNamed:@"image_takephoto_highlighted.png"] forState:UIControlStateHighlighted];
    [firstHolder addSubview:captureImageButton];
    
    CGRect frame2 = [self sixthItemHolderFrame];
    
    UIView* secondHolder = [[UIView alloc] initWithFrame:frame2];
    secondHolder.backgroundColor = [UIColor clearColor];
    [submenu addSubview:secondHolder];
    [submenuItems addObject:secondHolder];
    
    PSLabel* imageOpacityTitle = [[PSLabel alloc] initWithFrame:[self titleFrame]];
    imageOpacityTitle.backgroundColor = [UIColor clearColor];
    imageOpacityTitle.font = DESIGN_MENU_SUBMENU_TITLES_FONT;
    imageOpacityTitle.textColor = DESIGN_MENU_SUBMENU_TITLES_COLOR;
    imageOpacityTitle.text = @"Opaklık Seçimi";
    [secondHolder addSubview:imageOpacityTitle];
    
    PSSlider* opacitySlider = [[PSSlider alloc] initWithFrame:[self opacitySliderFrame]];
    [secondHolder addSubview:opacitySlider];
    [opacitySlider setSliderValue:0.5];
    
    secondHolder.clipsToBounds = YES;
    CALayer *bottomBorder = [CALayer layer];
    bottomBorder.borderColor = DESIGN_MENU_SUBMENU_BORDER_BOTTOM_COLOR.CGColor;
    bottomBorder.borderWidth = 1;
    bottomBorder.frame = CGRectMake(0.0, frame2.size.height-1.0, frame2.size.width, 1.0);
    [secondHolder.layer addSublayer:bottomBorder];
    
    [self addViewOptionsSubviewsToSubmenu:submenu];
    
    [self addDeleteSubviewsToSubmenu:submenu];
    
    [self addPriceSubviewsToSubmenu:submenu];
    
}
- (void) addViewOptionsSubviewsToSubmenu:(UIView*)submenu
{
    UIView* viewOptionsHolder = [[UIView alloc] initWithFrame:[self viewOptionsHolderFrame]];
    viewOptionsHolder.backgroundColor = [UIColor clearColor];
    [submenu addSubview:viewOptionsHolder];
    [submenuItems addObject:viewOptionsHolder];
    
    UIImageView* frontView = [[UIImageView alloc] initWithFrame:[self frontViewFrame]];
    frontView.backgroundColor = [UIColor clearColor];
    frontView.image = [UIImage imageNamed:@"view_front.png"];
    [viewOptionsHolder addSubview:frontView];
    
    UIImageView* rightView = [[UIImageView alloc] initWithFrame:[self rightViewFrame]];
    rightView.backgroundColor = [UIColor clearColor];
    rightView.image = [UIImage imageNamed:@"view_right.png"];
    [viewOptionsHolder addSubview:rightView];
    
    UIImageView* backView = [[UIImageView alloc] initWithFrame:[self backViewFrame]];
    backView.backgroundColor = [UIColor clearColor];
    backView.image = [UIImage imageNamed:@"view_back.png"];
    [viewOptionsHolder addSubview:backView];
    
    UIImageView* leftView = [[UIImageView alloc] initWithFrame:[self leftViewFrame]];
    leftView.backgroundColor = [UIColor clearColor];
    leftView.image = [UIImage imageNamed:@"view_left.png"];
    [viewOptionsHolder addSubview:leftView];
}
- (void) addDeleteSubviewsToSubmenu:(UIView*)submenu
{
    UIView* deleteHolder = [[UIView alloc] initWithFrame:[self deleteHolderFrame]];
    deleteHolder.backgroundColor = [UIColor clearColor];
    [submenu addSubview:deleteHolder];
    [submenuItems addObject:deleteHolder];
    
    UIButton* deleteLastButton = [UIButton buttonWithType:UIButtonTypeCustom];
    deleteLastButton.frame = [self deleteLastButtonFrame];
    deleteLastButton.backgroundColor = [UIColor clearColor];
    [deleteLastButton setBackgroundImage:[UIImage imageNamed:@"delete_last_normal.png"] forState:UIControlStateNormal];
    [deleteLastButton setBackgroundImage:[UIImage imageNamed:@"delete_last_highlighted.png"] forState:UIControlStateHighlighted];
    [deleteHolder addSubview:deleteLastButton];
    
    UIButton* deleteAllButton = [UIButton buttonWithType:UIButtonTypeCustom];
    deleteAllButton.frame = [self deleteAllButtonFrame];
    deleteAllButton.backgroundColor = [UIColor clearColor];
    [deleteAllButton setBackgroundImage:[UIImage imageNamed:@"delete_all_normal.png"] forState:UIControlStateNormal];
    [deleteAllButton setBackgroundImage:[UIImage imageNamed:@"delete_all_highlighted.png"] forState:UIControlStateHighlighted];
    [deleteHolder addSubview:deleteAllButton];
}
- (void) addPriceSubviewsToSubmenu:(UIView*)submenu
{
    UIView* priceHolder = [[UIView alloc] initWithFrame:[self priceHolderFrame]];
    priceHolder.backgroundColor = [UIColor clearColor];
    [submenu addSubview:priceHolder];
    [submenuItems addObject:priceHolder];
    
    PSLabel* priceLabel = [[PSLabel alloc] initWithFrame:[self priceLabelFrame]];
    priceLabel.backgroundColor = [UIColor clearColor];
    priceLabel.font = DESIGN_MENU_SUBMENU_PRICE_FONT;
    priceLabel.textColor = DESIGN_MENU_SUBMENU_PRICE_COLOR;
    priceLabel.textAlignment = NSTextAlignmentRight;
    priceLabel.text = @"123,80";
    [priceHolder addSubview:priceLabel];
    
    UIButton* tlButton = [UIButton buttonWithType:UIButtonTypeCustom];
    tlButton.frame = [self tlButtonFrame];
    tlButton.backgroundColor = [UIColor clearColor];
    [tlButton setBackgroundImage:[UIImage imageNamed:@"turkish_lira_normal.png"] forState:UIControlStateNormal];
    [tlButton setBackgroundImage:[UIImage imageNamed:@"turkish_lira_highlighted.png"] forState:UIControlStateHighlighted];
    [priceHolder addSubview:tlButton];
}
#pragma mark - Displaying submenus
- (void) showNextSubmenu
{
    CGFloat delay = 0.0;
    if (currentSubmenu != nil) {
        delay = 0.35;
        UIView* holder = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, currentSubmenu.frame.size.width, currentSubmenu.frame.size.height)];
        holder.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.0];
        [currentSubmenu addSubview:holder];
        
        [UIView animateWithDuration:0.45 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
            CGRect frame = currentSubmenu.frame;
            frame.origin.y += SUBMENU_HEIGHT;
            currentSubmenu.frame = frame;
            
            holder.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
        } completion:nil];
    }
    
    [UIView animateWithDuration:0.5 delay:delay options:UIViewAnimationOptionCurveEaseOut animations:^{
        CGRect frame = nextSubmenu.frame;
        frame.origin.y -= SUBMENU_HEIGHT;
        nextSubmenu.frame = frame;
    } completion:^(BOOL finished) {
        [currentSubmenu removeFromSuperview];
        currentSubmenuType = nextSubmenuType;
        currentSubmenu = nextSubmenu;
        nextSubmenu = nil;
        nextSubmenuType = SUBMENU_TYPE_NONE;
    }];
    
    for (int i = 0; i < submenuItems.count; i++) {
        UIView* currentView = [submenuItems objectAtIndex:i];
        CGRect frame = currentView.frame;
        CGRect oldFrame = frame;
        frame.origin.y = SUBMENU_HEIGHT;
        currentView.frame = frame;
        currentView.alpha = 0.0;
        [UIView animateWithDuration:0.30 delay:delay+0.30+i*0.05 options:UIViewAnimationOptionCurveEaseOut animations:^{
            currentView.frame = oldFrame;
            currentView.alpha = 1.0;
        } completion:^(BOOL finished) {
            ;
        }];
    }
}

@end
