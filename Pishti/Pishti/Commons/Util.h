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
- (NSDate*) dateFormString:(NSString*)dateString;
- (NSString*) stringFromDate:(NSDate*)date;
- (UIImage*) stretchableImageWithOriginalImage:(UIImage*)originalImage
                                 andEdgeInsets:(UIEdgeInsets)edgeInset;

- (UIImage*) rotateImage:(UIImage*) src andOrientation:(UIImageOrientation) orientation;
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

@end
