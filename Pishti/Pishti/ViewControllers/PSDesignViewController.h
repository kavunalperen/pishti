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

@interface PSDesignViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate>

@property UITableView* fabricSubmenuTableView;
@property UITableView* brushSubmenuTableView;
@property UITableView* brushWidthTableView;
@property UITableView* labelColorTableView;
@property UITableView* labelFontTableView;

@end
