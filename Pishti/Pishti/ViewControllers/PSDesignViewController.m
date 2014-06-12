//
//  PSDesignViewController.m
//  Pishti
//
//  Created by Alperen Kavun on 11.05.2014.
//  Copyright (c) 2014 pishti. All rights reserved.
//

#define HALF_BACKGROUND_WIDTH 512.0
#define HALF_BACKGROUND_HEIGHT 768.0

#define LOGO_WIDTH 126.0
#define LOGO_HEIGHT 107.0

#define MAIN_MENU_WIDTH 84.0
#define MAIN_MENU_HEIGHT 768.0

#define MAIN_MENU_MAIN_BUTTONS_LEFT_MARGIN 17.0
#define MAIN_MENU_MAIN_BUTTONS_WIDTH 52.0
#define MAIN_MENU_MAIN_BUTTONS_HEIGHT 52.0

#define MAIN_MENU_VISION_BUTTONS_LEFT_MARGIN 17.0
#define MAIN_MENU_VISION_BUTTONS_WIDTH 52.0
#define MAIN_MENU_VISION_BUTTONS_HEIGHT 40.0

#define MAIN_MENU_OTHER_BUTTONS_LEFT_MARGIN 15.0
#define MAIN_MENU_OTHER_BUTTONS_WIDTH 25.0
#define MAIN_MENU_OTHER_BUTTONS_HEIGHT 38.0

#define MAIN_MENU_OTHER_BUTTONS_LINE_LEFT_MARGIN 0.0
#define MAIN_MENU_OTHER_BUTTONS_LINE_WIDTH 50.0
#define MAIN_MENU_OTHER_BUTTONS_LINE_HEIGHT 1.0

#define FABRIC_SUBMENU_WIDTH 162.0
#define FABRIC_SUBMENU_HEIGHT 655.0

#define FABRIC_SUBMENU_LEFT_TITLES_LEFT_MARGIN 15.0
#define FABRIC_SUBMENU_TITLES_SMALL_WIDTH 58.0
#define FABRIC_SUBMENU_TITLES_BIG_WIDTH 130.0
#define FABRIC_SUBMENU_TITLES_HEIGHT 17.0

#define FABRIC_SUBMENU_RIGHT_TITLES_LEFT_MARGIN 87.0
#define FABRIC_SUBMENU_VALUES_SMALL_WIDTH 58.0
#define FABRIC_SUBMENU_VALUES_BIG_WIDTH 130.0
#define FABRIC_SUBMENU_VALUES_HEIGHT 25.0

#define FABRIC_SUBMENU_IMAGE_WIDTH 63.0
#define FABRIC_SUBMENU_IMAGE_HEIGHT 25.0

#define FABRIC_SUBMENU_SEPERATOR_HEIGHT 1.0

#import "PSDesignViewController.h"

@interface PSDesignViewController ()

@end

@implementation PSDesignViewController
{
    CGFloat otherButtonHolderHeight;
    
    UIImageView* backgroundView;
    UIImageView* logoView;
    UIView* otherButtonHolder;
    UIImageView* fabricSubmenuView;
    UIImageView* brushSubmenuView;
    
    UIButton* profileButton;
    UIImageView* otherButtonsLine1;
    UIButton* helpButton;
    UIImageView* otherButtonsLine2;
    UIButton* settingsButton;
    
    UILabel* fabricColorSelectionValueLabel;
    UITapGestureRecognizer* colorTableOpeningGesture;
    UITapGestureRecognizer* colorTableClosingGesture;
    
    UILabel* brushColorSelectionValueLabel;
    UITapGestureRecognizer* brushColorTableOpeningGesture;
    UITapGestureRecognizer* brushColorTableClosingGesture;
    
    UILabel* brushWidthSelectionValueLabel;
    UITapGestureRecognizer* brushWidthTableOpeningGesture;
    UITapGestureRecognizer* brushWidthTableClosingGesture;
    
    NSArray* colors;
    NSArray* colorNames;
    NSArray* brushWidths;
    
    UIImageView* halfBackgroundLeftView;
    UIImageView* halfBackgroundRightView;
    
    PSModelCanvas* modelCanvas;
    
    UIButton* fabricButton;
    UIButton* brushButton;
    
    UIButton* basicBrushButton;
    UIButton* pattern1BrushButton;
    UIButton* pattern2BrushButton;
}
// view related main frames
- (CGRect) backgroundFrame
{
    return CGRectMake(0.0, 0.0, SCREEN_SIZE.height, SCREEN_SIZE.width);
}
- (CGRect) logoFrame
{
    return CGRectMake(SCREEN_SIZE.height-LOGO_WIDTH, 0.0, LOGO_WIDTH, LOGO_HEIGHT);
}

// menu frame
- (CGRect) mainMenuFrame
{
    return CGRectMake(SCREEN_SIZE.height-MAIN_MENU_WIDTH, 0.0, MAIN_MENU_WIDTH, MAIN_MENU_HEIGHT);
}

// main buttons frames
- (CGRect) fabricButtonFrame
{
    return CGRectMake(MAIN_MENU_MAIN_BUTTONS_LEFT_MARGIN, 107.0, MAIN_MENU_MAIN_BUTTONS_WIDTH, MAIN_MENU_MAIN_BUTTONS_HEIGHT);
}
- (CGRect) textButtonFrame
{
    return CGRectMake(MAIN_MENU_MAIN_BUTTONS_LEFT_MARGIN, 169.0, MAIN_MENU_MAIN_BUTTONS_WIDTH, MAIN_MENU_MAIN_BUTTONS_HEIGHT);
}
- (CGRect) brushButtonFrame
{
    return CGRectMake(MAIN_MENU_MAIN_BUTTONS_LEFT_MARGIN, 231.0, MAIN_MENU_MAIN_BUTTONS_WIDTH, MAIN_MENU_MAIN_BUTTONS_HEIGHT);
}
- (CGRect) imageButtonFrame
{
    return CGRectMake(MAIN_MENU_MAIN_BUTTONS_LEFT_MARGIN, 293.0, MAIN_MENU_MAIN_BUTTONS_WIDTH, MAIN_MENU_MAIN_BUTTONS_HEIGHT);
}
- (CGRect) orderButtonFrame
{
    return CGRectMake(MAIN_MENU_MAIN_BUTTONS_LEFT_MARGIN, 701.0, MAIN_MENU_MAIN_BUTTONS_WIDTH, MAIN_MENU_MAIN_BUTTONS_HEIGHT);
}

// vision buttons frames
- (CGRect) visionFrontButtonFrame
{
    return CGRectMake(MAIN_MENU_VISION_BUTTONS_LEFT_MARGIN, 521.0, MAIN_MENU_VISION_BUTTONS_WIDTH, MAIN_MENU_VISION_BUTTONS_HEIGHT);
}
- (CGRect) visionRightButtonFrame
{
    return CGRectMake(MAIN_MENU_VISION_BUTTONS_LEFT_MARGIN, 561.0, MAIN_MENU_VISION_BUTTONS_WIDTH, MAIN_MENU_VISION_BUTTONS_HEIGHT);
}
- (CGRect) visionBackButtonFrame
{
    return CGRectMake(MAIN_MENU_VISION_BUTTONS_LEFT_MARGIN, 601.0, MAIN_MENU_VISION_BUTTONS_WIDTH, MAIN_MENU_VISION_BUTTONS_HEIGHT);
}
- (CGRect) visionLeftButtonFrame
{
    return CGRectMake(MAIN_MENU_VISION_BUTTONS_LEFT_MARGIN, 641.0, MAIN_MENU_VISION_BUTTONS_WIDTH, MAIN_MENU_VISION_BUTTONS_HEIGHT);
}

// other buttons frames
- (CGRect) otherButtonHolderFrame
{
    return CGRectMake(0.0, 0.0, 45.0, SCREEN_SIZE.width);
}
- (CGRect) backButtonFrame
{
    return CGRectMake(MAIN_MENU_OTHER_BUTTONS_LEFT_MARGIN, 15.0, MAIN_MENU_OTHER_BUTTONS_WIDTH, MAIN_MENU_OTHER_BUTTONS_HEIGHT);
}
- (CGRect) profileButtonFrame
{
    CGFloat bottom = otherButtonHolderHeight;
    return CGRectMake(MAIN_MENU_OTHER_BUTTONS_LEFT_MARGIN, bottom-3*MAIN_MENU_OTHER_BUTTONS_HEIGHT-2*MAIN_MENU_OTHER_BUTTONS_LINE_HEIGHT-MAIN_MENU_OTHER_BUTTONS_LEFT_MARGIN, MAIN_MENU_OTHER_BUTTONS_WIDTH, MAIN_MENU_OTHER_BUTTONS_HEIGHT);
}
- (CGRect) otherButtonsLine1Frame
{
    CGFloat bottom = otherButtonHolderHeight;
    return CGRectMake(MAIN_MENU_OTHER_BUTTONS_LINE_LEFT_MARGIN, bottom-2*MAIN_MENU_OTHER_BUTTONS_HEIGHT-MAIN_MENU_OTHER_BUTTONS_LINE_HEIGHT-MAIN_MENU_OTHER_BUTTONS_LEFT_MARGIN, MAIN_MENU_OTHER_BUTTONS_LINE_WIDTH, MAIN_MENU_OTHER_BUTTONS_LINE_HEIGHT);
}
- (CGRect) helpButtonFrame
{
    CGFloat bottom = otherButtonHolderHeight;
    return CGRectMake(MAIN_MENU_OTHER_BUTTONS_LEFT_MARGIN, bottom-2*MAIN_MENU_OTHER_BUTTONS_HEIGHT-MAIN_MENU_OTHER_BUTTONS_LINE_HEIGHT-MAIN_MENU_OTHER_BUTTONS_LEFT_MARGIN, MAIN_MENU_OTHER_BUTTONS_WIDTH, MAIN_MENU_OTHER_BUTTONS_HEIGHT);
}
- (CGRect) otherButtonsLine2Frame
{
    CGFloat bottom = otherButtonHolderHeight;
    return CGRectMake(MAIN_MENU_OTHER_BUTTONS_LINE_LEFT_MARGIN, bottom-MAIN_MENU_OTHER_BUTTONS_HEIGHT-MAIN_MENU_OTHER_BUTTONS_LEFT_MARGIN-MAIN_MENU_OTHER_BUTTONS_LINE_HEIGHT, MAIN_MENU_OTHER_BUTTONS_LINE_WIDTH, MAIN_MENU_OTHER_BUTTONS_LINE_HEIGHT);
}
- (CGRect) settingsButtonFrame
{
    CGFloat bottom = otherButtonHolderHeight;
    return CGRectMake(MAIN_MENU_OTHER_BUTTONS_LEFT_MARGIN, bottom-MAIN_MENU_OTHER_BUTTONS_HEIGHT-MAIN_MENU_OTHER_BUTTONS_LEFT_MARGIN, MAIN_MENU_OTHER_BUTTONS_WIDTH, MAIN_MENU_OTHER_BUTTONS_HEIGHT);
}

// submenu buttons frames

// size selection frames
- (CGRect) sizeSelectionTitleFrame
{
    return CGRectMake(FABRIC_SUBMENU_LEFT_TITLES_LEFT_MARGIN, 53.0, FABRIC_SUBMENU_TITLES_SMALL_WIDTH, FABRIC_SUBMENU_TITLES_HEIGHT);
}
- (CGRect) sizeSelectionTitleSeperatorFrame
{
    return CGRectMake(FABRIC_SUBMENU_LEFT_TITLES_LEFT_MARGIN, 70.0, FABRIC_SUBMENU_TITLES_SMALL_WIDTH, FABRIC_SUBMENU_SEPERATOR_HEIGHT);
}
- (CGRect) sizeSelectionValueFrame
{
    return CGRectMake(FABRIC_SUBMENU_LEFT_TITLES_LEFT_MARGIN, 71.0, FABRIC_SUBMENU_VALUES_SMALL_WIDTH, FABRIC_SUBMENU_VALUES_HEIGHT);
}
- (CGRect) sizeSelectionValueSeperatorFrame
{
    return CGRectMake(FABRIC_SUBMENU_LEFT_TITLES_LEFT_MARGIN, 96.0, FABRIC_SUBMENU_VALUES_SMALL_WIDTH, FABRIC_SUBMENU_SEPERATOR_HEIGHT);
}
// shape selection frames
- (CGRect) shapeSelectionTitleFrame
{
    return CGRectMake(FABRIC_SUBMENU_RIGHT_TITLES_LEFT_MARGIN, 53.0, FABRIC_SUBMENU_TITLES_SMALL_WIDTH, FABRIC_SUBMENU_TITLES_HEIGHT);
}
- (CGRect) shapeSelectionTitleSeperatorFrame
{
    return CGRectMake(FABRIC_SUBMENU_RIGHT_TITLES_LEFT_MARGIN, 70.0, FABRIC_SUBMENU_TITLES_SMALL_WIDTH, FABRIC_SUBMENU_SEPERATOR_HEIGHT);
}
- (CGRect) shapeSelectionValueFrame
{
    return CGRectMake(FABRIC_SUBMENU_RIGHT_TITLES_LEFT_MARGIN, 71.0, FABRIC_SUBMENU_VALUES_SMALL_WIDTH, FABRIC_SUBMENU_VALUES_HEIGHT);
}
- (CGRect) shapeSelectionValueSeperatorFrame
{
    return CGRectMake(FABRIC_SUBMENU_RIGHT_TITLES_LEFT_MARGIN, 96.0, FABRIC_SUBMENU_VALUES_SMALL_WIDTH, FABRIC_SUBMENU_SEPERATOR_HEIGHT);
}
// fabric type selection frames
- (CGRect) fabricTypeSelectionTitleFrame
{
    return CGRectMake(FABRIC_SUBMENU_LEFT_TITLES_LEFT_MARGIN, 112.0, FABRIC_SUBMENU_TITLES_BIG_WIDTH, FABRIC_SUBMENU_TITLES_HEIGHT);
}
- (CGRect) fabricTypeSelectionTitleSeperatorFrame
{
    return CGRectMake(FABRIC_SUBMENU_LEFT_TITLES_LEFT_MARGIN, 129.0, FABRIC_SUBMENU_TITLES_BIG_WIDTH, FABRIC_SUBMENU_SEPERATOR_HEIGHT);
}
- (CGRect) fabricTypeSelectionValueFrame
{
    return CGRectMake(FABRIC_SUBMENU_LEFT_TITLES_LEFT_MARGIN, 130.0, FABRIC_SUBMENU_VALUES_BIG_WIDTH, FABRIC_SUBMENU_VALUES_HEIGHT);
}
- (CGRect) fabricTypeSelectionValueSeperatorFrame
{
    return CGRectMake(FABRIC_SUBMENU_LEFT_TITLES_LEFT_MARGIN, 156.0, FABRIC_SUBMENU_VALUES_BIG_WIDTH, FABRIC_SUBMENU_SEPERATOR_HEIGHT);
}
// fabric color selection frames
- (CGRect) fabricColorSelectionTitleFrame
{
    return CGRectMake(FABRIC_SUBMENU_LEFT_TITLES_LEFT_MARGIN, 172.0, FABRIC_SUBMENU_TITLES_BIG_WIDTH, FABRIC_SUBMENU_TITLES_HEIGHT);
}
- (CGRect) fabricColorSelectionTitleSeperatorFrame
{
    return CGRectMake(FABRIC_SUBMENU_LEFT_TITLES_LEFT_MARGIN, 189.0, FABRIC_SUBMENU_TITLES_BIG_WIDTH, FABRIC_SUBMENU_SEPERATOR_HEIGHT);
}
- (CGRect) fabricColorSelectionValueFrame
{
    return CGRectMake(FABRIC_SUBMENU_LEFT_TITLES_LEFT_MARGIN, 190.0, FABRIC_SUBMENU_VALUES_BIG_WIDTH, FABRIC_SUBMENU_VALUES_HEIGHT);
}
- (CGRect) fabricColorSelectionValueSeperatorFrame
{
    return CGRectMake(FABRIC_SUBMENU_LEFT_TITLES_LEFT_MARGIN, 190.0, FABRIC_SUBMENU_VALUES_BIG_WIDTH, FABRIC_SUBMENU_VALUES_HEIGHT);
}

// collar type selection frames
- (CGRect) collarTypeSelectionTitleFrame
{
    return CGRectMake(FABRIC_SUBMENU_LEFT_TITLES_LEFT_MARGIN, 232.0, FABRIC_SUBMENU_TITLES_BIG_WIDTH, FABRIC_SUBMENU_TITLES_HEIGHT);
}
- (CGRect) collarTypeSelectionTitleSeperatorFrame
{
    return CGRectMake(FABRIC_SUBMENU_LEFT_TITLES_LEFT_MARGIN, 249.0, FABRIC_SUBMENU_TITLES_BIG_WIDTH, FABRIC_SUBMENU_SEPERATOR_HEIGHT);
}
- (CGRect) collarTypeSelectionImageFrame
{
    return CGRectMake(FABRIC_SUBMENU_LEFT_TITLES_LEFT_MARGIN, 250.0, FABRIC_SUBMENU_IMAGE_WIDTH, FABRIC_SUBMENU_IMAGE_HEIGHT);
}
- (CGRect) collarTypeSelectionValueFrame
{
    return CGRectMake(FABRIC_SUBMENU_LEFT_TITLES_LEFT_MARGIN+FABRIC_SUBMENU_IMAGE_WIDTH+2.0, 250.0, FABRIC_SUBMENU_VALUES_BIG_WIDTH-FABRIC_SUBMENU_IMAGE_WIDTH-2.0, FABRIC_SUBMENU_VALUES_HEIGHT);
}
- (CGRect) collarTypeSelectionValueSeperatorFrame
{
    return CGRectMake(FABRIC_SUBMENU_LEFT_TITLES_LEFT_MARGIN, 276.0, FABRIC_SUBMENU_VALUES_BIG_WIDTH, FABRIC_SUBMENU_SEPERATOR_HEIGHT);
}

// sleeve type selection frames
- (CGRect) sleeveTypeSelectionTitleFrame
{
    return CGRectMake(FABRIC_SUBMENU_LEFT_TITLES_LEFT_MARGIN, 292.0, FABRIC_SUBMENU_TITLES_BIG_WIDTH, FABRIC_SUBMENU_TITLES_HEIGHT);
}
- (CGRect) sleeveTypeSelectionTitleSeperatorFrame
{
    return CGRectMake(FABRIC_SUBMENU_LEFT_TITLES_LEFT_MARGIN, 309.0, FABRIC_SUBMENU_TITLES_BIG_WIDTH, FABRIC_SUBMENU_SEPERATOR_HEIGHT);
}
- (CGRect) sleeveTypeSelectionImageFrame
{
    return CGRectMake(FABRIC_SUBMENU_LEFT_TITLES_LEFT_MARGIN, 310.0, FABRIC_SUBMENU_IMAGE_WIDTH, FABRIC_SUBMENU_IMAGE_HEIGHT);
}
- (CGRect) sleeveTypeSelectionValueFrame
{
    return CGRectMake(FABRIC_SUBMENU_LEFT_TITLES_LEFT_MARGIN+FABRIC_SUBMENU_IMAGE_WIDTH+2.0, 310.0, FABRIC_SUBMENU_VALUES_BIG_WIDTH-FABRIC_SUBMENU_IMAGE_WIDTH-2.0, FABRIC_SUBMENU_VALUES_HEIGHT);
}
- (CGRect) sleeveTypeSelectionValueSeperatorFrame
{
    return CGRectMake(FABRIC_SUBMENU_LEFT_TITLES_LEFT_MARGIN, 336.0, FABRIC_SUBMENU_VALUES_BIG_WIDTH, FABRIC_SUBMENU_SEPERATOR_HEIGHT);
}

// submenu frame
- (CGRect) fabricSubmenuFrame
{
    return CGRectMake(SCREEN_SIZE.height-FABRIC_SUBMENU_WIDTH-80.0, 113.0, FABRIC_SUBMENU_WIDTH, FABRIC_SUBMENU_HEIGHT);
}
- (CGRect) brushSubmenuFrame
{
    return CGRectMake(SCREEN_SIZE.height-FABRIC_SUBMENU_WIDTH-80.0, 113.0, FABRIC_SUBMENU_WIDTH, FABRIC_SUBMENU_HEIGHT);
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
    return UIInterfaceOrientationMaskLandscape | UIInterfaceOrientationMaskPortrait | UIInterfaceOrientationMaskPortraitUpsideDown;
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
-(void) adjustViewsForOrientation:(UIInterfaceOrientation)orientation duration:(NSTimeInterval)duration {
    if (orientation == UIInterfaceOrientationPortrait || orientation == UIInterfaceOrientationPortraitUpsideDown) {
        [UIView animateWithDuration:duration animations:^{
            backgroundView.frame = CGRectMake(0.0, 0.0, SCREEN_SIZE.width, SCREEN_SIZE.height);
            otherButtonHolder.frame = CGRectMake(0.0, 0.0, 45.0, SCREEN_SIZE.height);
            otherButtonHolderHeight = SCREEN_SIZE.height;
            profileButton.frame = [self profileButtonFrame];
            otherButtonsLine1.frame = [self otherButtonsLine1Frame];
            helpButton.frame = [self helpButtonFrame];
            otherButtonsLine2.frame = [self otherButtonsLine2Frame];
            settingsButton.frame = [self settingsButtonFrame];
        }];
    }
    else if (orientation == UIInterfaceOrientationLandscapeLeft || orientation == UIInterfaceOrientationLandscapeRight) {
        [UIView animateWithDuration:duration animations:^{
            backgroundView.frame = CGRectMake(0.0, 0.0, SCREEN_SIZE.height, SCREEN_SIZE.width);
            otherButtonHolder.frame = CGRectMake(0.0, 0.0, 45.0, SCREEN_SIZE.width);
            otherButtonHolderHeight = SCREEN_SIZE.width;
            profileButton.frame = [self profileButtonFrame];
            otherButtonsLine1.frame = [self otherButtonsLine1Frame];
            helpButton.frame = [self helpButtonFrame];
            otherButtonsLine2.frame = [self otherButtonsLine2Frame];
            settingsButton.frame = [self settingsButtonFrame];
        }];
    }
}

-(void) willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    [self adjustViewsForOrientation:toInterfaceOrientation duration:duration];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    otherButtonHolderHeight = SCREEN_SIZE.width;
    colors = @[[UIColor colorWithRed:57.0/255.0 green:66.0/255.0 blue:100.0/255.0 alpha:1.0],
               [UIColor colorWithRed:17.0/255.0 green:168.0/255.0 blue:171.0/255.0 alpha:1.0],
               [UIColor colorWithRed:230.0/255.0 green:76.0/255.0 blue:101.0/255.0 alpha:1.0],
               [UIColor colorWithRed:252.0/255.0 green:177.0/255.0 blue:80.0/255.0 alpha:1.0],
               [UIColor colorWithRed:185.0/255.0 green:190.0/255.0 blue:60.0/255.0 alpha:1.0],
               [UIColor colorWithRed:123.0/255.0 green:91.0/255.0 blue:162.0/255.0 alpha:1.0],
               [UIColor colorWithRed:111.0/255.0 green:104.0/255.0 blue:119.0/255.0 alpha:1.0]];
    
    colorNames = @[@"KOYU MOR",
                   @"TURKUAZ",
                   @"SOFT PEMBE",
                   @"HARDAL SARI",
                   @"ÇİM YEŞİL",
                   @"MOR",
                   @"FÜME"];
    
    brushWidths = @[[NSNumber numberWithFloat:4.0],
                    [NSNumber numberWithFloat:6.0],
                    [NSNumber numberWithFloat:8.0],
                    [NSNumber numberWithFloat:10.0],
                    [NSNumber numberWithFloat:12.0],
                    [NSNumber numberWithFloat:14.0],
                    [NSNumber numberWithFloat:16.0],
                    [NSNumber numberWithFloat:18.0]];
    
    [self performInitialSetups];
    [self addModelCanvas];
    
    // background views
    halfBackgroundLeftView = [[UIImageView alloc] initWithFrame:[self menuBackgroundLeftFrame]];
    halfBackgroundLeftView.backgroundColor = [UIColor clearColor];
    halfBackgroundLeftView.image = [UIImage imageNamed:@"splash_left.png"];
    [self.view addSubview:halfBackgroundLeftView];
    
    halfBackgroundRightView = [[UIImageView alloc] initWithFrame:[self menuBackgroundRightFrame]];
    halfBackgroundRightView.backgroundColor = [UIColor clearColor];
    halfBackgroundRightView.image = [UIImage imageNamed:@"splash_right.png"];
    [self.view addSubview:halfBackgroundRightView];
    
}
- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [UIView animateWithDuration:0.8 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        CGRect frame = halfBackgroundLeftView.frame;
        frame.origin.x -= frame.size.width;
        halfBackgroundLeftView.frame = frame;
        
        CGRect frame2 = halfBackgroundRightView.frame;
        frame2.origin.x += frame2.size.width;
        halfBackgroundRightView.frame = frame2;
    } completion:^(BOOL finished) {
    }];
}
- (CGRect) menuBackgroundLeftFrame
{
    return CGRectMake(0.0, 0.0, HALF_BACKGROUND_WIDTH, HALF_BACKGROUND_HEIGHT);
}
- (CGRect) menuBackgroundRightFrame
{
    return CGRectMake(HALF_BACKGROUND_WIDTH, 0.0, HALF_BACKGROUND_WIDTH, HALF_BACKGROUND_HEIGHT);
}
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 26.0;
}
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.brushWidthTableView) {
        return brushWidths.count;
    } else {
        return colors.count;
    }
}
- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.brushWidthTableView) {
        PSSubmenuTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:FABRIC_SUBMENU_BRUSH_WIDTH_CELL_IDENTIFIER];
        
        [cell setColorForColorView:modelCanvas.brushColor];
        [cell setWidthForBrushView:[[brushWidths objectAtIndex:indexPath.row] floatValue]];
        
        return cell;
    } else {
        PSSubmenuTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:FABRIC_SUBMENU_COLOR_CELL_IDENTIFIER];
        
        cell.mainLabel.text = [colorNames objectAtIndex:indexPath.row];
        [cell setColorForColorView:[colors objectAtIndex:indexPath.row]];
        
        return cell;
    }
}
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.fabricSubmenuTableView) {
        UIColor* selectedColor = [colors objectAtIndex:indexPath.row];
        
        fabricColorSelectionValueLabel.backgroundColor = selectedColor;
        modelCanvas.fillColor = selectedColor;
        [modelCanvas setNeedsDisplay];
        
        [tableView deselectRowAtIndexPath:indexPath animated:NO];
    } else if (tableView == self.brushSubmenuTableView){
        UIColor* selectedColor = [colors objectAtIndex:indexPath.row];
        
        brushColorSelectionValueLabel.backgroundColor = selectedColor;
        brushWidthSelectionValueLabel.backgroundColor = selectedColor;
        modelCanvas.brushColor = selectedColor;
        [modelCanvas setNeedsDisplay];
    } else {
        CGFloat selectedWidth = [[brushWidths objectAtIndex:indexPath.row] floatValue];
        brushWidthSelectionValueLabel.text = [NSString stringWithFormat:@"  %d point",(int)[[brushWidths objectAtIndex:indexPath.row] floatValue]];
        modelCanvas.brushWidth = selectedWidth;
        [modelCanvas setNeedsDisplay];
    }
}
- (void) addModelCanvas
{
    modelCanvas = [[PSModelCanvas alloc] initWithFrame:CGRectMake(45.0, 0.0, 747.0, 768.0)];
    modelCanvas.strokeColor = [UIColor grayColor];
    modelCanvas.fillColor = [colors objectAtIndex:5];
    modelCanvas.brushColor = [colors objectAtIndex:0];
    modelCanvas.brushWidth = 4.0;
    modelCanvas.brushOpacity = 1.0;
    modelCanvas.isBrushActive = NO;
    modelCanvas.brushType = BRUSH_TYPE_BASIC_COLOR;
    modelCanvas.patternImageName = nil;
    [self.view addSubview:modelCanvas];
    
    UIImageView* shadow = [[UIImageView alloc] initWithFrame:CGRectMake(45.0, 0.0, 747.0, 768.0)];
    shadow.backgroundColor = [UIColor clearColor];
    shadow.image = [UIImage imageNamed:@"golge.png"];
    [self.view addSubview:shadow];
}
- (void) performInitialSetups
{
    backgroundView = [[UIImageView alloc] initWithFrame:[self backgroundFrame]];
    backgroundView.backgroundColor = [UIColor clearColor];
    backgroundView.image = [UIImage imageNamed:@"mainscreen_bg.png"];
    [self.view addSubview:backgroundView];
    
    fabricSubmenuView = [[UIImageView alloc] initWithFrame:[self fabricSubmenuFrame]];
    fabricSubmenuView.backgroundColor = [UIColor clearColor];
    fabricSubmenuView.image = [UIImage imageNamed:@"fabric_submenubg.png"];
    [self.view addSubview:fabricSubmenuView];
    
    brushSubmenuView = [[UIImageView alloc] initWithFrame:[self brushSubmenuFrame]];
    brushSubmenuView.backgroundColor = [UIColor clearColor];
    brushSubmenuView.image = [UIImage imageNamed:@"fabric_submenubg.png"];
    [self.view addSubview:brushSubmenuView];
    
    CGRect brushSubmenuFrame = brushSubmenuView.frame;
    brushSubmenuFrame.origin.x += brushSubmenuFrame.size.width;
    brushSubmenuView.frame = brushSubmenuFrame;
    brushSubmenuView.alpha = 0;
    
    UIImageView* mainMenuView = [[UIImageView alloc] initWithFrame:[self mainMenuFrame]];
    mainMenuView.backgroundColor = [UIColor clearColor];
    mainMenuView.image = [UIImage imageNamed:@"menu_bg.png"];
    mainMenuView.userInteractionEnabled = YES;
    [self.view addSubview:mainMenuView];
    
    logoView = [[UIImageView alloc] initWithFrame:[self logoFrame]];
    logoView.backgroundColor = [UIColor clearColor];
    logoView.image = [UIImage imageNamed:@"mainscreen_logo.png"];
    [self.view addSubview:logoView];
    
    // version label, dummy, will be removed later
    CGRect frame = [self collarTypeSelectionTitleFrame];
    
    UILabel* versionLabel = [[UILabel alloc] initWithFrame:CGRectMake(frame.origin.x, fabricSubmenuView.frame.size.height-30.0, 130.0, 20.0)];
    versionLabel.backgroundColor = [UIColor clearColor];
    versionLabel.font = DESIGN_MENU_SUBMENU_TITLES_FONT;
    versionLabel.textColor = DESIGN_MENU_SUBMENU_TITLES_COLOR;
    versionLabel.text = @"Pişti Version 0.2.1";
    [fabricSubmenuView addSubview:versionLabel];
    
    UILabel* versionLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(frame.origin.x, fabricSubmenuView.frame.size.height-30.0, 130.0, 20.0)];
    versionLabel2.backgroundColor = [UIColor clearColor];
    versionLabel2.font = DESIGN_MENU_SUBMENU_TITLES_FONT;
    versionLabel2.textColor = DESIGN_MENU_SUBMENU_TITLES_COLOR;
    versionLabel2.text = @"Pişti Version 0.2.1";
    [brushSubmenuView addSubview:versionLabel2];
    
    
    // main buttons
    fabricButton = [UIButton buttonWithType:UIButtonTypeCustom];
    fabricButton.backgroundColor = [UIColor clearColor];
    fabricButton.frame = [self fabricButtonFrame];
    [fabricButton setImage:[UIImage imageNamed:@"fabric_btn_normal.png"] forState:UIControlStateNormal];
    [fabricButton setImage:[UIImage imageNamed:@"fabric_btn_highlighted.png"] forState:UIControlStateHighlighted];
    [fabricButton setImage:[UIImage imageNamed:@"fabric_btn_highlighted.png"] forState:UIControlStateSelected];
    fabricButton.selected = YES;
    [fabricButton addTarget:self action:@selector(openFabricMenu) forControlEvents:UIControlEventTouchUpInside];
    [mainMenuView addSubview:fabricButton];
    
    UIButton* textButton = [UIButton buttonWithType:UIButtonTypeCustom];
    textButton.backgroundColor = [UIColor clearColor];
    textButton.frame = [self textButtonFrame];
    [textButton setImage:[UIImage imageNamed:@"text_btn_normal.png"] forState:UIControlStateNormal];
    [textButton setImage:[UIImage imageNamed:@"text_btn_highlighted.png"] forState:UIControlStateHighlighted];
    [mainMenuView addSubview:textButton];
    
    brushButton = [UIButton buttonWithType:UIButtonTypeCustom];
    brushButton.backgroundColor = [UIColor clearColor];
    brushButton.frame = [self brushButtonFrame];
    [brushButton setImage:[UIImage imageNamed:@"brush_btn_normal.png"] forState:UIControlStateNormal];
    [brushButton setImage:[UIImage imageNamed:@"brush_btn_highlighted.png"] forState:UIControlStateHighlighted];
    [brushButton setImage:[UIImage imageNamed:@"brush_btn_highlighted.png"] forState:UIControlStateSelected];
    [brushButton addTarget:self action:@selector(openBrushMenu) forControlEvents:UIControlEventTouchUpInside];
    [mainMenuView addSubview:brushButton];
    
    UIButton* imageButton = [UIButton buttonWithType:UIButtonTypeCustom];
    imageButton.backgroundColor = [UIColor clearColor];
    imageButton.frame = [self imageButtonFrame];
    [imageButton setImage:[UIImage imageNamed:@"image_btn_normal.png"] forState:UIControlStateNormal];
    [imageButton setImage:[UIImage imageNamed:@"image_btn_highlighted.png"] forState:UIControlStateHighlighted];
    [mainMenuView addSubview:imageButton];
    
    UIButton* orderButton = [UIButton buttonWithType:UIButtonTypeCustom];
    orderButton.backgroundColor = [UIColor clearColor];
    orderButton.frame = [self orderButtonFrame];
    [orderButton setImage:[UIImage imageNamed:@"order_btn_normal.png"] forState:UIControlStateNormal];
    [orderButton setImage:[UIImage imageNamed:@"order_btn_highlighted.png"] forState:UIControlStateHighlighted];
    [mainMenuView addSubview:orderButton];
    
    // vision buttons
    UIButton* visionFrontButton = [UIButton buttonWithType:UIButtonTypeCustom];
    visionFrontButton.backgroundColor = [UIColor clearColor];
    visionFrontButton.frame = [self visionFrontButtonFrame];
    [visionFrontButton setImage:[UIImage imageNamed:@"view_front_normal.png"] forState:UIControlStateNormal];
    [visionFrontButton setImage:[UIImage imageNamed:@"view_front_selected.png"] forState:UIControlStateHighlighted];
    [visionFrontButton setImage:[UIImage imageNamed:@"view_front_selected.png"] forState:UIControlStateSelected];
    [mainMenuView addSubview:visionFrontButton];
    visionFrontButton.selected = YES;
    
    UIButton* visionRightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    visionRightButton.backgroundColor = [UIColor clearColor];
    visionRightButton.frame = [self visionRightButtonFrame];
    [visionRightButton setImage:[UIImage imageNamed:@"view_right_normal.png"] forState:UIControlStateNormal];
    [visionRightButton setImage:[UIImage imageNamed:@"view_right_selected.png"] forState:UIControlStateHighlighted];
    [visionRightButton setImage:[UIImage imageNamed:@"view_right_selected.png"] forState:UIControlStateSelected];
    [mainMenuView addSubview:visionRightButton];
    
    UIButton* visionBackButton = [UIButton buttonWithType:UIButtonTypeCustom];
    visionBackButton.backgroundColor = [UIColor clearColor];
    visionBackButton.frame = [self visionBackButtonFrame];
    [visionBackButton setImage:[UIImage imageNamed:@"view_back_normal.png"] forState:UIControlStateNormal];
    [visionBackButton setImage:[UIImage imageNamed:@"view_back_selected.png"] forState:UIControlStateHighlighted];
    [visionBackButton setImage:[UIImage imageNamed:@"view_back_selected.png"] forState:UIControlStateSelected];
    [mainMenuView addSubview:visionBackButton];
    
    UIButton* visionLeftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    visionLeftButton.backgroundColor = [UIColor clearColor];
    visionLeftButton.frame = [self visionLeftButtonFrame];
    [visionLeftButton setImage:[UIImage imageNamed:@"view_left_normal.png"] forState:UIControlStateNormal];
    [visionLeftButton setImage:[UIImage imageNamed:@"view_left_selected.png"] forState:UIControlStateHighlighted];
    [visionLeftButton setImage:[UIImage imageNamed:@"view_left_selected.png"] forState:UIControlStateSelected];
    [mainMenuView addSubview:visionLeftButton];
    
    // other buttons
    
    otherButtonHolder = [[UIView alloc] initWithFrame:[self otherButtonHolderFrame]];
    otherButtonHolder.backgroundColor = [UIColor clearColor];
    [self.view addSubview:otherButtonHolder];
    
    UIButton* backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.backgroundColor = [UIColor clearColor];
    backButton.frame = [self backButtonFrame];
    [backButton setImage:[UIImage imageNamed:@"back_btn_normal.png"] forState:UIControlStateNormal];
    [backButton setImage:[UIImage imageNamed:@"back_btn_highlighted.png"] forState:UIControlStateHighlighted];
    [backButton addTarget:self action:@selector(goBackForNow) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
    
    profileButton = [UIButton buttonWithType:UIButtonTypeCustom];
    profileButton.backgroundColor = [UIColor clearColor];
    profileButton.frame = [self profileButtonFrame];
    [profileButton setImage:[UIImage imageNamed:@"profile_btn_normal.png"] forState:UIControlStateNormal];
    [profileButton setImage:[UIImage imageNamed:@"profile_btn_highlighted.png"] forState:UIControlStateHighlighted];
    [self.view addSubview:profileButton];
    
    otherButtonsLine1 = [[UIImageView alloc] initWithFrame:[self otherButtonsLine1Frame]];
    otherButtonsLine1.backgroundColor = [UIColor clearColor];
    otherButtonsLine1.image = [UIImage imageNamed:@"left_btn_line.png"];
    [self.view addSubview:otherButtonsLine1];
    
    helpButton = [UIButton buttonWithType:UIButtonTypeCustom];
    helpButton.backgroundColor = [UIColor clearColor];
    helpButton.frame = [self helpButtonFrame];
    [helpButton setImage:[UIImage imageNamed:@"help_btn_normal.png"] forState:UIControlStateNormal];
    [helpButton setImage:[UIImage imageNamed:@"help_btn_highlighted.png"] forState:UIControlStateHighlighted];
    [self.view addSubview:helpButton];
    
    otherButtonsLine2 = [[UIImageView alloc] initWithFrame:[self otherButtonsLine2Frame]];
    otherButtonsLine2.backgroundColor = [UIColor clearColor];
    otherButtonsLine2.image = [UIImage imageNamed:@"left_btn_line.png"];
    [self.view addSubview:otherButtonsLine2];
    
    settingsButton = [UIButton buttonWithType:UIButtonTypeCustom];
    settingsButton.backgroundColor = [UIColor clearColor];
    settingsButton.frame = [self settingsButtonFrame];
    [settingsButton setImage:[UIImage imageNamed:@"settings_btn_normal.png"] forState:UIControlStateNormal];
    [settingsButton setImage:[UIImage imageNamed:@"settings_btn_highlighted.png"] forState:UIControlStateHighlighted];
    [self.view addSubview:settingsButton];
    
    // submenu
    
    // size selection
    UILabel* sizeSelectionTitleLabel = [[UILabel alloc] initWithFrame:[self sizeSelectionTitleFrame]];
    sizeSelectionTitleLabel.backgroundColor = [UIColor clearColor];
    sizeSelectionTitleLabel.font = DESIGN_MENU_SUBMENU_TITLES_FONT;
    sizeSelectionTitleLabel.textColor = DESIGN_MENU_SUBMENU_TITLES_COLOR;
    sizeSelectionTitleLabel.text = @"Beden Seçimi";
    [fabricSubmenuView addSubview:sizeSelectionTitleLabel];
    
    UIImageView* sizeSelectionTitleSeperator = [[UIImageView alloc] initWithFrame:[self sizeSelectionTitleSeperatorFrame]];
    sizeSelectionTitleSeperator.backgroundColor = [UIColor clearColor];
    sizeSelectionTitleSeperator.image = [UIImage imageNamed:@"ayrac_koyu.png"];
    [fabricSubmenuView addSubview:sizeSelectionTitleSeperator];
    
    UILabel* sizeSelectionValueLabel = [[UILabel alloc] initWithFrame:[self sizeSelectionValueFrame]];
    sizeSelectionValueLabel.backgroundColor = [UIColor clearColor];
    sizeSelectionValueLabel.font = DESIGN_MENU_SUBMENU_VALUES_FONT;
    sizeSelectionValueLabel.textColor = DESIGN_MENU_SUBMENU_VALUES_COLOR;
    sizeSelectionValueLabel.text = @"XXLARGE";
    [fabricSubmenuView addSubview:sizeSelectionValueLabel];
    
    UIImageView* sizeSelectionValueSeperator = [[UIImageView alloc] initWithFrame:[self sizeSelectionValueSeperatorFrame]];
    sizeSelectionValueSeperator.backgroundColor = [UIColor clearColor];
    sizeSelectionValueSeperator.image = [UIImage imageNamed:@"ayrac_acik.png"];
    [fabricSubmenuView addSubview:sizeSelectionValueSeperator];
    
    // shape selection
    UILabel* shapeSelectionTitleLabel = [[UILabel alloc] initWithFrame:[self shapeSelectionTitleFrame]];
    shapeSelectionTitleLabel.backgroundColor = [UIColor clearColor];
    shapeSelectionTitleLabel.font = DESIGN_MENU_SUBMENU_TITLES_FONT;
    shapeSelectionTitleLabel.textColor = DESIGN_MENU_SUBMENU_TITLES_COLOR;
    shapeSelectionTitleLabel.text = @"Kalıp Seçimi";
    [fabricSubmenuView addSubview:shapeSelectionTitleLabel];
    
    UIImageView* shapeSelectionTitleSeperator = [[UIImageView alloc] initWithFrame:[self shapeSelectionTitleSeperatorFrame]];
    shapeSelectionTitleSeperator.backgroundColor = [UIColor clearColor];
    shapeSelectionTitleSeperator.image = [UIImage imageNamed:@"ayrac_koyu.png"];
    [fabricSubmenuView addSubview:shapeSelectionTitleSeperator];
    
    UILabel* shapeSelectionValueLabel = [[UILabel alloc] initWithFrame:[self shapeSelectionValueFrame]];
    shapeSelectionValueLabel.backgroundColor = [UIColor clearColor];
    shapeSelectionValueLabel.font = DESIGN_MENU_SUBMENU_VALUES_FONT;
    shapeSelectionValueLabel.textColor = DESIGN_MENU_SUBMENU_VALUES_COLOR;
    shapeSelectionValueLabel.text = @"NORMAL";
    [fabricSubmenuView addSubview:shapeSelectionValueLabel];
    
    UIImageView* shapeSelectionValueSeperator = [[UIImageView alloc] initWithFrame:[self shapeSelectionValueSeperatorFrame]];
    shapeSelectionValueSeperator.backgroundColor = [UIColor clearColor];
    shapeSelectionValueSeperator.image = [UIImage imageNamed:@"ayrac_acik.png"];
    [fabricSubmenuView addSubview:shapeSelectionValueSeperator];
    
    // fabric type selection
    UILabel* fabricTypeSelectionTitleLabel = [[UILabel alloc] initWithFrame:[self fabricTypeSelectionTitleFrame]];
    fabricTypeSelectionTitleLabel.backgroundColor = [UIColor clearColor];
    fabricTypeSelectionTitleLabel.font = DESIGN_MENU_SUBMENU_TITLES_FONT;
    fabricTypeSelectionTitleLabel.textColor = DESIGN_MENU_SUBMENU_TITLES_COLOR;
    fabricTypeSelectionTitleLabel.text = @"Kumaş Cinsi";
    [fabricSubmenuView addSubview:fabricTypeSelectionTitleLabel];
    
    UIImageView* fabricTypeSelectionTitleSeperator = [[UIImageView alloc] initWithFrame:[self fabricTypeSelectionTitleSeperatorFrame]];
    fabricTypeSelectionTitleSeperator.backgroundColor = [UIColor clearColor];
    fabricTypeSelectionTitleSeperator.image = [UIImage imageNamed:@"ayrac_koyu.png"];
    [fabricSubmenuView addSubview:fabricTypeSelectionTitleSeperator];
    
    UILabel* fabricTypeSelectionValueLabel = [[UILabel alloc] initWithFrame:[self fabricTypeSelectionValueFrame]];
    fabricTypeSelectionValueLabel.backgroundColor = [UIColor clearColor];
    fabricTypeSelectionValueLabel.font = DESIGN_MENU_SUBMENU_VALUES_FONT;
    fabricTypeSelectionValueLabel.textColor = DESIGN_MENU_SUBMENU_VALUES_COLOR;
    fabricTypeSelectionValueLabel.text = @"MERSERİZE";
    [fabricSubmenuView addSubview:fabricTypeSelectionValueLabel];
    
    UIImageView* fabricTypeSelectionValueSeperator = [[UIImageView alloc] initWithFrame:[self fabricTypeSelectionValueSeperatorFrame]];
    fabricTypeSelectionValueSeperator.backgroundColor = [UIColor clearColor];
    fabricTypeSelectionValueSeperator.image = [UIImage imageNamed:@"ayrac_acik.png"];
    [fabricSubmenuView addSubview:fabricTypeSelectionValueSeperator];
    
    // fabric color selection
    UILabel* fabricColorSelectionTitleLabel = [[UILabel alloc] initWithFrame:[self fabricColorSelectionTitleFrame]];
    fabricColorSelectionTitleLabel.backgroundColor = [UIColor clearColor];
    fabricColorSelectionTitleLabel.font = DESIGN_MENU_SUBMENU_TITLES_FONT;
    fabricColorSelectionTitleLabel.textColor = DESIGN_MENU_SUBMENU_TITLES_COLOR;
    fabricColorSelectionTitleLabel.text = @"Kumaş Renk Seçimi";
    [fabricSubmenuView addSubview:fabricColorSelectionTitleLabel];
    
    UIImageView* fabricColorSelectionTitleSeperator = [[UIImageView alloc] initWithFrame:[self fabricColorSelectionTitleSeperatorFrame]];
    fabricColorSelectionTitleSeperator.backgroundColor = [UIColor clearColor];
    fabricColorSelectionTitleSeperator.image = [UIImage imageNamed:@"ayrac_koyu.png"];
    [fabricSubmenuView addSubview:fabricColorSelectionTitleSeperator];
    
    fabricColorSelectionValueLabel = [[UILabel alloc] initWithFrame:[self fabricColorSelectionValueFrame]];
    fabricColorSelectionValueLabel.backgroundColor = [colors objectAtIndex:5];
    fabricColorSelectionValueLabel.font = DESIGN_MENU_SUBMENU_VALUES_FONT;
    fabricColorSelectionValueLabel.textColor = DESIGN_MENU_SUBMENU_VALUES_COLOR;
    [fabricSubmenuView addSubview:fabricColorSelectionValueLabel];
    
    fabricSubmenuView.userInteractionEnabled = YES;
    fabricColorSelectionValueLabel.userInteractionEnabled = YES;
    colorTableOpeningGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(openColorMenu)];
    colorTableOpeningGesture.delegate = self;
    [fabricColorSelectionValueLabel addGestureRecognizer:colorTableOpeningGesture];
    
    UIImageView* fabricColorSelectionValueSeperator = [[UIImageView alloc] initWithFrame:[self fabricColorSelectionValueSeperatorFrame]];
    fabricColorSelectionValueSeperator.backgroundColor = [UIColor clearColor];
    fabricColorSelectionValueSeperator.image = [UIImage imageNamed:@"renk_maske.png"];
    [fabricSubmenuView addSubview:fabricColorSelectionValueSeperator];
    
    UIImageView* fabricColorSelectionValueSeperator2 = [[UIImageView alloc] initWithFrame:[self fabricColorSelectionValueSeperatorFrame]];
    fabricColorSelectionValueSeperator2.backgroundColor = [UIColor clearColor];
    fabricColorSelectionValueSeperator2.image = [UIImage imageNamed:@"renk_maske.png"];
    
    CGRect aFrame4 = [self fabricColorSelectionValueSeperatorFrame];
    UIImageView* fabricColorSelectionValueSeperator3 = [[UIImageView alloc] initWithFrame:CGRectMake(aFrame4.origin.x, aFrame4.origin.y-100.0, aFrame4.size.width, aFrame4.size.height)];
    fabricColorSelectionValueSeperator3.backgroundColor = [UIColor clearColor];
    fabricColorSelectionValueSeperator3.image = [UIImage imageNamed:@"renk_maske.png"];
    
    
#pragma mark - Brush related, will be deleted later
    
    UILabel* brushColorSelectionTitleLabel = [[UILabel alloc] initWithFrame:[self fabricColorSelectionTitleFrame]];
    brushColorSelectionTitleLabel.backgroundColor = [UIColor clearColor];
    brushColorSelectionTitleLabel.font = DESIGN_MENU_SUBMENU_TITLES_FONT;
    brushColorSelectionTitleLabel.textColor = DESIGN_MENU_SUBMENU_TITLES_COLOR;
    brushColorSelectionTitleLabel.text = @"Brush Renk Seçimi";
    [brushSubmenuView addSubview:brushColorSelectionTitleLabel];
    
    UIImageView* brushColorSelectionTitleSeperator = [[UIImageView alloc] initWithFrame:[self fabricColorSelectionTitleSeperatorFrame]];
    brushColorSelectionTitleSeperator.backgroundColor = [UIColor clearColor];
    brushColorSelectionTitleSeperator.image = [UIImage imageNamed:@"ayrac_koyu.png"];
    [brushSubmenuView addSubview:brushColorSelectionTitleSeperator];
    
    brushColorSelectionValueLabel = [[UILabel alloc] initWithFrame:[self fabricColorSelectionValueFrame]];
    brushColorSelectionValueLabel.backgroundColor = [colors objectAtIndex:0];
    brushColorSelectionValueLabel.font = DESIGN_MENU_SUBMENU_VALUES_FONT;
    brushColorSelectionValueLabel.textColor = DESIGN_MENU_SUBMENU_VALUES_COLOR;
    [brushSubmenuView addSubview:brushColorSelectionValueLabel];
    
    CGRect aFrame = [self fabricColorSelectionTitleFrame];
    
    UILabel* brushWidthSelectionTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(aFrame.origin.x, aFrame.origin.y-100.0, aFrame.size.width, aFrame.size.height)];
    brushWidthSelectionTitleLabel.backgroundColor = [UIColor clearColor];
    brushWidthSelectionTitleLabel.font = DESIGN_MENU_SUBMENU_TITLES_FONT;
    brushWidthSelectionTitleLabel.textColor = DESIGN_MENU_SUBMENU_TITLES_COLOR;
    brushWidthSelectionTitleLabel.text = @"Brush Kalinlik Seçimi";
    [brushSubmenuView addSubview:brushWidthSelectionTitleLabel];
    
    CGRect aFrame2 = [self fabricColorSelectionTitleSeperatorFrame];
    UIImageView* brushWidthSelectionTitleSeperator = [[UIImageView alloc] initWithFrame:CGRectMake(aFrame2.origin.x, aFrame2.origin.y-100.0, aFrame2.size.width, aFrame2.size.height)];
    brushWidthSelectionTitleSeperator.backgroundColor = [UIColor clearColor];
    brushWidthSelectionTitleSeperator.image = [UIImage imageNamed:@"ayrac_koyu.png"];
    [brushSubmenuView addSubview:brushWidthSelectionTitleSeperator];
    
    CGRect aFrame3 = [self fabricColorSelectionValueFrame];
    brushWidthSelectionValueLabel = [[UILabel alloc] initWithFrame:CGRectMake(aFrame3.origin.x, aFrame3.origin.y-100.0, aFrame3.size.width, aFrame3.size.height)];
    brushWidthSelectionValueLabel.backgroundColor = [colors objectAtIndex:0];
    brushWidthSelectionValueLabel.font = DESIGN_MENU_SUBMENU_VALUES_FONT;
    brushWidthSelectionValueLabel.textColor = DESIGN_MENU_SUBMENU_VALUES_COLOR;
    brushWidthSelectionValueLabel.text = [NSString stringWithFormat:@"  %d point",(int)[[brushWidths objectAtIndex:0] floatValue]];
    [brushSubmenuView addSubview:brushWidthSelectionValueLabel];
    
    brushSubmenuView.userInteractionEnabled = NO;
    brushColorSelectionValueLabel.userInteractionEnabled = NO;
    brushColorTableOpeningGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(openBrushColorMenu)];
    brushColorTableOpeningGesture.delegate = self;
    [brushColorSelectionValueLabel addGestureRecognizer:brushColorTableOpeningGesture];
    
    brushWidthSelectionValueLabel.userInteractionEnabled = NO;
    brushWidthTableOpeningGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(openBrushWidthMenu)];
    brushWidthTableOpeningGesture.delegate = self;
    [brushWidthSelectionValueLabel addGestureRecognizer:brushWidthTableOpeningGesture];
    
    [brushSubmenuView addSubview:fabricColorSelectionValueSeperator2];
    [brushSubmenuView addSubview:fabricColorSelectionValueSeperator3];
    
    CGRect aFrame5 = [self fabricColorSelectionTitleFrame];
    
    UILabel* brushOpacitySelectionTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(aFrame5.origin.x, aFrame5.origin.y+100.0, aFrame5.size.width, aFrame5.size.height)];
    brushOpacitySelectionTitleLabel.backgroundColor = [UIColor clearColor];
    brushOpacitySelectionTitleLabel.font = DESIGN_MENU_SUBMENU_TITLES_FONT;
    brushOpacitySelectionTitleLabel.textColor = DESIGN_MENU_SUBMENU_TITLES_COLOR;
    brushOpacitySelectionTitleLabel.text = @"Brush Opacity Seçimi";
    [brushSubmenuView addSubview:brushOpacitySelectionTitleLabel];
    
    CGRect aFrame6 = [self fabricColorSelectionTitleSeperatorFrame];
    UIImageView* brushOpacitySelectionTitleSeperator = [[UIImageView alloc] initWithFrame:CGRectMake(aFrame6.origin.x, aFrame6.origin.y+100.0, aFrame6.size.width, aFrame6.size.height)];
    brushOpacitySelectionTitleSeperator.backgroundColor = [UIColor clearColor];
    brushOpacitySelectionTitleSeperator.image = [UIImage imageNamed:@"ayrac_koyu.png"];
    [brushSubmenuView addSubview:brushOpacitySelectionTitleSeperator];
    
    CGRect aFrame7 = [self fabricColorSelectionValueFrame];
    UISlider* slider = [[UISlider alloc] initWithFrame:CGRectMake(aFrame7.origin.x, aFrame7.origin.y+120.0, aFrame7.size.width, aFrame7.size.height)];
    [slider addTarget:self action:@selector(sliderChanged:) forControlEvents:UIControlEventValueChanged];
    slider.minimumValue = 0.0;
    slider.maximumValue = 100.0;
    slider.value = 100.0;
    slider.continuous = YES;
    [brushSubmenuView addSubview:slider];
    
    CGRect aFrame8 = [self fabricColorSelectionValueFrame];
    UIButton* deleteLastOneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    deleteLastOneButton.backgroundColor = [UIColor clearColor];
    deleteLastOneButton.frame = CGRectMake(aFrame8.origin.x, aFrame8.origin.y+180.0, aFrame8.size.width, aFrame8.size.height);
    [deleteLastOneButton setTitle:@"Delete Last One" forState:UIControlStateNormal];
    [deleteLastOneButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [deleteLastOneButton setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
    [deleteLastOneButton addTarget:self action:@selector(deleteLastBrush) forControlEvents:UIControlEventTouchUpInside];
    [brushSubmenuView addSubview:deleteLastOneButton];
    
    UIButton* deleteAllButton = [UIButton buttonWithType:UIButtonTypeCustom];
    deleteAllButton.backgroundColor = [UIColor clearColor];
    deleteAllButton.frame = CGRectMake(aFrame8.origin.x, aFrame8.origin.y+220.0, aFrame8.size.width, aFrame8.size.height);
    [deleteAllButton setTitle:@"Delete All" forState:UIControlStateNormal];
    [deleteAllButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [deleteAllButton setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
    [deleteAllButton addTarget:self action:@selector(deleteAllBrushes) forControlEvents:UIControlEventTouchUpInside];
    [brushSubmenuView addSubview:deleteAllButton];
    
    basicBrushButton = [UIButton buttonWithType:UIButtonTypeCustom];
    basicBrushButton.backgroundColor = [UIColor clearColor];
    basicBrushButton.frame = CGRectMake(aFrame8.origin.x, aFrame8.origin.y+270.0, aFrame8.size.width, aFrame8.size.height);
    [basicBrushButton setTitle:@"Basic Type" forState:UIControlStateNormal];
    [basicBrushButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [basicBrushButton setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
    [basicBrushButton setTitleColor:[UIColor blueColor] forState:UIControlStateSelected];
    [basicBrushButton addTarget:self action:@selector(basicBrushTypeClicked) forControlEvents:UIControlEventTouchUpInside];
    [brushSubmenuView addSubview:basicBrushButton];
    basicBrushButton.selected = YES;
    
    pattern1BrushButton = [UIButton buttonWithType:UIButtonTypeCustom];
    pattern1BrushButton.backgroundColor = [UIColor clearColor];
    pattern1BrushButton.frame = CGRectMake(aFrame8.origin.x, aFrame8.origin.y+320.0, aFrame8.size.width, aFrame8.size.height);
    [pattern1BrushButton setTitle:@"Pattern1" forState:UIControlStateNormal];
    [pattern1BrushButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [pattern1BrushButton setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
    [pattern1BrushButton setTitleColor:[UIColor blueColor] forState:UIControlStateSelected];
    [pattern1BrushButton addTarget:self action:@selector(pattern1BrushTypeClicked) forControlEvents:UIControlEventTouchUpInside];
    [brushSubmenuView addSubview:pattern1BrushButton];
    
    pattern2BrushButton = [UIButton buttonWithType:UIButtonTypeCustom];
    pattern2BrushButton.backgroundColor = [UIColor clearColor];
    pattern2BrushButton.frame = CGRectMake(aFrame8.origin.x, aFrame8.origin.y+370.0, aFrame8.size.width, aFrame8.size.height);
    [pattern2BrushButton setTitle:@"Pattern2" forState:UIControlStateNormal];
    [pattern2BrushButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [pattern2BrushButton setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
    [pattern2BrushButton setTitleColor:[UIColor blueColor] forState:UIControlStateSelected];
    [pattern2BrushButton addTarget:self action:@selector(pattern2BrushTypeClicked) forControlEvents:UIControlEventTouchUpInside];
    [brushSubmenuView addSubview:pattern2BrushButton];
    
#pragma mark - dummy end
    
    // collar type selection
    UILabel* collarTypeSelectionTitleLabel = [[UILabel alloc] initWithFrame:[self collarTypeSelectionTitleFrame]];
    collarTypeSelectionTitleLabel.backgroundColor = [UIColor clearColor];
    collarTypeSelectionTitleLabel.font = DESIGN_MENU_SUBMENU_TITLES_FONT;
    collarTypeSelectionTitleLabel.textColor = DESIGN_MENU_SUBMENU_TITLES_COLOR;
    collarTypeSelectionTitleLabel.text = @"Yaka Tipi Seçimi";
    [fabricSubmenuView addSubview:collarTypeSelectionTitleLabel];
    
    UIImageView* collarTypeSelectionTitleSeperator = [[UIImageView alloc] initWithFrame:[self collarTypeSelectionTitleSeperatorFrame]];
    collarTypeSelectionTitleSeperator.backgroundColor = [UIColor clearColor];
    collarTypeSelectionTitleSeperator.image = [UIImage imageNamed:@"ayrac_koyu.png"];
    [fabricSubmenuView addSubview:collarTypeSelectionTitleSeperator];
    
    UIImageView* collarTypeSelectionImage = [[UIImageView alloc] initWithFrame:[self collarTypeSelectionImageFrame]];
    collarTypeSelectionImage.backgroundColor = [UIColor clearColor];
    collarTypeSelectionImage.image = [UIImage imageNamed:@"yaka_deneme.png"];
    [fabricSubmenuView addSubview:collarTypeSelectionImage];
    
    UILabel* collarTypeSelectionValueLabel = [[UILabel alloc] initWithFrame:[self collarTypeSelectionValueFrame]];
    collarTypeSelectionValueLabel.backgroundColor = [UIColor clearColor];
    collarTypeSelectionValueLabel.font = DESIGN_MENU_SUBMENU_VALUES_FONT;
    collarTypeSelectionValueLabel.textColor = DESIGN_MENU_SUBMENU_VALUES_COLOR;
    collarTypeSelectionValueLabel.text = @"KIRLANGIÇ";
    [fabricSubmenuView addSubview:collarTypeSelectionValueLabel];
    
    UIImageView* collarTypeSelectionValueSeperator = [[UIImageView alloc] initWithFrame:[self collarTypeSelectionValueSeperatorFrame]];
    collarTypeSelectionValueSeperator.backgroundColor = [UIColor clearColor];
    collarTypeSelectionValueSeperator.image = [UIImage imageNamed:@"ayrac_acik.png"];
    [fabricSubmenuView addSubview:collarTypeSelectionValueSeperator];
    
    // sleeve type selection
    UILabel* sleeveTypeSelectionTitleLabel = [[UILabel alloc] initWithFrame:[self sleeveTypeSelectionTitleFrame]];
    sleeveTypeSelectionTitleLabel.backgroundColor = [UIColor clearColor];
    sleeveTypeSelectionTitleLabel.font = DESIGN_MENU_SUBMENU_TITLES_FONT;
    sleeveTypeSelectionTitleLabel.textColor = DESIGN_MENU_SUBMENU_TITLES_COLOR;
    sleeveTypeSelectionTitleLabel.text = @"Kol Tipi Seçimi";
    [fabricSubmenuView addSubview:sleeveTypeSelectionTitleLabel];
    
    UIImageView* sleeveTypeSelectionTitleSeperator = [[UIImageView alloc] initWithFrame:[self sleeveTypeSelectionTitleSeperatorFrame]];
    sleeveTypeSelectionTitleSeperator.backgroundColor = [UIColor clearColor];
    sleeveTypeSelectionTitleSeperator.image = [UIImage imageNamed:@"ayrac_koyu.png"];
    [fabricSubmenuView addSubview:sleeveTypeSelectionTitleSeperator];
    
    UIImageView* sleeveTypeSelectionImage = [[UIImageView alloc] initWithFrame:[self sleeveTypeSelectionImageFrame]];
    sleeveTypeSelectionImage.backgroundColor = [UIColor clearColor];
    sleeveTypeSelectionImage.image = [UIImage imageNamed:@"yaka_kol.png"];
    [fabricSubmenuView addSubview:sleeveTypeSelectionImage];
    
    UILabel* sleeveTypeSelectionValueLabel = [[UILabel alloc] initWithFrame:[self sleeveTypeSelectionValueFrame]];
    sleeveTypeSelectionValueLabel.backgroundColor = [UIColor clearColor];
    sleeveTypeSelectionValueLabel.font = DESIGN_MENU_SUBMENU_VALUES_FONT;
    sleeveTypeSelectionValueLabel.textColor = DESIGN_MENU_SUBMENU_VALUES_COLOR;
    sleeveTypeSelectionValueLabel.text = @"BÜZGÜLÜ";
    [fabricSubmenuView addSubview:sleeveTypeSelectionValueLabel];
    
    UIImageView* sleeveTypeSelectionValueSeperator = [[UIImageView alloc] initWithFrame:[self sleeveTypeSelectionValueSeperatorFrame]];
    sleeveTypeSelectionValueSeperator.backgroundColor = [UIColor clearColor];
    sleeveTypeSelectionValueSeperator.image = [UIImage imageNamed:@"ayrac_acik.png"];
    [fabricSubmenuView addSubview:sleeveTypeSelectionValueSeperator];
    
}
- (void) basicBrushTypeClicked
{
    basicBrushButton.selected = YES;
    pattern1BrushButton.selected = NO;
    pattern2BrushButton.selected = NO;
    modelCanvas.brushType = BRUSH_TYPE_BASIC_COLOR;
}
- (void) pattern1BrushTypeClicked
{
    basicBrushButton.selected = NO;
    pattern1BrushButton.selected = YES;
    pattern2BrushButton.selected = NO;
    modelCanvas.brushType = BRUSH_TYPE_PATTERN_COLOR;
    modelCanvas.patternImageName = @"pattern1_erkek.png";
}
- (void) pattern2BrushTypeClicked
{
    basicBrushButton.selected = NO;
    pattern1BrushButton.selected = NO;
    pattern2BrushButton.selected = YES;
    modelCanvas.brushType = BRUSH_TYPE_PATTERN_COLOR;
    modelCanvas.patternImageName = @"pattern2_erkek.png";
}
- (void) deleteLastBrush
{
    [modelCanvas deleteLastOne];
}
- (void) deleteAllBrushes
{
    [modelCanvas deleteAll];
}
- (void) sliderChanged:(UISlider*)slider
{
    CGFloat sliderValue = slider.value;
    modelCanvas.brushOpacity = sliderValue/100.0;
}
- (void) openFabricMenu
{
    if (fabricButton.selected) {
        return;
    } else {
        modelCanvas.isBrushActive = NO;
        fabricButton.selected = YES;
        brushButton.selected = NO;
        
        brushSubmenuView.userInteractionEnabled = NO;
        
        brushColorSelectionValueLabel.userInteractionEnabled = NO;
        [brushColorSelectionValueLabel removeGestureRecognizer:brushColorTableOpeningGesture];
        brushColorTableOpeningGesture = nil;
        
        brushWidthSelectionValueLabel.userInteractionEnabled = NO;
        [brushWidthSelectionValueLabel removeGestureRecognizer:brushWidthTableOpeningGesture];
        brushWidthTableOpeningGesture = nil;
        
        [UIView animateWithDuration:0.5 animations:^{
            CGRect brushSubmenuFrame = brushSubmenuView.frame;
            brushSubmenuFrame.origin.x += brushSubmenuFrame.size.width;
            brushSubmenuView.frame = brushSubmenuFrame;
        } completion:^(BOOL finished) {
            brushSubmenuView.alpha = 0.0;
            fabricSubmenuView.alpha = 1.0;
            
            [UIView animateWithDuration:0.5 animations:^{
                CGRect fabricSubmenuFrame = fabricSubmenuView.frame;
                fabricSubmenuFrame.origin.x -= fabricSubmenuFrame.size.width;
                fabricSubmenuView.frame = fabricSubmenuFrame;
            } completion:^(BOOL finished) {
                fabricSubmenuView.userInteractionEnabled = YES;
                
                fabricColorSelectionValueLabel.userInteractionEnabled = YES;
                colorTableOpeningGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(openColorMenu)];
                colorTableOpeningGesture.delegate = self;
                [fabricColorSelectionValueLabel addGestureRecognizer:colorTableOpeningGesture];
            }];
        }];
    }
}
- (void) openBrushMenu
{
    if (brushButton.selected) {
        return;
    } else {
        modelCanvas.isBrushActive = YES;
        brushButton.selected = YES;
        fabricButton.selected = NO;
        
        fabricSubmenuView.userInteractionEnabled = NO;
        fabricColorSelectionValueLabel.userInteractionEnabled = NO;
        [fabricColorSelectionValueLabel removeGestureRecognizer:colorTableOpeningGesture];
        colorTableOpeningGesture = nil;
        
        [UIView animateWithDuration:0.5 animations:^{
            CGRect fabricSubmenuFrame = fabricSubmenuView.frame;
            fabricSubmenuFrame.origin.x += fabricSubmenuFrame.size.width;
            fabricSubmenuView.frame = fabricSubmenuFrame;
        } completion:^(BOOL finished) {
            fabricSubmenuView.alpha = 0.0;
            brushSubmenuView.alpha = 1.0;
            
            [UIView animateWithDuration:0.5 animations:^{
                CGRect brushSubmenuFrame = brushSubmenuView.frame;
                brushSubmenuFrame.origin.x -= brushSubmenuFrame.size.width;
                brushSubmenuView.frame = brushSubmenuFrame;
            } completion:^(BOOL finished) {
                brushSubmenuView.userInteractionEnabled = YES;
                
                brushColorSelectionValueLabel.userInteractionEnabled = YES;
                brushColorTableOpeningGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(openBrushColorMenu)];
                brushColorTableOpeningGesture.delegate = self;
                [brushColorSelectionValueLabel addGestureRecognizer:brushColorTableOpeningGesture];
                
                brushWidthSelectionValueLabel.userInteractionEnabled = YES;
                brushWidthTableOpeningGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(openBrushWidthMenu)];
                brushWidthTableOpeningGesture.delegate = self;
                [brushWidthSelectionValueLabel addGestureRecognizer:brushWidthTableOpeningGesture];
            }];
        }];
    }
}
-(BOOL) gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if (gestureRecognizer == colorTableOpeningGesture) {
        return YES;
    } else if (gestureRecognizer == colorTableClosingGesture){
        CGPoint point = [touch locationInView:self.view];
        CGPoint locationInView = [self.fabricSubmenuTableView convertPoint:point fromView:self.view];
        if (CGRectContainsPoint(self.fabricSubmenuTableView.bounds, locationInView)) {
            return NO;
        } else {
            return YES;
        }
    } else if (gestureRecognizer == brushColorTableOpeningGesture) {
        return YES;
    } else if (gestureRecognizer == brushColorTableClosingGesture) {
        CGPoint point = [touch locationInView:self.view];
        CGPoint locationInView = [self.brushSubmenuTableView convertPoint:point fromView:self.view];
        if (CGRectContainsPoint(self.brushSubmenuTableView.bounds, locationInView)) {
            return NO;
        } else {
            return YES;
        }
    } else if (gestureRecognizer == brushWidthTableOpeningGesture) {
        return YES;
    } else if (gestureRecognizer == brushWidthTableClosingGesture) {
        CGPoint point = [touch locationInView:self.view];
        CGPoint locationInView = [self.brushWidthTableView convertPoint:point fromView:self.view];
        if (CGRectContainsPoint(self.brushWidthTableView.bounds, locationInView)) {
            return NO;
        } else {
            return YES;
        }
    } else {
        return YES;
    }
}
- (void) openColorMenu
{
    NSLog(@"openColorMenu");
    [fabricColorSelectionValueLabel removeGestureRecognizer:colorTableOpeningGesture];
    colorTableOpeningGesture = nil;
    
    colorTableClosingGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeColorMenu)];
    colorTableClosingGesture.delegate = self;
    [self.view addGestureRecognizer:colorTableClosingGesture];
    
    CGRect frame = [self fabricColorSelectionValueFrame];
    
    self.fabricSubmenuTableView = [[UITableView alloc] initWithFrame:CGRectMake(frame.origin.x-10.0, frame.origin.y+frame.size.height, frame.size.width+20.0, 149.0)];
    self.fabricSubmenuTableView.backgroundColor = [UIColor colorWithRed:4.0/255.0 green:61.0/255.0 blue:93.0/255.0 alpha:1.0];
    self.fabricSubmenuTableView.layer.cornerRadius = 3.0;
    self.fabricSubmenuTableView.layer.shouldRasterize = YES;
    self.fabricSubmenuTableView.layer.rasterizationScale = SCREEN_SCALE;
    self.fabricSubmenuTableView.clipsToBounds = YES;
    [fabricSubmenuView addSubview:self.fabricSubmenuTableView];
    
    UIView* headerView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.fabricSubmenuTableView.frame.size.width, 10.0)];
    headerView.backgroundColor = [UIColor colorWithRed:4.0/255.0 green:61.0/255.0 blue:93.0/255.0 alpha:1.0];
    [self.fabricSubmenuTableView setTableHeaderView:headerView];
    
    UIView* footerView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.fabricSubmenuTableView.frame.size.width, 10.0)];
    footerView.backgroundColor = [UIColor colorWithRed:4.0/255.0 green:61.0/255.0 blue:93.0/255.0 alpha:1.0];
    [self.fabricSubmenuTableView setTableFooterView:footerView];
    
    self.fabricSubmenuTableView.dataSource = self;
    self.fabricSubmenuTableView.delegate = self;
    
    [self.fabricSubmenuTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.fabricSubmenuTableView registerClass:[PSSubmenuTableViewCell class] forCellReuseIdentifier:FABRIC_SUBMENU_COLOR_CELL_IDENTIFIER];
    
    [self.fabricSubmenuTableView reloadData];
}
- (void) openBrushColorMenu
{
    [brushColorSelectionValueLabel removeGestureRecognizer:brushColorTableOpeningGesture];
    brushColorTableOpeningGesture = nil;
    
    brushColorTableClosingGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeBrushColorMenu)];
    brushColorTableClosingGesture.delegate = self;
    [self.view addGestureRecognizer:brushColorTableClosingGesture];
    
    CGRect frame = [self fabricColorSelectionValueFrame];
    
    self.brushSubmenuTableView = [[UITableView alloc] initWithFrame:CGRectMake(frame.origin.x-10.0, frame.origin.y+frame.size.height, frame.size.width+20.0, 149.0)];
    self.brushSubmenuTableView.backgroundColor = [UIColor colorWithRed:4.0/255.0 green:61.0/255.0 blue:93.0/255.0 alpha:1.0];
    self.brushSubmenuTableView.layer.cornerRadius = 3.0;
    self.brushSubmenuTableView.layer.shouldRasterize = YES;
    self.brushSubmenuTableView.layer.rasterizationScale = SCREEN_SCALE;
    self.brushSubmenuTableView.clipsToBounds = YES;
    [brushSubmenuView addSubview:self.brushSubmenuTableView];
    
    UIView* headerView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.fabricSubmenuTableView.frame.size.width, 10.0)];
    headerView.backgroundColor = [UIColor colorWithRed:4.0/255.0 green:61.0/255.0 blue:93.0/255.0 alpha:1.0];
    [self.brushSubmenuTableView setTableHeaderView:headerView];
    
    UIView* footerView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.fabricSubmenuTableView.frame.size.width, 10.0)];
    footerView.backgroundColor = [UIColor colorWithRed:4.0/255.0 green:61.0/255.0 blue:93.0/255.0 alpha:1.0];
    [self.brushSubmenuTableView setTableFooterView:footerView];
    
    self.brushSubmenuTableView.dataSource = self;
    self.brushSubmenuTableView.delegate = self;
    
    [self.brushSubmenuTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.brushSubmenuTableView registerClass:[PSSubmenuTableViewCell class] forCellReuseIdentifier:FABRIC_SUBMENU_COLOR_CELL_IDENTIFIER];
    
    [self.brushSubmenuTableView reloadData];
}
- (void) openBrushWidthMenu
{
    [brushWidthSelectionValueLabel removeGestureRecognizer:brushWidthTableOpeningGesture];
    brushWidthTableOpeningGesture = nil;
    
    brushWidthTableClosingGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeBrushWidthMenu)];
    brushWidthTableClosingGesture.delegate = self;
    [self.view addGestureRecognizer:brushWidthTableClosingGesture];
    
    CGRect frame = [self fabricColorSelectionValueFrame];
    
    self.brushWidthTableView = [[UITableView alloc] initWithFrame:CGRectMake(frame.origin.x-10.0, frame.origin.y+frame.size.height-100.0, frame.size.width+20.0, 149.0)];
    self.brushWidthTableView.backgroundColor = [UIColor colorWithRed:4.0/255.0 green:61.0/255.0 blue:93.0/255.0 alpha:1.0];
    self.brushWidthTableView.layer.cornerRadius = 3.0;
    self.brushWidthTableView.layer.shouldRasterize = YES;
    self.brushWidthTableView.layer.rasterizationScale = SCREEN_SCALE;
    self.brushWidthTableView.clipsToBounds = YES;
    [brushSubmenuView addSubview:self.brushWidthTableView];
    
    UIView* headerView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.fabricSubmenuTableView.frame.size.width, 10.0)];
    headerView.backgroundColor = [UIColor colorWithRed:4.0/255.0 green:61.0/255.0 blue:93.0/255.0 alpha:1.0];
    [self.brushWidthTableView setTableHeaderView:headerView];
    
    UIView* footerView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.fabricSubmenuTableView.frame.size.width, 10.0)];
    footerView.backgroundColor = [UIColor colorWithRed:4.0/255.0 green:61.0/255.0 blue:93.0/255.0 alpha:1.0];
    [self.brushWidthTableView setTableFooterView:footerView];
    
    self.brushWidthTableView.dataSource = self;
    self.brushWidthTableView.delegate = self;
    
    [self.brushWidthTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.brushWidthTableView registerClass:[PSSubmenuTableViewCell class] forCellReuseIdentifier:FABRIC_SUBMENU_BRUSH_WIDTH_CELL_IDENTIFIER];
    
    [self.brushWidthTableView reloadData];
}
- (void) closeColorMenu
{
    [self.fabricSubmenuTableView removeFromSuperview];
    self.fabricSubmenuTableView = nil;
    
    [self.view removeGestureRecognizer:colorTableClosingGesture];
    colorTableClosingGesture = nil;

    colorTableOpeningGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(openColorMenu)];
    colorTableOpeningGesture.delegate = self;
    [fabricColorSelectionValueLabel addGestureRecognizer:colorTableOpeningGesture];
}
- (void) closeBrushColorMenu
{
    [self.brushSubmenuTableView removeFromSuperview];
    self.brushSubmenuTableView = nil;
    
    [self.view removeGestureRecognizer:brushColorTableClosingGesture];
    brushColorTableClosingGesture = nil;
    
    brushColorTableOpeningGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(openBrushColorMenu)];
    brushColorTableOpeningGesture.delegate = self;
    [brushColorSelectionValueLabel addGestureRecognizer:brushColorTableOpeningGesture];
}
- (void) closeBrushWidthMenu
{
    [self.brushWidthTableView removeFromSuperview];
    self.brushWidthTableView = nil;
    
    [self.view removeGestureRecognizer:brushWidthTableClosingGesture];
    brushWidthTableClosingGesture = nil;
    
    brushWidthTableOpeningGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(openBrushWidthMenu)];
    brushWidthTableOpeningGesture.delegate = self;
    [brushWidthSelectionValueLabel addGestureRecognizer:brushWidthTableOpeningGesture];
}
- (void) goBackForNow
{
    [UIView animateWithDuration:0.8 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        CGRect frame = halfBackgroundLeftView.frame;
        frame.origin.x += frame.size.width;
        halfBackgroundLeftView.frame = frame;
        
        CGRect frame2 = halfBackgroundRightView.frame;
        frame2.origin.x -= frame2.size.width;
        halfBackgroundRightView.frame = frame2;
    } completion:^(BOOL finished) {
        [self dismissViewControllerAnimated:NO completion:nil];
        //        [halfBackgroundLeftView removeFromSuperview];
        //        halfBackgroundLeftView = nil;
        //        [halfBackgroundRightView removeFromSuperview];
        //        halfBackgroundRightView = nil;
    }];
//    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
