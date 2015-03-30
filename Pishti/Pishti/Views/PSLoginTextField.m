//
//  PSLoginTextField.m
//  Pishti
//
//  Created by Alperen Kavun on 30/03/15.
//  Copyright (c) 2015 pishti. All rights reserved.
//

#import "PSLoginTextField.h"
#import "PSCommons.h"

@implementation PSLoginTextField

- (id) initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.font = LOGIN_VIEW_TEXT_FIELDS_FONT;
        self.textColor = LOGIN_VIEW_TEXT_FIELDS_TEXT_COLOR;
        self.tintColor = LOGIN_VIEW_TEXT_FIELDS_TEXT_COLOR;
        
        self.clipsToBounds = YES;
        CALayer *bottomBorder = [CALayer layer];
        bottomBorder.borderColor = LOGIN_VIEW_TEXT_FIELDS_BORDER_COLOR.CGColor;
        bottomBorder.borderWidth = 1;
        bottomBorder.frame = CGRectMake(0.0, frame.size.height-1.0, frame.size.width, 1.0);
        [self.layer addSublayer:bottomBorder];
    }
    
    return self;
}

- (CGRect)textRectForBounds:(CGRect)bounds {
    int leftMargin = 5.0;
    CGRect inset = CGRectMake(bounds.origin.x + leftMargin, bounds.origin.y, bounds.size.width - leftMargin, bounds.size.height);
    return inset;
}

- (CGRect)editingRectForBounds:(CGRect)bounds {
    int leftMargin = 5.0;
    CGRect inset = CGRectMake(bounds.origin.x + leftMargin, bounds.origin.y, bounds.size.width - leftMargin, bounds.size.height);
    return inset;
}

- (void) drawPlaceholderInRect:(CGRect)rect
{
    NSMutableParagraphStyle *paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    /// Set line break mode
    paragraphStyle.lineBreakMode = NSLineBreakByClipping;
    /// Set text alignment
    paragraphStyle.alignment = self.textAlignment;
    
    [[self placeholder] drawInRect:CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, rect.size.height) withAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                                                                                                         paragraphStyle, NSParagraphStyleAttributeName,
                                                                                                                                         LOGIN_VIEW_TEXT_FIELDS_FONT, NSFontAttributeName,
                                                                                                                                         LOGIN_VIEW_TEXT_FIELDS_PLACEHOLDER_COLOR, NSForegroundColorAttributeName,
                                                                                                                                         nil]];
}

@end
