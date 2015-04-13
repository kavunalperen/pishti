//
//  PSProfileViewController.m
//  Pishti
//
//  Created by Alperen Kavun on 13/04/15.
//  Copyright (c) 2015 pishti. All rights reserved.
//

#import "PSProfileViewController.h"
#import "PSAuthenticationManager.h"
#import "PSCommons.h"

#define TOP_BUTTONS_WIDTH 46.0
#define TOP_BUTTONS_HEIGHT 46.0

@interface PSProfileViewController ()

@end

@implementation PSProfileViewController

- (CGRect) backgroundViewFrame
{
    return CGRectMake(0.0, 0.0, SCREEN_SIZE.width, SCREEN_SIZE.height);
}
- (CGRect) logoFrame
{
    return CGRectMake(SCREEN_SIZE.width-84.0, 18.0, 84.0, 94.0);
}
- (CGRect) topButtonsHolderFrame
{
    return CGRectMake(15.0, 15.0, TOP_BUTTONS_WIDTH*3, TOP_BUTTONS_HEIGHT);
}
- (CGRect) backButtonFrame
{
    return CGRectMake(0.0, 0.0, TOP_BUTTONS_WIDTH, TOP_BUTTONS_HEIGHT);
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
