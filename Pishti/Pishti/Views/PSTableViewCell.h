//
//  PSColorTableViewCell.h
//  Pishti
//
//  Created by Alperen Kavun on 26.10.2014.
//  Copyright (c) 2014 pishti. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PSCommons.h"

#define FABRIC_COLOR_CELL_IDENTIFIER @"PSFabricColorTableViewCellIdentifier"
#define GENERAL_COLOR_CELL_IDENTIFIER @"PSGeneralColorTableViewCellIdentifier"
#define MAIN_CELL_IDENTIFIER @"PSMainTableViewCellIdentifier"
#define FABRIC_COLLAR_CELL_IDENTIFIER @"PSCollarTableViewCellIdentifier"
#define FABRIC_SLEEVE_CELL_IDENTIFIER @"PSSleeveTableViewCellIdentifier"

@interface PSTableViewCell : UITableViewCell

@property UIView* colorView;
@property UILabel* mainLabel;
@property UIImageView* iconView;

- (void) setIconWithName:(NSString*)iconName;
- (void) setColorForColorView:(UIColor*)color;
- (UIColor*) getColorForColorView;
- (void) makeSelected;

@end
