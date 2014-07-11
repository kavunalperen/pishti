//
//  PSModelCanvas.m
//  Pishti
//
//  Created by Alperen Kavun on 17.05.2014.
//  Copyright (c) 2014 pishti. All rights reserved.
//

#import "PSModelCanvas.h"
#import "Util.h"
#import <QuartzCore/QuartzCore.h>

@implementation PSModelCanvas
{
    BOOL isBrushing;
    int brushIndex;
    
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
        self.allLabels = [NSMutableArray new];
        self.allImages = [NSMutableArray new];
        
        isBrushing = NO;
        brushIndex = 0;
        
        self.userInteractionEnabled = YES;
        self.multipleTouchEnabled = NO;
        
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
- (BOOL) pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    BOOL isInside = NO;
    if (CGRectContainsPoint(self.bounds, point)) {
        for (UITextView* textView in self.allLabels) {
            CGPoint p = [textView convertPoint:point fromView:self];
            if (CGRectContainsPoint(textView.bounds, p) && textView == self.selectedTextView) {
                isInside = YES;
            }
        }
        if (self.isBrushActive) {
            isInside = YES;
        }
    }

    return isInside;
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    
    if (!self.isBrushActive) {
        return;
    }
    
    UITouch* touch = [touches anyObject];
    CGPoint p = [touch locationInView:self];
    
    if (CGPathContainsPoint(modelPath.CGPath, NULL, p, NO)) {
    
        NSDictionary* point = @{@"x":[NSNumber numberWithFloat:p.x],
                                @"y":[NSNumber numberWithFloat:p.y]};
        
        if (self.brushType == BRUSH_TYPE_BASIC_COLOR) {
            
            NSDictionary* aBrush = @{@"points":@[point].mutableCopy,
                                     @"type":[NSNumber numberWithInteger:self.brushType],
                                     @"width":[NSNumber numberWithFloat:self.brushWidth],
                                     @"color":self.brushColor,
                                     @"opacity":[NSNumber numberWithFloat:self.brushOpacity]};
            
            [self.brushes addObject:aBrush];
            
        } else {
            UIImage* image = [[Util sharedInstance] prepareImageForBrushing:[UIImage imageNamed:self.patternImageName] andBrushWidth:self.brushWidth];
            image = [[Util sharedInstance] maskedImage:image color:self.brushColor];
            image = [[Util sharedInstance] image:image byApplyingAlpha:self.brushOpacity];
            
            
            NSDictionary* aBrush = @{@"points":@[point].mutableCopy,
                                     @"type":[NSNumber numberWithInteger:self.brushType],
                                     @"width":[NSNumber numberWithFloat:self.brushWidth],
                                     @"pattern":image};
            
            [self.brushes addObject:aBrush];
        }
        
        isBrushing = YES;
    }
    [self setNeedsDisplay];
}
- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesMoved:touches withEvent:event];
    NSLog(@"touches moved");
    
    if (!self.isBrushActive) {
        return;
    }
    
    UITouch* touch = [touches anyObject];
    CGPoint p = [touch locationInView:self];
    
    if (isBrushing) {
        
        if (CGPathContainsPoint(modelPath.CGPath, NULL, p, NO)) {
        
            NSDictionary* point = @{@"x":[NSNumber numberWithFloat:p.x],
                                    @"y":[NSNumber numberWithFloat:p.y]};
            
            NSMutableArray* points = [[self.brushes objectAtIndex:brushIndex] objectForKey:@"points"];
            [points addObject:point];
        } else {
            isBrushing = NO;
            brushIndex++;
        }
        
    } else {
        if (CGPathContainsPoint(modelPath.CGPath, NULL, p, NO)) {
            
            NSDictionary* point = @{@"x":[NSNumber numberWithFloat:p.x],
                                    @"y":[NSNumber numberWithFloat:p.y]};
            
            if (self.brushType == BRUSH_TYPE_BASIC_COLOR) {
                
                NSDictionary* aBrush = @{@"points":@[point].mutableCopy,
                                         @"type":[NSNumber numberWithInteger:self.brushType],
                                         @"width":[NSNumber numberWithFloat:self.brushWidth],
                                         @"color":self.brushColor,
                                         @"opacity":[NSNumber numberWithFloat:self.brushOpacity]};
                
                [self.brushes addObject:aBrush];
                
            } else {
                UIImage* image = [[Util sharedInstance] prepareImageForBrushing:[UIImage imageNamed:self.patternImageName] andBrushWidth:self.brushWidth];
                image = [[Util sharedInstance] maskedImage:image color:self.brushColor];
                image = [[Util sharedInstance] image:image byApplyingAlpha:self.brushOpacity];
                
                
                NSDictionary* aBrush = @{@"points":@[point].mutableCopy,
                                         @"type":[NSNumber numberWithInteger:self.brushType],
                                         @"width":[NSNumber numberWithFloat:self.brushWidth],
                                         @"pattern":image};
                
                [self.brushes addObject:aBrush];
            }
            
            isBrushing = YES;
        }
    }
    
    [self setNeedsDisplay];
}
- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    NSLog(@"touches ended");
    
    if (!self.isBrushActive) {
        return;
    }
    
    UITouch* touch = [touches anyObject];
    CGPoint p = [touch locationInView:self];
    
    if (isBrushing) {
        if (CGPathContainsPoint(modelPath.CGPath, NULL, p, NO)) {
            NSDictionary* point = @{@"x":[NSNumber numberWithFloat:p.x],
                                    @"y":[NSNumber numberWithFloat:p.y]};
            
            NSMutableArray* points = [[self.brushes objectAtIndex:brushIndex] objectForKey:@"points"];
            [points addObject:point];
        }
        
        isBrushing = NO;
        brushIndex++;
    }
    
    [self setNeedsDisplay];
}
- (void) touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self touchesEnded:touches withEvent:event];
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
    
    for (NSDictionary* aBrush in self.brushes) {
        
        if([[aBrush objectForKey:@"type"] integerValue] == BRUSH_TYPE_BASIC_COLOR) {
            UIBezierPath* aPath = [UIBezierPath bezierPath];
            [aPath setLineWidth:[[aBrush objectForKey:@"width"] floatValue]];
            [aPath setLineJoinStyle:kCGLineJoinRound];
            [aPath setLineCapStyle:kCGLineCapRound];
            
            NSMutableArray* points = [aBrush objectForKey:@"points"];
            for (int i = 0; i < points.count; i += 3) {
                int remaining = (int)((points.count-i)-1);
                if (remaining == 0) {
                    
                } else if (remaining == 1) {
                    [aPath moveToPoint:CGPointMake([points[i][@"x"] floatValue], [points[i][@"y"] floatValue])];
                    [aPath addLineToPoint:CGPointMake([points[i+1][@"x"] floatValue], [points[i+1][@"y"] floatValue])];
                } else if (remaining == 2) {
                    [aPath moveToPoint:CGPointMake([points[i][@"x"] floatValue], [points[i][@"y"] floatValue])];
                    [aPath addQuadCurveToPoint:CGPointMake([points[i+2][@"x"] floatValue], [points[i+2][@"y"] floatValue])
                                  controlPoint:CGPointMake([points[i+1][@"x"] floatValue], [points[i+1][@"y"] floatValue])];
                } else if (remaining == 3) {
                    [aPath moveToPoint:CGPointMake([points[i][@"x"] floatValue], [points[i][@"y"] floatValue])];
                    [aPath addCurveToPoint:CGPointMake([points[i+3][@"x"] floatValue], [points[i+3][@"y"] floatValue])
                             controlPoint1:CGPointMake([points[i+1][@"x"] floatValue], [points[i+1][@"y"] floatValue])
                             controlPoint2:CGPointMake([points[i+2][@"x"] floatValue], [points[i+2][@"y"] floatValue])];
                } else if (remaining >= 4) {
//                if (remaining >= 4) {
                    CGPoint mid = CGPointMake(([points[i+2][@"x"] floatValue]+[points[i+4][@"x"] floatValue])/2.0,
                                              ([points[i+2][@"y"] floatValue]+[points[i+4][@"y"] floatValue])/2.0);
                    points[i+3] = @{@"x":[NSNumber numberWithFloat:mid.x],
                                    @"y":[NSNumber numberWithFloat:mid.y]};
                    
                    [aPath moveToPoint:CGPointMake([points[i][@"x"] floatValue], [points[i][@"y"] floatValue])];
                    [aPath addCurveToPoint:CGPointMake([points[i+3][@"x"] floatValue], [points[i+3][@"y"] floatValue])
                             controlPoint1:CGPointMake([points[i+1][@"x"] floatValue], [points[i+1][@"y"] floatValue])
                             controlPoint2:CGPointMake([points[i+2][@"x"] floatValue], [points[i+2][@"y"] floatValue])];
                    
//                    points[i] = points[i+3];
//                    points[i+1] = points[i+4];
                }
            }
            UIColor* color = [aBrush objectForKey:@"color"];
            color = [color colorWithAlphaComponent:[[aBrush objectForKey:@"opacity"] floatValue]];
            [color setStroke];
            [aPath stroke];
//            CGContextRef context = UIGraphicsGetCurrentContext();
////            CGContextSetStrokeColorWithColor(context, [[UIColor whiteColor] CGColor]);
//            CGContextSetShadowWithColor(context, CGSizeMake(0.0, 0.0), 15.0, [color CGColor]);
//            CGContextDrawPath(context, kCGPathFill);
        } else {
            UIImage* brushTexture = [aBrush objectForKey:@"pattern"];
            
            NSMutableArray* points = [aBrush objectForKey:@"points"];
            for (int i = 0; i < points.count; i++) {
                if (i == 0) {
                    [brushTexture drawAtPoint:CGPointMake([points[i][@"x"] floatValue], [points[i][@"y"] floatValue])];
                } else {
                    CGPoint vector = CGPointMake([points[i][@"x"] floatValue]-[points[i-1][@"x"] floatValue],
                                                 [points[i][@"y"] floatValue]-[points[i-1][@"y"] floatValue]);
                    
                    CGFloat distance = hypotf(vector.x, vector.y);
                    
                    vector.x /= distance;
                    vector.y /= distance;
                    
                    CGFloat width = [[aBrush objectForKey:@"width"] floatValue];
                    
                    for (CGFloat j = 0; j < distance; j += width*0.5) {
                        CGPoint p = CGPointMake([points[i-1][@"x"] floatValue] + j * vector.x,
                                                [points[i-1][@"y"] floatValue] + j * vector.y);
                        [brushTexture drawAtPoint:p];
                    }
                }
            }
        }
    }
}

@end