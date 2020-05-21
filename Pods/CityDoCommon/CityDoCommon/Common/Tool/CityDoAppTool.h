//
//  CityDoAppTool.h
//  CityDoCommon
//
//  Created by CityDoWCY on 2020/5/20.
//  Copyright © 2020 CityDo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CityDoAppTool : NSObject

#pragma mark - 打开 App Store
/**
 在App Store打开应用

 @param appId 应用id
 @return yes 能打开 no不能打开
 */
+ (BOOL)openAppStoreWithAppId:(NSString *__nonnull)appId;


/**
 在App Store打开应用评论页面

 @param appid 应用id
 @return yes 能打开 no不能打开
 */
+ (BOOL)openAPPCommenWithAppId:(NSString *__nonnull)appid;

#pragma mark - 拨打电话
/**
 拨打电话

 @param phoneNumber 电话号码
 */
+ (void)telWithPhoneNumber:(NSString *_Nonnull)phoneNumber;

#pragma mark - 打开链接 跳转safari

/**
 打开链接

 @param urlStr 需要用Safari打开的url
 */
+ (void)gotoSafariBrowserWithURL:(NSString *_Nonnull)urlStr;

#pragma mark - 计算缓存
// 显示缓存大小
+ (CGFloat)calculateCacheSize;
// 清理缓存
+ (void)clearAllCacheEndClearBlock:(void(^_Nonnull)(BOOL isSuccess))block;

@end

NS_ASSUME_NONNULL_END
