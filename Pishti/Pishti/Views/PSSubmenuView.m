//
//  PSSubmenuView.m
//  Pishti
//
//  Created by Alperen Kavun on 26.10.2014.
//  Copyright (c) 2014 pishti. All rights reserved.
//

#import "PSSubmenuView.h"
#import "PSCommons.h"
#import "PSSubmenuManager.h"

@implementation PSSubmenuView

- (id) initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = SUBMENU_BACKGROUND_COLOR;
        
        UIImageView* shadowView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, -9.0, 768.0, 9.0)];
        shadowView.backgroundColor = [UIColor clearColor];
        UIImage* shadowImage = [UIImage imageNamed:@"container_shadow.png"];
        shadowView.image = shadowImage;
        shadowView.alpha = 0.6;
        self.clipsToBounds = NO;
        [self addSubview:shadowView];
    }
    
    return self;
}
//-(BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
//{
//    if (self.textView != nil) {
//        
//        if (CGRectContainsPoint(self.textView.frame, point)) {
//            return YES;
//        }
//    }
//    
//    return [super pointInside:point withEvent:event];
//}
//- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
//{
//    CGFloat radius = 100.0;
//    CGRect frame = CGRectMake(-radius, -radius,
//                              self.frame.size.width + radius,
//                              self.frame.size.height + radius);
//    
//    if (CGRectContainsPoint(frame, point)) {
//        return self;
//    }
//    return nil;
//}
- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [[PSSubmenuManager sharedInstance] removeAnyTable];
}
- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    
}
- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    
}
- (void) touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    
}
@end
