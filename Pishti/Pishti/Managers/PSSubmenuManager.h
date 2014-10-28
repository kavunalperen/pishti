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

typedef enum PSSubmenuType
{
    SUBMENU_TYPE_NONE,
    SUBMENU_TYPE_FABRIC,
    SUBMENU_TYPE_IMAGE,
    SUBMENU_TYPE_TEXT
} PSSubmenuType;

typedef enum PSSubmenuTableType
{
    SUBMENU_TABLE_TYPE_FABRIC_COLOR,
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
- (PSSubmenuType)getCurrentSubmenuType;

@end
