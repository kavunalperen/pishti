//
//  PSAddressTableViewCell.m
//  Pishti
//
//  Created by Alperen Kavun on 18/04/15.
//  Copyright (c) 2015 pishti. All rights reserved.
//

#import "PSAddressTableViewCell.h"
#import "PSCommons.h"
#import "Util.h"

#define     CellWidth       SCREEN_SIZE.width-90.0
#define     LabelsHeight    38.0

@implementation PSAddressTableViewCell

- (CGRect) addressTitleFrame
{
    return CGRectMake(0.0, 20.0, 220.0, 38.0);
}
- (CGRect) addressFrame
{
    return CGRectMake(0.0, 20.0, 100.0, 38.0);
}
- (CGRect) addressCityFrame
{
    return CGRectMake(0.0, 67.0, 220.0, 38.0);
}

- (CGRect) addressCountyFrame
{
    return CGRectMake(229.0, 67.0, 220.0, 38.0);
}

- (CGRect) updateButtonFrame
{
    return CGRectMake(458.0, 67.0, 220.0, 38.0);
}

- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self commonInitializer];
        if ([reuseIdentifier isEqualToString:AddressTableViewCellIdentifier]) {
            [self stylizeForAddressCell];
        }
    }
    
    return self;
}

- (void) commonInitializer
{
    [self setBackgroundView:[UIView new]];
    [self setSelectedBackgroundView:[UIView new]];
    
    self.accessoryType = UITableViewCellAccessoryNone;
    
    self.backgroundColor = [UIColor clearColor];
}

- (void) stylizeForAddressCell
{
    self.updateButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.updateButton.frame = [self updateButtonFrame];
    self.updateButton.titleLabel.font = PROFILE_VIEW_UPDATE_BUTTON_FONT;
    [self.updateButton setBackgroundImage:[[Util sharedInstance] UIImageWithUIColor:PROFILE_VIEW_UPDATE_BUTTON_NORMAL_COLOR] forState:UIControlStateNormal];
    [self.updateButton setBackgroundImage:[[Util sharedInstance] UIImageWithUIColor:PROFILE_VIEW_UPDATE_BUTTON_HIGHLIGHTED_COLOR] forState:UIControlStateHighlighted];
    [self.updateButton setTitleColor:PROFILE_VIEW_UPDATE_BUTTON_TITLE_NORMAL_COLOR forState:UIControlStateNormal];
    [self.updateButton setTitleColor:PROFILE_VIEW_UPDATE_BUTTON_TITLE_HIGHLIGHTED_COLOR forState:UIControlStateHighlighted];
    [self.updateButton setTitle:@"GÜNCELLE" forState:UIControlStateNormal];
    [self.updateButton addTarget:self action:@selector(updateAddress) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.updateButton];
}

- (PSLabel*) createLabelWithFrame:(CGRect)frame isTitle:(BOOL)isTitle
{
    PSLabel* label = [[PSLabel alloc] initWithFrame:frame];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = ADDRESS_CELL_LABEL_COLORS;
    if (isTitle) {
        label.font = ADDRESS_CELL_TITLE_FONT;
    } else {
        label.font = ADDRESS_CELL_LABELS_FONT;
    }
    
    return label;
}

- (void) customizeWithCurrentAddress
{
    self.addressTitle = [self createLabelWithFrame:[self addressTitleFrame] isTitle:YES];
    [self addSubview:self.addressTitle];
    
    self.address = [self createLabelWithFrame:[self addressFrame] isTitle:NO];
    [self addSubview:self.address];
    
    self.addressCity = [self createLabelWithFrame:[self addressCityFrame] isTitle:NO];
    [self addSubview:self.addressCity];
    
    self.addressCounty = [self createLabelWithFrame:[self addressCountyFrame] isTitle:NO];
    [self addSubview:self.addressCounty];
    
    NSString* addressTitle = [NSString stringWithFormat:@"%@: ", [self.currentAddress objectForKey:@"addressTitle"]];
    NSString* address = [self.currentAddress objectForKey:@"address"];
    
    CGRect titleFrame = self.addressTitle.frame;
    CGSize titleSize = [[Util sharedInstance] text:addressTitle sizeWithFont:ADDRESS_CELL_TITLE_FONT constrainedToSize:CGSizeMake(1000.0, 38.0)];
    titleFrame.size.width = titleSize.width+10.0;
    self.addressTitle.frame = titleFrame;
    
    CGRect addressFrame = self.address.frame;
    addressFrame.size.width = CellWidth-titleSize.width-10.0;
    addressFrame.origin.x = titleSize.width;
    self.address.frame = addressFrame;
    
    self.addressTitle.text = addressTitle;
    self.address.text = address;
    self.addressCity.text = [self.currentAddress objectForKey:@"addressCity"];
    self.addressCounty.text = [self.currentAddress objectForKey:@"addressCounty"];
    
    [self addBorderBottomToView:self.addressTitle withColor:PROFILE_VALUES_BORDER_COLOR withHeight:1.0];
    [self addBorderBottomToView:self.address withColor:PROFILE_VALUES_BORDER_COLOR withHeight:1.0];
    [self addBorderBottomToView:self.addressCity withColor:PROFILE_VALUES_BORDER_COLOR withHeight:1.0];
    [self addBorderBottomToView:self.addressCounty withColor:PROFILE_VALUES_BORDER_COLOR withHeight:1.0];
}
- (void) addBorderBottomToView:(UIView*)view withColor:(UIColor*)color withHeight:(CGFloat)height
{
    CGRect frame = view.frame;
    CALayer* bottomBorder = [CALayer layer];
    bottomBorder.borderColor = color.CGColor;
    bottomBorder.borderWidth = height;
    bottomBorder.frame = CGRectMake(0.0, frame.size.height-height, frame.size.width, height);
    [view.layer addSublayer:bottomBorder];
}
- (void) updateAddress
{
    [[NSNotificationCenter defaultCenter] postNotificationName:AddressWillBeUpdatedNotification object:self.currentAddress];
}
- (void) prepareForReuse
{
    [self.addressTitle removeFromSuperview];
    self.addressTitle = nil;
    [self.address removeFromSuperview];
    self.address = nil;
    [self.addressCity removeFromSuperview];
    self.addressCity = nil;
    [self.addressCounty removeFromSuperview];
    self.addressCounty = nil;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
