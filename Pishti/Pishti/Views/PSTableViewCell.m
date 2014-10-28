//
//  PSColorTableViewCell.m
//  Pishti
//
//  Created by Alperen Kavun on 26.10.2014.
//  Copyright (c) 2014 pishti. All rights reserved.
//

#import "PSTableViewCell.h"

@implementation PSTableViewCell
{
    UIView* backgroundView;
    UIView* selectedBackgroundView;
    
    UIColor* colorForColorView;
}
- (void)awakeFromNib {
    // Initialization code
}

- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self commonInitializer];
        if ([reuseIdentifier isEqualToString:COLOR_CELL_IDENTIFIER]) {
            [self stylizeForColorCell];
        } else if ([reuseIdentifier isEqualToString:MAIN_CELL_IDENTIFIER]) {
            [self stylizeForMainCell];
        }
    }
    
    return self;
}
- (void) commonInitializer
{
    backgroundView = [UIView new];
    [backgroundView setBackgroundColor:[UIColor clearColor]];
    [self setBackgroundView:backgroundView];
    
    selectedBackgroundView = [UIView new];
    [selectedBackgroundView setBackgroundColor:[UIColor clearColor]];
    [self setSelectedBackgroundView:selectedBackgroundView];
    
    self.accessoryType = UITableViewCellAccessoryNone;
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.backgroundColor = [UIColor clearColor];
}
- (void) stylizeForMainCell
{
    self.mainLabel = [[UILabel alloc] initWithFrame:CGRectMake(10.0, 0.0, 170.0, 37.0)];
    self.mainLabel.backgroundColor = [UIColor clearColor];
    self.mainLabel.font = DESIGN_MENU_SUBMENU_TABLEVIEW_CELL_FONT;
    self.mainLabel.textColor = DESIGN_MENU_SUBMENU_TABLEVIEW_CELL_NORMAL_TEXT_COLOR;
    [self addSubview:self.mainLabel];
}
- (void) stylizeForColorCell
{
    self.colorView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 56.0, 37.0)];
    self.colorView.backgroundColor = [UIColor clearColor];
    
    UIImageView* mask = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"color_mask.png"]];
    mask.backgroundColor = [UIColor clearColor];
    [self.colorView addSubview:mask];
    [self addSubview:self.colorView];
    
    self.mainLabel = [[UILabel alloc] initWithFrame:CGRectMake(60.0, 0.0, 170.0, 37.0)];
    self.mainLabel.backgroundColor = [UIColor clearColor];
    self.mainLabel.font = DESIGN_MENU_SUBMENU_TABLEVIEW_CELL_FONT;
    self.mainLabel.textColor = DESIGN_MENU_SUBMENU_TABLEVIEW_CELL_NORMAL_TEXT_COLOR;
    [self addSubview:self.mainLabel];
    
}
- (void) makeSelected
{
    self.mainLabel.textColor = DESIGN_MENU_SUBMENU_TABLEVIEW_CELL_SELECTED_TEXT_COLOR;
}
- (void) setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
    
    if (!self.highlighted && highlighted) {
        self.mainLabel.textColor = DESIGN_MENU_SUBMENU_TABLEVIEW_CELL_HIGHLIGHTED_TEXT_COLOR;
    } else if (self.highlighted && !highlighted) {
        self.mainLabel.textColor = DESIGN_MENU_SUBMENU_TABLEVIEW_CELL_NORMAL_TEXT_COLOR;
    }
    
    [super setHighlighted:highlighted animated:animated];
    
    self.colorView.backgroundColor = colorForColorView;
}
- (void) setColorForColorView:(UIColor*)color
{
    colorForColorView = color;
    self.colorView.backgroundColor = colorForColorView;
}
- (UIColor*) getColorForColorView
{
    return colorForColorView;
}
- (void) prepareForReuse
{
    self.mainLabel.textColor = DESIGN_MENU_SUBMENU_TABLEVIEW_CELL_NORMAL_TEXT_COLOR;
}
@end
