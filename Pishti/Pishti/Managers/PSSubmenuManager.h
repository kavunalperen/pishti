//
//  PSSubmenuManager.h
//  Pishti
//
//  Created by Alperen Kavun on 14.10.2014.
//  Copyright (c) 2014 pishti. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PSDesignViewController2.h"
#import "PSSlider.h"
#import "PSImageView.h"

#define TEXT_OPACITY_KEY @"kTextOpacity"
#define BOLDNESS_KEY @"kIsBold"
#define ITALICNESS_KEY @"kIsItalic"
#define DIRECTION_KEY @"kIsVertical"
#define TEXT_ALIGNMENT_KEY @"kTextAlignment"
#define TEXT_COLOR_INDEX_KEY @"kTextColor"
#define TEXT_FONT_INDEX_KEY @"kTextFontIndex"
#define CURRENT_TEXT_KEY @"kCurrentText"
#define DEFAULT_FONT_HEIGHT 22.0

#define IMAGE_OPACITY_KEY @"kImageOpacity"

#define FABRIC_SIZE_INDEX_KEY @"kFabricSizeIndex"
#define FABRIC_SHAPE_INDEX_KEY @"kFabricShapeIndex"
#define FABRIC_TYPE_INDEX_KEY @"kFabricTypeIndex"
#define FABRIC_COLOR_INDEX_KEY @"kFabricColorIndex"
#define FABRIC_COLLAR_INDEX_KEY @"kFabricCollarIndex"
#define FABRIC_SLEEVE_INDEX_KEY @"kFabricSleeveIndex"

typedef enum PSSubmenuType
{
    SUBMENU_TYPE_NONE,
    SUBMENU_TYPE_FABRIC,
    SUBMENU_TYPE_IMAGE,
    SUBMENU_TYPE_TEXT
} PSSubmenuType;

typedef enum PSSubmenuTableType
{
    SUBMENU_TABLE_TYPE_FABRIC_SIZE,
    SUBMENU_TABLE_TYPE_FABRIC_SHAPE,
    SUBMENU_TABLE_TYPE_FABRIC_TYPE,
    SUBMENU_TABLE_TYPE_FABRIC_COLOR,
    SUBMENU_TABLE_TYPE_FABRIC_COLLAR,
    SUBMENU_TABLE_TYPE_FABRIC_SLEEVE,
    SUBMENU_TABLE_TYPE_TEXT_FONT,
    SUBMENU_TABLE_TYPE_TEXT_COLOR
} PSSubmenuTableType;

@interface PSSubmenuManager : NSObject <UITableViewDelegate, UITableViewDataSource, UITextViewDelegate>

+ (PSSubmenuManager*) sharedInstance;

- (void) setSubmenuDelegate:(PSDesignViewController2*)viewController;
- (void) showSubmenuWithType:(PSSubmenuType)submenuType;

- (void) sliderValueChanged:(PSSlider*)slider;
- (void) removeAnyTable;

- (CGFloat) getCurrentOpacity;
- (NSMutableDictionary*) getImageSettings;
- (PSSubmenuType)getCurrentSubmenuType;

- (void) setImageSettings:(NSMutableDictionary*)settings;
- (void) setTextSettings:(NSMutableDictionary*)settings;

- (UIColor*) getColorWithColorIndex:(NSInteger)colorIndex;
- (NSString*) getFontFamilyWithFontIndex:(NSInteger)fontIndex;

- (void) designLabelSelected:(PSDesignLabel*)label;
- (void) anImageSelected:(PSImageView*)image;

- (void) updateTotalPrice;

- (void) cleanups;

@end
