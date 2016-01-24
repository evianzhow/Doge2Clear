//
//  PreviewViewController.h
//  Clear
//
//  Created by Yifei Zhou on 11/29/15.
//  Copyright © 2015 Aladdin Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XLFormRowDescriptor;

@interface PreviewViewController : UIViewController

@property (strong, nonatomic) XLFormRowDescriptor *rowDescriptor;

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;

@end
