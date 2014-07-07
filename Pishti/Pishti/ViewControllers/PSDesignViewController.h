//
//  PSDesignViewController.h
//  Pishti
//
//  Created by Alperen Kavun on 11.05.2014.
//  Copyright (c) 2014 pishti. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "PSCommons.h"
#import "Util.h"
#import "PSModelCanvas.h"
#import "PSSubmenuTableViewCell.h"
#import "PSTextView.h"
#import "PSImageView.h"

#define RADIANS_TO_DEGREES(radians) ((radians) * (180.0 / M_PI))
#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)

#define HORIZONTAL_TEXTVIEW_TAG 1234
#define VERTICAL_TEXTVIEW_TAG 1235
#define SELECTION_VIEW_TAG 2442
#define EDIT_VIEW_TAG 2443
#define DELETE_VIEW_TAG 2444
#define MOVE_VIEW_TAG 2445
#define ROTATE_VIEW_TAG 2446

@interface PSDesignViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate, UIActionSheetDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITextViewDelegate>

@property UITableView* fabricSubmenuTableView;
@property UITableView* brushSubmenuTableView;
@property UITableView* brushWidthTableView;
@property UITableView* labelColorTableView;
@property UITableView* labelFontTableView;

@end
