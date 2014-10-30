//
//  PSDesignLabel.m
//  Pishti
//
//  Created by Alperen Kavun on 29.10.2014.
//  Copyright (c) 2014 pishti. All rights reserved.
//

#import "PSDesignLabel.h"
#import "Util.h"
#import "PSSubmenuManager.h"

@implementation PSDesignLabel


- (id) initWithCenter:(CGPoint)center
{
    if (self = [super init]) {
        self.backgroundColor = [UIColor clearColor];
        self.center = center;
        self.isVerticalSized = NO;
    }
    return self;
}

- (void) configureLabelWithSettings
{
    CGAffineTransform oldTransform = self.transform;
    self.transform = CGAffineTransformIdentity;
    
    CGFloat opacity = [[_labelSettings objectForKey:TEXT_OPACITY_KEY] floatValue];
    NSInteger textFontIndex = [[_labelSettings objectForKey:TEXT_FONT_INDEX_KEY] integerValue];
    bool isBold = [[_labelSettings objectForKey:BOLDNESS_KEY] boolValue];
    bool isItalic = [[_labelSettings objectForKey:ITALICNESS_KEY] boolValue];
    bool direction = [[_labelSettings objectForKey:DIRECTION_KEY] boolValue];
    NSInteger alignment = [[_labelSettings objectForKey:TEXT_ALIGNMENT_KEY] integerValue];
    NSInteger textColorIndex = [[_labelSettings objectForKey:TEXT_COLOR_INDEX_KEY] integerValue];
    NSString* currentText = [_labelSettings objectForKey:CURRENT_TEXT_KEY];
    self.originalText = currentText;
    
    NSString* fontFamily = [[PSSubmenuManager sharedInstance] getFontFamilyWithFontIndex:textFontIndex];
    NSString* fontName = [[Util sharedInstance] getFontNameForFamily:fontFamily andIsBold:isBold andIsItalic:isItalic];
    
    self.alpha = opacity;
    self.font = [UIFont fontWithName:fontName size:DEFAULT_FONT_HEIGHT];
    self.textAlignment = alignment;
    self.textColor = [[PSSubmenuManager sharedInstance] getColorWithColorIndex:textColorIndex];
    self.numberOfLines = 0;
    
    if (direction) {
        [self makeVertical];
        if (!self.isVerticalSized || CGSizeEqualToSize(self.originalSize, CGSizeZero)) {
            self.originalSize = self.frame.size;
            self.isVerticalSized = YES;
        }
        
    } else {
        self.text = currentText;
        
        CGPoint oldCenter = self.center;
        
        CGSize textSize = [[Util sharedInstance] text:self.text sizeWithFont:self.font constrainedToSize:CGSizeMake(1000.0, 1000.0)];
        self.frame = CGRectMake(0.0, 0.0, textSize.width, textSize.height);
        self.center = oldCenter;
        
        if (self.isVerticalSized || CGSizeEqualToSize(self.originalSize, CGSizeZero)) {
            
            self.originalSize = self.frame.size;
            self.isVerticalSized = NO;
        }
    }
    
    self.transform = oldTransform;
    
}

- (void) makeVertical
{
    NSString* verticalText = [self convertTextToVertical:self.originalText];
    
    self.text = verticalText;
    
    CGPoint oldCenter = self.center;
    
    CGSize textSize = [[Util sharedInstance] text:self.text sizeWithFont:self.font constrainedToSize:CGSizeMake(1000.0, 1000.0)];
    self.frame = CGRectMake(0.0, 0.0, textSize.width, textSize.height);
    self.center = oldCenter;
    
}
- (NSString*) convertTextToVertical:(NSString*)text
{
    NSString* verticalString = @"";
    
    for (int i = 0; i < text.length; i++) {
        NSRange range = NSMakeRange(i, 1);
        verticalString = [verticalString stringByAppendingString:[text substringWithRange:range]];
        
        if (i != text.length-1) {
            verticalString = [verticalString stringByAppendingString:@"\n"];
        }
    }
    
    return verticalString;
}
@end
