//
//  UIView+ALDAdditions.h
//  Aladdin
//
//  Created by Yifei Zhou on 7/25/15.
//  Copyright (c) 2015 Aladdin Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (ALDAdditions)

@property (nonatomic) CGFloat x;
@property (nonatomic) CGFloat y;
@property (nonatomic) CGFloat width;
@property (nonatomic) CGFloat height;
@property (nonatomic) CGSize size;
@property (nonatomic) CGPoint origin;
@property (nonatomic) CGFloat top;
@property (nonatomic) CGFloat bottom;
@property (nonatomic) CGFloat left;
@property (nonatomic) CGFloat right;

@property (NS_NONATOMIC_IOSONLY, readonly, strong) UIImage *currentScreenImage;

@property (readonly, nonatomic) UIImageView *ald_backgroundImageView;

- (void)ald_setBackgroundImage:(UIImage *)image inset:(UIEdgeInsets)inset;

@end
