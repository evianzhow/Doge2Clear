//
//  XLFormBaseCell+ALDForm.m
//  webond
//
//  Created by Yifei Zhou on 11/24/15.
//  Copyright © 2015 Aladdin Inc. All rights reserved.
//

#import "UITableViewCell+ALDForm.h"
#import <XLForm/XLForm.h>

@implementation UITableViewCell (ALDForm)

- (void)ald_configureRoundedCornersWithRowIndex:(NSInteger)row andNumberOfRowsInSection:(NSInteger)count
{
    MXRoundedCornersTableViewCellPosition position;
    if (row == 0 && row == count - 1) {
        position = MXRoundedCornersTableViewCellPositionSingle;
    } else if (row == count - 1) {
        position = MXRoundedCornersTableViewCellPositionBottom;
    } else if (row == 0) {
        position = MXRoundedCornersTableViewCellPositionTop;
    } else {
        position = MXRoundedCornersTableViewCellPositionMiddle;
    }
    
    self.backgroundColor = [UIColor clearColor];
    
    if ([self respondsToSelector:@selector(preferredStyle)]) {
        position = [(XLFormBaseCell <ALDFormRoundedCorneresStyleProtocol> *)self preferredStyle];
    }
    
    if (self.ald_backgroundImageView) {
        [self ald_removeBackgroundImageView];
    }
    [self ald_addBackgroundImageWithPosition:position];
    
    [self setNeedsDisplay];
}

- (void)ald_addBackgroundImageWithPosition:(MXRoundedCornersTableViewCellPosition)position
{
    UIImage *backgroundImage;

    if ([self respondsToSelector:@selector(backgroundImageForPosition:)]) {
        backgroundImage = [(XLFormBaseCell<ALDFormRoundedCorneresStyleProtocol> *)self backgroundImageForPosition:position];
    }

    if (!backgroundImage) {
        switch (position) {
        case MXRoundedCornersTableViewCellPositionNone: {
            break;
        }
        case MXRoundedCornersTableViewCellPositionTop: {
            backgroundImage = [[UIImage imageNamed:@"Round_Rect_Control_Background_Top"] resizableImageWithCapInsets:UIEdgeInsetsMake(7, 17, 1, 17)];
            break;
        }
        case MXRoundedCornersTableViewCellPositionMiddle: {
            backgroundImage = [[UIImage imageNamed:@"Round_Rect_Control_Background_Middle"] resizableImageWithCapInsets:UIEdgeInsetsMake(1, 17, 1, 17)];
            break;
        }
        case MXRoundedCornersTableViewCellPositionBottom: {
            backgroundImage = [[UIImage imageNamed:@"Round_Rect_Control_Background_Bottom"] resizableImageWithCapInsets:UIEdgeInsetsMake(1, 17, 7, 17)];
            break;
        }
        case MXRoundedCornersTableViewCellPositionSingle: {
            backgroundImage = [[UIImage imageNamed:@"Round_Rect_Control_Background"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 6, 5)];
            break;
        }
        default: {
            break;
        }
        }
    }

    UIEdgeInsets inset = UIEdgeInsetsZero;

    if ([self respondsToSelector:@selector(insetForBackgroundImageView)]) {
        inset = [(XLFormBaseCell<ALDFormRoundedCorneresStyleProtocol> *)self insetForBackgroundImageView];
    }

    [self ald_setBackgroundImage:backgroundImage inset:inset];
}

- (void)ald_removeBackgroundImageView
{
    [self.ald_backgroundImageView removeFromSuperview];
}

@end
