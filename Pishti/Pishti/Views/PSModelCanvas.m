//
//  PSModelCanvas.m
//  Pishti
//
//  Created by Alperen Kavun on 17.05.2014.
//  Copyright (c) 2014 pishti. All rights reserved.
//

#import "PSModelCanvas.h"
#import "Util.h"

@implementation PSModelCanvas
{
    BOOL isBrushing;
    int brushIndex;
    
    CGPoint previousPoint1;
    CGPoint previousPoint2;
    CGPoint currentTouch;
    UIImage *touchDraw;
    
    BOOL mouseSwiped;
    CGPoint lastPoint;
    
    UIImage* image;
}
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
        
        self.brushes = [NSMutableDictionary new];
        
        isBrushing = NO;
        brushIndex = 0;
        
        self.userInteractionEnabled = YES;
        
        image = [UIImage new];
        [self addSubview:[[UIImageView alloc] initWithImage:image]];
        
    }
    return self;
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    
    if (!_isBrushActive) {
        return;
    }
    
    UITouch* touch = [touches anyObject];
    
    CGPoint location = [touch locationInView:self];
    
    NSDictionary* touchDictionary = @{@"x":[NSNumber numberWithFloat:location.x],
                                      @"y":[NSNumber numberWithFloat:location.y]};
    
    NSMutableArray* touchesArray = @[touchDictionary].mutableCopy;
    
    NSDictionary* aBrush = @{@"points":touchesArray,
                             @"color":self.brushColor,
                             @"width":[NSNumber numberWithFloat:self.brushWidth]};
    
    [self.brushes setObject:aBrush forKey:[NSString stringWithFormat:@"%d",brushIndex]];
    
    isBrushing = YES;
    
    [self setNeedsDisplay];
    
}
- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesMoved:touches withEvent:event];
    
    if (!_isBrushActive) {
        return;
    }
    
    if (isBrushing) {
        
        NSMutableArray* touchesArray = [[self.brushes objectForKey:[NSString stringWithFormat:@"%d",brushIndex]] objectForKey:@"points"];
        
        if (touchesArray != nil) {
            
            UITouch* touch = [touches anyObject];
            
            CGPoint location = [touch locationInView:self];
            
            NSDictionary* touchDictionary = @{@"x":[NSNumber numberWithFloat:location.x],
                                              @"y":[NSNumber numberWithFloat:location.y]};
            
            [touchesArray addObject:touchDictionary];
        }
    }
    
    [self setNeedsDisplay];
}
- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    
    if (!_isBrushActive) {
        return;
    }
    
    if (isBrushing) {
        
        NSMutableArray* touchesArray = [[self.brushes objectForKey:[NSString stringWithFormat:@"%d",brushIndex]] objectForKey:@"points"];
        
        if (touchesArray != nil) {
            
            UITouch* touch = [touches anyObject];
            
            CGPoint location = [touch locationInView:self];
            
            NSDictionary* touchDictionary = @{@"x":[NSNumber numberWithFloat:location.x],
                                              @"y":[NSNumber numberWithFloat:location.y]};
            
            [touchesArray addObject:touchDictionary];
        }
        
        isBrushing = NO;
        brushIndex++;
    }
    
    [self setNeedsDisplay];
}
- (void) touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesCancelled:touches withEvent:event];
    
    if (!_isBrushActive) {
        return;
    }
    
    if (isBrushing) {
        [self.brushes removeObjectForKey:[NSString stringWithFormat:@"%d",brushIndex]];
        
        isBrushing = NO;
    }
    [self setNeedsDisplay];
}
CGPoint midPoint(CGPoint p1,CGPoint p2)
{
    return CGPointMake ((p1.x + p2.x) * 0.5,(p1.y + p2.y) * 0.5);
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
    [path2 fill];
    [path3 fill];
    
//    for (NSArray* brush in [self.brushes allValues]) {
//        
//        UIBezierPath* brushPath = [[UIBezierPath alloc] init];
//        [brushPath setLineWidth:8.0];
//        [brushPath setLineJoinStyle:kCGLineJoinRound];
//        [brushPath setLineCapStyle:kCGLineCapRound];
//        
//        [brushPath moveToPoint:CGPointMake([[brush[0] objectForKey:@"x"] floatValue],
//                                          [[brush[0] objectForKey:@"y"] floatValue])];
//        
//        for (int i = 1; i < brush.count; i++) {
//            
//            CGFloat x = [[brush[i] objectForKey:@"x"] floatValue];
//            CGFloat y = [[brush[i] objectForKey:@"y"] floatValue];
//        
//            [brushPath addLineToPoint:CGPointMake(x, y)];
//            
//        }
//        [self.brushColor setStroke];
//        [brushPath stroke];
//    }
    
//    for (NSDictionary* aBrush in [self.brushes allValues]) {
    
    NSArray* allKeys = [[self.brushes allKeys] sortedArrayUsingComparator:^NSComparisonResult(NSString* obj1, NSString* obj2) {
        if ([obj1 integerValue] < [obj2 integerValue]) {
            return NSOrderedAscending;
        } else if ([obj1 integerValue] == [obj2 integerValue]) {
            return NSOrderedSame;
        } else {
            return NSOrderedDescending;
        }
    }];
    
    for (int i = 0; i < allKeys.count; i++) {
        
        NSDictionary* aBrush = [self.brushes objectForKey:[allKeys objectAtIndex:i]];
        
        NSArray* brush = [aBrush objectForKey:@"points"];
        
        UIBezierPath* brushPath = [[UIBezierPath alloc] init];
        [brushPath setLineWidth:[[aBrush objectForKey:@"width"] floatValue]];
        [brushPath setLineJoinStyle:kCGLineJoinRound];
        [brushPath setLineCapStyle:kCGLineCapRound];

        [brushPath moveToPoint:CGPointMake([[brush[0] objectForKey:@"x"] floatValue],
                                          [[brush[0] objectForKey:@"y"] floatValue])];

        for (int i = 1; i < brush.count; i++) {

            CGFloat x = [[brush[i] objectForKey:@"x"] floatValue];
            CGFloat y = [[brush[i] objectForKey:@"y"] floatValue];

            [brushPath addLineToPoint:CGPointMake(x, y)];

        }
        [[aBrush objectForKey:@"color"] setStroke];
        [brushPath stroke];
    }
    
}

@end
