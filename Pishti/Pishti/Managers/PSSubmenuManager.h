//
//  PSSubmenuManager.h
//  Pishti
//
//  Created by Alperen Kavun on 14.10.2014.
//  Copyright (c) 2014 pishti. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum PSSubmenuType
{
    SUBMENU_TYPE_NONE,
    SUBMENU_TYPE_FABRIC,
    SUBMENU_TYPE_IMAGE,
    SUBMENU_TYPE_TEXT
} PSSubmenuType;

@interface PSSubmenuManager : NSObject

+ (PSSubmenuManager*) sharedInstance;

- (void) setSubmenuDelegate:(UIViewController*)viewController;

- (void) showSubmenuWithType:(PSSubmenuType)submenuType;

@end
