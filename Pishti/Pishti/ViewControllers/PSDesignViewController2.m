//
//  PSDesignViewController2.m
//  Pishti
//
//  Created by Alperen Kavun on 14.10.2014.
//  Copyright (c) 2014 pishti. All rights reserved.
//

#define MENU_WIDTH 500.0
#define MENU_HEIGHT 500.0
#define BUTTON_RADIUS 80.0
#define BUTTON_BOUNCE_RADIUS 95.0
#define BUTTON_SIZE_NORMAL 70.0
#define BUTTON_SIZE_HIGHLIGHTED 87.0

#import "PSDesignViewController2.h"
#import "PSSubmenuManager.h"
#import <QuartzCore/QuartzCore.h>
#import "PSImageView.h"

@interface PSDesignViewController2 ()

@end

@implementation PSDesignViewController2
{
    UILongPressGestureRecognizer* menuGesture;
    
    CGPoint menuCenterPoint;
    
    UIView* menuBackgroundView;
    UIImageView* menuBackgroundImageView;
    UIButton* fabricSubmenuButton;
    UIButton* textSubmenuButton;
    UIButton* imageSubmenuButton;
    
    PSModelCanvas* modelCanvas;
    
    NSMutableArray* unwantedViews;
}
#pragma mark - Frame Getters

- (CGRect) backgroundViewFrame
{
    return CGRectMake(0.0, 0.0, SCREEN_SIZE.width, SCREEN_SIZE.height);
}

- (CGRect) logoFrame
{
    return CGRectMake(SCREEN_SIZE.width-84.0, 18.0, 84.0, 94.0);
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark - ViewController Delegate Methods

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initialSetups];
    [self addModelCanvas];
    
    unwantedViews = @[].mutableCopy;
}
- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [[PSSubmenuManager sharedInstance] showSubmenuWithType:SUBMENU_TYPE_FABRIC];
}
#pragma mark - View Setup Methods
- (void) initialSetups
{
    UIImageView* backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mainscreen_bg.png"]];
    backgroundView.backgroundColor = [UIColor clearColor];
    backgroundView.frame = [self backgroundViewFrame];
    [self.view addSubview:backgroundView];
    
    UIImageView* logoView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mainscreen_logo.png"]];
    logoView.backgroundColor = [UIColor clearColor];
    logoView.frame = [self logoFrame];
    [self.view addSubview:logoView];
    
    menuGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressed:)];
    menuGesture.minimumPressDuration = 0.5;
    menuGesture.delegate = self;
    [self.view addGestureRecognizer:menuGesture];
    
    [[PSSubmenuManager sharedInstance] setSubmenuDelegate:self];
}
- (void) addModelCanvas
{
    modelCanvas = [[PSModelCanvas alloc] initWithFrame:CGRectMake(10.0, 0.0, 747.0, 768.0)];
    modelCanvas.strokeColor = [UIColor grayColor];
    modelCanvas.fillColor = [UIColor colorWithRed:230.0/255.0 green:76.0/255.0 blue:101.0/255.0 alpha:1.0];
    [self.view addSubview:modelCanvas];
    
    UIImageView* shadow = [[UIImageView alloc] initWithFrame:CGRectMake(10.0, 0.0, 747.0, 768.0)];
    shadow.backgroundColor = [UIColor clearColor];
    shadow.image = [UIImage imageNamed:@"golge.png"];
    [self.view addSubview:shadow];
}
- (void) addViewToUnwantedViews:(UIView*)view
{
    [unwantedViews addObject:view];
}
- (void) removeViewFromUnwantedViews:(UIView*)view
{
    [unwantedViews removeObject:view];
}
#pragma mark - Gesture Recognizer Methods
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    for (UIView* view in unwantedViews) {
        CGPoint point = [touch locationInView:view];
        if (CGRectContainsPoint(view.bounds, point)) {
            return NO;
        }
    }
    
    return YES;
}
- (void) longPressed:(UILongPressGestureRecognizer*)longPress
{
    CGPoint menuPoint = [longPress locationInView:self.view];
    CGPoint fabricTouch;
    CGPoint imageTouch;
    CGPoint textTouch;
    if (menuBackgroundView != nil) {
        fabricTouch = [longPress locationInView:fabricSubmenuButton];
        imageTouch = [longPress locationInView:imageSubmenuButton];
        textTouch = [longPress locationInView:textSubmenuButton];
    }
    
    if (longPress.state == UIGestureRecognizerStateBegan) {
        NSLog(@"long press began");
        menuCenterPoint = menuPoint;
        [self showMenu];
    } else if (longPress.state == UIGestureRecognizerStateChanged) {
        
        PSSubmenuType currentType = [[PSSubmenuManager sharedInstance] getCurrentSubmenuType];
        
        if (currentType != SUBMENU_TYPE_FABRIC) {
        
            if ([fabricSubmenuButton.layer containsPoint:fabricTouch]) {
                [fabricSubmenuButton setHighlighted:YES];
                CGPoint oldCenter = fabricSubmenuButton.center;
                [UIView animateWithDuration:0.12 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                    fabricSubmenuButton.frame = CGRectMake(0.0, 0.0, BUTTON_SIZE_HIGHLIGHTED, BUTTON_SIZE_HIGHLIGHTED);
                    fabricSubmenuButton.center = oldCenter;
                } completion:^(BOOL finished) {
                    ;
                }];
            } else {
                [fabricSubmenuButton setHighlighted:NO];
                CGPoint oldCenter = fabricSubmenuButton.center;
                [UIView animateWithDuration:0.2 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                    fabricSubmenuButton.frame = CGRectMake(0.0, 0.0, BUTTON_SIZE_NORMAL, BUTTON_SIZE_NORMAL);
                    fabricSubmenuButton.center = oldCenter;
                } completion:^(BOOL finished) {
                    ;
                }];
            }
        }
        
        if (currentType != SUBMENU_TYPE_IMAGE) {
            if ([imageSubmenuButton.layer containsPoint:imageTouch]) {
                [imageSubmenuButton setHighlighted:YES];
                CGPoint oldCenter = imageSubmenuButton.center;
                [UIView animateWithDuration:0.12 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                    imageSubmenuButton.frame = CGRectMake(0.0, 0.0, BUTTON_SIZE_HIGHLIGHTED, BUTTON_SIZE_HIGHLIGHTED);
                    imageSubmenuButton.center = oldCenter;
                } completion:^(BOOL finished) {
                    ;
                }];
            } else {
                [imageSubmenuButton setHighlighted:NO];
                CGPoint oldCenter = imageSubmenuButton.center;
                [UIView animateWithDuration:0.2 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                    imageSubmenuButton.frame = CGRectMake(0.0, 0.0, BUTTON_SIZE_NORMAL, BUTTON_SIZE_NORMAL);
                    imageSubmenuButton.center = oldCenter;
                } completion:^(BOOL finished) {
                    ;
                }];
            }
        }
        
        if (currentType != SUBMENU_TYPE_TEXT) {
            if ([textSubmenuButton.layer containsPoint:textTouch]) {
                [textSubmenuButton setHighlighted:YES];
                CGPoint oldCenter = textSubmenuButton.center;
                [UIView animateWithDuration:0.12 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                    textSubmenuButton.frame = CGRectMake(0.0, 0.0, BUTTON_SIZE_HIGHLIGHTED, BUTTON_SIZE_HIGHLIGHTED);
                    textSubmenuButton.center = oldCenter;
                } completion:^(BOOL finished) {
                    ;
                }];
            } else {
                [textSubmenuButton setHighlighted:NO];
                CGPoint oldCenter = textSubmenuButton.center;
                [UIView animateWithDuration:0.2 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                    textSubmenuButton.frame = CGRectMake(0.0, 0.0, BUTTON_SIZE_NORMAL, BUTTON_SIZE_NORMAL);
                    textSubmenuButton.center = oldCenter;
                } completion:^(BOOL finished) {
                    ;
                }];
            }
        }
    } else if (longPress.state == UIGestureRecognizerStateEnded){
        NSLog(@"long press ended");
        
        if ([fabricSubmenuButton.layer containsPoint:fabricTouch]) {
            [self showFabricSubmenu];
        }
        
        if ([imageSubmenuButton.layer containsPoint:imageTouch]) {
            [self showImageSubmenu];
        }
        
        if ([textSubmenuButton.layer containsPoint:textTouch]) {
            [self showTextSubmenu];
        }
        
        [self hideMenu];
    } else if (longPress.state == UIGestureRecognizerStateCancelled) {
        NSLog(@"long press cancelled");
        [self hideMenu];
    }
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

#pragma mark - Menu Related Methods

- (void) showMenu
{
    
    menuBackgroundView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, MENU_WIDTH, MENU_HEIGHT)];
    menuBackgroundView.center = menuCenterPoint;
    [self.view addSubview:menuBackgroundView];
    
    menuBackgroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, MENU_WIDTH, MENU_HEIGHT)];
    menuBackgroundImageView.backgroundColor = [UIColor clearColor];
    menuBackgroundImageView.image = [UIImage imageNamed:@"menu_bg.png"];
    menuBackgroundImageView.alpha = 0.0;
    [menuBackgroundView addSubview:menuBackgroundImageView];
    
    fabricSubmenuButton = [UIButton buttonWithType:UIButtonTypeCustom];
    fabricSubmenuButton.frame = CGRectMake(0.0, 0.0, BUTTON_SIZE_NORMAL, BUTTON_SIZE_NORMAL);
    fabricSubmenuButton.center = CGPointMake(MENU_WIDTH*0.5, MENU_HEIGHT*0.5);
    fabricSubmenuButton.alpha = 0.0;
    fabricSubmenuButton.backgroundColor = [UIColor clearColor];
    [fabricSubmenuButton setContentMode:UIViewContentModeScaleAspectFit];
    [fabricSubmenuButton setBackgroundImage:[UIImage imageNamed:@"fabric_btn_normal.png"] forState:UIControlStateNormal];
    [fabricSubmenuButton setBackgroundImage:[UIImage imageNamed:@"fabric_btn_highlighted.png"] forState:UIControlStateHighlighted];
    [menuBackgroundView addSubview:fabricSubmenuButton];
    
    imageSubmenuButton = [UIButton buttonWithType:UIButtonTypeCustom];
    imageSubmenuButton.frame = CGRectMake(0.0, 0.0, BUTTON_SIZE_NORMAL, BUTTON_SIZE_NORMAL);
    imageSubmenuButton.center = CGPointMake(MENU_WIDTH*0.5, MENU_HEIGHT*0.5);
    imageSubmenuButton.alpha = 0.0;
    imageSubmenuButton.backgroundColor = [UIColor clearColor];
    [imageSubmenuButton setContentMode:UIViewContentModeScaleAspectFit];
    [imageSubmenuButton setBackgroundImage:[UIImage imageNamed:@"image_btn_normal.png"] forState:UIControlStateNormal];
    [imageSubmenuButton setBackgroundImage:[UIImage imageNamed:@"image_btn_highlighted.png"] forState:UIControlStateHighlighted];
    [menuBackgroundView addSubview:imageSubmenuButton];
    
    textSubmenuButton = [UIButton buttonWithType:UIButtonTypeCustom];
    textSubmenuButton.frame = CGRectMake(0.0, 0.0, BUTTON_SIZE_NORMAL, BUTTON_SIZE_NORMAL);
    textSubmenuButton.center = CGPointMake(MENU_WIDTH*0.5, MENU_HEIGHT*0.5);
    textSubmenuButton.alpha = 0.0;
    textSubmenuButton.backgroundColor = [UIColor clearColor];
    [textSubmenuButton setContentMode:UIViewContentModeScaleAspectFit];
    [textSubmenuButton setBackgroundImage:[UIImage imageNamed:@"text_btn_normal.png"] forState:UIControlStateNormal];
    [textSubmenuButton setBackgroundImage:[UIImage imageNamed:@"text_btn_highlighted.png"] forState:UIControlStateHighlighted];
    [menuBackgroundView addSubview:textSubmenuButton];
    
    PSSubmenuType currentType = [[PSSubmenuManager sharedInstance] getCurrentSubmenuType];
    
    CGPoint oldCenter;
    
    switch (currentType) {
        case SUBMENU_TYPE_FABRIC:
            fabricSubmenuButton.highlighted = YES;
            oldCenter = fabricSubmenuButton.center;
            fabricSubmenuButton.frame = CGRectMake(0.0, 0.0, BUTTON_SIZE_HIGHLIGHTED, BUTTON_SIZE_HIGHLIGHTED);
            fabricSubmenuButton.center = oldCenter;
            break;
        case SUBMENU_TYPE_TEXT:
            textSubmenuButton.highlighted = YES;
            oldCenter = textSubmenuButton.center;
            textSubmenuButton.frame = CGRectMake(0.0, 0.0, BUTTON_SIZE_HIGHLIGHTED, BUTTON_SIZE_HIGHLIGHTED);
            textSubmenuButton.center = oldCenter;
            break;
        case SUBMENU_TYPE_IMAGE:
            imageSubmenuButton.highlighted = YES;
            oldCenter = imageSubmenuButton.center;
            imageSubmenuButton.frame = CGRectMake(0.0, 0.0, BUTTON_SIZE_HIGHLIGHTED, BUTTON_SIZE_HIGHLIGHTED);
            imageSubmenuButton.center = oldCenter;
            break;
            
        default:
            break;
    }
    
    [UIView animateWithDuration:0.44 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        menuBackgroundImageView.alpha = 1.0;
    } completion:^(BOOL finished) {
        ;
    }];
    
    [UIView animateWithDuration:0.17 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        fabricSubmenuButton.center = CGPointMake(MENU_WIDTH*0.5-BUTTON_BOUNCE_RADIUS*sqrtf(3)*0.5, MENU_HEIGHT*0.5-BUTTON_BOUNCE_RADIUS*0.5);
        fabricSubmenuButton.alpha = 1.0;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.15 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            fabricSubmenuButton.center = CGPointMake(MENU_WIDTH*0.5-BUTTON_RADIUS*sqrtf(3)*0.5, MENU_HEIGHT*0.5-BUTTON_RADIUS*0.5);
        } completion:^(BOOL finished) {
            ;
        }];
    }];
    
    [UIView animateWithDuration:0.17 delay:0.07 options:UIViewAnimationOptionCurveEaseOut animations:^{
        imageSubmenuButton.center = CGPointMake(MENU_WIDTH*0.5+BUTTON_BOUNCE_RADIUS*sqrtf(3)*0.5, MENU_HEIGHT*0.5-BUTTON_BOUNCE_RADIUS*0.5);
        imageSubmenuButton.alpha = 1.0;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.15 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            imageSubmenuButton.center = CGPointMake(MENU_WIDTH*0.5+BUTTON_RADIUS*sqrtf(3)*0.5, MENU_HEIGHT*0.5-BUTTON_RADIUS*0.5);
        } completion:^(BOOL finished) {
            ;
        }];
    }];
    
    [UIView animateWithDuration:0.17 delay:0.12 options:UIViewAnimationOptionCurveEaseOut animations:^{
        textSubmenuButton.center = CGPointMake(MENU_WIDTH*0.5, MENU_HEIGHT*0.5+BUTTON_BOUNCE_RADIUS);
        textSubmenuButton.alpha = 1.0;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.15 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            textSubmenuButton.center = CGPointMake(MENU_WIDTH*0.5, MENU_HEIGHT*0.5+BUTTON_RADIUS);
        } completion:^(BOOL finished) {
            ;
        }];
    }];
}

- (void) hideMenu
{
    [UIView animateWithDuration:0.32 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        menuBackgroundImageView.alpha = 0.0;
    } completion:^(BOOL finished) {
        ;
    }];
    
    [UIView animateWithDuration:0.2 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        fabricSubmenuButton.center = CGPointMake(MENU_WIDTH*0.5, MENU_HEIGHT*0.5);
        fabricSubmenuButton.alpha = 0.0;
    } completion:^(BOOL finished) {
        ;
    }];
    
    [UIView animateWithDuration:0.2 delay:0.07 options:UIViewAnimationOptionCurveEaseOut animations:^{
        imageSubmenuButton.center = CGPointMake(MENU_WIDTH*0.5, MENU_HEIGHT*0.5);
        imageSubmenuButton.alpha = 0.0;
    } completion:^(BOOL finished) {
        ;
    }];
    
    [UIView animateWithDuration:0.2 delay:0.12 options:UIViewAnimationOptionCurveEaseOut animations:^{
        textSubmenuButton.center = CGPointMake(MENU_WIDTH*0.5, MENU_HEIGHT*0.5);
        textSubmenuButton.alpha = 0.0;
    } completion:^(BOOL finished) {
        
        [fabricSubmenuButton removeFromSuperview];
        fabricSubmenuButton = nil;
        
        [imageSubmenuButton removeFromSuperview];
        imageSubmenuButton = nil;
        
        [textSubmenuButton removeFromSuperview];
        textSubmenuButton = nil;
        
        [menuBackgroundImageView removeFromSuperview];
        menuBackgroundImageView = nil;
        
        [menuBackgroundView removeFromSuperview];
        menuBackgroundView = nil;
    }];
}

- (void) showFabricSubmenu
{
    NSLog(@"show fabric submenu");
    [[PSSubmenuManager sharedInstance] showSubmenuWithType:SUBMENU_TYPE_FABRIC];
}

- (void) showImageSubmenu
{
    NSLog(@"show image submenu");
    [[PSSubmenuManager sharedInstance] showSubmenuWithType:SUBMENU_TYPE_IMAGE];
}

- (void) showTextSubmenu
{
    NSLog(@"show text submenu");
    [[PSSubmenuManager sharedInstance] showSubmenuWithType:SUBMENU_TYPE_TEXT];
}

#pragma mark - Image picker controller delegate methods
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [self imageSelected:[info objectForKey:UIImagePickerControllerOriginalImage]];
    
    [picker.view removeFromSuperview];
    [picker removeFromParentViewController];
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
}
- (void) imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker.view removeFromSuperview];
    [picker removeFromParentViewController];
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
}
- (void) imageSelected:(UIImage*)image
{
    if (image != nil) {
        
        UIImage* newImage = [[Util sharedInstance] prepareImageForDesign:image];
        
        CGSize imageSize = newImage.size;
        
        PSImageView* imageView = [[PSImageView alloc] initWithFrame:CGRectMake(0.0,
                                                                               0.0,
                                                                               imageSize.width,
                                                                               imageSize.height)];
        imageView.center = menuCenterPoint;
        
        imageView.backgroundColor = [UIColor clearColor];
        imageView.image = newImage;
        
        CGFloat currentOpacity = [[PSSubmenuManager sharedInstance] getCurrentOpacity];
        
        imageView.alpha = currentOpacity;
        imageView.opacity = currentOpacity;
        
        [modelCanvas addSubview:imageView];
        
        [modelCanvas.allImages addObject:imageView];
    }
}
#pragma mark - Deletion Operations
- (void) deleteLastImage
{
    NSLog(@"delete last image from design view");
    if (modelCanvas.allImages.count > 0) {
        UIView* lastImage = [modelCanvas.allImages objectAtIndex:modelCanvas.allImages.count-1];
        [lastImage removeFromSuperview];
        [modelCanvas.allImages removeObject:lastImage];
    }
}
- (void) deleteAllImages
{
    NSLog(@"delete all images from design view");
    for (UIView* view in modelCanvas.allImages) {
        [view removeFromSuperview];
    }
    
    modelCanvas.allImages = @[].mutableCopy;
}
- (void) deleteLastLabel
{
    if (modelCanvas.allLabels.count > 0) {
        UIView* lastLabel = [modelCanvas.allLabels objectAtIndex:modelCanvas.allLabels.count-1];
        [lastLabel removeFromSuperview];
        [modelCanvas.allImages removeObject:lastLabel];
    }
}
- (void) deleteAllLabels
{
    for (UIView* view in modelCanvas.allLabels) {
        [view removeFromSuperview];
    }
    
    modelCanvas.allLabels = @[].mutableCopy;
}
#pragma mark - Fabric Operations
- (void) fabricColorSelected:(UIColor*)color
{
    modelCanvas.fillColor = color;
    [modelCanvas setNeedsDisplay];
}
#pragma mark - Touch Operations
- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    [[PSSubmenuManager sharedInstance] removeAnyTable];
}

#pragma mark - Memory warning
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
