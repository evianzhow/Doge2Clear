//
//  ViewController.m
//  WallpaperTest
//
//  Created by erike on 09/06/14.
//  Copyright (c) 2014 erik. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "SaveListViewController.h"

@interface SaveListViewController ()

@end

@implementation SaveListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.allowsEditing = NO;
    self.saveWallpaperData = YES;
}

- (void)setImageAsHomeScreenAndLockScreenClicked:(id)arg1
{
    [super setImageAsHomeScreenAndLockScreenClicked:arg1];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self shutdown];
    });
}
- (void)setImageAsHomeScreenClicked:(id)arg1
{
    [super setImageAsHomeScreenAndLockScreenClicked:arg1];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self shutdown];
    });
}
- (void)setImageAsLockScreenClicked:(id)arg1
{
    [super setImageAsLockScreenClicked:arg1];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self shutdown];
    });
}

- (void)shutdown
{
    UIApplication *application = [UIApplication sharedApplication];
    [application.delegate applicationWillTerminate:application];
}

@end
