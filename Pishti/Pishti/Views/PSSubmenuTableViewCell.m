//
//  PSSubmenuTableViewCell.m
//  Pishti
//
//  Created by Alperen Kavun on 17.05.2014.
//  Copyright (c) 2014 pishti. All rights reserved.
//

#import "PSSubmenuTableViewCell.h"

@implementation PSSubmenuTableViewCell
{
    UIView* backgroundView;
    UIView* selectedBackgroundView;
    UIColor* colorForColorView;
    
    CGFloat brushWidth;
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self commonInitializer];
        if ([reuseIdentifier isEqualToString:FABRIC_SUBMENU_COLOR_CELL_IDENTIFIER]) {
            [self stylizeForColorCell];
        } else if ([reuseIdentifier isEqualToString:FABRIC_SUBMENU_SIZE_CELL_IDENTIFIER]) {
            [self stylizeForSizeCell];
        } else if ([reuseIdentifier isEqualToString:FABRIC_SUBMENU_BRUSH_WIDTH_CELL_IDENTIFIER]) {
            [self stylizeForBrushWidthCell];
        } else if ([reuseIdentifier isEqualToString:FABRIC_SUBMENU_LABEL_FONT_CELL_IDENTIFIER]) {
            [self stylizeForLabelFontCell];
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
    
    self.seperatorView = [[UIView alloc] initWithFrame:CGRectMake(0.0, self.frame.size.height-1.0, self.frame.size.width, 1.0)];
    [self.seperatorView setBackgroundColor:[UIColor clearColor]];
    [self addSubview:self.seperatorView];
    
    self.accessoryType = UITableViewCellAccessoryNone;
    
    self.backgroundColor = [UIColor clearColor];
}
- (void) stylizeForColorCell
{
    self.colorView = [[UIView alloc] initWithFrame:CGRectMake(10.0, 0.0, 25.0, 25.0)];
    self.colorView.backgroundColor = [UIColor clearColor];
    self.colorView.layer.cornerRadius = 2.0;
    self.colorView.layer.shouldRasterize = YES;
    self.colorView.layer.rasterizationScale = SCREEN_SCALE;
    [self addSubview:self.colorView];
    
    self.mainLabel = [[UILabel alloc] initWithFrame:CGRectMake(43.0, 0.0, 87.0, 25.0)];
    self.mainLabel.backgroundColor = [UIColor clearColor];
    self.mainLabel.font = DESIGN_MENU_SUBMENU_VALUES_FONT;
    self.mainLabel.textColor = DESIGN_MENU_SUBMENU_VALUES_COLOR;
    [self addSubview:self.mainLabel];
}
- (void) stylizeForBrushWidthCell
{
    self.colorView = [[UIView alloc] initWithFrame:CGRectMake(10.0, 0.0, 110.0, 0.0)];
    self.colorView.backgroundColor = [UIColor clearColor];
    [self addSubview:self.colorView];
}
- (void) stylizeForLabelFontCell
{
    self.mainLabel = [[UILabel alloc] initWithFrame:CGRectMake(10.0, 0.0, 120.0, 25.0)];
    self.mainLabel.backgroundColor = [UIColor clearColor];
    self.mainLabel.textColor = DESIGN_MENU_SUBMENU_VALUES_COLOR;
    [self addSubview:self.mainLabel];
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
- (void) setWidthForBrushView:(CGFloat)brushViewWidth
{
    brushWidth = brushViewWidth;
    self.colorView.frame = CGRectMake(10.0, (26.0-brushWidth)*0.5, 110.0, brushWidth);
    self.colorView.backgroundColor = colorForColorView;
}
- (CGFloat) getWidthForBrushView
{
    return brushWidth;
}

- (void) stylizeForSizeCell
{
    
}
- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    self.backgroundColor = [UIColor clearColor];
    [super setSelected:selected animated:animated];
    [self.seperatorView setBackgroundColor:[UIColor clearColor]];
    [self.colorView setBackgroundColor:colorForColorView];
    // Configure the view for the selected state
}
- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
    self.backgroundColor = [UIColor clearColor];
    [super setHighlighted:highlighted animated:animated];
    [self.seperatorView setBackgroundColor:[UIColor clearColor]];
    [self.colorView setBackgroundColor:colorForColorView];
}
- (void) setFrame:(CGRect)frame
{
    [super setFrame:frame];
    [self.seperatorView setFrame:CGRectMake(0.0, self.frame.size.height-1.0, self.frame.size.width, 1.0)];
}
@end
