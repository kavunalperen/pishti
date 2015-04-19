//
//  Util.h
//  Gong
//
//  Created by Alperen Kavun on 8.04.2014.
//  Copyright (c) 2014 pishti. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Util : NSObject

+ (Util*)sharedInstance;

- (UIImage*) UIImageWithUIColor:(UIColor*)color;
- (UIImage*) maskImage:(UIImage*)image withMask:(UIImage *)maskImage;
- (CGSize) text:(NSString*)text sizeWithFont:(UIFont*)font constrainedToSize:(CGSize)size;
- (UIImage*) stretchableImageWithOriginalImage:(UIImage*)originalImage
                                 andEdgeInsets:(UIEdgeInsets)edgeInset;

- (UIImage*) rotateImage:(UIImage*) src andOrientation:(UIImageOrientation) orientation;
- (UIImage*) rotateImage:(UIImage *)src andOrientation:(UIImageOrientation)orientation andRotationAngle:(CGFloat)rotationAngle;
- (UIImage*) prepareImageForBrushing:(UIImage*)image andBrushWidth:(CGFloat)brushWidth;
- (UIImage*) prepareImageForDesign:(UIImage*)image;
- (UIImage*)image:(UIImage*)image byScalingAndCroppingForSize:(CGSize)targetSize;
- (UIImage *)normalizedImage:(UIImage*)image;
- (UIImage *)fixOrientation:(UIImage*)image;
- (UIImage *)maskedImage:(UIImage *)image color:(UIColor *)color;
- (UIImage *)maskedImageNamed:(NSString *)name color:(UIColor *)color;
- (UIImage *)image: (UIImage*)image byApplyingAlpha:(CGFloat) alpha;

- (NSString*) nilAndNullCheckWithString:(NSString*)aString;
- (NSNumber*) nilAndNullCheckWithNumber:(NSNumber*)aNumber;

- (NSString*) getFontNameForFamily:(NSString*)family
                         andIsBold:(bool)isBold
                       andIsItalic:(bool)isItalic;

- (NSString*) stringFromDate:(NSDate*)date;
- (NSDate*) dateFromString:(NSString*)string;

@end
