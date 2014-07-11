//
//  PSTextView.m
//  Pishti
//
//  Created by Alperen Kavun on 4.07.2014.
//  Copyright (c) 2014 pishti. All rights reserved.
//

#import "PSTextView.h"

@implementation PSTextView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        self.textContainer.lineFragmentPadding = 0;
        self.textContainerInset = UIEdgeInsetsZero;
        self.scrollEnabled = NO;
        self.selectable = NO;
        self.editable = NO;
        self.autocorrectionType = UITextAutocorrectionTypeNo;
        self.autocapitalizationType = UITextAutocapitalizationTypeNone;
    }
    return self;
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    
    
}
//- (BOOL) pointInside:(CGPoint)point withEvent:(UIEvent *)event
//{
//    if (!CGRectContainsPoint(self.bounds, point)) {
//        return NO;
//    } else {
//        return YES;
//    }
//}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
