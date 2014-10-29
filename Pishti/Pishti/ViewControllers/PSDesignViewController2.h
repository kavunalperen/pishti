//
//  PSDesignViewController2.h
//  Pishti
//
//  Created by Alperen Kavun on 14.10.2014.
//  Copyright (c) 2014 pishti. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PSCommons.h"
#import "Util.h"
#import "PSModelCanvas.h"
#import "PSDesignLabel.h"

#define RADIANS_TO_DEGREES(radians) ((radians) * (180.0 / M_PI))
#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)

#define DELETE_VIEW_TAG 2442
#define SCALE_VIEW_TAG 2443
#define MOVE_VIEW_TAG 2444
#define ROTATE_VIEW_TAG 2445

@interface PSDesignViewController2 : UIViewController <UIGestureRecognizerDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>

- (void) fabricColorSelected:(UIColor*)color;
- (void) deleteLastImage;
- (void) deleteAllImages;
- (void) deleteLastLabel;
- (void) deleteAllLabels;

- (void) addViewToUnwantedViews:(UIView*)view;
- (void) removeViewFromUnwantedViews:(UIView*)view;
- (CGPoint) getMenuCenterPoint;
- (void) addDesignLabel:(PSDesignLabel*)label;
- (void) imageSettingsChanged:(NSMutableDictionary*)settings;
- (void) labelSettingsChanged:(NSMutableDictionary*)settings;

@end
