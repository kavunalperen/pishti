//
//  PSSlider.m
//  Pishti
//
//  Created by Alperen Kavun on 24.10.2014.
//  Copyright (c) 2014 pishti. All rights reserved.
//

#import "PSSlider.h"
#import "PSCommons.h"
#import "PSSubmenuManager.h"

@implementation PSSlider

- (id) initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setThumbImage:[UIImage imageNamed:@"slider_bullet_normal.png"] forState:UIControlStateNormal];
        [self setThumbImage:[UIImage imageNamed:@"slider_bullet_highlighted.png"] forState:UIControlStateHighlighted];
        [self setMinimumTrackImage:[UIImage imageNamed:@"slider_loader.png"] forState:UIControlStateNormal];
        [self setMaximumTrackImage:[UIImage imageNamed:@"slider_holder.png"] forState:UIControlStateHighlighted];
        [self addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
        [self addTooltip];
    }
    
    return self;
}
- (void) addTooltip
{
    self.tooltip = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, -7.0, 26.0, 22.0)];
    self.tooltip.backgroundColor = [UIColor clearColor];
    self.tooltip.image = [UIImage imageNamed:@"slider_tooltip_2.png"];
    [self addSubview:self.tooltip];
    
    self.tooltipLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 26.0, 17.0)];
    self.tooltipLabel.backgroundColor = [UIColor clearColor];
    self.tooltipLabel.font = DESIGN_MENU_SUBMENU_SLIDER_FONT;
    self.tooltipLabel.textColor = DESIGN_MENU_SUBMENU_SLIDER_TEXT_COLOR;
    self.tooltipLabel.text = @"0";
    self.tooltipLabel.textAlignment = NSTextAlignmentCenter;
    [self.tooltip addSubview:self.tooltipLabel];
}
- (void) valueChanged:(UISlider*)slider
{
    [self updateTooltipPositionAndValue:slider.value];
    [[PSSubmenuManager sharedInstance] sliderValueChanged:self];
}
- (void) setSliderValue:(CGFloat)value
{
    self.value = value;
    [self updateTooltipPositionAndValue:value];
}
- (void) updateTooltipPositionAndValue:(CGFloat)value
{
    int valueInt = (int)(roundf(value*100.0));
    
    self.tooltipLabel.text = [NSString stringWithFormat:@"%d",valueInt];
    
    self.tooltip.center = CGPointMake([self xPositionFromSliderValue:self]-7.0, self.tooltip.center.y);
}
- (float)xPositionFromSliderValue:(UISlider *)aSlider;
{
    float sliderRange = aSlider.frame.size.width - aSlider.currentThumbImage.size.width;
    float sliderOrigin = aSlider.frame.origin.x + (aSlider.currentThumbImage.size.width/2.0);

    float sliderValueToPixels = (aSlider.value/aSlider.maximumValue * sliderRange) + sliderOrigin;

    return sliderValueToPixels;
}

@end
