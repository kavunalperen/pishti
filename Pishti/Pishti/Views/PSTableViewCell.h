//
//  PSColorTableViewCell.h
//  Pishti
//
//  Created by Alperen Kavun on 26.10.2014.
//  Copyright (c) 2014 pishti. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PSCommons.h"

#define COLOR_CELL_IDENTIFIER @"PSColorTableViewCellIdentifier"
#define MAIN_CELL_IDENTIFIER @"PSMainTableViewCellIdentifier"

@interface PSTableViewCell : UITableViewCell

@property UIView* colorView;
@property UILabel* mainLabel;

- (void) setColorForColorView:(UIColor*)color;
- (UIColor*) getColorForColorView;
- (void) makeSelected;

@end
