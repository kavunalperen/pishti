//
//  PSLabel.m
//  Pishti
//
//  Created by Alperen Kavun on 23.10.2014.
//  Copyright (c) 2014 pishti. All rights reserved.
//

#import "PSLabel.h"

@implementation PSLabel

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)drawTextInRect:(CGRect)rect {
    UIEdgeInsets insets = {0.0, 10.0, 0.0, 0.0};
    return [super drawTextInRect:UIEdgeInsetsInsetRect(rect, insets)];
}

@end
