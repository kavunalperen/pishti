//
//  PSHelpContentViewController.m
//  Pishti
//
//  Created by Alperen Kavun on 17.05.2014.
//  Copyright (c) 2014 pishti. All rights reserved.
//

#import "PSHelpContentViewController.h"

@interface PSHelpContentViewController ()

@end

@implementation PSHelpContentViewController
{
    UIImage* image;
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
- (id)initWithUIImage:(UIImage *)_image
{
    if(self = [super init])
    {
        image = _image;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIImageView* imageView = [[UIImageView alloc] initWithImage:image];
    [imageView setFrame:CGRectMake(0.0, 0.0, SCREEN_SIZE.height, SCREEN_SIZE.width)];
    [imageView setContentMode:UIViewContentModeScaleAspectFill];
    [self.view insertSubview:imageView atIndex:0];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
