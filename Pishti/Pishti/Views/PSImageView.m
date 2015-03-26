//
//  PSImageView.m
//  Pishti
//
//  Created by Alperen Kavun on 4.07.2014.
//  Copyright (c) 2014 pishti. All rights reserved.
//

#import "PSImageView.h"
#import "Util.h"
#import "PSSubmenuManager.h"

@implementation PSImageView

- (id) initWithCenter:(CGPoint)center
{
    if (self = [super init]) {
        self.backgroundColor = [UIColor clearColor];
        self.center = center;
        self.originalSize = CGSizeZero;
        self.originalCenter = center;
    }
    
    return self;
}
- (void) configureImageWithSettings
{
    CGFloat opacity = [[_imageSettings objectForKey:IMAGE_OPACITY_KEY] floatValue];
    
    self.alpha = opacity;
    
    if (CGSizeEqualToSize(self.originalSize, CGSizeZero)) {
        self.originalSize = self.frame.size;
    }
}

@end
