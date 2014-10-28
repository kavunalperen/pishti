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

#define RADIANS_TO_DEGREES(radians) ((radians) * (180.0 / M_PI))
#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)

@interface PSDesignViewController2 : UIViewController <UIGestureRecognizerDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>

- (void) fabricColorSelected:(UIColor*)color;
- (void) deleteLastImage;
- (void) deleteAllImages;
- (void) deleteLastLabel;
- (void) deleteAllLabels;

- (void) addViewToUnwantedViews:(UIView*)view;
- (void) removeViewFromUnwantedViews:(UIView*)view;

@end
