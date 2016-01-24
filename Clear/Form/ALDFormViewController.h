//
//  ALDFormViewController.h
//  webond
//
//  Created by Yifei Zhou on 10/19/15.
//  Copyright © 2015 Aladdin Inc. All rights reserved.
//

#import <XLForm/XLForm.h>

@interface ALDFormViewController : XLFormViewController

@property (readonly, nonatomic) NSString *alertTitle;

- (void)initializeForm;

- (BOOL)validateFormValues;

@end
