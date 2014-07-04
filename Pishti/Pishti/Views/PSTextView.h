//
//  PSTextView.h
//  Pishti
//
//  Created by Alperen Kavun on 4.07.2014.
//  Copyright (c) 2014 pishti. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PSTextView : UITextView

@property BOOL isBold;
@property BOOL isItalic;
@property BOOL isHorizontal;
@property NSInteger alignment;
@property UIColor* color;
@property NSString* fontName;
@property NSString* baseText;
@property CGFloat opacity;

@end
