//
//  ALDFormViewController.m
//  webond
//
//  Created by Yifei Zhou on 10/19/15.
//  Copyright © 2015 Aladdin Inc. All rights reserved.
//

#import "ALDFormViewController.h"
#import "UITableViewCell+ALDForm.h"

@interface ALDFormViewController ()

@end

@implementation ALDFormViewController

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self _commonInit];
}

- (void)_commonInit
{
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self _commonInit];
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self _commonInit];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initializeForm];
}

- (void)initializeForm
{
}

- (BOOL)validateFormValues
{
    NSArray * validationErrors = [self formValidationErrors];
    if (validationErrors.count > 0){
        [self showFormValidationError:[validationErrors firstObject]];
        return NO;
    }
    [self.tableView endEditing:YES];
    
    return YES;
}

@end
