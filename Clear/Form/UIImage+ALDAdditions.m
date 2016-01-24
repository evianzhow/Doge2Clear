//
//  UIImage+ALDAdditions.m
//  webond
//
//  Created by Yifei Zhou on 8/15/15.
//  Copyright (c) 2015 Aladdin Inc. All rights reserved.
//

#import "UIImage+ALDAdditions.h"
#import <AVFoundation/AVFoundation.h>

@implementation UIImage (ALDAdditions)

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size
{
    if (CGSizeEqualToSize(size, CGSizeZero))
        return nil;
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);

    CGFloat imageScale = [UIScreen mainScreen].scale;
    UIGraphicsBeginImageContextWithOptions(size, NO, imageScale);

    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);

    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return image;
}

- (instancetype)ald_circularImage
{
    CGFloat sideLength = fmin(self.size.width, self.size.height);
    CGRect frame = CGRectMake(0.0, 0.0, sideLength, sideLength);

    UIGraphicsBeginImageContextWithOptions(frame.size, false, self.scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    UIBezierPath *imagePath = [UIBezierPath bezierPathWithRoundedRect:frame cornerRadius:sideLength / 2];
    [imagePath addClip];

    [self drawInRect:frame];

    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    CGContextRestoreGState(context);
    UIGraphicsEndImageContext();
    return newImage;
}

- (UIImage *)ald_tintedImageWithColor:(UIColor *)tintColor
{
    UIGraphicsBeginImageContextWithOptions(self.size, NO, [[UIScreen mainScreen] scale]);
    CGContextRef context = UIGraphicsGetCurrentContext();

    CGContextTranslateCTM(context, 0, self.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);

    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);

    // draw alpha-mask
    CGContextSetBlendMode(context, kCGBlendModeNormal);
    CGContextDrawImage(context, rect, self.CGImage);

    // draw tint color, preserving alpha values of original image
    CGContextSetBlendMode(context, kCGBlendModeSourceIn);
    [tintColor setFill];
    CGContextFillRect(context, rect);

    UIImage *coloredImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return coloredImage;
}

- (UIImage *)ald_grayscaleImage
{
    return [self ald_tintedImageWithColor:[UIColor lightGrayColor]];
}

- (NSUInteger)ald_lengthOfImage
{
    NSData *imageData = UIImageJPEGRepresentation(self, 1);
    return [imageData length];
}

+ (UIImage *)ald_appIcon {
    UIImage *icon = [UIImage imageNamed:@"AppIcon40x40"];
    return icon;
}

#pragma mark - Resize

// http://nshipster.com/image-resizing/

- (UIImage *)ald_resizedImageWithSize:(CGSize)size shouldKeepRatio:(BOOL)keepRatio
{
    return [self ald_resizedImageWithSize:size opaque:YES shouldKeepRatio:keepRatio];
}

- (UIImage *)ald_resizedImageWithSize:(CGSize)size opaque:(BOOL)opaque shouldKeepRatio:(BOOL)keepRatio
{
    if (keepRatio) {
        CGRect rect = AVMakeRectWithAspectRatioInsideRect(self.size, (CGRect){CGPointZero, size});
        size = rect.size;
    }
    CGFloat scale = 0.0f;
    
    UIGraphicsBeginImageContextWithOptions(size, opaque, scale);
    [self drawInRect:(CGRect){CGPointZero, size}];
    
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return scaledImage;
}

@end
