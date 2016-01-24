//
//  UIColor+ALDAdditions.m
//  Clear
//
//  Created by Yifei Zhou on 11/30/15.
//  Copyright © 2015 Aladdin Inc. All rights reserved.
//

#import "UIColor+ALDAdditions.h"

@implementation UIColor (ALDAdditions)

+ (instancetype)ald_randomColor
{
    CGFloat hue = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
    UIColor *color = [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
    return color;
}

@end
