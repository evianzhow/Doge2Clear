//
//  UIImage+ALDAdditions.h
//  webond
//
//  Created by Yifei Zhou on 8/15/15.
//  Copyright (c) 2015 Aladdin Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ALDAdditions)

- (UIImage *)ald_tintedImageWithColor:(UIColor *)tintColor;

- (UIImage *)ald_grayscaleImage;

- (instancetype)ald_circularImage;

- (NSUInteger)ald_lengthOfImage;

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

+ (UIImage *)ald_appIcon;

// Resize

- (UIImage *)ald_resizedImageWithSize:(CGSize)size shouldKeepRatio:(BOOL)keepRatio;

- (UIImage *)ald_resizedImageWithSize:(CGSize)size opaque:(BOOL)opaque shouldKeepRatio:(BOOL)keepRatio;

@end
