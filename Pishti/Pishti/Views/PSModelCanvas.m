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
    
    UIBezierPath* modelPath;
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
        
        self.brushes = [NSMutableArray new];
        
        isBrushing = NO;
        brushIndex = 0;
        
        self.userInteractionEnabled = YES;
        
        [self drawModel];
    }
    return self;
}
- (void) drawModel
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
    
    modelPath = [[UIBezierPath alloc] init];
    [modelPath appendPath:path];
    [modelPath appendPath:path2];
    [modelPath appendPath:path3];
    
    UIBezierPath* shadowPath = [[UIBezierPath alloc] init];
    [shadowPath appendPath:path];
    [shadowPath appendPath:path2];
    [shadowPath appendPath:path3];
    self.layer.shadowPath = shadowPath.CGPath;
}
- (void) deleteLastOne
{
    if (brushIndex > 0) {
        brushIndex--;
        [self.brushes removeObjectAtIndex:brushIndex];
        [self setNeedsDisplay];
    }
}
- (void) deleteAll
{
    if (brushIndex > 0) {
        brushIndex = 0;
        self.brushes = [NSMutableArray new];
        [self setNeedsDisplay];
    }
}
- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    
    if (!_isBrushActive) {
        return;
    }
    
    UITouch* touch = [touches anyObject];
    
    CGPoint location = [touch locationInView:self];
    
    if (CGPathContainsPoint(modelPath.CGPath, NULL, location, NO)) {
    
        UIBezierPath* brushPath = [[UIBezierPath alloc] init];
        brushPath.miterLimit = -30.0;
        [brushPath setLineWidth:self.brushWidth];
        [brushPath setLineJoinStyle:kCGLineJoinRound];
        [brushPath setLineCapStyle:kCGLineCapRound];
        
        [brushPath moveToPoint:location];
        
        CGFloat red, blue,green;
        [self.brushColor getRed:&red green:&green blue:&blue alpha:nil];
        UIColor* brushColor = [UIColor colorWithRed:red green:green blue:blue alpha:self.brushOpacity];;
        
        if (self.brushType == BRUSH_TYPE_PATTERN_COLOR) {
            
            UIImage* patternImage = [[Util sharedInstance] maskedImageNamed:self.patternImageName color:brushColor];
            
            brushColor = [UIColor colorWithPatternImage:patternImage];
        }
        
        NSDictionary* aBrush = @{@"brush":brushPath,
                                 @"stroke":brushColor};
        
        [self.brushes addObject:aBrush];
        
        isBrushing = YES;
    }
    
    [self setNeedsDisplay];
    
}
- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesMoved:touches withEvent:event];
    
    if (!_isBrushActive) {
        return;
    }
    
    UITouch* touch = [touches anyObject];
    
    CGPoint location = [touch locationInView:self];
    
    if (isBrushing) {
        
        if (CGPathContainsPoint(modelPath.CGPath, NULL, location, NO)) {
            UIBezierPath* brushPath = [[self.brushes objectAtIndex:brushIndex] objectForKey:@"brush"];
            [brushPath addLineToPoint:location];
        } else {
            isBrushing = NO;
            brushIndex++;
        }
    } else {
        if (CGPathContainsPoint(modelPath.CGPath, NULL, location, NO)) {
            
            UIBezierPath* brushPath = [[UIBezierPath alloc] init];
            brushPath.miterLimit = -30.0;
            [brushPath setLineWidth:self.brushWidth];
            [brushPath setLineJoinStyle:kCGLineJoinRound];
            [brushPath setLineCapStyle:kCGLineCapRound];
            
            [brushPath moveToPoint:location];
            
            CGFloat red, blue,green;
            [self.brushColor getRed:&red green:&green blue:&blue alpha:nil];
            UIColor* brushColor = [UIColor colorWithRed:red green:green blue:blue alpha:self.brushOpacity];;
            
            if (self.brushType == BRUSH_TYPE_PATTERN_COLOR) {
                
                UIImage* patternImage = [[Util sharedInstance] maskedImageNamed:self.patternImageName color:brushColor];
                
                brushColor = [UIColor colorWithPatternImage:patternImage];
            }
            
            NSDictionary* aBrush = @{@"brush":brushPath,
                                     @"stroke":brushColor};
            
            [self.brushes addObject:aBrush];
            
            isBrushing = YES;
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
    
    UITouch* touch = [touches anyObject];
    
    CGPoint location = [touch locationInView:self];
    
    if (isBrushing) {
        
        if (CGPathContainsPoint(modelPath.CGPath, NULL, location, NO)) {
            UIBezierPath* brushPath = [[self.brushes objectAtIndex:brushIndex] objectForKey:@"brush"];
            [brushPath addLineToPoint:location];
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
        [self.brushes removeObjectAtIndex:brushIndex];
        isBrushing = NO;
    }
    [self setNeedsDisplay];
}

CGPoint midPoint(CGPoint p1,CGPoint p2)
{
    return CGPointMake ((p1.x + p2.x) * 0.5,(p1.y + p2.y) * 0.5);
}

- (void)drawRect:(CGRect)rect
{
    // color operations
    if (self.fillColor != nil) {
        [self.fillColor setFill];
    } else {
        [[UIColor blueColor] setFill];
    }
    
    [modelPath fill];
    
    for (int i = 0; i < self.brushes.count; i++) {
        
        NSDictionary* brushDict = [self.brushes objectAtIndex:i];
        
        UIBezierPath* brushPath = [brushDict objectForKey:@"brush"];
        [[brushDict objectForKey:@"stroke"] setStroke];
        
        [brushPath stroke];
    }
}


//NSArray* allKeys = [[self.brushes allKeys] sortedArrayUsingComparator:^NSComparisonResult(NSString* obj1, NSString* obj2) {
//    if ([obj1 integerValue] < [obj2 integerValue]) {
//        return NSOrderedAscending;
//    } else if ([obj1 integerValue] == [obj2 integerValue]) {
//        return NSOrderedSame;
//    } else {
//        return NSOrderedDescending;
//    }
//}];
//
//for (int i = 0; i < allKeys.count; i++) {
//    
//    NSDictionary* aBrush = [self.brushes objectForKey:[allKeys objectAtIndex:i]];
//    
//    NSArray* brush = [aBrush objectForKey:@"points"];
//    
//    UIBezierPath* brushPath = [[UIBezierPath alloc] init];
//    brushPath.miterLimit = -30.0;
//    [brushPath setLineWidth:[[aBrush objectForKey:@"width"] floatValue]];
//    [brushPath setLineJoinStyle:kCGLineJoinRound];
//    [brushPath setLineCapStyle:kCGLineCapRound];
//    
//    [brushPath moveToPoint:CGPointMake([[brush[0] objectForKey:@"x"] floatValue],
//                                       [[brush[0] objectForKey:@"y"] floatValue])];
//    
//    for (int i = 1; i < brush.count; i++) {
//        
//        CGFloat x = [[brush[i] objectForKey:@"x"] floatValue];
//        CGFloat y = [[brush[i] objectForKey:@"y"] floatValue];
//        
//        [brushPath addLineToPoint:CGPointMake(x, y)];
//        
//    }
//    UIColor* originalColor = [aBrush objectForKey:@"color"];
//    CGFloat red, blue,green;
//    [originalColor getRed:&red green:&green blue:&blue alpha:nil];
//    UIColor* brushColor = [UIColor colorWithRed:red green:green blue:blue alpha:[[aBrush objectForKey:@"opacity"] floatValue]];
//    
//    UIImage* patternImage = [[Util sharedInstance] maskedImageNamed:@"brush2_disi.png" color:brushColor];
//    
//    [[UIColor colorWithPatternImage:patternImage] setStroke];
//    
//    [brushPath stroke];
//}


@end