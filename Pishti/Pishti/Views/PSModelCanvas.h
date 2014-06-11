//
//  PSModelCanvas.h
//  Pishti
//
//  Created by Alperen Kavun on 17.05.2014.
//  Copyright (c) 2014 pishti. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PSCommons.h"

@interface PSModelCanvas : UIView

@property UIColor* strokeColor;
@property UIColor* fillColor;

@property UIColor* brushColor;
@property CGFloat brushWidth;
@property BOOL isBrushActive;

@property NSMutableDictionary* brushes;

@end
