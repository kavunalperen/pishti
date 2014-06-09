//
//  PSSubmenuTableViewCell.h
//  Pishti
//
//  Created by Alperen Kavun on 17.05.2014.
//  Copyright (c) 2014 pishti. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PSCommons.h"

#define FABRIC_SUBMENU_SIZE_CELL_IDENTIFIER @"FabricSubmenuSizeCellIdentifier"
#define FABRIC_SUBMENU_COLOR_CELL_INDETIFIER @"FabricSubmenuColorCellIdentifier"

@interface PSSubmenuTableViewCell : UITableViewCell

@property UIView* seperatorView;
@property UIView* colorView;
@property UILabel* mainLabel;

- (void) setColorForColorView:(UIColor*)color;
- (UIColor*) getColorForColorView;

@end
