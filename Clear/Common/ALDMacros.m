//
//  ALDMacros.m
//  Aladdin
//
//  Created by Yifei Zhou on 7/7/15.
//  Copyright (c) 2015 Aladdin Inc. All rights reserved.
//

#import "ALDMacros.h"

NSUInteger DeviceSystemMajorVersion()
{
    static NSUInteger _deviceSystemMajorVersion = -1;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
      _deviceSystemMajorVersion = ([[UIDevice currentDevice].systemVersion componentsSeparatedByString:@"."][0]).intValue;
    });
    return _deviceSystemMajorVersion;
}

void ALDLog(NSString *format, ...)
{
    va_list args;
    va_start(args, format);
    NSString *string = [[NSString alloc] initWithFormat:format arguments:args];

    // will make debug difficult, so output directly
    //  dispatch_async(dispatch_get_main_queue(), ^{
    //    fputs([string UTF8String], stdout);
    //  });

    fputs(string.UTF8String, stdout);

    va_end(args);
}