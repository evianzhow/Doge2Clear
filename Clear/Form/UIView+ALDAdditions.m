//
//  UIView+ALDAdditions.m
//  Aladdin
//
//  Created by Yifei Zhou on 7/25/15.
//  Copyright (c) 2015 Aladdin Inc. All rights reserved.
//

#import "UIView+ALDAdditions.h"
#import <objc/runtime.h>

@implementation UIView (ALDAdditions)

static char kAssociatedObjectKey;

- (void)setX:(CGFloat)x
{
    CGRect frame = CGRectMake(x, self.y, self.width, self.height);
    self.frame = frame;
}

- (CGFloat)x
{
    return self.origin.x;
}

- (void)setY:(CGFloat)y
{
    CGRect frame = CGRectMake(self.x, y, self.width, self.height);
    self.frame = frame;
}

- (CGFloat)y
{
    return self.origin.y;
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = CGRectMake(self.x, self.y, width, self.height);
    self.frame = frame;
}

- (CGFloat)width
{
    return self.size.width;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = CGRectMake(self.x, self.y, self.width, height);
    self.frame = frame;
}

- (CGFloat)height
{
    return self.size.height;
}

- (void)setSize:(CGSize)size
{
    self.width = size.width;
    self.height = size.height;
}

- (CGSize)size
{
    return self.frame.size;
}

- (void)setOrigin:(CGPoint)origin
{
    self.x = origin.x;
    self.y = origin.y;
}

- (CGPoint)origin
{
    return self.frame.origin;
}

- (void)setTop:(CGFloat)top
{
    self.y = top;
}

- (CGFloat)top
{
    return self.y;
}

- (void)setBottom:(CGFloat)bottom
{
    self.y = bottom - self.height;
}

- (CGFloat)bottom
{
    return self.y + self.height;
}

- (void)setLeft:(CGFloat)left
{
    self.x = left;
}

- (CGFloat)left
{
    return self.x;
}

- (void)setRight:(CGFloat)right
{
    self.x = right - self.width;
}

- (CGFloat)right
{
    return self.x + self.width;
}

- (UIImage *)currentScreenImage
{
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, [UIScreen mainScreen].scale);
    [self drawViewHierarchyInRect:self.bounds afterScreenUpdates:YES];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return image;
}

- (UIImageView *)ald_backgroundImageView
{
    id object = objc_getAssociatedObject(self, &kAssociatedObjectKey);
    if (object && [object isKindOfClass:[UIImageView class]]) {
        return object;
    }
    return nil;
}

- (void)ald_setBackgroundImage:(UIImage *)image inset:(UIEdgeInsets)inset
{
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    [self addSubview:imageView];
    
    objc_setAssociatedObject(self, &kAssociatedObjectKey, imageView, OBJC_ASSOCIATION_ASSIGN);
    
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).offset(inset.top);
        make.bottom.mas_equalTo(self.mas_bottom).offset(-inset.bottom);
        make.left.mas_equalTo(self.mas_left).offset(inset.left);
        make.right.mas_equalTo(self.mas_right).offset(-inset.right);
    }];
    [self sendSubviewToBack:imageView];
}

@end
