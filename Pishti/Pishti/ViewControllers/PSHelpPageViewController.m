//
//  PSHelpPageViewController.m
//  Pishti
//
//  Created by Alperen Kavun on 17.05.2014.
//  Copyright (c) 2014 pishti. All rights reserved.
//

#import "PSHelpPageViewController.h"

@interface PSHelpPageViewController () <UIPageViewControllerDelegate,UIPageViewControllerDataSource>

@property NSArray* contentViewControllers;
@property UIPageControl* pageControl;

@end

@implementation PSHelpPageViewController
{
    NSInteger currentIndex;
}

- (CGRect) pageControlFrame
{
    return CGRectMake((SCREEN_SIZE.width-100.0)*0.5, SCREEN_SIZE.width-80.0, 100.0,44.0);
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
+ (PSHelpPageViewController *)create
{
    NSDictionary *options = [NSDictionary dictionaryWithObject:
                             [NSNumber numberWithInteger:UIPageViewControllerSpineLocationMin]
                                                        forKey: UIPageViewControllerOptionSpineLocationKey];
    return [[PSHelpPageViewController alloc]
            initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll
            navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal
            options:options];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.pageControl = [[UIPageControl alloc] initWithFrame:[self pageControlFrame]];
    self.pageControl.backgroundColor = [UIColor clearColor];
    [self.pageControl setNumberOfPages:5];
    [self.pageControl setCurrentPage:0];
    [self.view addSubview:self.pageControl];
    
    self.dataSource = self;
    self.delegate = self;
    
    self.contentViewControllers = @[
                                    [[PSHelpContentViewController alloc] initWithUIImage:[UIImage imageNamed:@"help1.png"]],
                                    [[PSHelpContentViewController alloc] initWithUIImage:[UIImage imageNamed:@"help2.png"]],
                                    [[PSHelpContentViewController alloc] initWithUIImage:[UIImage imageNamed:@"help3.png"]],
                                    [[PSHelpContentViewController alloc] initWithUIImage:[UIImage imageNamed:@"help4.png"]],
                                    [[PSHelpContentViewController alloc] initWithUIImage:[UIImage imageNamed:@"help5.png"]]
                                    ];
    
    PSHelpContentViewController* lastVc = (PSHelpContentViewController*)[self.contentViewControllers objectAtIndex:4];
    lastVc.view.userInteractionEnabled = YES;
    
    UITapGestureRecognizer* tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeHowToUse)];
    [lastVc.view addGestureRecognizer:tapGesture];
    
    [self setViewControllers:[NSArray arrayWithObject:[self.contentViewControllers objectAtIndex:0]] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:^(BOOL finished) {
        
    }];
}
- (void) closeHowToUse
{
    [self dismissViewControllerAnimated:NO completion:nil];
}
- (void)startGoThrough
{
    [self showViewController:[self.contentViewControllers objectAtIndex:0] direction:UIPageViewControllerNavigationDirectionForward];
    [self.pageControl setCurrentPage:0];
    [self showPageControl];
}
-(void) showPageControl
{
    [UIView animateWithDuration:0.1 animations:^{
        self.pageControl.alpha = 1.0;
    }];
}
- (void) hidePageControl
{
    [UIView animateWithDuration:0.1 animations:^{
        self.pageControl.alpha = 0.0;
    }];
}

- (void) showViewController:(UIViewController*)viewController direction:(UIPageViewControllerNavigationDirection)direction
{
    __block PSHelpPageViewController *blocksafeSelf = self;
    [self setViewControllers:@[viewController] direction:direction animated:YES completion:^(BOOL finished){
        if(finished)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                [blocksafeSelf setViewControllers:@[viewController] direction:direction animated:NO completion:NULL];// bug fix for uipageview controller
            });
        }
    }];
}

-(void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed
{
    UIViewController* viewController = [self.viewControllers objectAtIndex:0];
    
    NSInteger index = [self.contentViewControllers indexOfObject:viewController];
    [self.pageControl setCurrentPage:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    
    for(int i=0;i<self.contentViewControllers.count ;i++)
    {
        if(viewController == [self.contentViewControllers objectAtIndex:i])
        {
            if(i+1 < self.contentViewControllers.count)
            {
                return [self.contentViewControllers objectAtIndex:i+1];
            }
        }
    }
    return nil;
}
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    
    for(int i=0;i<self.contentViewControllers.count ;i++)
    {
        if(viewController == [self.contentViewControllers objectAtIndex:i])
        {
            if(i-1 >= 0)
            {
                return [self.contentViewControllers objectAtIndex:i-1];
            }
        }
    }
    return nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
