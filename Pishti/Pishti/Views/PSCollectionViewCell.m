//
//  PSCollectionViewCell.m
//  Pishti
//
//  Created by Alperen Kavun on 20.11.2014.
//  Copyright (c) 2014 pishti. All rights reserved.
//

#import "PSCollectionViewCell.h"
#import "PSCommons.h"

@implementation PSCollectionViewCell

- (id) initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self initMainComponents];
    }
    
    return self;
}

- (void) initMainComponents
{
    self.backgroundColor = [UIColor whiteColor];
    self.layer.borderWidth = 1.0;
    self.layer.borderColor = DESIGN_MENU_SUBMENU_IMAGE_GALLERY_BORDER_COLOR.CGColor;
    
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, 110.0, 93.0)];
    self.imageView.contentMode = UIViewContentModeScaleToFill;
    self.imageView.backgroundColor = [UIColor clearColor];
    [self addSubview:self.imageView];
}

@end
