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

- (CGRect) menuBackgroundFrame
{
    return CGRectMake(0.0, 0.0, SCREEN_SIZE.width, SCREEN_SIZE.height);
}
- (CGRect) designButtonFrame
{
    return CGRectMake(434.0, 343.0, MAIN_MENU_MAIN_BUTTONS_WIDTH, MAIN_MENU_MAIN_BUTTONS_HEIGHT);
}
- (CGRect) buyButtonFrame
{
    return CGRectMake(209.0, 343.0, MAIN_MENU_MAIN_BUTTONS_WIDTH, MAIN_MENU_MAIN_BUTTONS_HEIGHT);
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
- (void) performInitialSetups
{
    
    UIImageView* backgroundView = [[UIImageView alloc] initWithFrame:[self menuBackgroundFrame]];
    backgroundView.backgroundColor = [UIColor clearColor];
    backgroundView.image = [UIImage imageNamed:@"splash_bg.png"];
    [self.view addSubview:backgroundView];
    
    // design button
    UIButton* designButton = [UIButton buttonWithType:UIButtonTypeCustom];
    designButton.frame = [self designButtonFrame];
    designButton.backgroundColor = [UIColor clearColor];
    [designButton setImage:[UIImage imageNamed:@"brush_btn_normal.png"] forState:UIControlStateNormal];
    [designButton setImage:[UIImage imageNamed:@"brush_btn_highlighted.png"] forState:UIControlStateHighlighted];
    [designButton addTarget:self action:@selector(openDesignScreen) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:designButton];
    
    // buy button
    UIButton* buyButton = [UIButton buttonWithType:UIButtonTypeCustom];
    buyButton.frame = [self buyButtonFrame];
    buyButton.backgroundColor = [UIColor clearColor];
    [buyButton setImage:[UIImage imageNamed:@"haziral_btn_normal.png"] forState:UIControlStateNormal];
    [buyButton setImage:[UIImage imageNamed:@"haziral_btn_highlighted.png"] forState:UIControlStateHighlighted];
    [self.view addSubview:buyButton];
}
- (void) openHelp
{
    PSHelpPageViewController* howToUse = [PSHelpPageViewController create];
    [self presentViewController:howToUse animated:NO completion:nil];
    
}
- (void) openDesignScreen
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
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
