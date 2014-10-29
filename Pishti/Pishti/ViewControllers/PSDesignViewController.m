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
    UIImageView* imageSubmenuView;
    UIImageView* textSubmenuView;
    
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
    
    UILabel* labelFontSelectionValueLabel;
    UITapGestureRecognizer* labelFontTableOpeningGesture;
    UITapGestureRecognizer* labelFontTableClosingGesture;
    
    UILabel* labelColorSelectionValueLabel;
    UITapGestureRecognizer* labelColorTableOpeningGesture;
    UITapGestureRecognizer* labelColorTableClosingGesture;
    
    NSArray* colors;
    NSArray* colorNames;
    NSArray* brushWidths;
    NSArray* labelFontNames;
    
    UIButton* isLabelBoldButton;
    UIButton* isLabelItalicButton;
    UIButton* isLabelHorizontalButton;
    UIButton* alignmentButton;
    
    BOOL isLabelBold;
    BOOL isLabelItalic;
    BOOL isLabelHorizontal;
    float labelOpacity;
    float imageOpacity;
    
    float currentZIndex;
    
    NSInteger labelAlignment;
//    NSMutableArray* allLabels;
    NSInteger labelIndex;
    
    NSString* selectedFontName;
    UIColor* selectedLabelColor;
    
    UISlider* brushOpacitySlider;
    UISlider* labelOpacitySlider;
    UISlider* imageOpacitySlider;
    
    UIImagePickerController* imagePickerController;
    
    NSInteger imageIndex;
//    NSMutableArray* allImages;
    
    UIImageView* halfBackgroundLeftView;
    UIImageView* halfBackgroundRightView;
    
    PSModelCanvas* modelCanvas;
    
    UIButton* fabricButton;
    UIButton* textButton;
    UIButton* brushButton;
    UIButton* imageButton;
    
    UIButton* basicBrushButton;
    UIButton* pattern1BrushButton;
    UIButton* pattern2BrushButton;
    
    UIView* selectedItem;
    UIView* currentEditView;
    UIView* currentDeleteView;
    UIView* currentMoveView;
    UIView* currentRotateView;
    UIView* currentSelectionView;
    
    NSDate* lastTapDate;
    
    BOOL shouldHandleTouch;
    
    BOOL isMoving;
    BOOL isRotating;
    BOOL isScaling;
    
    CGPoint scaleStartingPoint;
    CGPoint moveStartingPoint;
    CGPoint rotateStartingPoint;
    CGPoint rotateCenterPoint;
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
- (CGRect) imageSubmenuFrame
{
    return CGRectMake(SCREEN_SIZE.height-FABRIC_SUBMENU_WIDTH-80.0, 113.0, FABRIC_SUBMENU_WIDTH, FABRIC_SUBMENU_HEIGHT);
}
- (CGRect) textSubmenuFrame
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
    
    labelFontNames = @[@"Helvetica",
                       @"Arial"];
    
//    allLabels = @[].mutableCopy;
    labelIndex = 0;
    
//    allImages = @[].mutableCopy;
    imageIndex = 0;
    
    selectedFontName = [labelFontNames objectAtIndex:0];
    selectedLabelColor = [colors objectAtIndex:0];
    
    isLabelBold = NO;
    isLabelItalic = NO;
    isLabelHorizontal = YES;
    labelAlignment = 0;
    labelOpacity = 1.0;
    imageOpacity = 1.0;
    
    currentZIndex = 0.0;
    
    shouldHandleTouch = YES;
    
    isMoving = NO;
    isRotating = NO;
    
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
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
}
- (void)keyboardWillShow:(NSNotification *)notif
{
    ((PSTextView*)selectedItem).selectable = YES;
    ((PSTextView*)selectedItem).editable = YES;
}
- (void)keyboardWillHide:(NSNotification *)notif
{
    ((PSTextView*)selectedItem).selectable = NO;
    ((PSTextView*)selectedItem).editable = NO;
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
    } else if (tableView == self.labelFontTableView){
        return labelFontNames.count;
    } else {
        return colors.count;
    }
}
- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.brushWidthTableView) {
        PSSubmenuTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:FABRIC_SUBMENU_BRUSH_WIDTH_CELL_IDENTIFIER];
        
//        [cell setColorForColorView:modelCanvas.brushColor];
        [cell setWidthForBrushView:[[brushWidths objectAtIndex:indexPath.row] floatValue]];
        
        return cell;
    } else if (tableView == self.labelFontTableView) {
        PSSubmenuTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:FABRIC_SUBMENU_LABEL_FONT_CELL_IDENTIFIER];
        
        UIFont* font;
        if (indexPath.row == 0) {
            font = [UIFont fontWithName:@"Helvetica" size:20.0];
        } else {
            font = [UIFont fontWithName:@"ArialMT" size:20.0];
        }
        
        cell.mainLabel.font = font;
        cell.mainLabel.text = [labelFontNames objectAtIndex:indexPath.row];
        
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
//        modelCanvas.brushColor = selectedColor;
        [modelCanvas setNeedsDisplay];
    } else if (tableView == self.labelFontTableView) {
        
        selectedFontName = [labelFontNames objectAtIndex:indexPath.row];
        labelFontSelectionValueLabel.text = selectedFontName;
        
        if (selectedItem && [selectedItem isKindOfClass:[UITextView class]]) {
            ((PSTextView*)selectedItem).fontName = selectedFontName;
            UIFont* oldFont = ((PSTextView*)selectedItem).font;
            UIFont* newFont = [UIFont fontWithName:[self convertFontName] size:oldFont.pointSize];
            
            CGPoint oldCenter = ((PSTextView*)selectedItem).center;
            
            CGSize labelSize = [[Util sharedInstance] text:((PSTextView*)selectedItem).text
                                              sizeWithFont:newFont
                                         constrainedToSize:CGSizeMake(1000.0, 1000.0)];
            labelSize = CGSizeMake(labelSize.width+2.0, labelSize.height+2.0);
            
            CGRect frame = modelCanvas.frame;
            CGRect newFrame = CGRectMake((frame.size.width-labelSize.width)*0.5,
                                         (frame.size.height-labelSize.height)*0.5,
                                         labelSize.width,
                                         labelSize.height);
            
            ((PSTextView*)selectedItem).frame = newFrame;
            ((PSTextView*)selectedItem).center = oldCenter;
            ((PSTextView*)selectedItem).font = newFont;
            [self rearrangeSelectionRelatedViewsFrame];
        }
        
    } else if (tableView == self.labelColorTableView) {
        UIColor* selectedColor = [colors objectAtIndex:indexPath.row];
        
        selectedLabelColor = selectedColor;
        labelColorSelectionValueLabel.backgroundColor = selectedColor;
        if (selectedItem && [selectedItem isKindOfClass:[UITextView class]]) {
            ((PSTextView*)selectedItem).color = selectedLabelColor;
            ((PSTextView*)selectedItem).textColor = selectedLabelColor;
        }
        
    } else if (tableView == self.brushWidthTableView) {
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
//    modelCanvas.brushColor = [colors objectAtIndex:0];
//    modelCanvas.brushWidth = 4.0;
//    modelCanvas.brushOpacity = 1.0;
//    modelCanvas.isBrushActive = NO;
//    modelCanvas.brushType = BRUSH_TYPE_BASIC_COLOR;
//    modelCanvas.patternImageName = nil;
    [self.view addSubview:modelCanvas];
    
    UIImageView* shadow = [[UIImageView alloc] initWithFrame:CGRectMake(45.0, 0.0, 747.0, 768.0)];
    shadow.backgroundColor = [UIColor clearColor];
    shadow.image = [UIImage imageNamed:@"golge.png"];
    shadow.layer.zPosition = currentZIndex;
    currentZIndex += 1.0;
    [self.view addSubview:shadow];
}
- (void) boldnessChanged
{
    isLabelBold = !isLabelBold;
    
    [self makeBoldness:isLabelBold];
    
    if (selectedItem && [selectedItem isKindOfClass:[UITextView class]]) {
        UIFont* oldFont = ((PSTextView*)selectedItem).font;
        UIFont* newFont = [UIFont fontWithName:[self convertFontName] size:oldFont.pointSize];
        
        CGPoint oldCenter = ((PSTextView*)selectedItem).center;
        
        ((PSTextView*)selectedItem).font = newFont;
        CGSize labelSize = [[Util sharedInstance] text:((PSTextView*)selectedItem).text
                                          sizeWithFont:newFont
                                     constrainedToSize:CGSizeMake(1000.0, 1000.0)];
        labelSize = CGSizeMake(labelSize.width+2.0, labelSize.height+2.0);
        
        CGRect frame = modelCanvas.frame;
        CGRect newFrame = CGRectMake((frame.size.width-labelSize.width)*0.5,
                                     (frame.size.height-labelSize.height)*0.5,
                                     labelSize.width,
                                     labelSize.height);
        
        ((PSTextView*)selectedItem).frame = newFrame;
        ((PSTextView*)selectedItem).center = oldCenter;
        ((PSTextView*)selectedItem).isBold = isLabelBold;
        [self rearrangeSelectionRelatedViewsFrame];
    }
}
- (void) makeBoldness:(BOOL)boldness
{
    if (boldness) {
        [isLabelBoldButton setTitle:@"Bold Label" forState:UIControlStateNormal];
    } else {
        [isLabelBoldButton setTitle:@"Not Bold" forState:UIControlStateNormal];
    }
}
- (void) italicnessChanged
{
    isLabelItalic = !isLabelItalic;
    
    [self makeItalicness:isLabelItalic];
    
    if (selectedItem && [selectedItem isKindOfClass:[UITextView class]]) {
        UIFont* oldFont = ((PSTextView*)selectedItem).font;
        UIFont* newFont = [UIFont fontWithName:[self convertFontName] size:oldFont.pointSize];
        
        CGPoint oldCenter = ((PSTextView*)selectedItem).center;
        
        ((PSTextView*)selectedItem).font = newFont;
        CGSize labelSize = [[Util sharedInstance] text:((PSTextView*)selectedItem).text
                                          sizeWithFont:newFont
                                     constrainedToSize:CGSizeMake(1000.0, 1000.0)];
        labelSize = CGSizeMake(labelSize.width+2.0, labelSize.height+2.0);
        
        CGRect frame = modelCanvas.frame;
        CGRect newFrame = CGRectMake((frame.size.width-labelSize.width)*0.5,
                                     (frame.size.height-labelSize.height)*0.5,
                                     labelSize.width,
                                     labelSize.height);
        
        ((PSTextView*)selectedItem).frame = newFrame;
        ((PSTextView*)selectedItem).center = oldCenter;
        ((PSTextView*)selectedItem).isItalic = isLabelItalic;
        [self rearrangeSelectionRelatedViewsFrame];
    }
}
- (void) makeItalicness:(BOOL)italicness
{
    if (italicness) {
        [isLabelItalicButton setTitle:@"Italic Label" forState:UIControlStateNormal];
    } else {
        [isLabelItalicButton setTitle:@"Not Italic" forState:UIControlStateNormal];
    }
}
- (void) alignmentChanged
{
    labelAlignment = (labelAlignment+1)%3;
    
    [self makeAlignment:labelAlignment];
    
    if (selectedItem && [selectedItem isKindOfClass:[UITextView class]]) {
        if (((PSTextView*)selectedItem).isHorizontal) {
            ((PSTextView*)selectedItem).textAlignment = [self convertAlignment:labelAlignment];
            [self rearrangeSelectionRelatedViewsFrame];
        }
        ((PSTextView*)selectedItem).alignment = labelAlignment;
    }
    
}
- (void) makeAlignment:(NSInteger)alignment
{
    if (alignment == 0) {
        [alignmentButton setTitle:@"Left Align" forState:UIControlStateNormal];
    } else if (alignment == 1) {
        [alignmentButton setTitle:@"Right Align" forState:UIControlStateNormal];
    } else if (alignment == 2) {
        [alignmentButton setTitle:@"Center Align" forState:UIControlStateNormal];
    }
}
- (void) horizontalnessChanged
{
    isLabelHorizontal = !isLabelHorizontal;
    
    [self makeHorizontalness:isLabelHorizontal];
    
    if (selectedItem && [selectedItem isKindOfClass:[UITextView class]]) {
        
        NSString* baseText = ((PSTextView*)selectedItem).baseText;
        NSString* newString = [self prepareString:baseText.mutableCopy];
        
        CGPoint oldCenter = ((PSTextView*)selectedItem).center;
        
        CGSize labelSize = [[Util sharedInstance] text:newString
                                          sizeWithFont:((PSTextView*)selectedItem).font
                                     constrainedToSize:CGSizeMake(1000.0, 1000.0)];
        labelSize = CGSizeMake(labelSize.width+2.0, labelSize.height+2.0);
        
        CGRect frame = modelCanvas.frame;
        CGRect newFrame = CGRectMake((frame.size.width-labelSize.width)*0.5,
                                     (frame.size.height-labelSize.height)*0.5,
                                     labelSize.width,
                                     labelSize.height);
        
        ((PSTextView*)selectedItem).frame = newFrame;
        ((PSTextView*)selectedItem).center = oldCenter;
        ((PSTextView*)selectedItem).text = newString;
        ((PSTextView*)selectedItem).isHorizontal = isLabelHorizontal;
        if (isLabelHorizontal) {
            ((PSTextView*)selectedItem).tag = HORIZONTAL_TEXTVIEW_TAG;
        } else {
            ((PSTextView*)selectedItem).tag = VERTICAL_TEXTVIEW_TAG;
        }
        
        if (!isLabelHorizontal) {
            ((PSTextView*)selectedItem).textAlignment = NSTextAlignmentCenter;
            labelAlignment = 2;
            ((PSTextView*)selectedItem).alignment = labelAlignment;
        }
        
        [self rearrangeSelectionRelatedViewsFrame];
        
    }
}
- (void) makeHorizontalness:(BOOL)horizontalness
{
    if (horizontalness) {
        [isLabelHorizontalButton setTitle:@"Horizontal" forState:UIControlStateNormal];
    } else {
        [isLabelHorizontalButton setTitle:@"Vertical" forState:UIControlStateNormal];
    }
}
- (void) deleteLastLabel
{
    if (labelIndex > 0) {
        [self deleteALabel:labelIndex-1];
    }
}
- (void) deleteALabel:(NSInteger)deletedLabelIndex
{
    if (deletedLabelIndex < modelCanvas.allLabels.count) {
        if ([modelCanvas.allLabels objectAtIndex:deletedLabelIndex] == selectedItem) {
            [self removeSelectionRelatedItems];
        }
        [[modelCanvas.allLabels objectAtIndex:deletedLabelIndex] removeFromSuperview];
        [modelCanvas.allLabels removeObjectAtIndex:deletedLabelIndex];
        labelIndex--;
    }
}
- (void) deleteAllLabels
{
    if (labelIndex > 0) {
        for (UITextView* textView in modelCanvas.allLabels) {
            [textView removeFromSuperview];
            if (textView == selectedItem) {
                [self removeSelectionRelatedItems];
            }
        }
        modelCanvas.allLabels = @[].mutableCopy;
        labelIndex = 0;
    }
    
}
- (NSTextAlignment) convertAlignment:(NSInteger)alignment
{
    NSTextAlignment textAlignment;
    if (alignment == 0) {
        textAlignment = NSTextAlignmentLeft;
    } else if (alignment == 1) {
        textAlignment = NSTextAlignmentRight;
    } else if (alignment == 2) {
        textAlignment = NSTextAlignmentCenter;
    }
    
    return textAlignment;
}
- (NSString*) convertFontName
{
    NSString* baseFontName = selectedFontName;
    NSString* fontName = baseFontName;
    
    if (isLabelBold || isLabelItalic) {
        fontName = [NSString stringWithFormat:@"%@-",fontName];
    }
    
    if (isLabelBold) {
        fontName = [NSString stringWithFormat:@"%@Bold",fontName];
    }
    if (isLabelItalic) {
        if ([baseFontName isEqualToString:@"Helvetica"]) {
            fontName = [NSString stringWithFormat:@"%@Oblique",fontName];
        } else {
            fontName = [NSString stringWithFormat:@"%@Italic",fontName];
        }
    }
    
    if ([baseFontName isEqualToString:@"Arial"]) {
        fontName = [NSString stringWithFormat:@"%@MT",fontName];
    }
    
    return fontName;
}
- (NSMutableString*) prepareString:(NSMutableString*)string
{
    NSMutableString* newString = [NSMutableString new];
    if (!isLabelHorizontal) {
        labelAlignment = 2;
        [self makeAlignment:labelAlignment];
        for (int i = 0; i < string.length; i++) {
            [newString appendString:[string substringWithRange:NSMakeRange(i, 1)]];
            if (i != string.length-1) {
                if (![[string substringWithRange:NSMakeRange(i, 1)] isEqualToString:@"\n"]) {
                    [newString appendString:@"\n"];
                }
            }
        }
    } else {
        newString = [string mutableCopy];
    }
    
    return newString;
}
- (NSMutableString*) generateBaseString:(NSMutableString*)string
{
    NSMutableString* newString = [NSMutableString new];
    if (!isLabelHorizontal) {
        for (int i = 0; i < string.length; i += 2) {
            if (i != string.length-1) {
                [newString replaceCharactersInRange:NSMakeRange(i, 1) withString:@""];
            }
        }
    } else {
        newString = [string mutableCopy];
    }
    
    return newString;
}
- (void) addNewLabel
{
    NSString* fontName = [self convertFontName];
    
    NSString* shortVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    NSString* text = [NSString stringWithFormat:@"Pişti Version %@",shortVersion];
    
    UIFont* font = [UIFont fontWithName:fontName size:20.0];
    
    NSMutableString* newString = [self prepareString:text.mutableCopy];
    
    NSTextAlignment textAlignment = [self convertAlignment:labelAlignment];
    
    CGSize labelSize = [[Util sharedInstance] text:newString sizeWithFont:font constrainedToSize:CGSizeMake(1000.0, 1000.0)];
    labelSize = CGSizeMake(labelSize.width+2.0, labelSize.height+2.0);
    CGRect frame = modelCanvas.frame;
    
    PSTextView* newLabel = [[PSTextView alloc] initWithFrame:CGRectMake((frame.size.width-labelSize.width)*0.5,
                                                                        (frame.size.height-labelSize.height)*0.5,
                                                                        labelSize.width,
                                                                        labelSize.height)];
    newLabel.baseText = text;
    newLabel.isBold = isLabelBold;
    newLabel.isItalic = isLabelItalic;
    newLabel.isHorizontal = isLabelHorizontal;
    newLabel.fontName = selectedFontName;
    newLabel.color = selectedLabelColor;
    newLabel.opacity = labelOpacity;
    newLabel.alignment = textAlignment;
    
    newLabel.font = font;
    newLabel.text = newString;
    newLabel.textColor = selectedLabelColor;
    newLabel.tintColor = selectedLabelColor;
    newLabel.textAlignment = textAlignment;
    newLabel.alpha = labelOpacity;
    newLabel.delegate = self;
    newLabel.layer.zPosition = currentZIndex;
    currentZIndex += 1.0;
    [modelCanvas addSubview:newLabel];
    
    if (isLabelHorizontal) {
        newLabel.tag = HORIZONTAL_TEXTVIEW_TAG;
    } else {
        newLabel.tag = VERTICAL_TEXTVIEW_TAG;
    }
    
    [modelCanvas.allLabels addObject:newLabel];
    labelIndex++;
    
//    selectedItem = newLabel;
//    [self addSelectionRelatedViewToItem:selectedItem];
    
}
- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    if (shouldHandleTouch) {
        
        if (modelCanvas.isBrushActive) {
            return;
        } else {
            
            if (selectedItem) {
                UITouch* touch = [touches anyObject];
                CGPoint p = [touch locationInView:currentEditView];
                
                CGPoint p2 = [touch locationInView:currentDeleteView];
                
                CGPoint p3 = [touch locationInView:currentMoveView];
                
                CGPoint p4 = [touch locationInView:currentRotateView];
                
                if (CGRectContainsPoint(currentEditView.bounds, p)) {
                    // edit view tapped
                    ((UITextView*)selectedItem).editable = YES;
                    ((UITextView*)selectedItem).selectable = YES;
                    [((UITextView*)selectedItem) becomeFirstResponder];
                    
                    return;
                } else if (CGRectContainsPoint(currentDeleteView.bounds, p2)) {
//                    if ([selectedItem isKindOfClass:[UITextView class]]) {
//                        PSTextView* textView = (PSTextView*)selectedItem;
//                        [self deleteALabel:[modelCanvas.allLabels indexOfObject:textView]];
//                    } else if ([selectedItem isKindOfClass:[UIImageView class]]) {
//                        PSImageView* imageView = (PSImageView*)selectedItem;
//                        [self deleteAnImage:[modelCanvas.allImages indexOfObject:imageView]];
//                    }
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
            
            for (UITextView* textView in modelCanvas.allLabels) {
                
                UITouch* touch = [touches anyObject];
                CGPoint p = [touch locationInView:textView];
                
                if (CGRectContainsPoint(textView.bounds, p)) {
                    if (newlySelectedItem) {
                        if (textView.layer.zPosition > newlySelectedItem.layer.zPosition) {
                            newlySelectedItem = textView;
                        }
                    } else {
                        newlySelectedItem = textView;
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
                    if ([newlySelectedItem isKindOfClass:[UITextView class]]) {
                        NSDate* date = [NSDate date];
                        if (lastTapDate != nil) {
                            NSTimeInterval interval = [date timeIntervalSinceDate:lastTapDate];
                            if (interval < 0.3) {
                                // go to edit mode
                                ((UITextView*)selectedItem).editable = YES;
                                ((UITextView*)selectedItem).selectable = YES;
                                [((UITextView*)selectedItem) becomeFirstResponder];
                            } else {
                                lastTapDate = date;
                            }
                        } else {
                            lastTapDate = [NSDate date];
                        }
                    }
                } else {
                    [self removeSelectionRelatedItems];
                    [self addSelectionRelatedViewToItem:newlySelectedItem];
                    
                }
                
            } else {
                if (selectedItem) {
                    [self removeSelectionRelatedItems];
                }
            }
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
        
        CGFloat sx = 1+(scaleVector.x/selectedItem.frame.size.width);
        CGFloat sy = 1+(-scaleVector.y/selectedItem.frame.size.height);
        
        CGAffineTransform transform = selectedItem.transform;
        transform = CGAffineTransformScale(transform, sx, sy);
        selectedItem.transform = transform;
        selectedItem.center = center;
        scaleStartingPoint = currentPoint;
        
        [self rearrangeSelectionRelatedViewsFrame];
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
        
        CGFloat sx = 1+(scaleVector.x/selectedItem.frame.size.width);
        CGFloat sy = 1+(-scaleVector.y/selectedItem.frame.size.height);
        
        CGAffineTransform transform = selectedItem.transform;
        transform = CGAffineTransformScale(transform, sx, sy);
        selectedItem.transform = transform;
        selectedItem.center = center;
        scaleStartingPoint = currentPoint;
        
        [self rearrangeSelectionRelatedViewsFrame];
        
        isScaling = NO;
    }
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
//    
//    CGFloat p12 = [self getLengthFromStartingPoint:startingPoint toEndPoint:centerPoint];
//    CGFloat p23 = [self getLengthFromStartingPoint:centerPoint toEndPoint:endPoint];
//    CGFloat p13 = [self getLengthFromStartingPoint:endPoint toEndPoint:startingPoint];
//    
//    CGFloat p12Square = powf(p12, 2);
//    CGFloat p23Square = powf(p23, 2);
//    CGFloat p13Square = powf(p13, 2);
//    
//    CGFloat product = 2*p12*p23;
//    
//    CGFloat cosineOfTheAngle = (p12Square + p23Square - p13Square) / product;
//    
//    CGFloat radians = acosf(cosineOfTheAngle);
    
//    NSLog(@"p12 = %f",p12);
//    NSLog(@"p23 = %f",p23);
//    NSLog(@"p13 = %f",p13);
//    NSLog(@"p12Square = %f",p12Square);
//    NSLog(@"p23Square = %f",p23Square);
//    NSLog(@"p13Square = %f", p13Square);
//    NSLog(@"product = %f",product);
//    NSLog(@"cosine of the angle = %f", cosineOfTheAngle);
//    NSLog(@"angle = %f", radians);
//    
//    if (radians == NAN) {
//        radians = 0.0;
//    }
//    
//    if (endPoint.x < startingPoint.x) {
//        return radians;
//    } else {
//        return -radians;
//    }
}
- (CGFloat) getLengthFromStartingPoint:(CGPoint)startingPoint toEndPoint:(CGPoint)endPoint
{
    CGFloat x1 = startingPoint.x;
    CGFloat y1 = startingPoint.y;
    CGFloat x2 = endPoint.x;
    CGFloat y2 = endPoint.y;
    
    return sqrtf(powf(x1-x2, 2) + powf(y1-y2, 2));
}
- (void) touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self touchesEnded:touches withEvent:event];
}
- (void) removeSelectionRelatedItems
{
    if (selectedItem.isFirstResponder) {
//        [selectedItem resignFirstResponder];
//        ((UITextView*)selectedItem).editable = NO;
//        ((UITextView*)selectedItem).selectable = NO;
    }
    
    if ([selectedItem isKindOfClass:[UITextView class]]) {
        if (((UITextView*)selectedItem).text == nil ||
            ((UITextView*)selectedItem).text.length == 0) {
            [selectedItem removeFromSuperview];
            [modelCanvas.allLabels removeObject:selectedItem];
            labelIndex--;
        }
    }
    
    [currentEditView removeFromSuperview];
    currentEditView = nil;
    
    [currentDeleteView removeFromSuperview];
    currentDeleteView = nil;
    
    selectedItem = nil;
    
    [currentSelectionView removeFromSuperview];
    currentSelectionView = nil;
    
    [currentMoveView removeFromSuperview];
    currentMoveView = nil;
    
    [currentRotateView removeFromSuperview];
    currentRotateView = nil;
    
    modelCanvas.selectedTextView = nil;
    
}
- (void) rearrangeSelectionRelatedViewsFrame
{
    CGRect frame = selectedItem.frame;
    frame.origin.x -= 4.0;
    frame.origin.y -= 4.0;
    frame.size.width += 8.0;
    frame.size.height += 8.0;
    
    currentSelectionView.frame = frame;
    
    currentEditView.frame = CGRectMake(frame.origin.x-40.0,
                                       frame.origin.y-40.0,
                                       40.0,
                                       40.0);
    
    currentDeleteView.frame = CGRectMake(frame.origin.x+frame.size.width,
                                         frame.origin.y-40.0,
                                         40.0,
                                         40.0);
    
    currentMoveView.frame = CGRectMake(frame.origin.x-40.0,
                                       frame.origin.y+frame.size.height,
                                       40.0,
                                       40.0);
    
    currentRotateView.frame = CGRectMake(frame.origin.x+frame.size.width,
                                         frame.origin.y+frame.size.height,
                                         40.0,
                                         40.0);
}
- (void) addSelectionRelatedViewToItem:(UIView*)item
{
    if ([item isKindOfClass:[UITextView class]]) {
        lastTapDate = [NSDate date];
    }
    selectedItem = item;
    
    CGRect frame = item.frame;
    frame.origin.x -= 4.0;
    frame.origin.y -= 4.0;
    frame.size.width += 8.0;
    frame.size.height += 8.0;
    
//    currentSelectionView = [[UIView alloc] initWithFrame:frame];
//    currentSelectionView.backgroundColor = [UIColor clearColor];
//    currentSelectionView.layer.borderColor = [UIColor greenColor].CGColor;
//    currentSelectionView.layer.borderWidth = 2.0;
//    currentSelectionView.tag = SELECTION_VIEW_TAG;
//    currentSelectionView.layer.zPosition = currentZIndex;
//    [modelCanvas addSubview:currentSelectionView];
    
    currentDeleteView = [[UIView alloc] initWithFrame:CGRectMake(frame.origin.x+frame.size.width,
                                                                 frame.origin.y-40.0,
                                                                 40.0,
                                                                 40.0)];
    
    currentDeleteView.backgroundColor = [UIColor clearColor];
    UIImageView* imageView2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tool_delete_normal.png"]];
    [currentDeleteView addSubview:imageView2];
    currentDeleteView.tag = DELETE_VIEW_TAG2;
    currentDeleteView.layer.zPosition = currentZIndex;
    [modelCanvas addSubview:currentDeleteView];
    
    currentMoveView = [[UIView alloc] initWithFrame:CGRectMake(frame.origin.x-40.0,
                                                               frame.origin.y+frame.size.height,
                                                               40.0,
                                                               40.0)];
    
    currentMoveView.backgroundColor = [UIColor clearColor];
    UIImageView* imageView3 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tool_move_normal.png"]];
    [currentMoveView addSubview:imageView3];
    currentMoveView.tag = MOVE_VIEW_TAG2;
    currentMoveView.layer.zPosition = currentZIndex;
    [modelCanvas addSubview:currentMoveView];
    
    currentRotateView = [[UIView alloc] initWithFrame:CGRectMake(frame.origin.x+frame.size.width,
                                                                 frame.origin.y+frame.size.height,
                                                                 40.0,
                                                                 40.0)];
    
    currentRotateView.backgroundColor = [UIColor clearColor];
    UIImageView* imageView4 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tool_rotate_normal.png"]];
    [currentRotateView addSubview:imageView4];
    currentRotateView.tag = ROTATE_VIEW_TAG2;
    currentRotateView.layer.zPosition = currentZIndex;
    [modelCanvas addSubview:currentRotateView];
    
    if ([item isKindOfClass:[UITextView class]]) {
        currentEditView = [[UIView alloc] initWithFrame:CGRectMake(frame.origin.x-40.0,
                                                                    frame.origin.y-40.0,
                                                                    40.0,
                                                                    40.0)];
        currentEditView.backgroundColor = [UIColor clearColor];
        UIImageView* imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tool_edit_normal.png"]];
        [currentEditView addSubview:imageView];
        currentEditView.tag = EDIT_VIEW_TAG2;
        currentEditView.layer.zPosition = currentZIndex;
        [modelCanvas addSubview:currentEditView];
        
    }
    
    currentZIndex += 1.0;
    
    if ([selectedItem isKindOfClass:[UITextView class]]) {

        PSTextView* textView = (PSTextView*)selectedItem;
        
        modelCanvas.selectedTextView = textView;
        
        isLabelBold = textView.isBold;
        isLabelItalic = textView.isItalic;
        isLabelHorizontal = textView.isHorizontal;
        labelAlignment = textView.alignment;
        
        [self makeBoldness:textView.isBold];
        [self makeItalicness:textView.isItalic];
        [self makeHorizontalness:textView.isHorizontal];
        [self makeAlignment:textView.alignment];
        
        [labelFontSelectionValueLabel setText:textView.fontName];
        selectedFontName = textView.fontName;
        
        [labelColorSelectionValueLabel setBackgroundColor:textView.color];
        selectedLabelColor = textView.color;
            
        labelOpacitySlider.value = textView.opacity*100;
        labelOpacity = textView.opacity;
    } else if ([selectedItem isKindOfClass:[UIImageView class]]) {
        PSImageView* imageView = (PSImageView*)selectedItem;
        
//        imageOpacitySlider.value = imageView.opacity*100;
//        imageOpacity = imageView.opacity;
    }
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    PSTextView* selectedTextView = (PSTextView*)selectedItem;
    
    NSString* baseText = selectedTextView.baseText;
    
    NSInteger difference = textView.text.length-baseText.length;
    
    NSRange newRange = NSMakeRange(range.location-difference, range.length);
    
    NSString* newBaseText = [baseText stringByReplacingCharactersInRange:newRange withString:text];
    
    selectedTextView.baseText = newBaseText;
    
    NSString* newText = [self prepareString:newBaseText.mutableCopy];
    
    textView.text = newText;
    
    CGPoint oldCenter = textView.center;
    
    CGSize labelSize = [[Util sharedInstance] text:newText sizeWithFont:textView.font constrainedToSize:CGSizeMake(1000.0, 1000.0)];
    labelSize = CGSizeMake(labelSize.width+2.0, labelSize.height+2.0);
    
    CGRect frame = textView.frame;
    frame.size = labelSize;
    textView.frame = frame;
    textView.center = oldCenter;
    [self rearrangeSelectionRelatedViewsFrame];

    
    return NO;
    
    
//    if (textView.tag == HORIZONTAL_TEXTVIEW_TAG) {
//        if (selectedItem && [selectedItem isKindOfClass:[UITextView class]]) {
//            NSString* currentText = [textView.text stringByReplacingCharactersInRange:range withString:text];
//            NSString* newText = [self generateBaseString:currentText.mutableCopy];
//            ((PSTextView*)selectedItem).baseText = newText;
//        }
//        return YES;
//    } else {
//        if ([text isEqualToString:@""] || [text isEqualToString:@"\n"]) {
//            NSString* newText = [textView.text stringByReplacingCharactersInRange:range withString:text];
//            textView.text = newText;
//        
//        } else {
//            NSString* newText = [textView.text stringByReplacingCharactersInRange:range withString:text];
//            if (range.length > 0) {
//                if (textView.tag == VERTICAL_TEXTVIEW_TAG) {
//                    if (newText.length > 1) {
//                        NSString* lastCharacter = [newText substringWithRange:NSMakeRange(newText.length-1, 1)];
//                        NSMutableString* newString = [NSMutableString stringWithString:[newText substringWithRange:NSMakeRange(0, newText.length-1)]];
//                        [newString appendString:@"\n"];
//                        [newString appendString:lastCharacter];
//                        textView.text = newString;
//                    } else {
//                        textView.text = newText;
//                    }
//                }
//            }
//        }
//        
//        NSString* newText = textView.text;
//        
//        CGPoint oldCenter = textView.center;
//        
//        CGSize labelSize = [[Util sharedInstance] text:newText sizeWithFont:textView.font constrainedToSize:CGSizeMake(1000.0, 1000.0)];
//        
//        CGRect frame = textView.frame;
//        frame.size = labelSize;
//        textView.frame = frame;
//        textView.center = oldCenter;
//        [self rearrangeSelectionRelatedViewsFrame];
//
//        if (selectedItem && [selectedItem isKindOfClass:[UITextView class]]) {
//            NSString* currentText = textView.text;
//            NSString* newText = [self generateBaseString:currentText.mutableCopy];
//            ((PSTextView*)selectedItem).baseText = newText;
//        }
//        
//        return NO;
//    }
    
    return NO;
}
- (void)textViewDidChange:(UITextView *)textView
{
    NSString* text = textView.text;
    
    if (text == nil) {
        return;
    } else {
        if (textView.tag == HORIZONTAL_TEXTVIEW_TAG) {
            CGPoint oldCenter = textView.center;
            
            CGSize labelSize = [[Util sharedInstance] text:text sizeWithFont:textView.font constrainedToSize:CGSizeMake(1000.0, 1000.0)];
            labelSize = CGSizeMake(labelSize.width+2.0, labelSize.height+2.0);
            
            CGRect frame = textView.frame;
            frame.size = labelSize;
            textView.frame = frame;
            textView.center = oldCenter;
        }
    }
    [self rearrangeSelectionRelatedViewsFrame];
}
- (void) addImage
{
    UIActionSheet* sheet = [[UIActionSheet alloc] initWithTitle:nil
                                                       delegate:self
                                              cancelButtonTitle:@"Cancel"
                                         destructiveButtonTitle:nil
                                              otherButtonTitles:@"Add From Library",
                                                                @"Take Photo", nil];
    [sheet showInView:self.view];
}
- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if(buttonIndex != actionSheet.cancelButtonIndex)
    {
        if(imagePickerController == nil)
        {
            imagePickerController = [[UIImagePickerController alloc] init];
            imagePickerController.delegate = self;
            imagePickerController.navigationBar.translucent = NO;
            imagePickerController.modalPresentationStyle = UIModalPresentationFullScreen;
        }
        
        if (buttonIndex == actionSheet.firstOtherButtonIndex) {
            imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
//            [self presentViewController:imagePickerController animated:YES completion:^{}];
        } else {
            imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
            //            imagePickerController.showsCameraControls = NO;
//            [self presentViewController:imagePickerController animated:YES completion:^{}];
        }
        
        [[UIApplication sharedApplication] setStatusBarHidden:YES];
//        [self.navigationController setNavigationBarHidden:YES];
        [self addChildViewController:imagePickerController];
        [self.view addSubview:imagePickerController.view];
        imagePickerController.view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        imagePickerController.view.frame = self.view.bounds;
        [imagePickerController didMoveToParentViewController:self];
    }
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
//    [picker dismissViewControllerAnimated:YES completion:^{
        [self imageSelected:[info objectForKey:UIImagePickerControllerOriginalImage]];
//    }];
    [picker.view removeFromSuperview];
    [picker removeFromParentViewController];
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
//    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
}
- (void) imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
//    [picker dismissViewControllerAnimated:YES completion:nil];
    [picker.view removeFromSuperview];
    [picker removeFromParentViewController];
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
//    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
}
- (void) imageSelected:(UIImage*)image
{
    
    if (image != nil) {
        
        UIImage* newImage = [[Util sharedInstance] prepareImageForDesign:image];
        
        CGRect frame = modelCanvas.frame;
        CGSize imageSize = newImage.size;
        
        PSImageView* imageView = [[PSImageView alloc] initWithFrame:CGRectMake((frame.size.width-imageSize.width)*0.5,
                                                                               (frame.size.height-imageSize.height)*0.5,
                                                                               imageSize.width,
                                                                               imageSize.height)];
        imageView.backgroundColor = [UIColor clearColor];
        imageView.image = newImage;
        imageView.alpha = imageOpacity;
//        imageView.opacity = imageOpacity;
//        imageView.layer.zPosition = currentZIndex;
        currentZIndex += 1.0;
        [modelCanvas addSubview:imageView];
        
        [modelCanvas.allImages addObject:imageView];
        imageIndex++;
    }
}
- (void) deleteLastImage
{
    if (imageIndex > 0) {
        [self deleteAnImage:imageIndex-1];
    }
}
- (void) deleteAnImage:(NSInteger)deletedImageIndex
{
    if (deletedImageIndex < modelCanvas.allImages.count) {
        if ([modelCanvas.allImages objectAtIndex:deletedImageIndex] == selectedItem) {
            [self removeSelectionRelatedItems];
        }
        [[modelCanvas.allImages objectAtIndex:deletedImageIndex] removeFromSuperview];
        [modelCanvas.allImages removeObjectAtIndex:deletedImageIndex];
        imageIndex--;
    }
}
- (void) deleteAllImages
{
    if (imageIndex > 0) {
        for (UIImageView* imageView in modelCanvas.allImages) {
            [imageView removeFromSuperview];
            if (imageView == selectedItem) {
                [self removeSelectionRelatedItems];
            }
        }
        modelCanvas.allImages = @[].mutableCopy;
        imageIndex = 0;
    }
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
    
    imageSubmenuView = [[UIImageView alloc] initWithFrame:[self imageSubmenuFrame]];
    imageSubmenuView.backgroundColor = [UIColor clearColor];
    imageSubmenuView.image = [UIImage imageNamed:@"fabric_submenubg.png"];
    [self.view addSubview:imageSubmenuView];
    
    textSubmenuView = [[UIImageView alloc] initWithFrame:[self textSubmenuFrame]];
    textSubmenuView.backgroundColor = [UIColor clearColor];
    textSubmenuView.image = [UIImage imageNamed:@"fabric_submenubg.png"];
    [self.view addSubview:textSubmenuView];
    
    CGRect brushSubmenuFrame = brushSubmenuView.frame;
    brushSubmenuFrame.origin.x += brushSubmenuFrame.size.width;
    brushSubmenuView.frame = brushSubmenuFrame;
    brushSubmenuView.alpha = 0;
    
    CGRect imageSubmenuFrame = imageSubmenuView.frame;
    imageSubmenuFrame.origin.x += imageSubmenuFrame.size.width;
    imageSubmenuView.frame = imageSubmenuFrame;
    imageSubmenuView.alpha = 0;
    
    CGRect textSubmenuFrame = textSubmenuView.frame;
    textSubmenuFrame.origin.x += textSubmenuFrame.size.width;
    textSubmenuView.frame = textSubmenuFrame;
    textSubmenuView.alpha = 0;
    
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
    
    NSString* shortVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    NSString* versionText = [NSString stringWithFormat:@"Pişti Version %@",shortVersion];
    
    UILabel* versionLabel = [[UILabel alloc] initWithFrame:CGRectMake(frame.origin.x, fabricSubmenuView.frame.size.height-30.0, 130.0, 20.0)];
    versionLabel.backgroundColor = [UIColor clearColor];
    versionLabel.font = DESIGN_MENU_SUBMENU_TITLES_FONT;
    versionLabel.textColor = DESIGN_MENU_SUBMENU_TITLES_COLOR;
    versionLabel.text = versionText;
    [fabricSubmenuView addSubview:versionLabel];
    
    UILabel* versionLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(frame.origin.x, fabricSubmenuView.frame.size.height-30.0, 130.0, 20.0)];
    versionLabel2.backgroundColor = [UIColor clearColor];
    versionLabel2.font = DESIGN_MENU_SUBMENU_TITLES_FONT;
    versionLabel2.textColor = DESIGN_MENU_SUBMENU_TITLES_COLOR;
    versionLabel2.text = versionText;
    [brushSubmenuView addSubview:versionLabel2];
    
    UILabel* versionLabel3 = [[UILabel alloc] initWithFrame:CGRectMake(frame.origin.x, fabricSubmenuView.frame.size.height-30.0, 130.0, 20.0)];
    versionLabel3.backgroundColor = [UIColor clearColor];
    versionLabel3.font = DESIGN_MENU_SUBMENU_TITLES_FONT;
    versionLabel3.textColor = DESIGN_MENU_SUBMENU_TITLES_COLOR;
    versionLabel3.text = versionText;
    [textSubmenuView addSubview:versionLabel2];
    
    UILabel* versionLabel4 = [[UILabel alloc] initWithFrame:CGRectMake(frame.origin.x, fabricSubmenuView.frame.size.height-30.0, 130.0, 20.0)];
    versionLabel4.backgroundColor = [UIColor clearColor];
    versionLabel4.font = DESIGN_MENU_SUBMENU_TITLES_FONT;
    versionLabel4.textColor = DESIGN_MENU_SUBMENU_TITLES_COLOR;
    versionLabel4.text = versionText;
    [imageSubmenuView addSubview:versionLabel4];
    
    
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
    
    textButton = [UIButton buttonWithType:UIButtonTypeCustom];
    textButton.backgroundColor = [UIColor clearColor];
    textButton.frame = [self textButtonFrame];
    [textButton setImage:[UIImage imageNamed:@"text_btn_normal.png"] forState:UIControlStateNormal];
    [textButton setImage:[UIImage imageNamed:@"text_btn_highlighted.png"] forState:UIControlStateHighlighted];
    [textButton setImage:[UIImage imageNamed:@"text_btn_highlighted.png"] forState:UIControlStateSelected];
    [textButton addTarget:self action:@selector(openTextMenu) forControlEvents:UIControlEventTouchUpInside];
    [mainMenuView addSubview:textButton];
    
    brushButton = [UIButton buttonWithType:UIButtonTypeCustom];
    brushButton.backgroundColor = [UIColor clearColor];
    brushButton.frame = [self brushButtonFrame];
    [brushButton setImage:[UIImage imageNamed:@"brush_btn_normal.png"] forState:UIControlStateNormal];
    [brushButton setImage:[UIImage imageNamed:@"brush_btn_highlighted.png"] forState:UIControlStateHighlighted];
    [brushButton setImage:[UIImage imageNamed:@"brush_btn_highlighted.png"] forState:UIControlStateSelected];
    [brushButton addTarget:self action:@selector(openBrushMenu) forControlEvents:UIControlEventTouchUpInside];
    [mainMenuView addSubview:brushButton];
    
    imageButton = [UIButton buttonWithType:UIButtonTypeCustom];
    imageButton.backgroundColor = [UIColor clearColor];
    imageButton.frame = [self imageButtonFrame];
    [imageButton setImage:[UIImage imageNamed:@"image_btn_normal.png"] forState:UIControlStateNormal];
    [imageButton setImage:[UIImage imageNamed:@"image_btn_highlighted.png"] forState:UIControlStateHighlighted];
    [imageButton setImage:[UIImage imageNamed:@"image_btn_highlighted.png"] forState:UIControlStateSelected];
    [imageButton addTarget:self action:@selector(openImageMenu) forControlEvents:UIControlEventTouchUpInside];
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

#pragma mark - Image related, will be deleted later
    
    CGRect cFrame = [self fabricColorSelectionValueFrame];
    
    UIButton* addImageButton = [UIButton buttonWithType:UIButtonTypeCustom];
    addImageButton.backgroundColor = [UIColor clearColor];
    addImageButton.frame = cFrame;
    [addImageButton setTitle:@"Add Image" forState:UIControlStateNormal];
    [addImageButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [addImageButton setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
    [addImageButton addTarget:self action:@selector(addImage) forControlEvents:UIControlEventTouchUpInside];
    [imageSubmenuView addSubview:addImageButton];
    
    CGRect cFrame2 = [self fabricColorSelectionValueFrame];
    cFrame2.origin.y += 60.0;
    
    UIButton* deleteLastImageButton = [UIButton buttonWithType:UIButtonTypeCustom];
    deleteLastImageButton.backgroundColor = [UIColor clearColor];
    deleteLastImageButton.frame = cFrame2;
    [deleteLastImageButton setTitle:@"Delete Last" forState:UIControlStateNormal];
    [deleteLastImageButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [deleteLastImageButton setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
    [deleteLastImageButton addTarget:self action:@selector(deleteLastImage) forControlEvents:UIControlEventTouchUpInside];
    [imageSubmenuView addSubview:deleteLastImageButton];
    
    CGRect cFrame3 = [self fabricColorSelectionValueFrame];
    cFrame3.origin.y += 120.0;
    
    UIButton* deleteAllImagesButton = [UIButton buttonWithType:UIButtonTypeCustom];
    deleteAllImagesButton.backgroundColor = [UIColor clearColor];
    deleteAllImagesButton.frame = cFrame3;
    [deleteAllImagesButton setTitle:@"Delete All" forState:UIControlStateNormal];
    [deleteAllImagesButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [deleteAllImagesButton setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
    [deleteAllImagesButton addTarget:self action:@selector(deleteAllImages) forControlEvents:UIControlEventTouchUpInside];
    [imageSubmenuView addSubview:deleteAllImagesButton];
    
    CGRect cFrame4 = [self fabricColorSelectionValueFrame];
    cFrame4.origin.y += 200.0;
    
    UILabel* imageOpacitySelectionTitleLabel = [[UILabel alloc] initWithFrame:cFrame4];
    imageOpacitySelectionTitleLabel.backgroundColor = [UIColor clearColor];
    imageOpacitySelectionTitleLabel.font = DESIGN_MENU_SUBMENU_TITLES_FONT;
    imageOpacitySelectionTitleLabel.textColor = DESIGN_MENU_SUBMENU_TITLES_COLOR;
    imageOpacitySelectionTitleLabel.text = @"Label Opacity Seçimi";
    [imageSubmenuView addSubview:imageOpacitySelectionTitleLabel];
    
    CGRect cFrame5 = [self fabricColorSelectionValueFrame];
    cFrame5.origin.y += 240.0;
    
    imageOpacitySlider = [[UISlider alloc] initWithFrame:cFrame5];
    [imageOpacitySlider addTarget:self action:@selector(sliderChanged:) forControlEvents:UIControlEventValueChanged];
    imageOpacitySlider.minimumValue = 0.0;
    imageOpacitySlider.maximumValue = 100.0;
    imageOpacitySlider.value = 100.0;
    imageOpacitySlider.continuous = YES;
    [imageSubmenuView addSubview:imageOpacitySlider];
    
#pragma mark - Label related, will be deleted later
    
    CGRect bFrame = [self fabricColorSelectionTitleFrame];
    bFrame.origin.y -= 100.0;
    
    UILabel* labelFontSelectionTitleLabel = [[UILabel alloc] initWithFrame:bFrame];
    labelFontSelectionTitleLabel.backgroundColor = [UIColor clearColor];
    labelFontSelectionTitleLabel.font = DESIGN_MENU_SUBMENU_TITLES_FONT;
    labelFontSelectionTitleLabel.textColor = DESIGN_MENU_SUBMENU_TITLES_COLOR;
    labelFontSelectionTitleLabel.text = @"Label Font Seçimi";
    [textSubmenuView addSubview:labelFontSelectionTitleLabel];
    
    CGRect bFrame2 = [self fabricColorSelectionTitleSeperatorFrame];
    bFrame2.origin.y -= 100.0;
    
    UIImageView* labelFontSelectionTitleSeperator = [[UIImageView alloc] initWithFrame:bFrame2];
    labelFontSelectionTitleSeperator.backgroundColor = [UIColor clearColor];
    labelFontSelectionTitleSeperator.image = [UIImage imageNamed:@"ayrac_koyu.png"];
    [textSubmenuView addSubview:labelFontSelectionTitleSeperator];
    
    CGRect bFrame3 = [self fabricColorSelectionValueFrame];
    bFrame3.origin.y -= 100.0;
    
    labelFontSelectionValueLabel = [[UILabel alloc] initWithFrame:bFrame3];
    labelFontSelectionValueLabel.backgroundColor = [UIColor clearColor];
    labelFontSelectionValueLabel.font = DESIGN_MENU_SUBMENU_VALUES_FONT;
    labelFontSelectionValueLabel.textColor = DESIGN_MENU_SUBMENU_VALUES_COLOR;
    labelFontSelectionValueLabel.text = [labelFontNames objectAtIndex:0];
    [textSubmenuView addSubview:labelFontSelectionValueLabel];
    
    CGRect bFrame4 = [self fabricColorSelectionValueFrame];
    bFrame4.origin.y -= 60.0;
    
    isLabelBoldButton = [UIButton buttonWithType:UIButtonTypeCustom];
    isLabelBoldButton.backgroundColor = [UIColor clearColor];
    isLabelBoldButton.frame = bFrame4;
    [isLabelBoldButton setTitle:@"Not Bold" forState:UIControlStateNormal];
    [isLabelBoldButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [isLabelBoldButton setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
    [isLabelBoldButton addTarget:self action:@selector(boldnessChanged) forControlEvents:UIControlEventTouchUpInside];
    [textSubmenuView addSubview:isLabelBoldButton];
    
    CGRect bFrame5 = [self fabricColorSelectionValueFrame];
    bFrame5.origin.y -= 30.0;
    
    isLabelItalicButton = [UIButton buttonWithType:UIButtonTypeCustom];
    isLabelItalicButton.backgroundColor = [UIColor clearColor];
    isLabelItalicButton.frame = bFrame5;
    [isLabelItalicButton setTitle:@"Not Italic" forState:UIControlStateNormal];
    [isLabelItalicButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [isLabelItalicButton setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
    [isLabelItalicButton addTarget:self action:@selector(italicnessChanged) forControlEvents:UIControlEventTouchUpInside];
    [textSubmenuView addSubview:isLabelItalicButton];
    
    CGRect bFrame6 = [self fabricColorSelectionValueFrame];
    
    alignmentButton = [UIButton buttonWithType:UIButtonTypeCustom];
    alignmentButton.backgroundColor = [UIColor clearColor];
    alignmentButton.frame = bFrame6;
    [alignmentButton setTitle:@"Left Align" forState:UIControlStateNormal];
    [alignmentButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [alignmentButton setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
    [alignmentButton addTarget:self action:@selector(alignmentChanged) forControlEvents:UIControlEventTouchUpInside];
    [textSubmenuView addSubview:alignmentButton];
    
    CGRect bFrame7 = [self fabricColorSelectionValueFrame];
    bFrame7.origin.y += 30.0;
    
    isLabelHorizontalButton = [UIButton buttonWithType:UIButtonTypeCustom];
    isLabelHorizontalButton.backgroundColor = [UIColor clearColor];
    isLabelHorizontalButton.frame = bFrame7;
    [isLabelHorizontalButton setTitle:@"Horizontal" forState:UIControlStateNormal];
    [isLabelHorizontalButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [isLabelHorizontalButton setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
    [isLabelHorizontalButton addTarget:self action:@selector(horizontalnessChanged) forControlEvents:UIControlEventTouchUpInside];
    [textSubmenuView addSubview:isLabelHorizontalButton];
    
    CGRect bFrame8 = [self fabricColorSelectionTitleFrame];
    bFrame8.origin.y += 80;
    
    UILabel* labelColorSelectionTitleLabel = [[UILabel alloc] initWithFrame:bFrame8];
    labelColorSelectionTitleLabel.backgroundColor = [UIColor clearColor];
    labelColorSelectionTitleLabel.font = DESIGN_MENU_SUBMENU_TITLES_FONT;
    labelColorSelectionTitleLabel.textColor = DESIGN_MENU_SUBMENU_TITLES_COLOR;
    labelColorSelectionTitleLabel.text = @"Label Renk Seçimi";
    [textSubmenuView addSubview:labelColorSelectionTitleLabel];
    
    CGRect bFrame9 = [self fabricColorSelectionTitleSeperatorFrame];
    bFrame9.origin.y += 80.0;
    
    UIImageView* labelColorSelectionTitleSeperator = [[UIImageView alloc] initWithFrame:bFrame9];
    labelColorSelectionTitleSeperator.backgroundColor = [UIColor clearColor];
    labelColorSelectionTitleSeperator.image = [UIImage imageNamed:@"ayrac_koyu.png"];
    [textSubmenuView addSubview:labelColorSelectionTitleSeperator];
    
    CGRect bFrame10 = [self fabricColorSelectionValueFrame];
    bFrame10.origin.y += 80.0;
    
    labelColorSelectionValueLabel = [[UILabel alloc] initWithFrame:bFrame10];
    labelColorSelectionValueLabel.backgroundColor = [colors objectAtIndex:0];
    labelColorSelectionValueLabel.font = DESIGN_MENU_SUBMENU_VALUES_FONT;
    labelColorSelectionValueLabel.textColor = DESIGN_MENU_SUBMENU_VALUES_COLOR;
    [textSubmenuView addSubview:labelColorSelectionValueLabel];
    
    CGRect bFrame11 = [self fabricColorSelectionValueSeperatorFrame];
    bFrame11.origin.y += 80.0;
    
    UIImageView* labelColorSelectionValueSeperator = [[UIImageView alloc] initWithFrame:bFrame11];
    labelColorSelectionValueSeperator.backgroundColor = [UIColor clearColor];
    labelColorSelectionValueSeperator.image = [UIImage imageNamed:@"renk_maske.png"];
    [textSubmenuView addSubview:labelColorSelectionValueSeperator];
    
    CGRect bFrame12 = [self fabricColorSelectionTitleFrame];
    bFrame12.origin.y += 140.0;
    
    UILabel* labelOpacitySelectionTitleLabel = [[UILabel alloc] initWithFrame:bFrame12];
    labelOpacitySelectionTitleLabel.backgroundColor = [UIColor clearColor];
    labelOpacitySelectionTitleLabel.font = DESIGN_MENU_SUBMENU_TITLES_FONT;
    labelOpacitySelectionTitleLabel.textColor = DESIGN_MENU_SUBMENU_TITLES_COLOR;
    labelOpacitySelectionTitleLabel.text = @"Label Opacity Seçimi";
    [textSubmenuView addSubview:labelOpacitySelectionTitleLabel];
    
    CGRect bFrame13 = [self fabricColorSelectionTitleSeperatorFrame];
    bFrame13.origin.y += 140.0;
    
    UIImageView* labelOpacitySelectionTitleSeperator = [[UIImageView alloc] initWithFrame:bFrame13];
    labelOpacitySelectionTitleSeperator.backgroundColor = [UIColor clearColor];
    labelOpacitySelectionTitleSeperator.image = [UIImage imageNamed:@"ayrac_koyu.png"];
    [textSubmenuView addSubview:labelOpacitySelectionTitleSeperator];
    
    CGRect bFrame14 = [self fabricColorSelectionValueFrame];
    bFrame14.origin.y += 160.0;
    
    labelOpacitySlider = [[UISlider alloc] initWithFrame:bFrame14];
    [labelOpacitySlider addTarget:self action:@selector(sliderChanged:) forControlEvents:UIControlEventValueChanged];
    labelOpacitySlider.minimumValue = 0.0;
    labelOpacitySlider.maximumValue = 100.0;
    labelOpacitySlider.value = 100.0;
    labelOpacitySlider.continuous = YES;
    [textSubmenuView addSubview:labelOpacitySlider];
    
    CGRect bFrame15 = [self fabricColorSelectionValueFrame];
    bFrame15.origin.y += 200.0;
    
    UIButton* addLabelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    addLabelButton.backgroundColor = [UIColor clearColor];
    addLabelButton.frame = bFrame15;
    [addLabelButton setTitle:@"Add Label" forState:UIControlStateNormal];
    [addLabelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [addLabelButton setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
    [addLabelButton addTarget:self action:@selector(addNewLabel) forControlEvents:UIControlEventTouchUpInside];
    [textSubmenuView addSubview:addLabelButton];
    
    CGRect bFrame16 = [self fabricColorSelectionValueFrame];
    bFrame16.origin.y += 260.0;
    
    UIButton* deleteLastLabelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    deleteLastLabelButton.backgroundColor = [UIColor clearColor];
    deleteLastLabelButton.frame = bFrame16;
    [deleteLastLabelButton setTitle:@"Delete Last" forState:UIControlStateNormal];
    [deleteLastLabelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [deleteLastLabelButton setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
    [deleteLastLabelButton addTarget:self action:@selector(deleteLastLabel) forControlEvents:UIControlEventTouchUpInside];
    [textSubmenuView addSubview:deleteLastLabelButton];
    
    CGRect bFrame17 = [self fabricColorSelectionValueFrame];
    bFrame17.origin.y += 320.0;
    
    UIButton* deleteAllLabelsButton = [UIButton buttonWithType:UIButtonTypeCustom];
    deleteAllLabelsButton.backgroundColor = [UIColor clearColor];
    deleteAllLabelsButton.frame = bFrame17;
    [deleteAllLabelsButton setTitle:@"Delete All" forState:UIControlStateNormal];
    [deleteAllLabelsButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [deleteAllLabelsButton setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
    [deleteAllLabelsButton addTarget:self action:@selector(deleteAllLabels) forControlEvents:UIControlEventTouchUpInside];
    [textSubmenuView addSubview:deleteAllLabelsButton];
    
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
    brushOpacitySlider = [[UISlider alloc] initWithFrame:CGRectMake(aFrame7.origin.x, aFrame7.origin.y+120.0, aFrame7.size.width, aFrame7.size.height)];
    [brushOpacitySlider addTarget:self action:@selector(sliderChanged:) forControlEvents:UIControlEventValueChanged];
    brushOpacitySlider.minimumValue = 0.0;
    brushOpacitySlider.maximumValue = 100.0;
    brushOpacitySlider.value = 100.0;
    brushOpacitySlider.continuous = YES;
    [brushSubmenuView addSubview:brushOpacitySlider];
    
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
    modelCanvas.patternImageName = @"brush4_erkek.png";
}
- (void) pattern2BrushTypeClicked
{
    basicBrushButton.selected = NO;
    pattern1BrushButton.selected = NO;
    pattern2BrushButton.selected = YES;
    modelCanvas.brushType = BRUSH_TYPE_PATTERN_COLOR;
    modelCanvas.patternImageName = @"brush2_erkek.png";
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
    CGFloat sliderValuePercent = slider.value/100.0;
    if (slider == brushOpacitySlider) {
        modelCanvas.brushOpacity = sliderValuePercent;
    } else if (slider == labelOpacitySlider){
        labelOpacity = sliderValuePercent;
        if (selectedItem && [selectedItem isKindOfClass:[UITextView class]]) {
            ((PSTextView*)selectedItem).opacity = labelOpacity;
            ((PSTextView*)selectedItem).alpha = labelOpacity;
        }
    } else {
        imageOpacity = sliderValuePercent;
        if (selectedItem && [selectedItem isKindOfClass:[UIImageView class]]) {
//            ((PSImageView*)selectedItem).opacity = imageOpacity;
//            ((PSImageView*)selectedItem).alpha = imageOpacity;
        }
    }
}
- (void) openFabricMenu
{
    if (fabricButton.selected) {
        return;
    } else {
        modelCanvas.isBrushActive = NO;
        
        UIImageView* oldImageView;
        if (brushButton.selected) {
            oldImageView = brushSubmenuView;
        } else if (textButton.selected) {
            oldImageView = textSubmenuView;
        } else if (imageButton.selected) {
            oldImageView = imageSubmenuView;
        }
        
        fabricButton.selected = YES;
        brushButton.selected = NO;
        textButton.selected = NO;
        imageButton.selected = NO;
        
        oldImageView.userInteractionEnabled = NO;
        
        if (oldImageView == brushSubmenuView) {
            brushColorSelectionValueLabel.userInteractionEnabled = NO;
            [brushColorSelectionValueLabel removeGestureRecognizer:brushColorTableOpeningGesture];
            brushColorTableOpeningGesture = nil;
            
            brushWidthSelectionValueLabel.userInteractionEnabled = NO;
            [brushWidthSelectionValueLabel removeGestureRecognizer:brushWidthTableOpeningGesture];
            brushWidthTableOpeningGesture = nil;
        } else if (oldImageView == textSubmenuView) {
            
            labelColorSelectionValueLabel.userInteractionEnabled = NO;
            [labelColorSelectionValueLabel removeGestureRecognizer:labelColorTableOpeningGesture];
            labelColorTableOpeningGesture = nil;
            
            labelFontSelectionValueLabel.userInteractionEnabled = NO;
            [labelFontSelectionValueLabel removeGestureRecognizer:labelFontTableOpeningGesture];
            labelFontTableOpeningGesture = nil;
        }
        
        [UIView animateWithDuration:0.5 animations:^{
            CGRect oldSubmenuFrame = oldImageView.frame;
            oldSubmenuFrame.origin.x += oldSubmenuFrame.size.width;
            oldImageView.frame = oldSubmenuFrame;
        } completion:^(BOOL finished) {
            oldImageView.alpha = 0.0;
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
        
        UIImageView* oldImageView;
        if (fabricButton.selected) {
            oldImageView = fabricSubmenuView;
        } else if (textButton.selected) {
            oldImageView = textSubmenuView;
        } else if (imageButton.selected) {
            oldImageView = imageSubmenuView;
        }
        
        fabricButton.selected = NO;
        brushButton.selected = YES;
        textButton.selected = NO;
        imageButton.selected = NO;
        
        oldImageView.userInteractionEnabled = NO;
        
        if (oldImageView == fabricSubmenuView) {
            fabricColorSelectionValueLabel.userInteractionEnabled = NO;
            [fabricColorSelectionValueLabel removeGestureRecognizer:colorTableOpeningGesture];
            colorTableOpeningGesture = nil;
        } else if (oldImageView == textSubmenuView) {
            labelColorSelectionValueLabel.userInteractionEnabled = NO;
            [labelColorSelectionValueLabel removeGestureRecognizer:labelColorTableOpeningGesture];
            labelColorTableOpeningGesture = nil;
            
            labelFontSelectionValueLabel.userInteractionEnabled = NO;
            [labelFontSelectionValueLabel removeGestureRecognizer:labelFontTableOpeningGesture];
            labelFontTableOpeningGesture = nil;
        }
        
        
        [UIView animateWithDuration:0.5 animations:^{
            CGRect oldSubmenuFrame = oldImageView.frame;
            oldSubmenuFrame.origin.x += oldSubmenuFrame.size.width;
            oldImageView.frame = oldSubmenuFrame;
        } completion:^(BOOL finished) {
            oldImageView.alpha = 0.0;
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
- (void) openTextMenu
{
    if (textButton.selected) {
        return;
    } else {
        modelCanvas.isBrushActive = NO;
        
        UIImageView* oldImageView;
        if (fabricButton.selected) {
            oldImageView = fabricSubmenuView;
        } else if (imageButton.selected) {
            oldImageView = imageSubmenuView;
        } else if (brushButton.selected) {
            oldImageView = brushSubmenuView;
        }
        
        fabricButton.selected = NO;
        brushButton.selected = NO;
        textButton.selected = YES;
        imageButton.selected = NO;
        
        oldImageView.userInteractionEnabled = NO;
        
        if (oldImageView == fabricSubmenuView) {
            fabricColorSelectionValueLabel.userInteractionEnabled = NO;
            [fabricColorSelectionValueLabel removeGestureRecognizer:colorTableOpeningGesture];
            colorTableOpeningGesture = nil;
        } else if (oldImageView == brushSubmenuView) {
            brushColorSelectionValueLabel.userInteractionEnabled = NO;
            [brushColorSelectionValueLabel removeGestureRecognizer:brushColorTableOpeningGesture];
            brushColorTableOpeningGesture = nil;
            
            brushWidthSelectionValueLabel.userInteractionEnabled = NO;
            [brushWidthSelectionValueLabel removeGestureRecognizer:brushWidthTableOpeningGesture];
            brushWidthTableOpeningGesture = nil;
        }
        
        [UIView animateWithDuration:0.5 animations:^{
            CGRect oldSubmenuFrame = oldImageView.frame;
            oldSubmenuFrame.origin.x += oldSubmenuFrame.size.width;
            oldImageView.frame = oldSubmenuFrame;
        } completion:^(BOOL finished) {
            oldImageView.alpha = 0.0;
            textSubmenuView.alpha = 1.0;
            
            [UIView animateWithDuration:0.5 animations:^{
                CGRect textSubmenuFrame = textSubmenuView.frame;
                textSubmenuFrame.origin.x -= textSubmenuFrame.size.width;
                textSubmenuView.frame = textSubmenuFrame;
            } completion:^(BOOL finished) {
                textSubmenuView.userInteractionEnabled = YES;
                
                labelColorSelectionValueLabel.userInteractionEnabled = YES;
                labelColorTableOpeningGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(openLabelColorMenu)];
                labelColorTableOpeningGesture.delegate = self;
                [labelColorSelectionValueLabel addGestureRecognizer:labelColorTableOpeningGesture];
                
                labelFontSelectionValueLabel.userInteractionEnabled = YES;
                labelFontTableOpeningGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(openLabelFontMenu)];
                labelFontTableOpeningGesture.delegate = self;
                [labelFontSelectionValueLabel addGestureRecognizer:labelFontTableOpeningGesture];
            }];
        }];
    }
}
- (void) openImageMenu
{
    if (imageButton.selected) {
        return;
    } else {
        modelCanvas.isBrushActive = NO;
        
        UIImageView* oldImageView;
        if (fabricButton.selected) {
            oldImageView = fabricSubmenuView;
        } else if (textButton.selected) {
            oldImageView = textSubmenuView;
        } else if (brushButton.selected) {
            oldImageView = brushSubmenuView;
        }
        
        fabricButton.selected = NO;
        brushButton.selected = NO;
        textButton.selected = NO;
        imageButton.selected = YES;
        
        oldImageView.userInteractionEnabled = NO;
        
        if (oldImageView == fabricSubmenuView) {
            fabricColorSelectionValueLabel.userInteractionEnabled = NO;
            [fabricColorSelectionValueLabel removeGestureRecognizer:colorTableOpeningGesture];
            colorTableOpeningGesture = nil;
        } else if (oldImageView == brushSubmenuView) {
            brushColorSelectionValueLabel.userInteractionEnabled = NO;
            [brushColorSelectionValueLabel removeGestureRecognizer:brushColorTableOpeningGesture];
            brushColorTableOpeningGesture = nil;
            
            brushWidthSelectionValueLabel.userInteractionEnabled = NO;
            [brushWidthSelectionValueLabel removeGestureRecognizer:brushWidthTableOpeningGesture];
            brushWidthTableOpeningGesture = nil;
        } else if (oldImageView == textSubmenuView) {
            labelColorSelectionValueLabel.userInteractionEnabled = NO;
            [labelColorSelectionValueLabel removeGestureRecognizer:labelColorTableOpeningGesture];
            labelColorTableOpeningGesture = nil;
            
            labelFontSelectionValueLabel.userInteractionEnabled = NO;
            [labelFontSelectionValueLabel removeGestureRecognizer:labelFontTableOpeningGesture];
            labelFontTableOpeningGesture = nil;
        }
        
        [UIView animateWithDuration:0.5 animations:^{
            CGRect oldSubmenuFrame = oldImageView.frame;
            oldSubmenuFrame.origin.x += oldSubmenuFrame.size.width;
            oldImageView.frame = oldSubmenuFrame;
        } completion:^(BOOL finished) {
            oldImageView.alpha = 0.0;
            imageSubmenuView.alpha = 1.0;
            
            [UIView animateWithDuration:0.5 animations:^{
                CGRect imageSubmenuFrame = imageSubmenuView.frame;
                imageSubmenuFrame.origin.x -= imageSubmenuFrame.size.width;
                imageSubmenuView.frame = imageSubmenuFrame;
            } completion:^(BOOL finished) {
                imageSubmenuView.userInteractionEnabled = YES;
                
            }];
        }];
    }
}
-(BOOL) gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if (gestureRecognizer == colorTableOpeningGesture) {
        shouldHandleTouch = NO;
        return YES;
    } else if (gestureRecognizer == colorTableClosingGesture){
        CGPoint point = [touch locationInView:self.view];
        CGPoint locationInView = [self.fabricSubmenuTableView convertPoint:point fromView:self.view];
        if (CGRectContainsPoint(self.fabricSubmenuTableView.bounds, locationInView)) {
            return NO;
        } else {
            shouldHandleTouch = NO;
            return YES;
        }
    } else if (gestureRecognizer == brushColorTableOpeningGesture) {
        shouldHandleTouch = NO;
        return YES;
    } else if (gestureRecognizer == brushColorTableClosingGesture) {
        CGPoint point = [touch locationInView:self.view];
        CGPoint locationInView = [self.brushSubmenuTableView convertPoint:point fromView:self.view];
        if (CGRectContainsPoint(self.brushSubmenuTableView.bounds, locationInView)) {
            return NO;
        } else {
            shouldHandleTouch = NO;
            return YES;
        }
    } else if (gestureRecognizer == brushWidthTableOpeningGesture) {
        shouldHandleTouch = NO;
        return YES;
    } else if (gestureRecognizer == brushWidthTableClosingGesture) {
        CGPoint point = [touch locationInView:self.view];
        CGPoint locationInView = [self.brushWidthTableView convertPoint:point fromView:self.view];
        if (CGRectContainsPoint(self.brushWidthTableView.bounds, locationInView)) {
            return NO;
        } else {
            shouldHandleTouch = NO;
            return YES;
        }
    } else if (gestureRecognizer == labelColorTableOpeningGesture) {
        shouldHandleTouch = NO;
        return YES;
    } else if (gestureRecognizer == labelColorTableClosingGesture) {
        CGPoint point = [touch locationInView:self.view];
        CGPoint locationInView = [self.labelColorTableView convertPoint:point fromView:self.view];
        if (CGRectContainsPoint(self.labelColorTableView.bounds, locationInView)) {
            return NO;
        } else {
            shouldHandleTouch = NO;
            return YES;
        }
    } else if (gestureRecognizer == labelFontTableOpeningGesture) {
        shouldHandleTouch = NO;
        return YES;
    } else if (gestureRecognizer == labelFontTableClosingGesture) {
        CGPoint point = [touch locationInView:self.view];
        CGPoint locationInView = [self.labelFontTableView convertPoint:point fromView:self.view];
        if (CGRectContainsPoint(self.labelFontTableView.bounds, locationInView)) {
            return NO;
        } else {
            shouldHandleTouch = NO;
            return YES;
        }
    } else {
        shouldHandleTouch = NO;
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
    
    shouldHandleTouch = YES;
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
    
    shouldHandleTouch = YES;
}
- (void) openLabelColorMenu
{
    [labelColorSelectionValueLabel removeGestureRecognizer:labelColorTableOpeningGesture];
    labelColorTableOpeningGesture = nil;
    
    labelColorTableClosingGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeLabelColorMenu)];
    labelColorTableClosingGesture.delegate = self;
    [self.view addGestureRecognizer:labelColorTableClosingGesture];
    
    CGRect frame = [self fabricColorSelectionValueFrame];
    frame.origin.y += 80.0;
    
    self.labelColorTableView = [[UITableView alloc] initWithFrame:CGRectMake(frame.origin.x-10.0, frame.origin.y+frame.size.height, frame.size.width+20.0, 149.0)];
    self.labelColorTableView.backgroundColor = [UIColor colorWithRed:4.0/255.0 green:61.0/255.0 blue:93.0/255.0 alpha:1.0];
    self.labelColorTableView.layer.cornerRadius = 3.0;
    self.labelColorTableView.layer.shouldRasterize = YES;
    self.labelColorTableView.layer.rasterizationScale = SCREEN_SCALE;
    self.labelColorTableView.clipsToBounds = YES;
    [textSubmenuView addSubview:self.labelColorTableView];
    
    UIView* headerView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.labelColorTableView.frame.size.width, 10.0)];
    headerView.backgroundColor = [UIColor colorWithRed:4.0/255.0 green:61.0/255.0 blue:93.0/255.0 alpha:1.0];
    [self.labelColorTableView setTableHeaderView:headerView];
    
    UIView* footerView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.labelColorTableView.frame.size.width, 10.0)];
    footerView.backgroundColor = [UIColor colorWithRed:4.0/255.0 green:61.0/255.0 blue:93.0/255.0 alpha:1.0];
    [self.labelColorTableView setTableFooterView:footerView];
    
    self.labelColorTableView.dataSource = self;
    self.labelColorTableView.delegate = self;
    
    [self.labelColorTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.labelColorTableView registerClass:[PSSubmenuTableViewCell class] forCellReuseIdentifier:FABRIC_SUBMENU_COLOR_CELL_IDENTIFIER];
    
    [self.labelColorTableView reloadData];
    
    shouldHandleTouch = YES;
}
- (void) openLabelFontMenu
{
    [labelFontSelectionValueLabel removeGestureRecognizer:labelFontTableOpeningGesture];
    labelFontTableOpeningGesture = nil;
    
    labelFontTableClosingGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeLabelFontMenu)];
    labelFontTableClosingGesture.delegate = self;
    [self.view addGestureRecognizer:labelFontTableClosingGesture];
    
    CGRect frame = [self fabricColorSelectionValueFrame];
    frame.origin.y -= 100.0;
    
    self.labelFontTableView = [[UITableView alloc] initWithFrame:CGRectMake(frame.origin.x-10.0, frame.origin.y+frame.size.height, frame.size.width+20.0, 149.0)];
    self.labelFontTableView.backgroundColor = [UIColor colorWithRed:4.0/255.0 green:61.0/255.0 blue:93.0/255.0 alpha:1.0];
    self.labelFontTableView.layer.cornerRadius = 3.0;
    self.labelFontTableView.layer.shouldRasterize = YES;
    self.labelFontTableView.layer.rasterizationScale = SCREEN_SCALE;
    self.labelFontTableView.clipsToBounds = YES;
    [textSubmenuView addSubview:self.labelFontTableView];
    
    UIView* headerView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.labelFontTableView.frame.size.width, 10.0)];
    headerView.backgroundColor = [UIColor colorWithRed:4.0/255.0 green:61.0/255.0 blue:93.0/255.0 alpha:1.0];
    [self.labelFontTableView setTableHeaderView:headerView];
    
    UIView* footerView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.labelFontTableView.frame.size.width, 10.0)];
    footerView.backgroundColor = [UIColor colorWithRed:4.0/255.0 green:61.0/255.0 blue:93.0/255.0 alpha:1.0];
    [self.labelFontTableView setTableFooterView:footerView];
    
    self.labelFontTableView.dataSource = self;
    self.labelFontTableView.delegate = self;
    
    [self.labelFontTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.labelFontTableView registerClass:[PSSubmenuTableViewCell class] forCellReuseIdentifier:FABRIC_SUBMENU_LABEL_FONT_CELL_IDENTIFIER];
    
    [self.labelFontTableView reloadData];
    
    shouldHandleTouch = YES;
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
    
    shouldHandleTouch = YES;
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
    
    shouldHandleTouch = YES;
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
    
    shouldHandleTouch = YES;
}
- (void) closeLabelColorMenu
{
    [self.labelColorTableView removeFromSuperview];
    self.labelColorTableView = nil;
    
    [self.view removeGestureRecognizer:labelColorTableClosingGesture];
    labelColorTableClosingGesture = nil;
    
    labelColorTableOpeningGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(openLabelColorMenu)];
    labelColorTableOpeningGesture.delegate = self;
    [labelColorSelectionValueLabel addGestureRecognizer:labelColorTableOpeningGesture];
    
    shouldHandleTouch = YES;
}
- (void) closeLabelFontMenu
{
    [self.labelFontTableView removeFromSuperview];
    self.labelFontTableView = nil;
    
    [self.view removeGestureRecognizer:labelFontTableClosingGesture];
    labelFontTableClosingGesture = nil;
    
    labelFontTableOpeningGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(openLabelFontMenu)];
    labelFontTableOpeningGesture.delegate = self;
    [labelFontSelectionValueLabel addGestureRecognizer:labelFontTableOpeningGesture];
    
    shouldHandleTouch = YES;
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
    
    shouldHandleTouch = YES;
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
- (void) dealloc
{
    NSLog(@"dealloced");
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
