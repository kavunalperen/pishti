//
//  PSHelpPageViewController.h
//  Pishti
//
//  Created by Alperen Kavun on 17.05.2014.
//  Copyright (c) 2014 pishti. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PSCommons.h"
#import "PSHelpContentViewController.h"

@interface PSHelpPageViewController : UIPageViewController

+ (PSHelpPageViewController*) create;

- (void) showViewController:(UIViewController*)viewController direction:(UIPageViewControllerNavigationDirection)direction;

- (void) startGoThrough;

@end
