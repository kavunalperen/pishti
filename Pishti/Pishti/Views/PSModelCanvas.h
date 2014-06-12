//
//  PSModelCanvas.h
//  Pishti
//
//  Created by Alperen Kavun on 17.05.2014.
//  Copyright (c) 2014 pishti. All rights reserved.
//


typedef enum BRUSH_TYPE
{
    BRUSH_TYPE_BASIC_COLOR,
    BRUSH_TYPE_PATTERN_COLOR
} BRUSH_TYPE;

#import <UIKit/UIKit.h>
#import "PSCommons.h"

@interface PSModelCanvas : UIView

@property UIColor* strokeColor;
@property UIColor* fillColor;

@property NSString* patternImageName;
@property BRUSH_TYPE brushType;
@property UIColor* brushColor;
@property CGFloat brushWidth;
@property CGFloat brushOpacity;
@property BOOL isBrushActive;

@property NSMutableArray* brushes;

- (void) deleteLastOne;
- (void) deleteAll;

@end
