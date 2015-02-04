//
//  PSTemplateTextField.m
//  Pishti
//
//  Created by Alperen Kavun on 21.11.2014.
//  Copyright (c) 2014 pishti. All rights reserved.
//

#import "PSTemplateTextField.h"
#import "PSCommons.h"

@implementation PSTemplateTextField

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (CGRect)textRectForBounds:(CGRect)bounds {
    int leftMargin = 15.0;
    CGRect inset = CGRectMake(bounds.origin.x + leftMargin, bounds.origin.y, bounds.size.width - leftMargin, bounds.size.height);
    return inset;
}

- (CGRect)editingRectForBounds:(CGRect)bounds {
    int leftMargin = 15.0;
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
    
    NSMutableDictionary* attrs = @{NSParagraphStyleAttributeName:paragraphStyle,
                                   NSForegroundColorAttributeName:DESIGN_MENU_SUBMENU_TEMPLATE_TEXT_FIELD_PLACEHOLDER_COLOR}.mutableCopy;
    if (self.currentFont != nil) {
        [attrs setObject:self.currentFont forKey:NSFontAttributeName];
    }
    
    [[self placeholder] drawInRect:CGRectMake(rect.origin.x, rect.origin.y+15.0, rect.size.width, rect.size.height-30.0) withAttributes:attrs];
}
@end
