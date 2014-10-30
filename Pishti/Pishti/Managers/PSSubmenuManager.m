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
#import "PSTableView.h"
#import "PSTableViewCell.h"
#import "PSSubmenuView.h"
#import "PSSubmenuTextView.h"
#import "PSDesignLabel.h"

#define SUBMENU_HEIGHT 255.0

static PSSubmenuManager* __sharedInstance;

@implementation PSSubmenuManager
{
#pragma mark - Variables
    PSDesignViewController2* submenuDelegate;
    
    PSSubmenuType currentSubmenuType;
    PSSubmenuType nextSubmenuType;
    UIView* currentSubmenu;
    UIView* nextSubmenu;
    
    NSMutableArray* submenuItems;
    
    UIImagePickerController* imagePicker;
    
    PSSlider* imageOpacitySlider;
    PSSlider* textOpacitySlider;
    
    NSArray* colors;
    NSArray* colorNames;
    
    PSTableView* fabricColorTableView;
    UIView* fabricColorTableViewHolder;
    UIView* fabricColorView;
    PSLabel* fabricColorValue;
    
    PSTableView* textColorTableView;
    UIView* textColorTableViewHolder;
    UIView* textColorView;
    PSLabel* textColorValue;
    
    PSTableView* textFontTableView;
    UIView* textFontTableViewHolder;
    PSLabel* textFontValue;
    
    NSArray* fontFamilyNames;
    
    NSMutableDictionary* labelSettings;
    NSMutableDictionary* fabricSettings;
    NSMutableDictionary* imageSettings;
    
    UIButton* boldnessButton;
    UIButton* italicnessButton;
    UIButton* directionButton;
    UIButton* leftAlignmentButton;
    UIButton* rightAlignmentButton;
    UIButton* centerAlignmentButton;
    
    PSSubmenuTextView* textView;
    UIView* textViewHolder;
    
    PSSubmenuTextView* proxyTextView;
    UIView* proxyTextViewHolder;
    
    CGFloat heightChange;
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
- (CGRect) proxyTextViewHolderFrame
{
    return CGRectMake(0.0, SCREEN_SIZE.height-SUBMENU_HEIGHT, 260.0, 156.0);
}
- (CGRect) proxyTextViewFrame
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
        [__sharedInstance submenuSetups];
        [[NSNotificationCenter defaultCenter] addObserver:__sharedInstance
                                                 selector:@selector(keyboardWillShow:)
                                                     name:UIKeyboardWillShowNotification
                                                   object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:__sharedInstance
                                                 selector:@selector(keyboardWillHide:)
                                                     name:UIKeyboardWillHideNotification
                                                   object:nil];
    }
    
    return __sharedInstance;
}
- (void) cleanups
{
    currentSubmenuType = SUBMENU_TYPE_NONE;
    currentSubmenu = nil;
}
- (void) submenuSetups
{
    colors = @[[UIColor colorWithRed:57.0/255.0 green:66.0/255.0 blue:100.0/255.0 alpha:1.0],
               [UIColor colorWithRed:17.0/255.0 green:168.0/255.0 blue:171.0/255.0 alpha:1.0],
               [UIColor colorWithRed:230.0/255.0 green:76.0/255.0 blue:101.0/255.0 alpha:1.0],
               [UIColor colorWithRed:252.0/255.0 green:177.0/255.0 blue:80.0/255.0 alpha:1.0],
               [UIColor colorWithRed:185.0/255.0 green:190.0/255.0 blue:60.0/255.0 alpha:1.0],
               [UIColor colorWithRed:123.0/255.0 green:91.0/255.0 blue:162.0/255.0 alpha:1.0],
               [UIColor colorWithRed:111.0/255.0 green:104.0/255.0 blue:119.0/255.0 alpha:1.0]];
    
    colorNames = @[@"KOYU MOR",
                   @"TURKUAZ",
                   @"SOFT PEMBE",
                   @"HARDAL SARI",
                   @"ÇİM YEŞİL",
                   @"MOR",
                   @"FÜME"];
    
    fontFamilyNames = @[@"Arial",
                        @"Bookman Old Style",
                        @"Rockwell",
                        @"TR McLean",
                        @"TR Eagles",
                        @"TR Courier New",
                        @"Trebuchet MS",
                        @"Helvetica"];
    
    fontFamilyNames = [fontFamilyNames sortedArrayUsingComparator:^NSComparisonResult(NSString* obj1, NSString* obj2) {
        return [obj1 compare:obj2];
    }];
    
    fabricSettings = @{FABRIC_COLOR_INDEX_KEY:[NSNumber numberWithInteger:2]}.mutableCopy;
    
    labelSettings = @{CURRENT_TEXT_KEY:@"",
                      TEXT_OPACITY_KEY:[NSNumber numberWithFloat:1.0],
                      BOLDNESS_KEY:[NSNumber numberWithBool:NO],
                      ITALICNESS_KEY:[NSNumber numberWithBool:NO],
                      DIRECTION_KEY:[NSNumber numberWithBool:NO],
                      TEXT_COLOR_INDEX_KEY:[NSNumber numberWithInteger:0],
                      TEXT_ALIGNMENT_KEY:[NSNumber numberWithInteger:NSTextAlignmentLeft],
                      TEXT_FONT_INDEX_KEY:[NSNumber numberWithInteger:0]}.mutableCopy;
    
    imageSettings = @{IMAGE_OPACITY_KEY:[NSNumber numberWithFloat:1.0]}.mutableCopy;
    
}
#pragma mark - Public methods
- (void) setSubmenuDelegate:(PSDesignViewController2*)viewController
{
    submenuDelegate = viewController;
}
- (void) showSubmenuWithType:(PSSubmenuType)submenuType
{
    nextSubmenuType = submenuType;
    
    if (currentSubmenuType == nextSubmenuType) {
        return;
    } else {
        [self removeAnyTable];
        nextSubmenu = [self generateSubmenuWithType:nextSubmenuType];
        [submenuDelegate.view addSubview:nextSubmenu];
        [submenuDelegate addViewToUnwantedViews:nextSubmenu];
        [self showNextSubmenu];
    }
}
#pragma mark - Generating submenus
- (UIView*) generateSubmenuWithType:(PSSubmenuType)submenuType
{
    CGRect frame = submenuDelegate.view.frame;
    PSSubmenuView* submenu = [[PSSubmenuView alloc] initWithFrame:CGRectMake(0.0, frame.size.height, frame.size.width, SUBMENU_HEIGHT)];
    
    
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
    
    UIButton* fourthHolder = [UIButton buttonWithType:UIButtonTypeCustom];
    fourthHolder.frame = frame4;
    [fourthHolder addTarget:self action:@selector(fabricColorClicked:) forControlEvents:UIControlEventTouchUpInside];
    fourthHolder.backgroundColor = [UIColor clearColor];
    [submenu addSubview:fourthHolder];
    [submenuItems addObject:fourthHolder];
    
    PSLabel* fourthItemTitle = [[PSLabel alloc] initWithFrame:[self titleFrame]];
    fourthItemTitle.backgroundColor = [UIColor clearColor];
    fourthItemTitle.font = DESIGN_MENU_SUBMENU_TITLES_FONT;
    fourthItemTitle.textColor = DESIGN_MENU_SUBMENU_TITLES_COLOR;
    fourthItemTitle.text = @"Kumaş Renk Seçimi";
    [fourthHolder addSubview:fourthItemTitle];
    
    fabricColorView = [[UIView alloc] initWithFrame:[self indentedValueIconFrame]];
    fabricColorView.backgroundColor = [UIColor clearColor];
    [fourthHolder addSubview:fabricColorView];
    
    UIImageView* fourthItemIcon = [[UIImageView alloc] initWithFrame:[self indentedValueIconFrame]];
    fourthItemIcon.backgroundColor = [UIColor clearColor];
    fourthItemIcon.image = [UIImage imageNamed:@"color_mask.png"];
    fourthItemIcon.userInteractionEnabled = NO;
    [fourthHolder addSubview:fourthItemIcon];
    
    fabricColorValue = [[PSLabel alloc] initWithFrame:[self indentedValueFrame]];
    fabricColorValue.backgroundColor = [UIColor clearColor];
    fabricColorValue.font = DESIGN_MENU_SUBMENU_VALUES_FONT;
    [fourthHolder addSubview:fabricColorValue];
    
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
    
    [self configureFabricSubmenuWithCurrentOptions];
}
- (void) addSubviewsToTextSubmenu:(UIView*)submenu
{
    submenuItems = @[].mutableCopy;
    
    textViewHolder = [[UIView alloc] initWithFrame:[self textViewHolderFrame]];
    textViewHolder.backgroundColor = [UIColor clearColor];
    [submenu addSubview:textViewHolder];
    [submenuItems addObject:textViewHolder];
    
    textView = [[PSSubmenuTextView alloc] initWithFrame:[self textViewFrame]];
    textView.backgroundColor = [UIColor whiteColor];
    textView.contentInset = UIEdgeInsetsMake(10.0, 0.0, 10.0, 0.0);
    textView.textContainerInset = UIEdgeInsetsMake(10.0, 10.0, 10.0, 10.0);
    textView.contentSize = CGSizeMake(textView.frame.size.width, 1000.0);
    [textView setShowsHorizontalScrollIndicator:NO];
    textView.layer.borderWidth = 1.0;
    textView.layer.borderColor = DESIGN_MENU_SUBMENU_TEXTVIEW_BORDER_COLOR.CGColor;
    textView.delegate = self;
    [textViewHolder addSubview:textView];
    
    UIButton* addNewLabelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    addNewLabelButton.frame = [self addNewtextButtonFrame];
    addNewLabelButton.center = CGPointMake(30.0, 30.0);
    addNewLabelButton.backgroundColor = [UIColor clearColor];
    [addNewLabelButton setBackgroundImage:[UIImage imageNamed:@"text_addnew_normal.png"] forState:UIControlStateNormal];
    [addNewLabelButton setBackgroundImage:[UIImage imageNamed:@"text_addnew_highlighted.png"] forState:UIControlStateHighlighted];
    [addNewLabelButton addTarget:self action:@selector(addNewLabelClicked:) forControlEvents:UIControlEventTouchUpInside];
    [textViewHolder addSubview:addNewLabelButton];
    
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
    
    textOpacitySlider = [[PSSlider alloc] initWithFrame:[self opacitySliderFrame]];
    [firstHolder addSubview:textOpacitySlider];
    
    firstHolder.clipsToBounds = YES;
    CALayer *bottomBorder = [CALayer layer];
    bottomBorder.borderColor = DESIGN_MENU_SUBMENU_BORDER_BOTTOM_COLOR.CGColor;
    bottomBorder.borderWidth = 1;
    bottomBorder.frame = CGRectMake(0.0, frame.size.height-1.0, frame.size.width, 1.0);
    [firstHolder.layer addSublayer:bottomBorder];
    
    // text font
    
    CGRect frame2 = [self fourthItemHolderFrame];
    
    UIButton* secondHolder = [UIButton buttonWithType:UIButtonTypeCustom];
    secondHolder.frame = frame2;
    [secondHolder addTarget:self action:@selector(textFontClicked:) forControlEvents:UIControlEventTouchUpInside];
    secondHolder.backgroundColor = [UIColor clearColor];
    [submenu addSubview:secondHolder];
    [submenuItems addObject:secondHolder];
    
    PSLabel* textFontTitle = [[PSLabel alloc] initWithFrame:[self titleFrame]];
    textFontTitle.backgroundColor = [UIColor clearColor];
    textFontTitle.font = DESIGN_MENU_SUBMENU_TITLES_FONT;
    textFontTitle.textColor = DESIGN_MENU_SUBMENU_TITLES_COLOR;
    textFontTitle.text = @"Yazı Karakter Seçimi";
    [secondHolder addSubview:textFontTitle];
    
    textFontValue = [[PSLabel alloc] initWithFrame:[self valueFrame]];
    textFontValue.backgroundColor = [UIColor clearColor];
    textFontValue.font = DESIGN_MENU_SUBMENU_VALUES_FONT;
    textFontValue.textColor = DESIGN_MENU_SUBMENU_VALUES_COLOR;
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
    
    boldnessButton = [UIButton buttonWithType:UIButtonTypeCustom];
    boldnessButton.frame = [self firstSettingFrame];
    boldnessButton.backgroundColor = [UIColor clearColor];
    boldnessButton.adjustsImageWhenHighlighted = NO;
    [boldnessButton setBackgroundImage:[UIImage imageNamed:@"text_bold_normal.png"] forState:UIControlStateNormal];
    [boldnessButton setBackgroundImage:[UIImage imageNamed:@"text_bold_active.png"] forState:UIControlStateSelected];
    [boldnessButton addTarget:self action:@selector(boldnessClicked:) forControlEvents:UIControlEventTouchUpInside];
    [thirdHolder addSubview:boldnessButton];
    
    italicnessButton = [UIButton buttonWithType:UIButtonTypeCustom];
    italicnessButton.frame = [self secondSettingFrame];
    italicnessButton.backgroundColor = [UIColor clearColor];
    italicnessButton.adjustsImageWhenHighlighted = NO;
    [italicnessButton setBackgroundImage:[UIImage imageNamed:@"text_italic_normal.png"] forState:UIControlStateNormal];
    [italicnessButton setBackgroundImage:[UIImage imageNamed:@"text_italic_active.png"] forState:UIControlStateSelected];
    [italicnessButton addTarget:self action:@selector(italicnessClicked:) forControlEvents:UIControlEventTouchUpInside];
    [thirdHolder addSubview:italicnessButton];
    
    directionButton = [UIButton buttonWithType:UIButtonTypeCustom];
    directionButton.frame = [self thirdSettingFrame];
    directionButton.backgroundColor = [UIColor clearColor];
    directionButton.adjustsImageWhenHighlighted = NO;
    [directionButton setBackgroundImage:[UIImage imageNamed:@"text_ltr_active.png"] forState:UIControlStateNormal];
    [directionButton setBackgroundImage:[UIImage imageNamed:@"text_ttb_active.png"] forState:UIControlStateSelected];
    [directionButton addTarget:self action:@selector(directionClicked:) forControlEvents:UIControlEventTouchUpInside];
    [thirdHolder addSubview:directionButton];
    
    leftAlignmentButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftAlignmentButton.frame = [self fourthSettingFrame];
    leftAlignmentButton.backgroundColor = [UIColor clearColor];
    leftAlignmentButton.adjustsImageWhenHighlighted = NO;
    [leftAlignmentButton setBackgroundImage:[UIImage imageNamed:@"text_leftalign_normal.png"] forState:UIControlStateNormal];
    [leftAlignmentButton setBackgroundImage:[UIImage imageNamed:@"text_leftalign_active.png"] forState:UIControlStateSelected];
    [leftAlignmentButton addTarget:self action:@selector(leftAlignmentClicked:) forControlEvents:UIControlEventTouchUpInside];
    [thirdHolder addSubview:leftAlignmentButton];
    
    rightAlignmentButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightAlignmentButton.frame = [self fifthSettingFrame];
    rightAlignmentButton.backgroundColor = [UIColor clearColor];
    rightAlignmentButton.adjustsImageWhenHighlighted = NO;
    [rightAlignmentButton setBackgroundImage:[UIImage imageNamed:@"text_rightalign_normal.png"] forState:UIControlStateNormal];
    [rightAlignmentButton setBackgroundImage:[UIImage imageNamed:@"text_rightalign_active.png"] forState:UIControlStateSelected];
    [rightAlignmentButton addTarget:self action:@selector(rightAlignmentClicked:) forControlEvents:UIControlEventTouchUpInside];
    [thirdHolder addSubview:rightAlignmentButton];
    
    centerAlignmentButton = [UIButton buttonWithType:UIButtonTypeCustom];
    centerAlignmentButton.frame = [self sixthSettingFrame];
    centerAlignmentButton.backgroundColor = [UIColor clearColor];
    centerAlignmentButton.adjustsImageWhenHighlighted = NO;
    [centerAlignmentButton setBackgroundImage:[UIImage imageNamed:@"text_centeralign_normal.png"] forState:UIControlStateNormal];
    [centerAlignmentButton setBackgroundImage:[UIImage imageNamed:@"text_centeralign_active.png"] forState:UIControlStateSelected];
    [centerAlignmentButton addTarget:self action:@selector(centerAlignmentClicked:) forControlEvents:UIControlEventTouchUpInside];
    [thirdHolder addSubview:centerAlignmentButton];
    
    thirdHolder.clipsToBounds = YES;
    CALayer *bottomBorder3 = [CALayer layer];
    bottomBorder3.borderColor = DESIGN_MENU_SUBMENU_BORDER_BOTTOM_COLOR.CGColor;
    bottomBorder3.borderWidth = 1;
    bottomBorder3.frame = CGRectMake(0.0, frame3.size.height-1.0, frame3.size.width, 1.0);
    [thirdHolder.layer addSublayer:bottomBorder3];
    
    // text color
    
    CGRect frame4 = [self sixthItemHolderFrame];
    
    UIButton* fourthHolder = [UIButton buttonWithType:UIButtonTypeCustom];
    fourthHolder.frame = frame4;
    [fourthHolder addTarget:self action:@selector(textColorClicked:) forControlEvents:UIControlEventTouchUpInside];
    fourthHolder.backgroundColor = [UIColor clearColor];
    [submenu addSubview:fourthHolder];
    [submenuItems addObject:fourthHolder];
    
    PSLabel* textColorTitle = [[PSLabel alloc] initWithFrame:[self titleFrame]];
    textColorTitle.backgroundColor = [UIColor clearColor];
    textColorTitle.font = DESIGN_MENU_SUBMENU_TITLES_FONT;
    textColorTitle.textColor = DESIGN_MENU_SUBMENU_TITLES_COLOR;
    textColorTitle.text = @"Yazı Renk Seçimi";
    [fourthHolder addSubview:textColorTitle];
    
    textColorView = [[UIView alloc] initWithFrame:[self indentedValueIconFrame]];
    textColorView.backgroundColor = [UIColor clearColor];
    [fourthHolder addSubview:textColorView];
    
    UIImageView* fourthItemIcon = [[UIImageView alloc] initWithFrame:[self indentedValueIconFrame]];
    fourthItemIcon.backgroundColor = [UIColor clearColor];
    fourthItemIcon.image = [UIImage imageNamed:@"color_mask_main.png"];
    [fourthHolder addSubview:fourthItemIcon];
    
    textColorValue = [[PSLabel alloc] initWithFrame:[self indentedValueFrame]];
    textColorValue.backgroundColor = [UIColor clearColor];
    textColorValue.font = DESIGN_MENU_SUBMENU_VALUES_FONT;
    [fourthHolder addSubview:textColorValue];
    
    fourthHolder.clipsToBounds = YES;
    CALayer *bottomBorder4 = [CALayer layer];
    bottomBorder4.borderColor = DESIGN_MENU_SUBMENU_BORDER_BOTTOM_COLOR.CGColor;
    bottomBorder4.borderWidth = 1;
    bottomBorder4.frame = CGRectMake(0.0, frame4.size.height-1.0, frame4.size.width, 1.0);
    [fourthHolder.layer addSublayer:bottomBorder4];
    
    [self addViewOptionsSubviewsToSubmenu:submenu];
    
    [self addDeleteSubviewsToSubmenu:submenu];
    
    [self addPriceSubviewsToSubmenu:submenu];
    
    [self configureTextSubmenuWithCurrentOptions];
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
    [selectImageButton addTarget:self action:@selector(selectImageClicked:) forControlEvents:UIControlEventTouchUpInside];
    [firstHolder addSubview:selectImageButton];
    
    UIButton* captureImageButton = [UIButton buttonWithType:UIButtonTypeCustom];
    captureImageButton.frame = [self captureImageButtonFrame];
    captureImageButton.backgroundColor = [UIColor clearColor];
    [captureImageButton setBackgroundImage:[UIImage imageNamed:@"image_takephoto_normal.png"] forState:UIControlStateNormal];
    [captureImageButton setBackgroundImage:[UIImage imageNamed:@"image_takephoto_highlighted.png"] forState:UIControlStateHighlighted];
    [captureImageButton addTarget:self action:@selector(captureImageClicked:) forControlEvents:UIControlEventTouchUpInside];
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
    
    imageOpacitySlider = [[PSSlider alloc] initWithFrame:[self opacitySliderFrame]];
    [secondHolder addSubview:imageOpacitySlider];
    
    secondHolder.clipsToBounds = YES;
    CALayer *bottomBorder = [CALayer layer];
    bottomBorder.borderColor = DESIGN_MENU_SUBMENU_BORDER_BOTTOM_COLOR.CGColor;
    bottomBorder.borderWidth = 1;
    bottomBorder.frame = CGRectMake(0.0, frame2.size.height-1.0, frame2.size.width, 1.0);
    [secondHolder.layer addSublayer:bottomBorder];
    
    [self addViewOptionsSubviewsToSubmenu:submenu];
    
    [self addDeleteSubviewsToSubmenu:submenu];
    
    [self addPriceSubviewsToSubmenu:submenu];
    
    [self configureImageSubmenuWithCurrentOptions];
}
- (void) addViewOptionsSubviewsToSubmenu:(UIView*)submenu
{
    UIView* viewOptionsHolder = [[UIView alloc] initWithFrame:[self viewOptionsHolderFrame]];
    viewOptionsHolder.backgroundColor = [UIColor clearColor];
    [submenu addSubview:viewOptionsHolder];
    [submenuItems addObject:viewOptionsHolder];
    
    UIImageView* frontView = [[UIImageView alloc] initWithFrame:[self frontViewFrame]];
    frontView.backgroundColor = [UIColor clearColor];
    frontView.image = [UIImage imageNamed:@"view_front_selected.png"];
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
    [deleteLastButton addTarget:self action:@selector(deleteLastClicked:) forControlEvents:UIControlEventTouchUpInside];
    [deleteHolder addSubview:deleteLastButton];
    
    UIButton* deleteAllButton = [UIButton buttonWithType:UIButtonTypeCustom];
    deleteAllButton.frame = [self deleteAllButtonFrame];
    deleteAllButton.backgroundColor = [UIColor clearColor];
    [deleteAllButton setBackgroundImage:[UIImage imageNamed:@"delete_all_normal.png"] forState:UIControlStateNormal];
    [deleteAllButton setBackgroundImage:[UIImage imageNamed:@"delete_all_highlighted.png"] forState:UIControlStateHighlighted];
    [deleteAllButton addTarget:self action:@selector(deleteAllClicked:) forControlEvents:UIControlEventTouchUpInside];
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
#pragma mark - Configuring submenus
- (void) configureFabricSubmenuWithCurrentOptions
{
    NSInteger fabricColorIndex = [[fabricSettings objectForKey:FABRIC_COLOR_INDEX_KEY] integerValue];
    
    fabricColorView.backgroundColor = [colors objectAtIndex:fabricColorIndex];
    
    fabricColorValue.textColor = [colors objectAtIndex:fabricColorIndex];
    fabricColorValue.text = [colorNames objectAtIndex:fabricColorIndex];
}
- (void) configureTextSubmenuWithCurrentOptions
{
    [submenuDelegate labelSettingsChanged:labelSettings];
    
    CGFloat opacity = [[labelSettings objectForKey:TEXT_OPACITY_KEY] floatValue];
    NSInteger textFontIndex = [[labelSettings objectForKey:TEXT_FONT_INDEX_KEY] integerValue];
    bool isBold = [[labelSettings objectForKey:BOLDNESS_KEY] boolValue];
    bool isItalic = [[labelSettings objectForKey:ITALICNESS_KEY] boolValue];
    bool direction = [[labelSettings objectForKey:DIRECTION_KEY] boolValue];
    NSInteger alignment = [[labelSettings objectForKey:TEXT_ALIGNMENT_KEY] integerValue];
    NSInteger textColorIndex = [[labelSettings objectForKey:TEXT_COLOR_INDEX_KEY] integerValue];
    NSString* currentText = [labelSettings objectForKey:CURRENT_TEXT_KEY];
    
    [textOpacitySlider setSliderValue:opacity];
    
    textColorView.backgroundColor = [colors objectAtIndex:textColorIndex];
    
    textColorValue.textColor = [colors objectAtIndex:textColorIndex];
    textColorValue.text = [colorNames objectAtIndex:textColorIndex];
    
    textFontValue.text = [fontFamilyNames objectAtIndex:textFontIndex];
    
    NSString* fontName = [[Util sharedInstance] getFontNameForFamily:[fontFamilyNames objectAtIndex:textFontIndex] andIsBold:isBold andIsItalic:isItalic];
    textView.font = [UIFont fontWithName:fontName size:DEFAULT_FONT_HEIGHT];
    textView.textColor = [colors objectAtIndex:textColorIndex];
    textView.tintColor = [colors objectAtIndex:textColorIndex];
    textView.text = currentText;
    textView.textAlignment = alignment;
    
    if (isBold) {
        boldnessButton.selected = YES;
    } else {
        boldnessButton.selected = NO;
    }
    if (isItalic) {
        italicnessButton.selected = YES;
    } else {
        italicnessButton.selected = NO;
    }
    if (direction) {
        directionButton.selected = YES;
    } else {
        directionButton.selected = NO;
    }
    switch (alignment) {
        case NSTextAlignmentLeft:
            leftAlignmentButton.selected = YES;
            rightAlignmentButton.selected = NO;
            centerAlignmentButton.selected = NO;
            break;
        case NSTextAlignmentRight:
            leftAlignmentButton.selected = NO;
            rightAlignmentButton.selected = YES;
            centerAlignmentButton.selected = NO;
            break;
        case NSTextAlignmentCenter:
            leftAlignmentButton.selected = NO;
            rightAlignmentButton.selected = NO;
            centerAlignmentButton.selected = YES;
            break;
        default:
            break;
    }
}
- (void) configureImageSubmenuWithCurrentOptions
{
    [submenuDelegate imageSettingsChanged:imageSettings];
    
    CGFloat opacity = [[imageSettings objectForKey:IMAGE_OPACITY_KEY] floatValue];
    [imageOpacitySlider setSliderValue:opacity];
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
        [submenuDelegate removeViewFromUnwantedViews:currentSubmenu];
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
#pragma mark - Textfield Delegates
- (BOOL)textViewShouldBeginEditing:(UITextView *)aTextView
{
    
    if (aTextView == textView) {
        
        proxyTextViewHolder = [[UIView alloc] initWithFrame:[self proxyTextViewHolderFrame]];
        proxyTextViewHolder.backgroundColor = [UIColor clearColor];
        proxyTextViewHolder.alpha = 0.0;
        [submenuDelegate.view addSubview:proxyTextViewHolder];
        [submenuDelegate addViewToUnwantedViews:proxyTextViewHolder];
        
        proxyTextView = [[PSSubmenuTextView alloc] initWithFrame:[self proxyTextViewFrame]];
        proxyTextView.backgroundColor = [UIColor whiteColor];
        proxyTextView.contentInset = UIEdgeInsetsMake(10.0, 0.0, 10.0, 0.0);
        proxyTextView.textContainerInset = UIEdgeInsetsMake(10.0, 10.0, 10.0, 10.0);
        proxyTextView.contentSize = CGSizeMake(proxyTextView.frame.size.width, 1000.0);
        [proxyTextView setShowsHorizontalScrollIndicator:NO];
        proxyTextView.layer.borderWidth = 1.0;
        proxyTextView.layer.borderColor = DESIGN_MENU_SUBMENU_TEXTVIEW_BORDER_COLOR.CGColor;
        proxyTextView.delegate = self;
        [proxyTextViewHolder addSubview:proxyTextView];
        
        NSInteger fontIndex = [[labelSettings objectForKey:TEXT_FONT_INDEX_KEY] integerValue];
        bool isBold = [[labelSettings objectForKey:BOLDNESS_KEY] boolValue];
        bool isItalic = [[labelSettings objectForKey:ITALICNESS_KEY] boolValue];
        NSInteger alignment = [[labelSettings objectForKey:TEXT_ALIGNMENT_KEY] integerValue];
        
        NSString* fontName = [[Util sharedInstance] getFontNameForFamily:[fontFamilyNames objectAtIndex:fontIndex] andIsBold:isBold andIsItalic:isItalic];
        proxyTextView.font = [UIFont fontWithName:fontName size:DEFAULT_FONT_HEIGHT];
        
        proxyTextView.textAlignment = alignment;
        
        NSInteger textColorIndex = [[labelSettings objectForKey:TEXT_COLOR_INDEX_KEY] integerValue];
        proxyTextView.textColor = [colors objectAtIndex:textColorIndex];
        proxyTextView.tintColor = [colors objectAtIndex:textColorIndex];
        
        proxyTextView.text = textView.text;
        
        [proxyTextView becomeFirstResponder];
        
        return NO;
    } else if (aTextView == proxyTextView) {
        return YES;
    }
    
    return YES;
}
- (void)textViewDidChange:(UITextView*)aTextView
{
    if (aTextView == proxyTextView) {
        NSString* currentText = aTextView.text;
        textView.text = currentText;
        if (currentText == nil) {
            currentText = @"";
        }
        [labelSettings setObject:currentText forKey:CURRENT_TEXT_KEY];
        [self configureTextSubmenuWithCurrentOptions];
    }
}
#pragma mark - Public Methods
- (CGFloat) getCurrentOpacity
{
    if (currentSubmenuType == SUBMENU_TYPE_IMAGE) {
        return imageOpacitySlider.value;
    } else if (currentSubmenuType == SUBMENU_TYPE_TEXT) {
        return textOpacitySlider.value;
    } else {
        return 0.0;
    }
}
- (NSDictionary*) getImageSettings
{
    return imageSettings;
}
- (void) setImageSettings:(NSMutableDictionary*)settings
{
    imageSettings = [NSMutableDictionary dictionaryWithDictionary:settings];
    [self configureImageSubmenuWithCurrentOptions];
}
- (void) setTextSettings:(NSMutableDictionary*)settings
{
    labelSettings = [NSMutableDictionary dictionaryWithDictionary:settings];
    [self configureTextSubmenuWithCurrentOptions];
}
- (void) sliderValueChanged:(PSSlider *)slider
{
    if (slider == textOpacitySlider) {
        [self textOpacityChanged];
    } else if (slider == imageOpacitySlider) {
        [self imageOpacityChanged];
    }
}
- (PSSubmenuType)getCurrentSubmenuType
{
    return currentSubmenuType;
}
- (UIColor*) getColorWithColorIndex:(NSInteger)colorIndex
{
    return [colors objectAtIndex:colorIndex];
}
- (NSString*) getFontFamilyWithFontIndex:(NSInteger)fontIndex
{
    return [fontFamilyNames objectAtIndex:fontIndex];
}

- (void) designLabelSelected:(PSDesignLabel*)label
{
    
}
- (void) anImageSelected:(PSImageView*)image
{
    
}

#pragma mark - Tableview Delegates
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == fabricColorTableView) {
        return colors.count;
    } else if (tableView == textFontTableView) {
        return fontFamilyNames.count;
    } else if (tableView == textColorTableView) {
        return colors.count;
    } else {
        return 0;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 37.0;
}
- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PSTableViewCell* cell;
    
    if (tableView == fabricColorTableView) {
        NSInteger index = [[fabricSettings objectForKey:FABRIC_COLOR_INDEX_KEY] integerValue];
        cell = [tableView dequeueReusableCellWithIdentifier:FABRIC_COLOR_CELL_IDENTIFIER];
        [cell setColorForColorView:[colors objectAtIndex:indexPath.row]];
        cell.mainLabel.text = [colorNames objectAtIndex:indexPath.row];
        if (indexPath.row == index) {
            [cell makeSelected];
        }
    } else if (tableView == textFontTableView) {
        NSInteger index = [[labelSettings objectForKey:TEXT_FONT_INDEX_KEY] integerValue];
        cell = [tableView dequeueReusableCellWithIdentifier:MAIN_CELL_IDENTIFIER];
        NSString* fontFamily = [fontFamilyNames objectAtIndex:indexPath.row];
        cell.mainLabel.text = fontFamily;
        NSString* fontName = [[Util sharedInstance] getFontNameForFamily:fontFamily andIsBold:NO andIsItalic:NO];
        cell.mainLabel.font = [UIFont fontWithName:fontName size:DEFAULT_FONT_HEIGHT];
        
        if (indexPath.row == index) {
            [cell makeSelected];
        }
    } else if (tableView == textColorTableView) {
        NSInteger index = [[labelSettings objectForKey:TEXT_COLOR_INDEX_KEY] integerValue];
        cell = [tableView dequeueReusableCellWithIdentifier:GENERAL_COLOR_CELL_IDENTIFIER];
        [cell setColorForColorView:[colors objectAtIndex:indexPath.row]];
        cell.mainLabel.text = [colorNames objectAtIndex:indexPath.row];
        if (indexPath.row == index) {
            [cell makeSelected];
        }
    }
    
    return cell;
}
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == fabricColorTableView) {
        
        NSInteger fabricColorIndex = indexPath.row;
        
        NSInteger oldIndex = [[fabricSettings objectForKey:FABRIC_COLOR_INDEX_KEY] integerValue];
        
        if (fabricColorIndex == oldIndex) {
            [fabricColorTableView reloadData];
            [self removeTableWithType:SUBMENU_TABLE_TYPE_FABRIC_COLOR];
        } else {
            [fabricSettings setObject:[NSNumber numberWithInteger:fabricColorIndex] forKey:FABRIC_COLOR_INDEX_KEY];
            [self configureFabricSubmenuWithCurrentOptions];
            
            [submenuDelegate fabricColorSelected:[colors objectAtIndex:fabricColorIndex]];
            [fabricColorTableView reloadData];
        }
    } else if (tableView == textFontTableView) {
        NSInteger textFontIndex = indexPath.row;
        
        NSInteger oldIndex = [[labelSettings objectForKey:TEXT_FONT_INDEX_KEY] integerValue];
        
        if (textFontIndex == oldIndex) {
            [textFontTableView reloadData];
            [self removeTableWithType:SUBMENU_TABLE_TYPE_TEXT_FONT];
        } else {
            [labelSettings setObject:[NSNumber numberWithInteger:textFontIndex] forKey:TEXT_FONT_INDEX_KEY];
            [self configureTextSubmenuWithCurrentOptions];
            [textFontTableView reloadData];
        }
    } else if (tableView == textColorTableView) {
        NSInteger textColorIndex = indexPath.row;
        
        NSInteger oldIndex = [[labelSettings objectForKey:TEXT_COLOR_INDEX_KEY] integerValue];
        
        if (textColorIndex == oldIndex) {
            [textColorTableView reloadData];
            [self removeTableWithType:SUBMENU_TABLE_TYPE_TEXT_COLOR];
        } else {
            [labelSettings setObject:[NSNumber numberWithInteger:textColorIndex] forKey:TEXT_COLOR_INDEX_KEY];
            [self configureTextSubmenuWithCurrentOptions];
            [textColorTableView reloadData];
        }
    }
}
#pragma mark - Button actions

#pragma mark - Fabric actions
- (void) fabricColorClicked:(UIButton*)button
{
    [self addTableWithType:SUBMENU_TABLE_TYPE_FABRIC_COLOR];
}

#pragma mark - Text actions
- (void) addNewLabelClicked:(UIButton*)button
{
    CGPoint menuCenterPoint = [submenuDelegate getMenuCenterPoint];
    PSDesignLabel* newLabel = [[PSDesignLabel alloc] initWithCenter:menuCenterPoint];
    newLabel.labelSettings = [NSMutableDictionary dictionaryWithDictionary:labelSettings];
    [newLabel configureLabelWithSettings];
    
    [submenuDelegate addDesignLabel:newLabel];
}
- (void) textFontClicked:(UIButton*)button
{
    [self addTableWithType:SUBMENU_TABLE_TYPE_TEXT_FONT];
}
- (void) textColorClicked:(UIButton*)button
{
    [self addTableWithType:SUBMENU_TABLE_TYPE_TEXT_COLOR];
}
- (void) boldnessClicked:(UIButton*)button
{
    boldnessButton.selected = !boldnessButton.selected;
    
    [labelSettings setObject:[NSNumber numberWithBool:boldnessButton.selected] forKey:BOLDNESS_KEY];
    [self configureTextSubmenuWithCurrentOptions];
}
- (void) italicnessClicked:(UIButton*)button
{
    italicnessButton.selected = !italicnessButton.selected;
    
    [labelSettings setObject:[NSNumber numberWithBool:italicnessButton.selected] forKey:ITALICNESS_KEY];
    [self configureTextSubmenuWithCurrentOptions];
}
- (void) directionClicked:(UIButton*)button
{
    directionButton.selected = !directionButton.selected;
    
    [labelSettings setObject:[NSNumber numberWithBool:directionButton.selected] forKey:DIRECTION_KEY];
    [self configureTextSubmenuWithCurrentOptions];
}
- (void) leftAlignmentClicked:(UIButton*)button
{
    if (leftAlignmentButton.selected) {
        return;
    }
    
    leftAlignmentButton.selected = YES;
    rightAlignmentButton.selected = NO;
    centerAlignmentButton.selected = NO;
    
    [labelSettings setObject:[NSNumber numberWithInteger:NSTextAlignmentLeft] forKey:TEXT_ALIGNMENT_KEY];
    
    [self configureTextSubmenuWithCurrentOptions];
}
- (void) rightAlignmentClicked:(UIButton*)button
{
    if (rightAlignmentButton.selected) {
        return;
    }
    
    leftAlignmentButton.selected = NO;
    rightAlignmentButton.selected = YES;
    centerAlignmentButton.selected = NO;
    
    [labelSettings setObject:[NSNumber numberWithInteger:NSTextAlignmentRight] forKey:TEXT_ALIGNMENT_KEY];
    
    [self configureTextSubmenuWithCurrentOptions];
}
- (void) centerAlignmentClicked:(UIButton*)button
{
    if (centerAlignmentButton.selected) {
        return;
    }
    
    leftAlignmentButton.selected = NO;
    rightAlignmentButton.selected = NO;
    centerAlignmentButton.selected = YES;
    
    [labelSettings setObject:[NSNumber numberWithInteger:NSTextAlignmentCenter] forKey:TEXT_ALIGNMENT_KEY];
    
    [self configureTextSubmenuWithCurrentOptions];
}
- (void) textOpacityChanged
{
    [labelSettings setObject:[NSNumber numberWithFloat:textOpacitySlider.value] forKey:TEXT_OPACITY_KEY];
    [self configureTextSubmenuWithCurrentOptions];
}

#pragma mark - Image Actions
- (void) selectImageClicked:(UIButton*)button
{
    [self initializeImagePicker];
    
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentImagePicker];
}
- (void) captureImageClicked:(UIButton*)button
{
    [self initializeImagePicker];
    
    imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    [self presentImagePicker];
}
- (void) initializeImagePicker
{
    if (imagePicker == nil) {
        imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.delegate = submenuDelegate;
        imagePicker.navigationBar.translucent = NO;
        imagePicker.modalPresentationStyle = UIModalPresentationFullScreen;
    }
}
- (void) presentImagePicker
{
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    
    [submenuDelegate addChildViewController:imagePicker];
    [submenuDelegate.view addSubview:imagePicker.view];
    imagePicker.view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    imagePicker.view.frame = submenuDelegate.view.bounds;
    [imagePicker didMoveToParentViewController:submenuDelegate];
}
- (void) imageOpacityChanged
{
    [imageSettings setObject:[NSNumber numberWithFloat:imageOpacitySlider.value] forKey:IMAGE_OPACITY_KEY];
    [self configureImageSubmenuWithCurrentOptions];
}

#pragma mark - General Buttons Actions
- (void) deleteLastClicked:(UIButton*)button
{
    NSLog(@"delete last clicked");
    if (currentSubmenuType == SUBMENU_TYPE_IMAGE) {
        [self deleteLastImage];
    } else if (currentSubmenuType == SUBMENU_TYPE_TEXT) {
        [self deleteLastLabel];
    }
}
- (void) deleteAllClicked:(UIButton*)button
{
    NSLog(@"delete all clicked");
    if (currentSubmenuType == SUBMENU_TYPE_IMAGE) {
        [self deleteAllImages];
    } else if (currentSubmenuType == SUBMENU_TYPE_TEXT) {
        [self deleteAllLabels];
    }
}
- (void) deleteLastImage
{
    [submenuDelegate deleteLastImage];
}
- (void) deleteLastLabel
{
    [submenuDelegate deleteLastLabel];
}
- (void) deleteAllImages
{
    NSLog(@"delete all images from submenu manager");
    [submenuDelegate deleteAllImages];
}
- (void) deleteAllLabels
{
    [submenuDelegate deleteAllLabels];
}

#pragma mark - Table Openings - Closings
- (void) addTableWithType:(PSSubmenuTableType)tableType
{
    [self removeAnyTable];
    
    CGRect frame;
    
    switch (tableType) {
        case SUBMENU_TABLE_TYPE_FABRIC_COLOR:
            frame = [self fourthItemHolderFrame];
            break;
        case SUBMENU_TABLE_TYPE_TEXT_FONT:
            frame = [self fourthItemHolderFrame];
            break;
        case SUBMENU_TABLE_TYPE_TEXT_COLOR:
            frame = [self sixthItemHolderFrame];
            break;
            
        default:
            break;
    }
    
    CGRect holderFrame = CGRectMake(frame.origin.x+currentSubmenu.frame.origin.x-37.0,
                                    frame.origin.y+currentSubmenu.frame.origin.y+frame.size.height-258.0-1.0,
                                    304.0, 258.0);
    
    CGRect tableFrame = CGRectMake(37.0,
                                   68.0,
                                   230.0, 190.0);
    
    
    
    UIView* tableViewHolder = [[UIView alloc] initWithFrame:holderFrame];
    tableViewHolder.backgroundColor = [UIColor clearColor];
    tableViewHolder.clipsToBounds = YES;
    
    UIImageView* tableBackgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"submenu_table_bg.png"]];
    tableBackgroundView.backgroundColor = [UIColor clearColor];
    [tableViewHolder addSubview:tableBackgroundView];
    
    [submenuDelegate.view addSubview:tableViewHolder];
    [submenuDelegate addViewToUnwantedViews:tableViewHolder];
    
//    tableViewHolder.layer.shadowColor = [UIColor blackColor].CGColor;
//    tableViewHolder.layer.shadowOpacity = 0.55;
//    tableViewHolder.layer.shadowRadius = 65.0;
    
    PSTableView* tableView = [[PSTableView alloc] initWithFrame:tableFrame];
    
    [tableView registerClass:[PSTableViewCell class] forCellReuseIdentifier:FABRIC_COLOR_CELL_IDENTIFIER];
    [tableView registerClass:[PSTableViewCell class] forCellReuseIdentifier:GENERAL_COLOR_CELL_IDENTIFIER];
    [tableView registerClass:[PSTableViewCell class] forCellReuseIdentifier:MAIN_CELL_IDENTIFIER];
    
    tableView.delegate = self;
    tableView.dataSource = self;
    [tableViewHolder addSubview:tableView];
    
//    CGRect titleFrame = [self titleFrame];
    
    UIView* headerView = [[UIView alloc] initWithFrame:CGRectMake(37.0, 37.0, 230.0, 32.0)];
    headerView.backgroundColor = [UIColor clearColor];
    
    UILabel* headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(10.0, 0.0, 210.0, 32.0)];
    headerLabel.backgroundColor = [UIColor clearColor];
    headerLabel.font = DESIGN_MENU_SUBMENU_TITLES_FONT;
    headerLabel.textColor = DESIGN_MENU_SUBMENU_TITLES_COLOR;
    [headerView addSubview:headerLabel];
//    tableView.tableHeaderView = headerView;
    [tableViewHolder addSubview:headerView];
    
    switch (tableType) {
        case SUBMENU_TABLE_TYPE_FABRIC_COLOR:
            headerLabel.text = @"Kumaş Renk Seçimi";
            fabricColorTableViewHolder = tableViewHolder;
            fabricColorTableView = tableView;
            break;
        case SUBMENU_TABLE_TYPE_TEXT_FONT:
            headerLabel.text = @"Yazı Karakter Seçimi";
            textFontTableViewHolder = tableViewHolder;
            textFontTableView = tableView;
            break;
        case SUBMENU_TABLE_TYPE_TEXT_COLOR:
            headerLabel.text = @"Yazı Renk Seçimi";
            textColorTableViewHolder = tableViewHolder;
            textColorTableView = tableView;
            break;
            
        default:
            break;
    }
    
    [self animateTableOpeningWithType:tableType];
}
- (void) removeTableWithType:(PSSubmenuTableType)tableType
{
    UIView* view;
    
    switch (tableType) {
        case SUBMENU_TABLE_TYPE_FABRIC_COLOR:
            view = fabricColorTableViewHolder;
            break;
        case SUBMENU_TABLE_TYPE_TEXT_FONT:
            view = textFontTableViewHolder;
            break;
        case SUBMENU_TABLE_TYPE_TEXT_COLOR:
            view = textColorTableViewHolder;
            break;
            
        default:
            break;
    }
    
    [submenuDelegate removeViewFromUnwantedViews:view];
    [self animateTableClosingWithType:tableType];
}
- (void) animateTableOpeningWithType:(PSSubmenuTableType)tableType
{
    UIView* holderView;
    
    switch (tableType) {
        case SUBMENU_TABLE_TYPE_FABRIC_COLOR:
            holderView = fabricColorTableViewHolder;
            break;
        case SUBMENU_TABLE_TYPE_TEXT_FONT:
            holderView = textFontTableViewHolder;
            break;
        case SUBMENU_TABLE_TYPE_TEXT_COLOR:
            holderView = textColorTableViewHolder;
            break;
            
        default:
            break;
    }
    
    holderView.clipsToBounds = NO;
    CGRect frame = holderView.frame;
    holderView.layer.anchorPoint = CGPointMake(0.5, 1.0);
    holderView.frame = frame;
    
    holderView.transform = CGAffineTransformMakeScale(0.8, 0.1);
    
    [UIView animateWithDuration:0.17 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        holderView.transform = CGAffineTransformMakeScale(1.15, 1.15);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.15 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            holderView.transform = CGAffineTransformMakeScale(1.0, 1.0);
        } completion:^(BOOL finished) {
            holderView.layer.anchorPoint = CGPointMake(0.5, 0.5);
            holderView.frame = frame;
            
            if (fabricColorTableView.indexPathForSelectedRow != nil) {
                NSLog(@"not nil");
            } else {
                NSLog(@"nil");
            }
        }];
    }];
}
- (void) animateTableClosingWithType:(PSSubmenuTableType)tableType
{
    UIView* holderView;
    
    switch (tableType) {
        case SUBMENU_TABLE_TYPE_FABRIC_COLOR:
            holderView = fabricColorTableViewHolder;
            break;
        case SUBMENU_TABLE_TYPE_TEXT_FONT:
            holderView = textFontTableViewHolder;
            break;
        case SUBMENU_TABLE_TYPE_TEXT_COLOR:
            holderView = textColorTableViewHolder;
            break;
            
        default:
            break;
    }
    
    CGRect frame = holderView.frame;
    holderView.layer.anchorPoint = CGPointMake(0.5, 1.0);
    holderView.frame = frame;
    
    [UIView animateWithDuration:0.15 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        holderView.transform = CGAffineTransformMakeScale(1.15, 1.15);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.17 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
            holderView.transform = CGAffineTransformMakeScale(0.8, 0.1);
        } completion:^(BOOL finished) {
            [self tableCleanupsWithType:tableType];
        }];
    }];
}
- (void) tableCleanupsWithType:(PSSubmenuTableType)tableType
{
    
    switch (tableType) {
        case SUBMENU_TABLE_TYPE_FABRIC_COLOR:
            [fabricColorTableView removeFromSuperview];
            fabricColorTableView = nil;
            
            [fabricColorTableViewHolder removeFromSuperview];
            fabricColorTableViewHolder = nil;
            break;
        case SUBMENU_TABLE_TYPE_TEXT_FONT:
            [textFontTableView removeFromSuperview];
            textFontTableView = nil;
            
            [textFontTableViewHolder removeFromSuperview];
            textFontTableViewHolder = nil;
            break;
        case SUBMENU_TABLE_TYPE_TEXT_COLOR:
            [textColorTableView removeFromSuperview];
            textColorTableView = nil;
            
            [textColorTableViewHolder removeFromSuperview];
            textColorTableViewHolder = nil;
            break;
            
        default:
            break;
    }
}
- (void) removeAnyTable
{
    if (fabricColorTableViewHolder) {
        [self removeTableWithType:SUBMENU_TABLE_TYPE_FABRIC_COLOR];
    }
    if (textFontTableViewHolder) {
        [self removeTableWithType:SUBMENU_TABLE_TYPE_TEXT_FONT];
    }
    if (textColorTableViewHolder) {
        [self removeTableWithType:SUBMENU_TABLE_TYPE_TEXT_COLOR];
    }
}

#pragma mark - Keyboard Opening - Closing
- (void) keyboardWillShow:(NSNotification *)note{
    [self removeAnyTable];
    // get keyboard size and loctaion
    CGRect keyboardFrameBegin;
    CGRect keyboardFrameEnd;
    
    keyboardFrameBegin = [[note.userInfo valueForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    keyboardFrameEnd = [[note.userInfo valueForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    heightChange = keyboardFrameBegin.origin.y-keyboardFrameEnd.origin.y;
    
    NSNumber *duration = [note.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSNumber *curve = [note.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    
    CGRect frame = proxyTextViewHolder.frame;
    frame.origin.y -= heightChange;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:[duration floatValue]];
    [UIView setAnimationCurve:[curve integerValue]];
    [UIView setAnimationDelegate:self];
    
    // animations here
    
    proxyTextViewHolder.frame = frame;
    proxyTextViewHolder.alpha = 1.0;
    
    [UIView commitAnimations];
}
- (void) keyboardWillHide:(NSNotification *)note{
    
    CGRect keyboardFrameBegin;
    CGRect keyboardFrameEnd;
    
    keyboardFrameBegin = [[note.userInfo valueForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    keyboardFrameEnd = [[note.userInfo valueForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    heightChange = keyboardFrameEnd.origin.y-keyboardFrameBegin.origin.y;
    
    NSNumber *duration = [note.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSNumber *curve = [note.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    
    CGRect frame = proxyTextViewHolder.frame;
    frame.origin.y += heightChange;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:[duration floatValue]];
    [UIView setAnimationCurve:[curve integerValue]];
    [UIView setAnimationDidStopSelector:@selector(animationFinished)];
    [UIView setAnimationDelegate:self];
    
    // animations here
    
    proxyTextViewHolder.frame = frame;
    proxyTextViewHolder.alpha = 0.0;
    
    [UIView commitAnimations];
}
- (void) animationFinished
{
    [submenuDelegate removeViewFromUnwantedViews:proxyTextViewHolder];
    [proxyTextView removeFromSuperview];
    proxyTextView = nil;
    
    [proxyTextViewHolder removeFromSuperview];
    proxyTextViewHolder = nil;
}

- (void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end