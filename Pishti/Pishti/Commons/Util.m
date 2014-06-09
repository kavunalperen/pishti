//
//  Util.m
//  Gong
//
//  Created by Alperen Kavun on 8.04.2014.
//  Copyright (c) 2014 pishti. All rights reserved.
//

#import "Util.h"

static Util* sharedInstance = nil;
static NSArray* groupParticipantColors = nil;

@implementation Util

+ (Util*) sharedInstance
{
    if (sharedInstance == nil) {
        sharedInstance = [[Util alloc] init];
    }
    return sharedInstance;
}
- (NSString*) nilAndNullCheckWithString:(NSString*)aString
{
    NSString* string;
    if (aString == nil || [aString isKindOfClass:[NSNull class]]) {
        string = @"";
    } else {
        string = aString;
    }
    
    return string;
}
- (NSNumber*) nilAndNullCheckWithNumber:(NSNumber*)aNumber
{
    NSNumber* number;
    if (aNumber == nil || [aNumber isKindOfClass:[NSNull class]]) {
        number = [NSNumber numberWithInteger:INT32_MIN];
    } else {
        number = aNumber;
    }
    return number;
}

- (NSDate*) dateFormString:(NSString*)dateString
{
    if (dateString != nil) {
        NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setLocale:[NSLocale currentLocale]];
        [dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
        [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"];
        NSDate* createdAt = [dateFormatter dateFromString:dateString];
        
        return createdAt;
    } else {
        return nil;
    }
}
- (NSString*) stringFromDate:(NSDate*)date
{
    if (date != nil) {
        NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setLocale:[NSLocale currentLocale]];
        [dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
        [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"];
        
        NSString* createdAtStr = [dateFormatter stringFromDate:date];
        
        return createdAtStr;
    } else {
        return nil;
    }
}
-(CGSize)text:(NSString*)text sizeWithFont:(UIFont*)font constrainedToSize:(CGSize)size{
    
    NSDictionary *attributesDictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                          font, NSFontAttributeName,
                                          nil];

    
    CGRect frame = [text boundingRectWithSize:size
                                      options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading)
                                   attributes:attributesDictionary
                                      context:nil];
    
    CGSize labelSize = CGSizeMake((ceilf)(frame.size.width), (ceilf)(frame.size.height));
    
    return labelSize;
}

- (UIImage*)UIImageWithUIColor:(UIColor*)color {
    if (color != nil) {
        CGRect rect = CGRectMake(0, 0, 1, 1);
        UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetFillColorWithColor(context,color.CGColor);
        
        CGContextFillRect(context, rect);
        UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        return img;
    } else {
        return nil;
    }
}
- (UIImage*) maskImage:(UIImage *)image withMask:(UIImage *)maskImage {
    //
    if (image != nil && maskImage != nil) {
#define ROUND_UP(N, S) ((((N) + (S) - 1) / (S)) * (S))
        image = [self image:image byScalingAndCroppingForSize:CGSizeMake(maskImage.size.width, maskImage.size.height)];
        // Original RGBA image
        CGImageRef originalMaskImage = [maskImage CGImage];
        float width = CGImageGetWidth(originalMaskImage);
        float height = CGImageGetHeight(originalMaskImage);
        
        // Make a bitmap context that's only 1 alpha channel
        // WARNING: the bytes per row probably needs to be a multiple of 4
        int strideLength = ROUND_UP(width * 1, 4);
        unsigned char * alphaData = calloc(strideLength * height, sizeof(unsigned char));
        CGContextRef alphaOnlyContext = CGBitmapContextCreate(alphaData,
                                                              width,
                                                              height,
                                                              8,
                                                              strideLength,
                                                              NULL,
                                                              (CGBitmapInfo)kCGImageAlphaOnly);
        
        // Draw the RGBA image into the alpha-only context.
        CGContextDrawImage(alphaOnlyContext, CGRectMake(0, 0, width, height), originalMaskImage);
        
        // Walk the pixels and invert the alpha value. This lets you colorize the opaque shapes in the original image.
        // If you want to do a traditional mask (where the opaque values block) just get rid of these loops.
        for (int y = 0; y < height; y++) {
            for (int x = 0; x < width; x++) {
                unsigned char val = alphaData[y*strideLength + x];
                val = 255 - val;
                alphaData[y*strideLength + x] = val;
            }
        }
        
        CGImageRef alphaMaskImage = CGBitmapContextCreateImage(alphaOnlyContext);
        CGContextRelease(alphaOnlyContext);
        free(alphaData);
        
        // Make a mask
        CGImageRef mask = CGImageMaskCreate(CGImageGetWidth(alphaMaskImage),
                                            CGImageGetHeight(alphaMaskImage),
                                            CGImageGetBitsPerComponent(alphaMaskImage),
                                            CGImageGetBitsPerPixel(alphaMaskImage),
                                            CGImageGetBytesPerRow(alphaMaskImage),
                                            CGImageGetDataProvider(alphaMaskImage), NULL, false);
        
        CGImageRef masked = CGImageCreateWithMask([image CGImage], mask);
        UIImage* maskedImage = [UIImage imageWithCGImage:masked];
        CGImageRelease(mask);
        CGImageRelease(masked);
        CGImageRelease(alphaMaskImage);
        return maskedImage;
    } else {
        return nil;
    }
    
}

- (UIImage*) stretchableImageWithOriginalImage:(UIImage*)originalImage
                                 andEdgeInsets:(UIEdgeInsets)edgeInset
{
    if (originalImage != nil) {
        return [originalImage resizableImageWithCapInsets:edgeInset
                                             resizingMode:UIImageResizingModeStretch];
    } else {
        return nil;
    }
}

- (UIImage*)image:(UIImage*)image byScalingAndCroppingForSize:(CGSize)targetSize
{
    if (image != nil) {
        UIImage* sourceImage = image;
        UIImage *newImage = nil;
        CGSize imageSize = sourceImage.size;
        CGFloat width = imageSize.width;
        CGFloat height = imageSize.height;
        CGFloat targetWidth = targetSize.width;
        CGFloat targetHeight = targetSize.height;
        CGFloat scaleFactor = 0.0;
        CGFloat scaledWidth = targetWidth;
        CGFloat scaledHeight = targetHeight;
        CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
        
        if (CGSizeEqualToSize(imageSize, targetSize) == NO) {
            CGFloat widthFactor = targetWidth / width;
            CGFloat heightFactor = targetHeight / height;
            
            if (widthFactor > heightFactor) {
                scaleFactor = widthFactor; // scale to fit height
            }
            else {
                scaleFactor = heightFactor; // scale to fit width
            }
            
            scaledWidth  = width * scaleFactor;
            scaledHeight = height * scaleFactor;
            
            // center the image
            if (widthFactor > heightFactor) {
                thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
            }
            else {
                if (widthFactor < heightFactor) {
                    thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
                }
            }
        }
        
        UIGraphicsBeginImageContext(targetSize); // this will crop
        
        CGRect thumbnailRect = CGRectZero;
        thumbnailRect.origin = thumbnailPoint;
        thumbnailRect.size.width  = scaledWidth;
        thumbnailRect.size.height = scaledHeight;
        
        [sourceImage drawInRect:thumbnailRect];
        
        newImage = UIGraphicsGetImageFromCurrentImageContext();
        
        if(newImage == nil)
        {
            //        NSLog(@"could not scale image");
            return nil;
        }
        
        //pop the context to get back to the default
        UIGraphicsEndImageContext();
        return newImage;
    } else {
        return nil;
    }
}
- (UIImage *)fixOrientation:(UIImage*)image {
    
    if (image != nil) {
        // No-op if the orientation is already correct
        if (image.imageOrientation == UIImageOrientationUp) return image;
        
        // We need to calculate the proper transformation to make the image upright.
        // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
        CGAffineTransform transform = CGAffineTransformIdentity;
        
        switch (image.imageOrientation) {
            case UIImageOrientationDown:
            case UIImageOrientationDownMirrored:
                transform = CGAffineTransformTranslate(transform, image.size.width, image.size.height);
                transform = CGAffineTransformRotate(transform, M_PI);
                break;
                
            case UIImageOrientationLeft:
            case UIImageOrientationLeftMirrored:
                transform = CGAffineTransformTranslate(transform, image.size.width, 0);
                transform = CGAffineTransformRotate(transform, M_PI_2);
                break;
                
            case UIImageOrientationRight:
            case UIImageOrientationRightMirrored:
                transform = CGAffineTransformTranslate(transform, 0, image.size.height);
                transform = CGAffineTransformRotate(transform, -M_PI_2);
                break;
            case UIImageOrientationUp:
            case UIImageOrientationUpMirrored:
                break;
        }
        
        switch (image.imageOrientation) {
            case UIImageOrientationUpMirrored:
            case UIImageOrientationDownMirrored:
                transform = CGAffineTransformTranslate(transform, image.size.width, 0);
                transform = CGAffineTransformScale(transform, -1, 1);
                break;
                
            case UIImageOrientationLeftMirrored:
            case UIImageOrientationRightMirrored:
                transform = CGAffineTransformTranslate(transform, image.size.height, 0);
                transform = CGAffineTransformScale(transform, -1, 1);
                break;
            case UIImageOrientationUp:
            case UIImageOrientationDown:
            case UIImageOrientationLeft:
            case UIImageOrientationRight:
                break;
        }
        
        // Now we draw the underlying CGImage into a new context, applying the transform
        // calculated above.
        CGContextRef ctx = CGBitmapContextCreate(NULL, image.size.width, image.size.height,
                                                 CGImageGetBitsPerComponent(image.CGImage), 0,
                                                 CGImageGetColorSpace(image.CGImage),
                                                 CGImageGetBitmapInfo(image.CGImage));
        CGContextConcatCTM(ctx, transform);
        switch (image.imageOrientation) {
            case UIImageOrientationLeft:
            case UIImageOrientationLeftMirrored:
            case UIImageOrientationRight:
            case UIImageOrientationRightMirrored:
                // Grr...
                CGContextDrawImage(ctx, CGRectMake(0,0,image.size.height,image.size.width), image.CGImage);
                break;
                
            default:
                CGContextDrawImage(ctx, CGRectMake(0,0,image.size.width,image.size.height), image.CGImage);
                break;
        }
        
        // And now we just create a new UIImage from the drawing context
        CGImageRef cgimg = CGBitmapContextCreateImage(ctx);   
        UIImage *img = [UIImage imageWithCGImage:cgimg];   
        CGContextRelease(ctx);   
        CGImageRelease(cgimg);   
        return img;
    } else {
        return  nil;
    }
}
- (UIImage *)normalizedImage:(UIImage*)image {
    if (image != nil) {
        if (image.imageOrientation == UIImageOrientationUp) return image;
        
        UIGraphicsBeginImageContextWithOptions(image.size, NO, image.scale);
        [image drawInRect:(CGRect){0, 0, image.size}];
        UIImage *normalizedImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return normalizedImage;
    } else {
        return nil;
    }
}
@end
