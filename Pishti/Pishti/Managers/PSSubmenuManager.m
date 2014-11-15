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
#import "PSPriceManager.h"

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
    NSArray* sizes;
    NSArray* sleeves;
    NSArray* sleeveIcons;
    NSArray* collars;
    NSArray* collarIcons;
    NSArray* fabricTypes;
    NSArray* shapes;
    
    PSTableView* fabricSizeTableView;
    UIView* fabricSizeTableViewHolder;
    PSLabel* fabricSizeValue;
    
    PSTableView* fabricShapeTableView;
    UIView* fabricShapeTableViewHolder;
    PSLabel* fabricShapeValue;
    
    PSTableView* fabricTypeTableView;
    UIView* fabricTypeTableViewHolder;
    PSLabel* fabricTypeValue;
    
    PSTableView* fabricCollarTableView;
    UIView* fabricCollarTableViewHolder;
    UIImageView* fabricCollarIcon;
    PSLabel* fabricCollarValue;
    
    PSTableView* fabricSleeveTableView;
    UIView* fabricSleeveTableViewHolder;
    UIImageView* fabricSleeveIcon;
    PSLabel* fabricSleeveValue;
    
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
    NSMutableDictionary* priceSettings;
    
    UIButton* boldnessButton;
    UIButton* italicnessButton;
    UIButton* directionButton;
    UIButton* leftAlignmentButton;
    UIButton* rightAlignmentButton;
    UIButton* centerAlignmentButton;
    
    PSSubmenuTextView* textView;
    UIView* textViewHolder;
    UIButton* addNewLabelButton;
    
    PSSubmenuTextView* proxyTextView;
    UIView* proxyTextViewHolder;
    
    PSLabel* priceLabel;
    
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
//        [__sharedInstance submenuSetups];
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
    
    sizes = @[@"X-SMALL",
              @"SMALL",
              @"MEDIUM",
              @"LARGE",
              @"X-LARGE",
              @"XX-LARGE"];
    
    shapes = @[@"SLİM-FİT",
               @"REGULAR",
               @"NORMAL",
               @"NOT-SLİM-FİT",
               @"BOL",
               @"ÇUVAL-GİBİ"];
    
    fabricTypes = @[@"PENYE",
                    @"MERSERİZE",
                    @"KAŞMİR",
                    @"GABARDİN",
                    @"PATİSKA",
                    @"BRANDA BEZİ",
                    @"OPAL",
                    @"ORGANİZE",
                    @"POPLİN"];
    
    collars = @[@"V-YAKA",
                @"KAYIK",
                @"BİSİKLET",
                @"SIFIR",
                @"BİR",
                @"İKİ"];
    
    collarIcons = @[@"yaka1.png",
                    @"yaka2.png",
                    @"yaka3.png",
                    @"yaka1.png",
                    @"yaka2.png",
                    @"yaka3.png"];
    
    sleeves = @[@"V-KOL",
                @"BÜZGÜLÜ",
                @"SALAŞ",
                @"DÜĞMELİ",
                @"KOL DÜĞMELİ"];
    
    sleeveIcons = @[@"yaka1.png",
                    @"yaka2.png",
                    @"yaka3.png",
                    @"yaka1.png",
                    @"yaka2.png"];
    
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
                        @"McLean",
                        @"Eagles",
                        @"Courier New",
                        @"Trebuchet MS",
                        @"Helvetica"];
    
    fontFamilyNames = [fontFamilyNames sortedArrayUsingComparator:^NSComparisonResult(NSString* obj1, NSString* obj2) {
        return [obj1 compare:obj2];
    }];
    
    fabricSettings = @{FABRIC_SIZE_INDEX_KEY:[NSNumber numberWithInteger:0],
                       FABRIC_COLOR_INDEX_KEY:[NSNumber numberWithInteger:2],
                       FABRIC_SHAPE_INDEX_KEY:[NSNumber numberWithInteger:0],
                       FABRIC_TYPE_INDEX_KEY:[NSNumber numberWithInteger:0],
                       FABRIC_COLLAR_INDEX_KEY:[NSNumber numberWithInteger:0],
                       FABRIC_SLEEVE_INDEX_KEY:[NSNumber numberWithInteger:0]}.mutableCopy;
    
    labelSettings = @{CURRENT_TEXT_KEY:@"",
                      TEXT_OPACITY_KEY:[NSNumber numberWithFloat:1.0],
                      BOLDNESS_KEY:[NSNumber numberWithBool:NO],
                      ITALICNESS_KEY:[NSNumber numberWithBool:NO],
                      DIRECTION_KEY:[NSNumber numberWithBool:NO],
                      TEXT_COLOR_INDEX_KEY:[NSNumber numberWithInteger:0],
                      TEXT_ALIGNMENT_KEY:[NSNumber numberWithInteger:NSTextAlignmentLeft],
                      TEXT_FONT_INDEX_KEY:[NSNumber numberWithInteger:0]}.mutableCopy;
    
    imageSettings = @{IMAGE_OPACITY_KEY:[NSNumber numberWithFloat:1.0]}.mutableCopy;
    
    priceSettings = @{BASE_MODEL_KEY:@"general",
                      SLEEVE_TYPE_KEY:[sleeves objectAtIndex:0],
                      COLLAR_TYPE_KEY:[collars objectAtIndex:0],
                      FABRIC_TYPE_KEY:[fabricTypes objectAtIndex:0],
                      IMAGES_KEY:[submenuDelegate getImageElementFrames],
                      LABELS_KEY:[submenuDelegate getLabelElementFrames],
                      TOTAL_PRICE_KEY:[NSNumber numberWithFloat:0.0]}.mutableCopy;
    
}
#pragma mark - Public methods
- (void) setSubmenuDelegate:(PSDesignViewController2*)viewController
{
    submenuDelegate = viewController;
    [self submenuSetups];
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
    
    UIButton* fabricSizeHolder = [UIButton buttonWithType:UIButtonTypeCustom];
    fabricSizeHolder.frame = frame;
    [fabricSizeHolder addTarget:self action:@selector(fabricSizeClicked:) forControlEvents:UIControlEventTouchUpInside];
    fabricSizeHolder.backgroundColor = [UIColor clearColor];
    [submenu addSubview:fabricSizeHolder];
    [submenuItems addObject:fabricSizeHolder];
    
    PSLabel* fabricSizeTitle = [[PSLabel alloc] initWithFrame:[self titleFrame]];
    fabricSizeTitle.backgroundColor = [UIColor clearColor];
    fabricSizeTitle.font = DESIGN_MENU_SUBMENU_TITLES_FONT;
    fabricSizeTitle.textColor = DESIGN_MENU_SUBMENU_TITLES_COLOR;
    fabricSizeTitle.text = @"Beden Seçimi";
    [fabricSizeHolder addSubview:fabricSizeTitle];
    
    fabricSizeValue = [[PSLabel alloc] initWithFrame:[self valueFrame]];
    fabricSizeValue.backgroundColor = [UIColor clearColor];
    fabricSizeValue.font = DESIGN_MENU_SUBMENU_VALUES_FONT;
    fabricSizeValue.textColor = DESIGN_MENU_SUBMENU_VALUES_COLOR;
    [fabricSizeHolder addSubview:fabricSizeValue];
    
    fabricSizeHolder.clipsToBounds = YES;
    CALayer *bottomBorder = [CALayer layer];
    bottomBorder.borderColor = DESIGN_MENU_SUBMENU_BORDER_BOTTOM_COLOR.CGColor;
    bottomBorder.borderWidth = 1;
    bottomBorder.frame = CGRectMake(0.0, frame.size.height-1.0, frame.size.width, 1.0);
    [fabricSizeHolder.layer addSublayer:bottomBorder];
    
    // second item
    
    CGRect frame2 = [self secondItemHolderFrame];
    
    UIButton* fabricShapeHolder = [UIButton buttonWithType:UIButtonTypeCustom];
    fabricShapeHolder.frame = frame2;
    [fabricShapeHolder addTarget:self action:@selector(fabricShapeClicked:) forControlEvents:UIControlEventTouchUpInside];
    fabricShapeHolder.backgroundColor = [UIColor clearColor];
    [submenu addSubview:fabricShapeHolder];
    [submenuItems addObject:fabricShapeHolder];
    
    PSLabel* fabricShapeTitle = [[PSLabel alloc] initWithFrame:[self titleFrame]];
    fabricShapeTitle.backgroundColor = [UIColor clearColor];
    fabricShapeTitle.font = DESIGN_MENU_SUBMENU_TITLES_FONT;
    fabricShapeTitle.textColor = DESIGN_MENU_SUBMENU_TITLES_COLOR;
    fabricShapeTitle.text = @"Kalıp Seçimi";
    [fabricShapeHolder addSubview:fabricShapeTitle];
    
    fabricShapeValue = [[PSLabel alloc] initWithFrame:[self valueFrame]];
    fabricShapeValue.backgroundColor = [UIColor clearColor];
    fabricShapeValue.font = DESIGN_MENU_SUBMENU_VALUES_FONT;
    fabricShapeValue.textColor = DESIGN_MENU_SUBMENU_VALUES_COLOR;
    [fabricShapeHolder addSubview:fabricShapeValue];
    
    fabricShapeHolder.clipsToBounds = YES;
    CALayer *bottomBorder2 = [CALayer layer];
    bottomBorder2.borderColor = DESIGN_MENU_SUBMENU_BORDER_BOTTOM_COLOR.CGColor;
    bottomBorder2.borderWidth = 1;
    bottomBorder2.frame = CGRectMake(0.0, frame2.size.height-1.0, frame2.size.width, 1.0);
    [fabricShapeHolder.layer addSublayer:bottomBorder2];
    
    // third item
    
    CGRect frame3 = [self thirdItemHolderFrame];
    
    UIButton* fabricTypeHolder = [UIButton buttonWithType:UIButtonTypeCustom];
    fabricTypeHolder.frame = frame3;
    [fabricTypeHolder addTarget:self action:@selector(fabricTypeClicked:) forControlEvents:UIControlEventTouchUpInside];
    fabricTypeHolder.backgroundColor = [UIColor clearColor];
    [submenu addSubview:fabricTypeHolder];
    [submenuItems addObject:fabricTypeHolder];
    
    PSLabel* fabricTypeTitle = [[PSLabel alloc] initWithFrame:[self titleFrame]];
    fabricTypeTitle.backgroundColor = [UIColor clearColor];
    fabricTypeTitle.font = DESIGN_MENU_SUBMENU_TITLES_FONT;
    fabricTypeTitle.textColor = DESIGN_MENU_SUBMENU_TITLES_COLOR;
    fabricTypeTitle.text = @"Kumaş Cinsi";
    [fabricTypeHolder addSubview:fabricTypeTitle];
    
    fabricTypeValue = [[PSLabel alloc] initWithFrame:[self valueFrame]];
    fabricTypeValue.backgroundColor = [UIColor clearColor];
    fabricTypeValue.font = DESIGN_MENU_SUBMENU_VALUES_FONT;
    fabricTypeValue.textColor = DESIGN_MENU_SUBMENU_VALUES_COLOR;
    fabricTypeValue.text = @"MERSERİZE";
    [fabricTypeHolder addSubview:fabricTypeValue];
    
    fabricTypeHolder.clipsToBounds = YES;
    CALayer *bottomBorder3 = [CALayer layer];
    bottomBorder3.borderColor = DESIGN_MENU_SUBMENU_BORDER_BOTTOM_COLOR.CGColor;
    bottomBorder3.borderWidth = 1;
    bottomBorder3.frame = CGRectMake(0.0, frame3.size.height-1.0, frame3.size.width, 1.0);
    [fabricTypeHolder.layer addSublayer:bottomBorder3];
    
    // fourth item
    
    CGRect frame4 = [self fourthItemHolderFrame];
    
    UIButton* fabricColorHolder = [UIButton buttonWithType:UIButtonTypeCustom];
    fabricColorHolder.frame = frame4;
    [fabricColorHolder addTarget:self action:@selector(fabricColorClicked:) forControlEvents:UIControlEventTouchUpInside];
    fabricColorHolder.backgroundColor = [UIColor clearColor];
    [submenu addSubview:fabricColorHolder];
    [submenuItems addObject:fabricColorHolder];
    
    PSLabel* fabricColorTitle = [[PSLabel alloc] initWithFrame:[self titleFrame]];
    fabricColorTitle.backgroundColor = [UIColor clearColor];
    fabricColorTitle.font = DESIGN_MENU_SUBMENU_TITLES_FONT;
    fabricColorTitle.textColor = DESIGN_MENU_SUBMENU_TITLES_COLOR;
    fabricColorTitle.text = @"Kumaş Renk Seçimi";
    [fabricColorHolder addSubview:fabricColorTitle];
    
    fabricColorView = [[UIView alloc] initWithFrame:[self indentedValueIconFrame]];
    fabricColorView.backgroundColor = [UIColor clearColor];
    [fabricColorHolder addSubview:fabricColorView];
    
    UIImageView* fabricColorIcon = [[UIImageView alloc] initWithFrame:[self indentedValueIconFrame]];
    fabricColorIcon.backgroundColor = [UIColor clearColor];
    fabricColorIcon.image = [UIImage imageNamed:@"color_mask.png"];
    fabricColorIcon.userInteractionEnabled = NO;
    [fabricColorHolder addSubview:fabricColorIcon];
    
    fabricColorValue = [[PSLabel alloc] initWithFrame:[self indentedValueFrame]];
    fabricColorValue.backgroundColor = [UIColor clearColor];
    fabricColorValue.font = DESIGN_MENU_SUBMENU_VALUES_FONT;
    [fabricColorHolder addSubview:fabricColorValue];
    
    fabricColorHolder.clipsToBounds = YES;
    CALayer* bottomBorder4 = [CALayer layer];
    bottomBorder4.borderColor = DESIGN_MENU_SUBMENU_BORDER_BOTTOM_COLOR.CGColor;
    bottomBorder4.borderWidth = 1.0;
    bottomBorder4.frame = CGRectMake(0.0, frame4.size.height-1.0, frame4.size.width, 1.0);
    [fabricColorHolder.layer addSublayer:bottomBorder4];
    
    // fifth item
    
    CGRect frame5 = [self fifthItemHolderFrame];
    
    UIButton* fabricCollarHolder = [UIButton buttonWithType:UIButtonTypeCustom];
    fabricCollarHolder.frame = frame5;
    [fabricCollarHolder addTarget:self action:@selector(fabricCollarClicked:) forControlEvents:UIControlEventTouchUpInside];
    fabricCollarHolder.backgroundColor = [UIColor clearColor];
    [submenu addSubview:fabricCollarHolder];
    [submenuItems addObject:fabricCollarHolder];
    
    PSLabel* fabricCollarTitle = [[PSLabel alloc] initWithFrame:[self titleFrame]];
    fabricCollarTitle.backgroundColor = [UIColor clearColor];
    fabricCollarTitle.font = DESIGN_MENU_SUBMENU_TITLES_FONT;
    fabricCollarTitle.textColor = DESIGN_MENU_SUBMENU_TITLES_COLOR;
    fabricCollarTitle.text = @"Yaka Seçimi";
    [fabricCollarHolder addSubview:fabricCollarTitle];
    
    UIView* colorView2 = [[UIView alloc] initWithFrame:[self indentedValueIconFrame]];
    colorView2.backgroundColor = [UIColor cyanColor];
    [fabricCollarHolder addSubview:colorView2];
    
    fabricCollarIcon = [[UIImageView alloc] initWithFrame:[self indentedValueIconFrame]];
    fabricCollarIcon.backgroundColor = [UIColor clearColor];
    [fabricCollarHolder addSubview:fabricCollarIcon];
    
    fabricCollarValue = [[PSLabel alloc] initWithFrame:[self indentedValueFrame]];
    fabricCollarValue.backgroundColor = [UIColor clearColor];
    fabricCollarValue.font = DESIGN_MENU_SUBMENU_VALUES_FONT;
    fabricCollarValue.textColor = DESIGN_MENU_SUBMENU_VALUES_COLOR;
    [fabricCollarHolder addSubview:fabricCollarValue];
    
    fabricCollarHolder.clipsToBounds = YES;
    CALayer *bottomBorder5 = [CALayer layer];
    bottomBorder5.borderColor = DESIGN_MENU_SUBMENU_BORDER_BOTTOM_COLOR.CGColor;
    bottomBorder5.borderWidth = 1;
    bottomBorder5.frame = CGRectMake(0.0, frame5.size.height-1.0, frame5.size.width, 1.0);
    [fabricCollarHolder.layer addSublayer:bottomBorder5];
    
    // sixth item
    
    CGRect frame6 = [self sixthItemHolderFrame];
    
    UIButton* fabricSleeveHolder = [UIButton buttonWithType:UIButtonTypeCustom];
    fabricSleeveHolder.frame = frame6;
    [fabricSleeveHolder addTarget:self action:@selector(fabricSleeveClicked:) forControlEvents:UIControlEventTouchUpInside];
    fabricSleeveHolder.backgroundColor = [UIColor clearColor];
    [submenu addSubview:fabricSleeveHolder];
    [submenuItems addObject:fabricSleeveHolder];
    
    PSLabel* fabricSleeveTitle = [[PSLabel alloc] initWithFrame:[self titleFrame]];
    fabricSleeveTitle.backgroundColor = [UIColor clearColor];
    fabricSleeveTitle.font = DESIGN_MENU_SUBMENU_TITLES_FONT;
    fabricSleeveTitle.textColor = DESIGN_MENU_SUBMENU_TITLES_COLOR;
    fabricSleeveTitle.text = @"Kol Tipi Seçimi";
    [fabricSleeveHolder addSubview:fabricSleeveTitle];
    
    UIView* colorView3 = [[UIView alloc] initWithFrame:[self indentedValueIconFrame]];
    colorView3.backgroundColor = [UIColor cyanColor];
    [fabricSleeveHolder addSubview:colorView3];
    
    fabricSleeveIcon = [[UIImageView alloc] initWithFrame:[self indentedValueIconFrame]];
    fabricSleeveIcon.backgroundColor = [UIColor clearColor];
    [fabricSleeveHolder addSubview:fabricSleeveIcon];
    
    fabricSleeveValue = [[PSLabel alloc] initWithFrame:[self indentedValueFrame]];
    fabricSleeveValue.backgroundColor = [UIColor clearColor];
    fabricSleeveValue.font = DESIGN_MENU_SUBMENU_VALUES_FONT;
    fabricSleeveValue.textColor = DESIGN_MENU_SUBMENU_VALUES_COLOR;
    [fabricSleeveHolder addSubview:fabricSleeveValue];
    
    fabricSleeveHolder.clipsToBounds = YES;
    CALayer *bottomBorder6 = [CALayer layer];
    bottomBorder6.borderColor = DESIGN_MENU_SUBMENU_BORDER_BOTTOM_COLOR.CGColor;
    bottomBorder6.borderWidth = 1;
    bottomBorder6.frame = CGRectMake(0.0, frame6.size.height-1.0, frame6.size.width, 1.0);
    [fabricSleeveHolder.layer addSublayer:bottomBorder6];
    
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
    
    addNewLabelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    addNewLabelButton.frame = [self addNewtextButtonFrame];
    addNewLabelButton.center = CGPointMake(30.0, 30.0);
    addNewLabelButton.backgroundColor = [UIColor clearColor];
    [addNewLabelButton setBackgroundImage:[UIImage imageNamed:@"text_addnew_normal.png"] forState:UIControlStateNormal];
    [addNewLabelButton setBackgroundImage:[UIImage imageNamed:@"text_addnew_highlighted.png"] forState:UIControlStateHighlighted];
    [addNewLabelButton addTarget:self action:@selector(addNewLabelClicked:) forControlEvents:UIControlEventTouchUpInside];
    addNewLabelButton.enabled = NO;
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
    
    priceLabel = [[PSLabel alloc] initWithFrame:[self priceLabelFrame]];
    priceLabel.backgroundColor = [UIColor clearColor];
    priceLabel.font = DESIGN_MENU_SUBMENU_PRICE_FONT;
    priceLabel.textColor = DESIGN_MENU_SUBMENU_PRICE_COLOR;
    priceLabel.textAlignment = NSTextAlignmentRight;
    [priceHolder addSubview:priceLabel];
    
    UIButton* tlButton = [UIButton buttonWithType:UIButtonTypeCustom];
    tlButton.frame = [self tlButtonFrame];
    tlButton.backgroundColor = [UIColor clearColor];
    [tlButton setBackgroundImage:[UIImage imageNamed:@"turkish_lira_normal.png"] forState:UIControlStateNormal];
    [tlButton setBackgroundImage:[UIImage imageNamed:@"turkish_lira_highlighted.png"] forState:UIControlStateHighlighted];
    [priceHolder addSubview:tlButton];
    
    [self updateTotalPrice];
}
#pragma mark - Configuring submenus
- (void) configureFabricSubmenuWithCurrentOptions
{
    NSInteger fabricColorIndex = [[fabricSettings objectForKey:FABRIC_COLOR_INDEX_KEY] integerValue];
    fabricColorView.backgroundColor = [colors objectAtIndex:fabricColorIndex];
    fabricColorValue.textColor = [colors objectAtIndex:fabricColorIndex];
    fabricColorValue.text = [colorNames objectAtIndex:fabricColorIndex];
    
    NSInteger fabricSizeIndex = [[fabricSettings objectForKey:FABRIC_SIZE_INDEX_KEY] integerValue];
    fabricSizeValue.text = [sizes objectAtIndex:fabricSizeIndex];
    
    NSInteger fabricShapeIndex = [[fabricSettings objectForKey:FABRIC_SHAPE_INDEX_KEY] integerValue];
    fabricShapeValue.text = [shapes objectAtIndex:fabricShapeIndex];
    
    NSInteger fabricTypeIndex = [[fabricSettings objectForKey:FABRIC_TYPE_INDEX_KEY] integerValue];
    fabricTypeValue.text = [fabricTypes objectAtIndex:fabricTypeIndex];
    
    NSInteger fabricCollarIndex = [[fabricSettings objectForKey:FABRIC_COLLAR_INDEX_KEY] integerValue];
    fabricCollarValue.text = [collars objectAtIndex:fabricCollarIndex];
    fabricCollarIcon.image = [UIImage imageNamed:[collarIcons objectAtIndex:fabricCollarIndex]];
    
    NSInteger fabricSleeveIndex = [[fabricSettings objectForKey:FABRIC_SLEEVE_INDEX_KEY] integerValue];
    fabricSleeveValue.text = [sleeves objectAtIndex:fabricSleeveIndex];
    fabricSleeveIcon.image = [UIImage imageNamed:[sleeveIcons objectAtIndex:fabricSleeveIndex]];
}
- (void) configureTextSubmenuWithCurrentOptions
{
    [submenuDelegate labelSettingsChanged:labelSettings];
    [self updateTotalPrice];
    
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
    
    NSString* fontName = [[Util sharedInstance] getFontNameForFamily:[fontFamilyNames objectAtIndex:textFontIndex] andIsBold:isBold andIsItalic:isItalic];
    textView.font = [UIFont fontWithName:fontName size:DEFAULT_FONT_HEIGHT];
    textView.textColor = [colors objectAtIndex:textColorIndex];
    textView.tintColor = [colors objectAtIndex:textColorIndex];
    if ((currentText != nil) && (currentText.length > 0)) {
        textView.text = currentText;
        addNewLabelButton.enabled = YES;
    } else {
        addNewLabelButton.enabled = NO;
    }
    textView.textAlignment = alignment;
    
    
    textFontValue.text = [fontFamilyNames objectAtIndex:textFontIndex];
    NSString* valueFontName = [[Util sharedInstance] getFontNameForFamily:[fontFamilyNames objectAtIndex:textFontIndex] andIsBold:NO andIsItalic:NO];
    textFontValue.font = [UIFont fontWithName:valueFontName size:DEFAULT_FONT_HEIGHT];
    
    if (proxyTextView != nil) {
        proxyTextView.font = [UIFont fontWithName:fontName size:DEFAULT_FONT_HEIGHT];
        proxyTextView.textColor = [colors objectAtIndex:textColorIndex];
        proxyTextView.tintColor = [colors objectAtIndex:textColorIndex];
        proxyTextView.text = currentText;
        proxyTextView.textAlignment = alignment;
    }
    
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
    [self updateTotalPrice];
    
    CGFloat opacity = [[imageSettings objectForKey:IMAGE_OPACITY_KEY] floatValue];
    [imageOpacitySlider setSliderValue:opacity];
}
- (void) configurePriceSubviewsWithCurrentOptions
{
    CGFloat totalPrice = [[priceSettings objectForKey:TOTAL_PRICE_KEY] floatValue];
    
    NSString* priceText = [NSString stringWithFormat:@"%.2f",totalPrice];
    priceText = [priceText stringByReplacingOccurrencesOfString:@"." withString:@","];
    
    priceLabel.text = priceText;
}
- (void) updateTotalPrice
{
    [priceSettings setObject:[submenuDelegate getImageElementFrames] forKey:IMAGES_KEY];
    [priceSettings setObject:[submenuDelegate getLabelElementFrames] forKey:LABELS_KEY];
    
    [[PSPriceManager sharedInstance] computePriceWithDesignOptions:priceSettings];
    
    [self configurePriceSubviewsWithCurrentOptions];
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
        
        if (proxyTextView == nil) {
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
        }
        
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
//        if (currentText.length > 0) {
//            addNewLabelButton.enabled = YES;
//        } else {
//            addNewLabelButton.enabled = NO;
//        }
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
    if (tableView == fabricSizeTableView) {
        return sizes.count;
    } else if (tableView == fabricShapeTableView) {
        return shapes.count;
    } else if (tableView == fabricTypeTableView) {
        return fabricTypes.count;
    } else if (tableView == fabricColorTableView) {
        return colors.count;
    } else if (tableView == fabricCollarTableView) {
        return collars.count;
    } else if (tableView == fabricSleeveTableView) {
        return sleeves.count;
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
    
    if (tableView == fabricSizeTableView) {
        NSInteger index = [[fabricSettings objectForKey:FABRIC_SIZE_INDEX_KEY] integerValue];
        cell = [tableView dequeueReusableCellWithIdentifier:MAIN_CELL_IDENTIFIER];
        cell.mainLabel.text = [sizes objectAtIndex:indexPath.row];
        if (indexPath.row == index) {
            [cell makeSelected];
        }
    } else if (tableView == fabricShapeTableView) {
        NSInteger index = [[fabricSettings objectForKey:FABRIC_SHAPE_INDEX_KEY] integerValue];
        cell = [tableView dequeueReusableCellWithIdentifier:MAIN_CELL_IDENTIFIER];
        cell.mainLabel.text = [shapes objectAtIndex:indexPath.row];
        if (indexPath.row == index) {
            [cell makeSelected];
        }
    } else if (tableView == fabricTypeTableView) {
        NSInteger index = [[fabricSettings objectForKey:FABRIC_TYPE_INDEX_KEY] integerValue];
        cell = [tableView dequeueReusableCellWithIdentifier:MAIN_CELL_IDENTIFIER];
        cell.mainLabel.text = [fabricTypes objectAtIndex:indexPath.row];
        if (indexPath.row == index) {
            [cell makeSelected];
        }
    } else if (tableView == fabricColorTableView) {
        NSInteger index = [[fabricSettings objectForKey:FABRIC_COLOR_INDEX_KEY] integerValue];
        cell = [tableView dequeueReusableCellWithIdentifier:FABRIC_COLOR_CELL_IDENTIFIER];
        [cell setColorForColorView:[colors objectAtIndex:indexPath.row]];
        cell.mainLabel.text = [colorNames objectAtIndex:indexPath.row];
        if (indexPath.row == index) {
            [cell makeSelected];
        }
    } else if (tableView == fabricCollarTableView) {
        NSInteger index = [[fabricSettings objectForKey:FABRIC_COLLAR_INDEX_KEY] integerValue];
        cell = [tableView dequeueReusableCellWithIdentifier:FABRIC_COLLAR_CELL_IDENTIFIER];
        [cell setIconWithName:[collarIcons objectAtIndex:indexPath.row]];
        cell.mainLabel.text = [collars objectAtIndex:indexPath.row];
        if (indexPath.row == index) {
            [cell makeSelected];
        }
    } else if (tableView == fabricSleeveTableView) {
        NSInteger index = [[fabricSettings objectForKey:FABRIC_SLEEVE_INDEX_KEY] integerValue];
        cell = [tableView dequeueReusableCellWithIdentifier:FABRIC_SLEEVE_CELL_IDENTIFIER];
        [cell setIconWithName:[sleeveIcons objectAtIndex:indexPath.row]];
        cell.mainLabel.text = [sleeves objectAtIndex:indexPath.row];
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
    if (tableView == fabricSizeTableView) {
        NSInteger fabricSizeIndex = indexPath.row;
        
        NSInteger oldIndex = [[fabricSettings objectForKey:FABRIC_SIZE_INDEX_KEY] integerValue];
        
        if (fabricSizeIndex == oldIndex) {
            [fabricSizeTableView reloadData];
            [self removeTableWithType:SUBMENU_TABLE_TYPE_FABRIC_SIZE];
        } else {
            [fabricSettings setObject:[NSNumber numberWithInteger:fabricSizeIndex] forKey:FABRIC_SIZE_INDEX_KEY];
            [self configureFabricSubmenuWithCurrentOptions];
            [fabricSizeTableView reloadData];
        }
    } else if (tableView == fabricShapeTableView) {
        NSInteger fabricShapeIndex = indexPath.row;
        
        NSInteger oldIndex = [[fabricSettings objectForKey:FABRIC_SHAPE_INDEX_KEY] integerValue];
        
        if (fabricShapeIndex == oldIndex) {
            [fabricShapeTableView reloadData];
            [self removeTableWithType:SUBMENU_TABLE_TYPE_FABRIC_SHAPE];
        } else {
            [fabricSettings setObject:[NSNumber numberWithInteger:fabricShapeIndex] forKey:FABRIC_SHAPE_INDEX_KEY];
            [self configureFabricSubmenuWithCurrentOptions];
            [fabricShapeTableView reloadData];
        }
    } else if (tableView == fabricTypeTableView) {
        NSInteger fabricTypeIndex = indexPath.row;
        
        NSInteger oldIndex = [[fabricSettings objectForKey:FABRIC_TYPE_INDEX_KEY] integerValue];
        
        if (fabricTypeIndex == oldIndex) {
            [fabricTypeTableView reloadData];
            [self removeTableWithType:SUBMENU_TABLE_TYPE_FABRIC_TYPE];
        } else {
            [fabricSettings setObject:[NSNumber numberWithInteger:fabricTypeIndex] forKey:FABRIC_TYPE_INDEX_KEY];
            [self configureFabricSubmenuWithCurrentOptions];
            
            [fabricTypeTableView reloadData];
            
            [priceSettings setObject:[fabricTypes objectAtIndex:fabricTypeIndex] forKey:FABRIC_TYPE_KEY];
            [self updateTotalPrice];
        }
    } else if (tableView == fabricColorTableView) {
        
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
    } else if (tableView == fabricCollarTableView) {
        
        NSInteger fabricCollarIndex = indexPath.row;
        
        NSInteger oldIndex = [[fabricSettings objectForKey:FABRIC_COLLAR_INDEX_KEY] integerValue];
        
        if (fabricCollarIndex == oldIndex) {
            [fabricCollarTableView reloadData];
            [self removeTableWithType:SUBMENU_TABLE_TYPE_FABRIC_COLLAR];
        } else {
            [fabricSettings setObject:[NSNumber numberWithInteger:fabricCollarIndex] forKey:FABRIC_COLLAR_INDEX_KEY];
            [self configureFabricSubmenuWithCurrentOptions];
            
            [fabricCollarTableView reloadData];
            
            [priceSettings setObject:[collars objectAtIndex:fabricCollarIndex] forKey:COLLAR_TYPE_KEY];
            [self updateTotalPrice];
        }
        
    } else if (tableView == fabricSleeveTableView) {
        
        NSInteger fabricSleeveIndex = indexPath.row;
        
        NSInteger oldIndex = [[fabricSettings objectForKey:FABRIC_SLEEVE_INDEX_KEY] integerValue];
        
        if (fabricSleeveIndex == oldIndex) {
            [fabricSleeveTableView reloadData];
            [self removeTableWithType:SUBMENU_TABLE_TYPE_FABRIC_SLEEVE];
        } else {
            [fabricSettings setObject:[NSNumber numberWithInteger:fabricSleeveIndex] forKey:FABRIC_SLEEVE_INDEX_KEY];
            [self configureFabricSubmenuWithCurrentOptions];
            
            [fabricSleeveTableView reloadData];
            
            [priceSettings setObject:[sleeves objectAtIndex:fabricSleeveIndex] forKey:SLEEVE_TYPE_KEY];
            [self updateTotalPrice];
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
- (void) fabricSizeClicked:(UIButton*)button
{
    [self addTableWithType:SUBMENU_TABLE_TYPE_FABRIC_SIZE];
}
- (void) fabricShapeClicked:(UIButton*)button
{
    [self addTableWithType:SUBMENU_TABLE_TYPE_FABRIC_SHAPE];
}
- (void) fabricTypeClicked:(UIButton*)button
{
    [self addTableWithType:SUBMENU_TABLE_TYPE_FABRIC_TYPE];
}
- (void) fabricColorClicked:(UIButton*)button
{
    [self addTableWithType:SUBMENU_TABLE_TYPE_FABRIC_COLOR];
}
- (void) fabricCollarClicked:(UIButton*)button
{
    [self addTableWithType:SUBMENU_TABLE_TYPE_FABRIC_COLLAR];
}
- (void) fabricSleeveClicked:(UIButton*)button
{
    [self addTableWithType:SUBMENU_TABLE_TYPE_FABRIC_SLEEVE];
}

#pragma mark - Text actions
- (void) addNewLabelClicked:(UIButton*)button
{
    
    NSString* currentText = [labelSettings objectForKey:CURRENT_TEXT_KEY];
    if (currentText == nil || [currentText isEqualToString:@""]) {
        return;
    }
    
    CGPoint menuCenterPoint = [submenuDelegate getMenuCenterPoint];
    PSDesignLabel* newLabel = [[PSDesignLabel alloc] initWithCenter:menuCenterPoint];
    newLabel.labelSettings = [NSMutableDictionary dictionaryWithDictionary:labelSettings];
    [newLabel configureLabelWithSettings];
    
    [submenuDelegate addDesignLabel:newLabel];
    [[PSSubmenuManager sharedInstance] updateTotalPrice];
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
    NSArray* cellIdentifiers;
    
    switch (tableType) {
        case SUBMENU_TABLE_TYPE_FABRIC_SIZE:
            frame = [self firstItemHolderFrame];
            cellIdentifiers = @[MAIN_CELL_IDENTIFIER];
            break;
        case SUBMENU_TABLE_TYPE_FABRIC_SHAPE:
            frame = [self secondItemHolderFrame];
            cellIdentifiers = @[MAIN_CELL_IDENTIFIER];
            break;
        case SUBMENU_TABLE_TYPE_FABRIC_TYPE:
            frame = [self thirdItemHolderFrame];
            cellIdentifiers = @[MAIN_CELL_IDENTIFIER];
            break;
        case SUBMENU_TABLE_TYPE_FABRIC_COLOR:
            frame = [self fourthItemHolderFrame];
            cellIdentifiers = @[FABRIC_COLOR_CELL_IDENTIFIER];
            break;
        case SUBMENU_TABLE_TYPE_FABRIC_COLLAR:
            frame = [self fifthItemHolderFrame];
            cellIdentifiers = @[FABRIC_COLLAR_CELL_IDENTIFIER];
            break;
        case SUBMENU_TABLE_TYPE_FABRIC_SLEEVE:
            frame = [self sixthItemHolderFrame];
            cellIdentifiers = @[FABRIC_SLEEVE_CELL_IDENTIFIER];
            break;
        case SUBMENU_TABLE_TYPE_TEXT_FONT:
            frame = [self fourthItemHolderFrame];
            cellIdentifiers = @[MAIN_CELL_IDENTIFIER];
            break;
        case SUBMENU_TABLE_TYPE_TEXT_COLOR:
            frame = [self sixthItemHolderFrame];
            cellIdentifiers = @[GENERAL_COLOR_CELL_IDENTIFIER];
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
    
    PSTableView* tableView = [[PSTableView alloc] initWithFrame:tableFrame];
    
    for (NSString* identifier in cellIdentifiers) {
        [tableView registerClass:[PSTableViewCell class] forCellReuseIdentifier:identifier];
    }
    
    tableView.delegate = self;
    tableView.dataSource = self;
    [tableViewHolder addSubview:tableView];
    
    UIView* headerView = [[UIView alloc] initWithFrame:CGRectMake(37.0, 37.0, 230.0, 32.0)];
    headerView.backgroundColor = [UIColor clearColor];
    
    UILabel* headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(10.0, 0.0, 210.0, 32.0)];
    headerLabel.backgroundColor = [UIColor clearColor];
    headerLabel.font = DESIGN_MENU_SUBMENU_TITLES_FONT;
    headerLabel.textColor = DESIGN_MENU_SUBMENU_TITLES_COLOR;
    [headerView addSubview:headerLabel];
    [tableViewHolder addSubview:headerView];
    
    switch (tableType) {
        case SUBMENU_TABLE_TYPE_FABRIC_SIZE:
            headerLabel.text = @"Beden Seçimi";
            fabricSizeTableViewHolder = tableViewHolder;
            fabricSizeTableView = tableView;
            break;
        case SUBMENU_TABLE_TYPE_FABRIC_SHAPE:
            headerLabel.text = @"Kalıp Seçimi";
            fabricShapeTableViewHolder = tableViewHolder;
            fabricShapeTableView = tableView;
            break;
        case SUBMENU_TABLE_TYPE_FABRIC_TYPE:
            headerLabel.text = @"Kumaş Cinsi";
            fabricTypeTableViewHolder = tableViewHolder;
            fabricTypeTableView = tableView;
            break;
        case SUBMENU_TABLE_TYPE_FABRIC_COLOR:
            headerLabel.text = @"Kumaş Renk Seçimi";
            fabricColorTableViewHolder = tableViewHolder;
            fabricColorTableView = tableView;
            break;
        case SUBMENU_TABLE_TYPE_FABRIC_COLLAR:
            headerLabel.text = @"Yaka Seçimi";
            fabricCollarTableViewHolder = tableViewHolder;
            fabricCollarTableView = tableView;
            break;
        case SUBMENU_TABLE_TYPE_FABRIC_SLEEVE:
            headerLabel.text = @"Kol Tipi Seçimi";
            fabricSleeveTableViewHolder = tableViewHolder;
            fabricSleeveTableView = tableView;
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
        case SUBMENU_TABLE_TYPE_FABRIC_SIZE:
            view = fabricSizeTableViewHolder;
            break;
        case SUBMENU_TABLE_TYPE_FABRIC_SHAPE:
            view = fabricShapeTableViewHolder;
            break;
        case SUBMENU_TABLE_TYPE_FABRIC_TYPE:
            view = fabricTypeTableViewHolder;
            break;
        case SUBMENU_TABLE_TYPE_FABRIC_COLOR:
            view = fabricColorTableViewHolder;
            break;
        case SUBMENU_TABLE_TYPE_FABRIC_COLLAR:
            view = fabricCollarTableViewHolder;
            break;
        case SUBMENU_TABLE_TYPE_FABRIC_SLEEVE:
            view = fabricSleeveTableViewHolder;
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
        case SUBMENU_TABLE_TYPE_FABRIC_SIZE:
            holderView = fabricSizeTableViewHolder;
            break;
        case SUBMENU_TABLE_TYPE_FABRIC_SHAPE:
            holderView = fabricShapeTableViewHolder;
            break;
        case SUBMENU_TABLE_TYPE_FABRIC_TYPE:
            holderView = fabricTypeTableViewHolder;
            break;
        case SUBMENU_TABLE_TYPE_FABRIC_COLOR:
            holderView = fabricColorTableViewHolder;
            break;
        case SUBMENU_TABLE_TYPE_FABRIC_COLLAR:
            holderView = fabricCollarTableViewHolder;
            break;
        case SUBMENU_TABLE_TYPE_FABRIC_SLEEVE:
            holderView = fabricSleeveTableViewHolder;
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
        }];
    }];
}
- (void) animateTableClosingWithType:(PSSubmenuTableType)tableType
{
    UIView* holderView;
    
    switch (tableType) {
        case SUBMENU_TABLE_TYPE_FABRIC_SIZE:
            holderView = fabricSizeTableViewHolder;
            break;
        case SUBMENU_TABLE_TYPE_FABRIC_SHAPE:
            holderView = fabricShapeTableViewHolder;
            break;
        case SUBMENU_TABLE_TYPE_FABRIC_TYPE:
            holderView = fabricTypeTableViewHolder;
            break;
        case SUBMENU_TABLE_TYPE_FABRIC_COLOR:
            holderView = fabricColorTableViewHolder;
            break;
        case SUBMENU_TABLE_TYPE_FABRIC_COLLAR:
            holderView = fabricCollarTableViewHolder;
            break;
        case SUBMENU_TABLE_TYPE_FABRIC_SLEEVE:
            holderView = fabricSleeveTableViewHolder;
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
        case SUBMENU_TABLE_TYPE_FABRIC_SIZE:
            [fabricSizeTableView removeFromSuperview];
            fabricSizeTableView = nil;
            
            [fabricSizeTableViewHolder removeFromSuperview];
            fabricSizeTableViewHolder = nil;
            break;
        case SUBMENU_TABLE_TYPE_FABRIC_SHAPE:
            [fabricShapeTableView removeFromSuperview];
            fabricShapeTableView = nil;
            
            [fabricShapeTableViewHolder removeFromSuperview];
            fabricShapeTableViewHolder = nil;
            break;
        case SUBMENU_TABLE_TYPE_FABRIC_TYPE:
            [fabricTypeTableView removeFromSuperview];
            fabricTypeTableView = nil;
            
            [fabricTypeTableViewHolder removeFromSuperview];
            fabricTypeTableViewHolder = nil;
            break;
        case SUBMENU_TABLE_TYPE_FABRIC_COLOR:
            [fabricColorTableView removeFromSuperview];
            fabricColorTableView = nil;
            
            [fabricColorTableViewHolder removeFromSuperview];
            fabricColorTableViewHolder = nil;
            break;
        case SUBMENU_TABLE_TYPE_FABRIC_COLLAR:
            [fabricCollarTableView removeFromSuperview];
            fabricCollarTableView = nil;
            
            [fabricCollarTableViewHolder removeFromSuperview];
            fabricCollarTableViewHolder = nil;
            break;
        case SUBMENU_TABLE_TYPE_FABRIC_SLEEVE:
            [fabricSleeveTableView removeFromSuperview];
            fabricSleeveTableView = nil;
            
            [fabricSleeveTableViewHolder removeFromSuperview];
            fabricSleeveTableViewHolder = nil;
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
    if (fabricSizeTableViewHolder) {
        [self removeTableWithType:SUBMENU_TABLE_TYPE_FABRIC_SIZE];
    }
    if (fabricShapeTableViewHolder) {
        [self removeTableWithType:SUBMENU_TABLE_TYPE_FABRIC_SHAPE];
    }
    if (fabricTypeTableViewHolder) {
        [self removeTableWithType:SUBMENU_TABLE_TYPE_FABRIC_TYPE];
    }
    if (fabricColorTableViewHolder) {
        [self removeTableWithType:SUBMENU_TABLE_TYPE_FABRIC_COLOR];
    }
    if (fabricCollarTableViewHolder) {
        [self removeTableWithType:SUBMENU_TABLE_TYPE_FABRIC_COLLAR];
    }
    if (fabricSleeveTableViewHolder) {
        [self removeTableWithType:SUBMENU_TABLE_TYPE_FABRIC_SLEEVE];
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
    proxyTextView.delegate = nil;
    [proxyTextView removeFromSuperview];
    proxyTextView = nil;
    
    [proxyTextViewHolder removeFromSuperview];
    proxyTextViewHolder = nil;
    
    [submenuDelegate keyboardHidingCompleted];
}

- (void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end