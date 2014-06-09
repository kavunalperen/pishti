//
//  PSModelCanvas.m
//  Pishti
//
//  Created by Alperen Kavun on 17.05.2014.
//  Copyright (c) 2014 pishti. All rights reserved.
//

#import "PSModelCanvas.h"

@implementation PSModelCanvas

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        self.layer.shadowOffset = CGSizeMake(6.0, 6.0);
        self.layer.shadowColor = [UIColor blackColor].CGColor;
        self.layer.shadowRadius = 7.0;
        self.layer.shadowOpacity = 0.31;
//        self.layer.shouldRasterize = YES;
//        self.layer.rasterizationScale = SCREEN_SCALE;
//        self.layer.shadowPath = [[UIBezierPath alloc] init].CGPath;
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    
    // body drawing
    UIBezierPath* path = [[UIBezierPath alloc] init];
    [path setLineWidth:1.0];
    [path moveToPoint:CGPointMake(148.0, 130.0)];
    [path addCurveToPoint:CGPointMake(176.0, 332.0) controlPoint1:CGPointMake(159.0, 158.0) controlPoint2:CGPointMake(176.0, 267.0)];
    [path addCurveToPoint:CGPointMake(170.0, 670.0) controlPoint1:CGPointMake(185.0, 332.0) controlPoint2:CGPointMake(225.0, 375.0)];
    [path addCurveToPoint:CGPointMake(577.0, 670.0) controlPoint1:CGPointMake(188.0, 705.0) controlPoint2:CGPointMake(559.0, 705.0)];
    [path addCurveToPoint:CGPointMake(571.0, 332.0) controlPoint1:CGPointMake(523.0, 375.0) controlPoint2:CGPointMake(562.0, 332.0)];
    [path addCurveToPoint:CGPointMake(600.0, 130.0) controlPoint1:CGPointMake(571.0, 267.0) controlPoint2:CGPointMake(588.0, 158.0)];
    [path addCurveToPoint:CGPointMake(447.0, 64.0) controlPoint1:CGPointMake(533.0, 106.0) controlPoint2:CGPointMake(479.0, 77.0)];
    [path addCurveToPoint:CGPointMake(301.0, 64.0) controlPoint1:CGPointMake(425.0, 109.0) controlPoint2:CGPointMake(323.0, 109.0)];
    [path addCurveToPoint:CGPointMake(148.0, 130.0) controlPoint1:CGPointMake(279.0, 77.0) controlPoint2:CGPointMake(215.0, 106.0)];
    [path closePath];
    
    // left arm
    UIBezierPath* path2 = [[UIBezierPath alloc] init];
    [path2 setLineWidth:1.0];
    [path2 moveToPoint:CGPointMake(148.0, 130.0)];
    [path2 addCurveToPoint:CGPointMake(48.0, 322.0) controlPoint1:CGPointMake(127.0, 141.0) controlPoint2:CGPointMake(64.0, 284.0)];
    [path2 addCurveToPoint:CGPointMake(155.0, 366.0) controlPoint1:CGPointMake(65.0, 340.0) controlPoint2:CGPointMake(132.0, 365.0)];
    [path2 addCurveToPoint:CGPointMake(176.0, 332.0) controlPoint1:CGPointMake(154.0, 322.0) controlPoint2:CGPointMake(164.0, 331.0)];
    [path2 addCurveToPoint:CGPointMake(148.0, 130.0) controlPoint1:CGPointMake(176.0, 267.0) controlPoint2:CGPointMake(159.0, 158.0)];
    [path2 closePath];
    
    // right arm
    UIBezierPath* path3 = [[UIBezierPath alloc] init];
    [path3 setLineWidth:1.0];
    [path3 moveToPoint:CGPointMake(600.0, 130.0)];
    [path3 addCurveToPoint:CGPointMake(699.0, 322.0) controlPoint1:CGPointMake(621.0, 141.0) controlPoint2:CGPointMake(683.0, 284.0)];
    [path3 addCurveToPoint:CGPointMake(593.0, 366.0) controlPoint1:CGPointMake(683.0, 340.0) controlPoint2:CGPointMake(616.0, 365.0)];
    [path3 addCurveToPoint:CGPointMake(571.0, 332.0) controlPoint1:CGPointMake(594.0, 322.0) controlPoint2:CGPointMake(584.0, 332.0)];
    [path3 addCurveToPoint:CGPointMake(600.0, 130.0) controlPoint1:CGPointMake(571.0, 267.0) controlPoint2:CGPointMake(588.0, 158.0)];
    [path3 closePath];
    
    UIBezierPath* shadowPath = [[UIBezierPath alloc] init];
    [shadowPath appendPath:path];
    [shadowPath appendPath:path2];
    [shadowPath appendPath:path3];
    self.layer.shadowPath = shadowPath.CGPath;
    
    // color operations
    if (self.fillColor != nil) {
        [self.fillColor setFill];
    } else {
        [[UIColor blueColor] setFill];
    }
    if (self.strokeColor != nil) {
        [self.strokeColor setStroke];
    } else {
        [[UIColor redColor] setStroke];
    }
    [path fill];
//    [path stroke];
    
    [path2 fill];
//    [path2 stroke];
    
    [path3 fill];
//    [path3 stroke];
}

@end
