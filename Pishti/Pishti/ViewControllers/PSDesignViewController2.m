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
#define MINIMUM_SCALE_FACTOR 0.25

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
    
    float currentZIndex;
    
    UIView* selectedItem;
    UIView* currentDeleteView;
    UIView* currentMoveView;
    UIView* currentRotateView;
    UIView* currentScaleView;
    
    BOOL isMoving;
    BOOL isRotating;
    BOOL isScaling;
    
    CGPoint moveStartingPoint;
    CGPoint rotateStartingPoint;
    CGPoint rotateCenterPoint;
    CGPoint scaleStartingPoint;
    
//    CGSize scaleStartingSize;
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
- (CGRect) deleteViewFrameWithFrame:(CGRect)frame
{
    return CGRectMake(frame.origin.x-40.0, frame.origin.y-40.0, 40.0, 40.0);
}
- (CGRect) scaleViewFrameWithFrame:(CGRect)frame
{
    return CGRectMake(frame.origin.x+frame.size.width, frame.origin.y-40.0, 40.0, 40.0);
}
- (CGRect) moveViewFrameWithFrame:(CGRect)frame
{
    return CGRectMake(frame.origin.x-40.0, frame.origin.y+frame.size.height, 40.0, 40.0);
}
- (CGRect) rotateViewFrameWithFrame:(CGRect)frame
{
    return CGRectMake(frame.origin.x+frame.size.width, frame.origin.y+frame.size.height, 40.0, 40.0);
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
    
    unwantedViews = @[].mutableCopy;
    
    [self initialSetups];
    [self addModelCanvas];
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
    
    currentZIndex = 0.0;
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
    shadow.layer.zPosition = currentZIndex;
    currentZIndex += 1.0;
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
- (CGPoint) getMenuCenterPoint
{
    return menuCenterPoint;
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
        
        PSImageView* imageView = [[PSImageView alloc] initWithCenter:menuCenterPoint];
        imageView.image = newImage;
        
        CGPoint oldCenter = imageView.center;
        
        imageView.frame = CGRectMake(0.0,
                                     0.0,
                                     imageSize.width,
                                     imageSize.height);
        
        imageView.center = oldCenter;
        
        NSMutableDictionary* imageSettings = [[PSSubmenuManager sharedInstance] getImageSettings];
        
        imageView.imageSettings = [NSMutableDictionary dictionaryWithDictionary:imageSettings];
        [imageView configureImageWithSettings];
        
        imageView.layer.zPosition = currentZIndex;
        currentZIndex += 1.0;
        
        [modelCanvas.allImages addObject:imageView];
        
        [modelCanvas addSubview:imageView];
    }
}
#pragma mark - Selected Item Settings
- (void) imageSettingsChanged:(NSMutableDictionary*)settings
{
    if (selectedItem) {
        if ([selectedItem isKindOfClass:[PSImageView class]]) {
            ((PSImageView*)selectedItem).imageSettings = [NSMutableDictionary dictionaryWithDictionary:settings];
            [((PSImageView*)selectedItem) configureImageWithSettings];
            [self rearrangeSelectionRelatedViewsFrame];
        }
    }
}
- (void) labelSettingsChanged:(NSMutableDictionary*)settings
{
    if (selectedItem) {
        if ([selectedItem isKindOfClass:[PSDesignLabel class]]) {
            ((PSDesignLabel*)selectedItem).labelSettings = [NSMutableDictionary dictionaryWithDictionary:settings];
            [((PSDesignLabel*)selectedItem) configureLabelWithSettings];
            [self rearrangeSelectionRelatedViewsFrame];
        }
    }
}
#pragma mark - Adding Labels
- (void) addDesignLabel:(PSDesignLabel*)label
{
    label.layer.zPosition = currentZIndex;
    currentZIndex += 1.0;
    [modelCanvas.allLabels addObject:label];
    [modelCanvas addSubview:label];
    
    [self removeSelectionRelatedItems];
    [self addSelectionRelatedViewToItem:label];
}
#pragma mark - Deletion Operations
- (void) deleteLastImage
{
    if (modelCanvas.allImages.count > 0) {
        PSImageView* lastImage = [modelCanvas.allImages objectAtIndex:modelCanvas.allImages.count-1];
        [self deleteAImage:lastImage];
    }
}
- (void) deleteAllImages
{
    for (PSImageView* view in modelCanvas.allImages) {
        [view removeFromSuperview];
    }
    
    modelCanvas.allImages = @[].mutableCopy;
}
- (void) deleteAImage:(PSImageView*)image
{
    [image removeFromSuperview];
    [modelCanvas.allImages removeObject:image];
}
- (void) deleteLastLabel
{
    if (modelCanvas.allLabels.count > 0) {
        PSDesignLabel* lastLabel = [modelCanvas.allLabels objectAtIndex:modelCanvas.allLabels.count-1];
        [self deleteALabel:lastLabel];
    }
}
- (void) deleteALabel:(PSDesignLabel*)label
{
    [label removeFromSuperview];
    [modelCanvas.allLabels removeObject:label];
}
- (void) deleteAllLabels
{
    for (PSDesignLabel* view in modelCanvas.allLabels) {
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
    [[PSSubmenuManager sharedInstance] removeAnyTable];
    if (selectedItem) {
        UITouch* touch = [touches anyObject];
        
        CGPoint p1 = [touch locationInView:currentDeleteView];
        
        CGPoint p2 = [touch locationInView:currentScaleView];
        
        CGPoint p3 = [touch locationInView:currentMoveView];
        
        CGPoint p4 = [touch locationInView:currentRotateView];
        
        if (CGRectContainsPoint(currentDeleteView.bounds, p1)) {
            if ([selectedItem isKindOfClass:[PSDesignLabel class]]) {
                [self deleteALabel:(PSDesignLabel *)selectedItem];
                
            } else if ([selectedItem isKindOfClass:[PSImageView class]]) {
                [self deleteAImage:(PSImageView*)selectedItem];
            }
            [self removeSelectionRelatedItems];
        } else if (CGRectContainsPoint(currentScaleView.bounds, p2)) {
            isScaling = YES;
            scaleStartingPoint = [touch locationInView:modelCanvas];
            return;
        } else if (CGRectContainsPoint(currentMoveView.bounds, p3)) {
            // move
            isMoving = YES;
            moveStartingPoint = [touch locationInView:modelCanvas];
            return;
        } else if (CGRectContainsPoint(currentRotateView.bounds, p4)) {
            // rotate
            isRotating = YES;
            rotateStartingPoint = [touch locationInView:modelCanvas];
            rotateCenterPoint = selectedItem.center;
            return;
        }
    }
    
    UIView* newlySelectedItem = nil;
    
    for (PSDesignLabel* label in modelCanvas.allLabels) {
        
        UITouch* touch = [touches anyObject];
        CGPoint p = [touch locationInView:label];
        
        if (CGRectContainsPoint(label.bounds, p)) {
            if (newlySelectedItem) {
                if (label.layer.zPosition > newlySelectedItem.layer.zPosition) {
                    newlySelectedItem = label;
                }
            } else {
                newlySelectedItem = label;
            }
        }
    }
    
    for (UIImageView* imageView in modelCanvas.allImages) {
        
        UITouch* touch = [touches anyObject];
        CGPoint p = [touch locationInView:imageView];
        
        if (CGRectContainsPoint(imageView.bounds, p)) {
            if (newlySelectedItem) {
                if (imageView.layer.zPosition > newlySelectedItem.layer.zPosition) {
                    newlySelectedItem = imageView;
                }
            } else {
                newlySelectedItem = imageView;
            }
        }
    }
    
    if (newlySelectedItem) {
        if (newlySelectedItem == selectedItem) {
            UITouch* touch = [touches anyObject];
            isMoving = YES;
            moveStartingPoint = [touch locationInView:modelCanvas];
        } else {
            [self removeSelectionRelatedItems];
            [self addSelectionRelatedViewToItem:newlySelectedItem];
        }
        
    } else {
        if (selectedItem) {
            [self removeSelectionRelatedItems];
        }
    }
    
    [super touchesBegan:touches withEvent:event];
}
- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (isMoving) {
        UITouch* touch = [touches anyObject];
        CGPoint currentPoint = [touch locationInView:modelCanvas];
        
        CGPoint moveVector = CGPointMake(currentPoint.x-moveStartingPoint.x,
                                         currentPoint.y-moveStartingPoint.y);
        
        CGPoint center = selectedItem.center;
        
        center.x += moveVector.x;
        center.y += moveVector.y;
        
        selectedItem.center = center;
        moveStartingPoint = currentPoint;
        [self rearrangeSelectionRelatedViewsFrame];
        
    } else if (isRotating) {
        UITouch* touch = [touches anyObject];
        CGPoint currentPoint = [touch locationInView:modelCanvas];
        
        CGFloat angle = [self getAngleFromStartingPoint:rotateStartingPoint toEndPoint:currentPoint andCenterPoint:selectedItem.center];
        
        CGAffineTransform transform = selectedItem.transform;
        transform = CGAffineTransformRotate(transform, angle);
        selectedItem.transform = transform;
        rotateStartingPoint = currentPoint;
        
        [self rearrangeSelectionRelatedViewsFrame];
    } else if (isScaling) {
        UITouch* touch = [touches anyObject];
        CGPoint currentPoint = [touch locationInView:modelCanvas];
        
        CGPoint scaleVector = CGPointMake(currentPoint.x-scaleStartingPoint.x,
                                          currentPoint.y-scaleStartingPoint.y);
        
        CGPoint center = selectedItem.center;
        CGAffineTransform oldTransform = selectedItem.transform;
        
        CGFloat sx = 1+(scaleVector.x/selectedItem.frame.size.width);
        CGFloat sy = 1+(-scaleVector.y/selectedItem.frame.size.height);
        
        CGAffineTransform transform = selectedItem.transform;
        transform = CGAffineTransformScale(transform, sx, sy);
        selectedItem.transform = transform;
        
        CGSize newSize = selectedItem.frame.size;
        
        if ([selectedItem isKindOfClass:[PSDesignLabel class]]) {
            
            if ((newSize.width/((PSDesignLabel*)selectedItem).originalSize.width < MINIMUM_SCALE_FACTOR) ||
                (newSize.height/((PSDesignLabel*)selectedItem).originalSize.height) < MINIMUM_SCALE_FACTOR ||
                sx < 0 || sy < 0) {
                selectedItem.transform = oldTransform;
            } else {
                selectedItem.center = center;
                scaleStartingPoint = currentPoint;
                
                [self rearrangeSelectionRelatedViewsFrame];
            }
        } else if ([selectedItem isKindOfClass:[PSImageView class]]) {
            if ((newSize.width/((PSImageView*)selectedItem).originalSize.width < MINIMUM_SCALE_FACTOR) ||
                (newSize.height/((PSImageView*)selectedItem).originalSize.height) < MINIMUM_SCALE_FACTOR ||
                sx < 0 || sy < 0) {
                selectedItem.transform = oldTransform;
            } else {
                selectedItem.center = center;
                scaleStartingPoint = currentPoint;
                
                [self rearrangeSelectionRelatedViewsFrame];
            }
        }
    }
}
- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    
    if (isMoving) {
        UITouch* touch = [touches anyObject];
        CGPoint currentPoint = [touch locationInView:modelCanvas];
        
        CGPoint moveVector = CGPointMake(currentPoint.x-moveStartingPoint.x,
                                         currentPoint.y-moveStartingPoint.y);
        
        CGPoint center = selectedItem.center;
        
        center.x += moveVector.x;
        center.y += moveVector.y;
        
        selectedItem.center = center;
        moveStartingPoint = currentPoint;
        [self rearrangeSelectionRelatedViewsFrame];
        
        isMoving = NO;
    } else if (isRotating) {
        UITouch* touch = [touches anyObject];
        CGPoint currentPoint = [touch locationInView:modelCanvas];
        
        CGFloat angle = [self getAngleFromStartingPoint:rotateStartingPoint toEndPoint:currentPoint andCenterPoint:selectedItem.center];
        
        CGAffineTransform transform = selectedItem.transform;
        transform = CGAffineTransformRotate(transform, angle);
        selectedItem.transform = transform;
        rotateStartingPoint = currentPoint;
        
        [self rearrangeSelectionRelatedViewsFrame];
        
        isRotating = NO;
    } else if (isScaling) {
        UITouch* touch = [touches anyObject];
        CGPoint currentPoint = [touch locationInView:modelCanvas];
        
        CGPoint scaleVector = CGPointMake(currentPoint.x-scaleStartingPoint.x,
                                          currentPoint.y-scaleStartingPoint.y);
        
        CGPoint center = selectedItem.center;
        CGAffineTransform oldTransform = selectedItem.transform;
        
        CGFloat sx = 1+(scaleVector.x/selectedItem.frame.size.width);
        CGFloat sy = 1+(-scaleVector.y/selectedItem.frame.size.height);
        
        CGAffineTransform transform = selectedItem.transform;
        transform = CGAffineTransformScale(transform, sx, sy);
        selectedItem.transform = transform;
        
        CGSize newSize = selectedItem.frame.size;
        
        if ([selectedItem isKindOfClass:[PSDesignLabel class]]) {
            
            if ((newSize.width/((PSDesignLabel*)selectedItem).originalSize.width < MINIMUM_SCALE_FACTOR) ||
                (newSize.height/((PSDesignLabel*)selectedItem).originalSize.height) < MINIMUM_SCALE_FACTOR ||
                sx < 0 || sy < 0) {
                selectedItem.transform = oldTransform;
            } else {
                selectedItem.center = center;
                scaleStartingPoint = currentPoint;
                
                [self rearrangeSelectionRelatedViewsFrame];
            }
        } else if ([selectedItem isKindOfClass:[PSImageView class]]) {
            if ((newSize.width/((PSImageView*)selectedItem).originalSize.width < MINIMUM_SCALE_FACTOR) ||
                (newSize.height/((PSImageView*)selectedItem).originalSize.height) < MINIMUM_SCALE_FACTOR ||
                sx < 0 || sy < 0) {
                selectedItem.transform = oldTransform;
            } else {
                selectedItem.center = center;
                scaleStartingPoint = currentPoint;
                
                [self rearrangeSelectionRelatedViewsFrame];
            }
        }
        
        isScaling = NO;
    }
}
- (void) touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self touchesEnded:touches withEvent:event];
}
- (CGFloat) computeAngleOfTheLine:(CGPoint)firstPoint andSecondPoint:(CGPoint)secondPoint
{
    CGFloat x1 = firstPoint.x;
    CGFloat x2 = secondPoint.x;
    CGFloat y1 = firstPoint.y;
    CGFloat y2 = secondPoint.y;
    
    CGFloat angle = 0.0;
    
    if (y1 == y2) {
        if (x1 > x2) {
            return M_PI;
        } else {
            return 0;
        }
    }
    if (x1 == x2) {
        if (y1 > y2) {
            return M_PI_2;
        } else {
            return 3*M_PI_2;
        }
    }
    
    angle = atanf((y2 - y1) / (x2 - x1));
    if (x2 < x1) {
        angle += M_PI;
    } else if (y2 > y1) {
        angle += 2 * M_PI;
    }
    return angle;
}
- (CGFloat) getAngleFromStartingPoint:(CGPoint)startingPoint toEndPoint:(CGPoint)endPoint andCenterPoint:(CGPoint)centerPoint
{
    CGFloat angle1 = [self computeAngleOfTheLine:centerPoint andSecondPoint:endPoint];
    CGFloat angle2 = [self computeAngleOfTheLine:centerPoint andSecondPoint:startingPoint];
    
    return angle1-angle2;
}
- (CGFloat) getLengthFromStartingPoint:(CGPoint)startingPoint toEndPoint:(CGPoint)endPoint
{
    CGFloat x1 = startingPoint.x;
    CGFloat y1 = startingPoint.y;
    CGFloat x2 = endPoint.x;
    CGFloat y2 = endPoint.y;
    
    return sqrtf(powf(x1-x2, 2) + powf(y1-y2, 2));
}
- (void) removeSelectionRelatedItems
{
    
    if ([selectedItem isKindOfClass:[PSDesignLabel class]]) {
        if (((PSDesignLabel*)selectedItem).text == nil ||
            ((PSDesignLabel*)selectedItem).text.length == 0) {
            [selectedItem removeFromSuperview];
            [modelCanvas.allLabels removeObject:selectedItem];
        }
    }
    
    [currentDeleteView removeFromSuperview];
    currentDeleteView = nil;
    
    [currentScaleView removeFromSuperview];
    currentScaleView = nil;
    
    [currentMoveView removeFromSuperview];
    currentMoveView = nil;
    
    [currentRotateView removeFromSuperview];
    currentRotateView = nil;
    
    selectedItem = nil;
    
    
}
- (void) rearrangeSelectionRelatedViewsFrame
{
    CGRect frame = selectedItem.frame;
    frame.origin.x -= 4.0;
    frame.origin.y -= 4.0;
    frame.size.width += 8.0;
    frame.size.height += 8.0;
    
    currentDeleteView.frame = [self deleteViewFrameWithFrame:frame];
    
    currentScaleView.frame = [self scaleViewFrameWithFrame:frame];
    
    currentMoveView.frame = [self moveViewFrameWithFrame:frame];
    
    currentRotateView.frame = [self rotateViewFrameWithFrame:frame];
}
- (void) addSelectionRelatedViewToItem:(UIView*)item
{
    selectedItem = item;
    
    CGRect frame = item.frame;
    frame.origin.x -= 4.0;
    frame.origin.y -= 4.0;
    frame.size.width += 8.0;
    frame.size.height += 8.0;
    
    currentDeleteView = [[UIView alloc] initWithFrame:[self deleteViewFrameWithFrame:frame]];
    
    currentDeleteView.backgroundColor = [UIColor clearColor];
    UIImageView* imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tool_delete_normal.png"]];
    [currentDeleteView addSubview:imageView];
    currentDeleteView.tag = DELETE_VIEW_TAG;
    currentDeleteView.layer.zPosition = currentZIndex;
    [modelCanvas addSubview:currentDeleteView];
    
    currentScaleView = [[UIView alloc] initWithFrame:[self scaleViewFrameWithFrame:frame]];
    
    currentScaleView.backgroundColor = [UIColor clearColor];
    UIImageView* imageView2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tool_edit_normal.png"]];
    [currentScaleView addSubview:imageView2];
    currentScaleView.tag = SCALE_VIEW_TAG;
    currentScaleView.layer.zPosition = currentZIndex;
    [modelCanvas addSubview:currentScaleView];
    
    currentMoveView = [[UIView alloc] initWithFrame:[self moveViewFrameWithFrame:frame]];
    
    currentMoveView.backgroundColor = [UIColor clearColor];
    UIImageView* imageView3 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tool_move_normal.png"]];
    [currentMoveView addSubview:imageView3];
    currentMoveView.tag = MOVE_VIEW_TAG;
    currentMoveView.layer.zPosition = currentZIndex;
    [modelCanvas addSubview:currentMoveView];
    
    currentRotateView = [[UIView alloc] initWithFrame:[self rotateViewFrameWithFrame:frame]];
    
    currentRotateView.backgroundColor = [UIColor clearColor];
    UIImageView* imageView4 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tool_rotate_normal.png"]];
    [currentRotateView addSubview:imageView4];
    currentRotateView.tag = ROTATE_VIEW_TAG;
    currentRotateView.layer.zPosition = currentZIndex;
    [modelCanvas addSubview:currentRotateView];
    
    currentZIndex += 1.0;
    
    if ([selectedItem isKindOfClass:[PSDesignLabel class]]) {
        
        [[PSSubmenuManager sharedInstance] setTextSettings:((PSDesignLabel*)selectedItem).labelSettings];
        [[PSSubmenuManager sharedInstance] showSubmenuWithType:SUBMENU_TYPE_TEXT];
        
    } else if ([selectedItem isKindOfClass:[PSImageView class]]) {
        [[PSSubmenuManager sharedInstance] setImageSettings:((PSImageView*)selectedItem).imageSettings];
        [[PSSubmenuManager sharedInstance] showSubmenuWithType:SUBMENU_TYPE_IMAGE];
    }
    
}
#pragma mark - Memory warning
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
