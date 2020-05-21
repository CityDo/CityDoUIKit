//
//  UIDevice+CityDoCommon.h
//  CityDoCommon
//
//  Created by CityDoWCY on 2020/5/20.
//  Copyright © 2020 CityDo. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIDevice (CityDoCommon)

/// 设备系统版本 (e.g. 8.1)
+ (double)systemVersion;

/// 设备是否是iPad
@property (nonatomic, readonly) BOOL isPad;

/// 设备是不是模拟器.
@property (nonatomic, readonly) BOOL isSimulator;

/// 设备是否越狱.
@property (nonatomic, readonly) BOOL isJailbroken;

/// 设备是否可以打电话
@property (nonatomic, readonly) BOOL canMakePhoneCalls NS_EXTENSION_UNAVAILABLE_IOS("");

/// The System's startup time.
@property (nonatomic, readonly) NSDate *systemUptime;

/// 设备是否有摄像头
@property (nonatomic, readonly) BOOL isHasCamera;

/// UDID
@property (nonatomic, readonly) NSString *UDIDStr;

@end

NS_ASSUME_NONNULL_END
