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
//-(CGRect)textRectForBounds:(CGRect)bounds{
//    
//    CGRect rect = bounds;
//    rect.size.width = rect.size.width;
//    return rect;
//}
//- (CGRect)textRectForBounds:(CGRect)bounds {
//    int leftMargin = 0.0;
//    CGRect inset = CGRectMake(bounds.origin.x + leftMargin, bounds.origin.y, bounds.size.width - leftMargin, bounds.size.height);
//    return inset;
//}
//
//- (CGRect)editingRectForBounds:(CGRect)bounds {
//    int leftMargin = 0.0;
//    CGRect inset = CGRectMake(bounds.origin.x + leftMargin, bounds.origin.y, bounds.size.width - leftMargin, bounds.size.height);
//    return inset;
//}
- (void) drawTextInRect:(CGRect)rect
{
    NSMutableParagraphStyle *paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    /// Set line break mode
    paragraphStyle.lineBreakMode = NSLineBreakByClipping;
    /// Set text alignment
    paragraphStyle.alignment = self.textAlignment;
    
    NSMutableDictionary* attrs = @{NSParagraphStyleAttributeName:paragraphStyle,
                                   NSFontAttributeName:self.font,
                                   NSForegroundColorAttributeName:self.textColor}.mutableCopy;
    
    [[self text] drawInRect:rect withAttributes:attrs];
}
@end
