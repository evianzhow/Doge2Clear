//
//  ALDMacros.h
//  Aladdin
//
//  Created by Yifei Zhou on 7/7/15.
//  Copyright (c) 2015 Aladdin Inc. All rights reserved.
//

#ifndef ALDMacros_h
#define ALDMacros_h

/**

 System Version Detection

 */

#define SYSTEM_VERSION_EQUAL_TO(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

/**

 Screen Size

 */

#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height
#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
#define kALDTextViewLargeHeight 3000.0f

/**

 Device Detection

 */
#define DEVICE_IS_IPAD ([[[UIDevice currentDevice].model substringToIndex:4] isEqualToString:@"iPad"])
#define DEVICE_IS_6_PLUS (SCREEN_WIDTH > 400.0f)
#define DEVICE_IS_4_INCH (SCREEN_WIDTH < 350.0f)

NSUInteger DeviceSystemMajorVersion();
#define IOS7 1
#define IOS8 (DeviceSystemMajorVersion() >= 8)

#define IOS_DEVICE ([[UIDevice currentDevice].model rangeOfString:@"Simulator"].location == NSNotFound)

/**

 Log Macros

 */

void ALDLog(NSString *format, ...);

#define ALDFILENAME (strrchr(__FILE__, '/') ? strrchr(__FILE__, '/') + 1 : __FILE__)

#ifdef DEBUG
#define DLog(fmt, ...)                                                                                                                                         \
    {                                                                                                                                                          \
        ALDLog((@"[%s:%d]  " fmt "\n"), ALDFILENAME, __LINE__, ##__VA_ARGS__);                                                                                 \
    }
#define ELog(err)                                                                                                                                              \
    {                                                                                                                                                          \
        if (err)                                                                                                                                               \
            DLog(@"%@", err)                                                                                                                                   \
    }
#else
#define DLog(...)
#define ELog(err)
#endif

// ALog always displays output regardless of the DEBUG setting
#define ALog(fmt, ...)                                                                                                                                         \
    {                                                                                                                                                          \
        ALDLog((@"[%s:%d]  " fmt "\n"), ALDFILENAME, __LINE__, ##__VA_ARGS__);                                                                                 \
    };

/**

 Blocks

 */
#define ALDExecuteBlockIfNotNil(__ALD_Block__, ...)                                                                                                            \
    {                                                                                                                                                          \
        if (__ALD_Block__)                                                                                                                                     \
            __ALD_Block__(__VA_ARGS__);                                                                                                                        \
    }

/**

 Constants

 */
#define ALDRangeZero NSMakeRange(0, 0)

/**

 Nil

 */

#define ALDObjectIsNilClass(OBJ) (!OBJ || [OBJ isKindOfClass:[NSNull class]])

/**

 Memory Management

 */

#define WEAKSELF typeof(self) __weak weakSelf = self;

/**

 Class Inheritance

 */

#ifdef DEBUG
#define RaiseSubclassThisException [NSException raise:NSInternalInconsistencyException format:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)]
#else
#define RaiseSubclassThisException
#endif

/**

 Text Field / View Validation

 */
#define TEXTFIELD_ADD_SELF                                                                                                                                     \
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(validateTextFields) name:UITextFieldTextDidChangeNotification object:nil]
#define TEXTFIELD_REMOVE_SELF [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:nil]

#define TEXTVIEW_ADD_SELF                                                                                                                                      \
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(validateTextFields) name:UITextViewTextDidChangeNotification object:nil]
#define TEXTVIEW_REMOVE_SELF [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextViewTextDidChangeNotification object:nil]

#define SuppressPerformSelectorLeakWarning(Stuff)                                                                                                              \
    do {                                                                                                                                                       \
        _Pragma("clang diagnostic push") _Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") Stuff;                                            \
        _Pragma("clang diagnostic pop")                                                                                                                        \
    } while (0)

#endif