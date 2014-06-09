//
//  PSMenuViewController.m
//  Pishti
//
//  Created by Alperen Kavun on 8.04.2014.
//  Copyright (c) 2014 pishti. All rights reserved.
//

#import "PSMenuViewController.h"
#import "PSDesignViewController.h"

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
//{
//    UIImageView* halfBackgroundLeftView;
//    UIImageView* halfBackgroundRightView;
//}
- (CGRect) menuBackgroundFrame
{
    return CGRectMake(0.0, 0.0, SCREEN_SIZE.height, SCREEN_SIZE.width);
}
- (CGRect) menuBackgroundRightFrame
{
    return CGRectMake(HALF_BACKGROUND_WIDTH, 0.0, HALF_BACKGROUND_WIDTH, HALF_BACKGROUND_HEIGHT);
}
- (CGRect) menuBackgroundLeftFrame
{
    return CGRectMake(0.0, 0.0, HALF_BACKGROUND_WIDTH, HALF_BACKGROUND_HEIGHT);
}
- (CGRect) designButtonFrame
{
    return CGRectMake(555.0, MAIN_MENU_MAIN_BUTTONS_TOP_MARGIN, MAIN_MENU_MAIN_BUTTONS_WIDTH, MAIN_MENU_MAIN_BUTTONS_HEIGHT);
}
- (CGRect) buyButtonFrame
{
    return CGRectMake(344.0, MAIN_MENU_MAIN_BUTTONS_TOP_MARGIN, MAIN_MENU_MAIN_BUTTONS_WIDTH, MAIN_MENU_MAIN_BUTTONS_HEIGHT);
}

- (CGRect) profileButtonFrame
{
    return CGRectMake(MAIN_MENU_OTHER_BUTTONS_LEFT_MARGIN, 637.0, MAIN_MENU_OTHER_BUTTONS_WIDTH, MAIN_MENU_OTHER_BUTTONS_HEIGHT);
}
- (CGRect) otherButtonsLine1Frame
{
    return CGRectMake(MAIN_MENU_OTHER_BUTTONS_LINE_LEFT_MARGIN, 675.0, MAIN_MENU_OTHER_BUTTONS_LINE_WIDTH, MAIN_MENU_OTHER_BUTTONS_LINE_HEIGHT);
}
- (CGRect) helpButtonFrame
{
    return CGRectMake(MAIN_MENU_OTHER_BUTTONS_LEFT_MARGIN, 676.0, MAIN_MENU_OTHER_BUTTONS_WIDTH, MAIN_MENU_OTHER_BUTTONS_HEIGHT);
}
- (CGRect) otherButtonsLine2Frame
{
    return CGRectMake(MAIN_MENU_OTHER_BUTTONS_LINE_LEFT_MARGIN, 714.0, MAIN_MENU_OTHER_BUTTONS_LINE_WIDTH, MAIN_MENU_OTHER_BUTTONS_LINE_HEIGHT);
}
- (CGRect) settingsButtonFrame
{
    return CGRectMake(MAIN_MENU_OTHER_BUTTONS_LEFT_MARGIN, 715.0, MAIN_MENU_OTHER_BUTTONS_WIDTH, MAIN_MENU_OTHER_BUTTONS_HEIGHT);
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (BOOL) shouldAutorotate
{
    return UIInterfaceOrientationMaskLandscape;
}
-(NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscape;
}
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    UIApplication *app = [UIApplication sharedApplication];
    
    if ([app statusBarOrientation] == UIInterfaceOrientationPortrait ||
        [app statusBarOrientation] == UIInterfaceOrientationPortraitUpsideDown) {
        return UIInterfaceOrientationLandscapeRight;
    } else {
        return [app statusBarOrientation];
    }
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self performInitialSetups];
}
- (void) performInitialSetups
{
    // background views
    UIImageView* halfBackgroundLeftView = [[UIImageView alloc] initWithFrame:[self menuBackgroundLeftFrame]];
    halfBackgroundLeftView.backgroundColor = [UIColor clearColor];
    halfBackgroundLeftView.image = [UIImage imageNamed:@"splash_left.png"];
    [self.view addSubview:halfBackgroundLeftView];
    
    UIImageView* halfBackgroundRightView = [[UIImageView alloc] initWithFrame:[self menuBackgroundRightFrame]];
    halfBackgroundRightView.backgroundColor = [UIColor clearColor];
    halfBackgroundRightView.image = [UIImage imageNamed:@"splash_right.png"];
    [self.view addSubview:halfBackgroundRightView];
    
    // design button
    UIButton* designButton = [UIButton buttonWithType:UIButtonTypeCustom];
    designButton.frame = [self designButtonFrame];
    designButton.backgroundColor = [UIColor clearColor];
    [designButton setImage:[UIImage imageNamed:@"tasarla_btn_normal.png"] forState:UIControlStateNormal];
    [designButton setImage:[UIImage imageNamed:@"tasarla_btn_highlighted.png"] forState:UIControlStateHighlighted];
    [designButton addTarget:self action:@selector(openDesignScreen) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:designButton];
    
    // buy button
    UIButton* buyButton = [UIButton buttonWithType:UIButtonTypeCustom];
    buyButton.frame = [self buyButtonFrame];
    buyButton.backgroundColor = [UIColor clearColor];
    [buyButton setImage:[UIImage imageNamed:@"haziral_btn_normal.png"] forState:UIControlStateNormal];
    [buyButton setImage:[UIImage imageNamed:@"haziral_btn_highlighted.png"] forState:UIControlStateHighlighted];
    [self.view addSubview:buyButton];
    
    // other buttons
    UIButton* profileButton = [UIButton buttonWithType:UIButtonTypeCustom];
    profileButton.backgroundColor = [UIColor clearColor];
    profileButton.frame = [self profileButtonFrame];
    [profileButton setImage:[UIImage imageNamed:@"profile_btn_normal.png"] forState:UIControlStateNormal];
    [profileButton setImage:[UIImage imageNamed:@"profile_btn_highlighted.png"] forState:UIControlStateHighlighted];
    [self.view addSubview:profileButton];
    
    UIImageView* otherButtonsLine1 = [[UIImageView alloc] initWithFrame:[self otherButtonsLine1Frame]];
    otherButtonsLine1.backgroundColor = [UIColor clearColor];
    otherButtonsLine1.image = [UIImage imageNamed:@"left_btn_line.png"];
    [self.view addSubview:otherButtonsLine1];
    
    UIButton* helpButton = [UIButton buttonWithType:UIButtonTypeCustom];
    helpButton.backgroundColor = [UIColor clearColor];
    helpButton.frame = [self helpButtonFrame];
    [helpButton setImage:[UIImage imageNamed:@"help_btn_normal.png"] forState:UIControlStateNormal];
    [helpButton setImage:[UIImage imageNamed:@"help_btn_highlighted.png"] forState:UIControlStateHighlighted];
    [helpButton addTarget:self action:@selector(openHelp) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:helpButton];
    
    UIImageView* otherButtonsLine2 = [[UIImageView alloc] initWithFrame:[self otherButtonsLine2Frame]];
    otherButtonsLine2.backgroundColor = [UIColor clearColor];
    otherButtonsLine2.image = [UIImage imageNamed:@"left_btn_line.png"];
    [self.view addSubview:otherButtonsLine2];
    
    UIButton* settingsButton = [UIButton buttonWithType:UIButtonTypeCustom];
    settingsButton.backgroundColor = [UIColor clearColor];
    settingsButton.frame = [self settingsButtonFrame];
    [settingsButton setImage:[UIImage imageNamed:@"settings_btn_normal.png"] forState:UIControlStateNormal];
    [settingsButton setImage:[UIImage imageNamed:@"settings_btn_highlighted.png"] forState:UIControlStateHighlighted];
    [self.view addSubview:settingsButton];
}
- (void) openHelp
{
    PSHelpPageViewController* howToUse = [PSHelpPageViewController create];
    [self presentViewController:howToUse animated:NO completion:nil];
    
}
- (void) openDesignScreen
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        PSDesignViewController* designVC = [[PSDesignViewController alloc] init];
        [self presentViewController:designVC animated:NO completion:^{
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
