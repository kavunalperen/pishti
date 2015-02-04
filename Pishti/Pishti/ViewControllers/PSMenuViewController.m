//
//  PSMenuViewController.m
//  Pishti
//
//  Created by Alperen Kavun on 8.04.2014.
//  Copyright (c) 2014 pishti. All rights reserved.
//

#import "PSMenuViewController.h"
#import "PSDesignViewController.h"
#import "PSDesignViewController2.h"
#import "SBJson.h"

#define HALF_BACKGROUND_WIDTH 512.0
#define HALF_BACKGROUND_HEIGHT 768.0

#define MAIN_MENU_MAIN_BUTTONS_TOP_MARGIN 500.0
#define MAIN_MENU_MAIN_BUTTONS_WIDTH 125.0
#define MAIN_MENU_MAIN_BUTTONS_HEIGHT 125.0

#define MAIN_MENU_OTHER_BUTTONS_LEFT_MARGIN 15.0
#define MAIN_MENU_OTHER_BUTTONS_WIDTH 25.0
#define MAIN_MENU_OTHER_BUTTONS_HEIGHT 38.0

#define MAIN_MENU_OTHER_BUTTONS_LINE_LEFT_MARGIN 0.0
#define MAIN_MENU_OTHER_BUTTONS_LINE_WIDTH 50.0
#define MAIN_MENU_OTHER_BUTTONS_LINE_HEIGHT 1.0

@interface PSMenuViewController ()

@end

@implementation PSMenuViewController
{
    UIButton* designButton;
    UIButton* buyButton;
    NSDictionary* animations;
    NSDictionary* backwardAnimations;
    NSMutableDictionary* animItems;
}
- (CGRect) menuBackgroundFrame
{
    return CGRectMake(0.0, 0.0, SCREEN_SIZE.width, SCREEN_SIZE.height);
}
- (CGRect) designButtonFrame
{
    return CGRectMake(434.0, 640.0, MAIN_MENU_MAIN_BUTTONS_WIDTH, MAIN_MENU_MAIN_BUTTONS_HEIGHT);
}
- (CGRect) buyButtonFrame
{
    return CGRectMake(209.0, 640.0, MAIN_MENU_MAIN_BUTTONS_WIDTH, MAIN_MENU_MAIN_BUTTONS_HEIGHT);
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self performInitialSetups];
    
}
- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setupInitialAnimationValues];
    [self performForwardAnimations];
}
- (void) setupInitialAnimationValues
{
    designButton.alpha = 0.0;
    buyButton.alpha = 0.0;
    
    for (NSDictionary* item in [animations objectForKey:@"items"]) {
        NSString* itemId = [item objectForKey:@"id"];
        CGFloat zIndex = [[item objectForKey:@"zIndex"] floatValue];
        
        NSDictionary* start = [item objectForKey:@"start"];
        
        CGPoint sCenter;
        sCenter.x = [[[start objectForKey:@"center"] objectForKey:@"x"] floatValue];
        sCenter.y = [[[start objectForKey:@"center"] objectForKey:@"y"] floatValue];
        
        CGSize sScale;
        sScale.width = [[[start objectForKey:@"scale"] objectForKey:@"x"] floatValue];
        sScale.height = [[[start objectForKey:@"scale"] objectForKey:@"y"] floatValue];
        
        CGFloat sAngle = [[start objectForKey:@"rotation"] floatValue]-90.0;
        
        UIImageView* imageView = [animItems objectForKey:itemId];
        imageView.layer.zPosition = zIndex;
        imageView.center = sCenter;
        
        CGAffineTransform scale = CGAffineTransformMakeScale(sScale.width, sScale.height);
        CGAffineTransform rotation = CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(sAngle));
        CGAffineTransform transform = CGAffineTransformConcat(scale, rotation);
        imageView.transform = transform;
    }
}
- (void) performForwardAnimations
{
    
    CGFloat buttonsFadeStart = [[animations objectForKey:@"buttons_fade_start"] floatValue];
    CGFloat buttonsFadeDuration = [[animations objectForKey:@"buttons_fade_duration"] floatValue];
    
    [UIView animateWithDuration:buttonsFadeDuration delay:buttonsFadeStart options:UIViewAnimationOptionCurveEaseOut animations:^{
        designButton.alpha = 1.0;
        buyButton.alpha = 1.0;
    } completion:nil];
    
    for (NSDictionary* item in [animations objectForKey:@"items"]) {
        NSString* itemId = [item objectForKey:@"id"];
        
        UIImageView* imageView = [animItems objectForKey:itemId];
        
        CGFloat delay = [[item objectForKey:@"delay"] floatValue];
        CGFloat duration = [[item objectForKey:@"duration"] floatValue];
        
        NSDictionary* end = [item objectForKey:@"end"];
        
        CGPoint eCenter;
        eCenter.x = [[[end objectForKey:@"center"] objectForKey:@"x"] floatValue];
        eCenter.y = [[[end objectForKey:@"center"] objectForKey:@"y"] floatValue];
        
        CGSize eScale;
        eScale.width = [[[end objectForKey:@"scale"] objectForKey:@"x"] floatValue];
        eScale.height = [[[end objectForKey:@"scale"] objectForKey:@"y"] floatValue];
        
        CGFloat eAngle = [[end objectForKey:@"rotation"] floatValue]-90.0;
        
        CGAffineTransform scale2 = CGAffineTransformMakeScale(eScale.width, eScale.height);
        CGAffineTransform rotation2 = CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(eAngle));
        CGAffineTransform transform2 = CGAffineTransformConcat(scale2, rotation2);
        
        [UIView animateWithDuration:duration delay:delay options:UIViewAnimationOptionCurveEaseOut animations:^{
            imageView.center = eCenter;
            imageView.transform = transform2;
        } completion:nil];
    }
}
- (void) performBackwardAnimations
{
    CGFloat buttonsFadeStart = [[backwardAnimations objectForKey:@"buttons_fade_start"] floatValue];
    CGFloat buttonsFadeDuration = [[backwardAnimations objectForKey:@"buttons_fade_duration"] floatValue];
    
    [UIView animateWithDuration:buttonsFadeDuration delay:buttonsFadeStart options:UIViewAnimationOptionCurveEaseIn animations:^{
        designButton.alpha = 0.0;
        buyButton.alpha = 0.0;
    } completion:nil];
    
    for (NSDictionary* item in [backwardAnimations objectForKey:@"items"]) {
        NSString* itemId = [item objectForKey:@"id"];
        
        UIImageView* imageView = [animItems objectForKey:itemId];
        
        CGFloat delay = [[item objectForKey:@"delay"] floatValue];
        CGFloat duration = [[item objectForKey:@"duration"] floatValue];
        
        NSDictionary* end = [item objectForKey:@"end"];
        
        CGPoint eCenter;
        eCenter.x = [[[end objectForKey:@"center"] objectForKey:@"x"] floatValue];
        eCenter.y = [[[end objectForKey:@"center"] objectForKey:@"y"] floatValue];
        
        CGSize eScale;
        eScale.width = [[[end objectForKey:@"scale"] objectForKey:@"x"] floatValue];
        eScale.height = [[[end objectForKey:@"scale"] objectForKey:@"y"] floatValue];
        
        CGFloat eAngle = [[end objectForKey:@"rotation"] floatValue]-90.0;
        
        CGAffineTransform scale = CGAffineTransformMakeScale(eScale.width, eScale.height);
        CGAffineTransform rotation = CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(eAngle));
        CGAffineTransform transform = CGAffineTransformConcat(scale, rotation);
        
        [UIView animateWithDuration:duration delay:delay options:UIViewAnimationOptionCurveEaseIn animations:^{
            imageView.center = eCenter;
            imageView.transform = transform;
        } completion:nil];
    }
}
- (void) performInitialSetups
{
    
    UIImageView* backgroundView = [[UIImageView alloc] initWithFrame:[self menuBackgroundFrame]];
    backgroundView.backgroundColor = [UIColor clearColor];
    backgroundView.image = [UIImage imageNamed:@"intro_bg.jpg"];
    [self.view addSubview:backgroundView];
    
    // design button
    designButton = [UIButton buttonWithType:UIButtonTypeCustom];
    designButton.frame = [self designButtonFrame];
    designButton.backgroundColor = [UIColor clearColor];
    [designButton setImage:[UIImage imageNamed:@"brush_btn_normal.png"] forState:UIControlStateNormal];
    [designButton setImage:[UIImage imageNamed:@"brush_btn_highlighted.png"] forState:UIControlStateHighlighted];
    [designButton addTarget:self action:@selector(openDesignScreen) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:designButton];
    
    // buy button
    buyButton = [UIButton buttonWithType:UIButtonTypeCustom];
    buyButton.frame = [self buyButtonFrame];
    buyButton.backgroundColor = [UIColor clearColor];
    [buyButton setImage:[UIImage imageNamed:@"haziral_btn_normal.png"] forState:UIControlStateNormal];
    [buyButton setImage:[UIImage imageNamed:@"haziral_btn_highlighted.png"] forState:UIControlStateHighlighted];
    [self.view addSubview:buyButton];
    
    if (animations == nil) {
        NSString* content = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"mainMenuAnimation_forward" ofType:@"json"]
                                                      encoding:NSUTF8StringEncoding
                                                         error:NULL];
        
        
        SBJsonParser* parser = [[SBJsonParser alloc] init];
        animations = [parser objectWithString:content];
        
        animItems = @{}.mutableCopy;
    }
    
    if (backwardAnimations == nil) {
        NSString* content = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"mainMenuAnimation_backward" ofType:@"json"]
                                                      encoding:NSUTF8StringEncoding
                                                         error:NULL];
        
        SBJsonParser* parser = [[SBJsonParser alloc] init];
        backwardAnimations = [parser objectWithString:content];
    }
    
    for (NSDictionary* item in [animations objectForKey:@"items"]) {
        NSString* imageName = [item objectForKey:@"imageName"];
        NSString* itemId = [item objectForKey:@"id"];
        UIImageView* imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
        [self.view addSubview:imageView];
        [animItems setObject:imageView forKey:itemId];
    }
}
- (void) openHelp
{
    PSHelpPageViewController* howToUse = [PSHelpPageViewController create];
    [self presentViewController:howToUse animated:NO completion:nil];
    
}
- (void) openDesignScreen
{
    [self performBackwardAnimations];
    CGFloat animsEnd = [[backwardAnimations objectForKey:@"all_animations_end"] floatValue];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(animsEnd * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        PSDesignViewController2* designVC = [[PSDesignViewController2 alloc] init];
        designVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [self presentViewController:designVC animated:YES completion:^{
            ;
        }];
    });
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
