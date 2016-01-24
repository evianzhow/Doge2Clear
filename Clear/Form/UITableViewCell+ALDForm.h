//
//  XLFormBaseCell+ALDForm.h
//  webond
//
//  Created by Yifei Zhou on 11/24/15.
//  Copyright © 2015 Aladdin Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

// https://github.com/maxsokolov/MXRoundedCornersTableViewCell

typedef NS_ENUM(NSUInteger, MXRoundedCornersTableViewCellPosition) {

    MXRoundedCornersTableViewCellPositionNone,
    MXRoundedCornersTableViewCellPositionTop,
    MXRoundedCornersTableViewCellPositionMiddle,
    MXRoundedCornersTableViewCellPositionBottom,
    MXRoundedCornersTableViewCellPositionSingle
};

@protocol ALDFormRoundedCorneresStyleProtocol <NSObject>

@optional
- (MXRoundedCornersTableViewCellPosition)preferredStyle;

- (UIImage *)backgroundImageForPosition:(MXRoundedCornersTableViewCellPosition)position;

- (UIEdgeInsets)insetForBackgroundImageView;

@end

@interface UITableViewCell (ALDForm)

- (void)ald_configureRoundedCornersWithRowIndex:(NSInteger)row andNumberOfRowsInSection:(NSInteger)count;

- (void)ald_addBackgroundImageWithPosition:(MXRoundedCornersTableViewCellPosition)position;

- (void)ald_removeBackgroundImageView;

@end
