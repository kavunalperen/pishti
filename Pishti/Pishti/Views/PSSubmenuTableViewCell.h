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
#define FABRIC_SUBMENU_COLOR_CELL_IDENTIFIER @"FabricSubmenuColorCellIdentifier"
#define FABRIC_SUBMENU_BRUSH_WIDTH_CELL_IDENTIFIER @"FabricSubmenuBrushWidthCellIdentifier"
#define FABRIC_SUBMENU_LABEL_FONT_CELL_IDENTIFIER @"FabricSubmenuLabelFontCellIdentifier"

@interface PSSubmenuTableViewCell : UITableViewCell

@property UIView* seperatorView;
@property UIView* colorView;
@property UILabel* mainLabel;

- (void) setColorForColorView:(UIColor*)color;
- (UIColor*) getColorForColorView;

- (void) setWidthForBrushView:(CGFloat)brushViewWidth;
- (CGFloat) getWidthForBrushView;

@end
