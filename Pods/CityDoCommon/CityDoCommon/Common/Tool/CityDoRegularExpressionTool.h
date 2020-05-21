//
//  CityDoRegularExpressionTool.h
//  CityDoCommon
//
//  Created by CityDoWCY on 2020/5/21.
//  Copyright © 2020 CityDo. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// 正则校验工具
@interface CityDoRegularExpressionTool : NSObject

#pragma mark - 手机号校验
/// 是否为正确电话号码
/// @param phoneNumber 传入需要检测的字符串
+ (BOOL)cd_isValidatePhoneNumber:(NSString *)phoneNumber;

#pragma mark - 邮箱校验
/// 是否为正确邮箱
/// @param email 邮箱地址
+ (BOOL)cd_isValidateEmail:(NSString *)email;

#pragma mark - 车牌号校验
/// 是否为正确的车牌号
/// @param carNo 车牌号
+ (BOOL)cd_isValidateCarNo:(NSString*)carNo;

#pragma mark - 身份证号校验
/// 是否为正确的身份证号
/// @param idCardNumberStr 身份证号
+ (BOOL)cd_isValidateIDCardNo:(NSString *)idCardNumberStr;

#pragma mark - 银行卡号校验
/// 是否是合法的银行卡号
/// @param cardNumber 银行卡号
+ (BOOL)cd_isValidateBankCardNumber:(NSString *)cardNumber;


@end

NS_ASSUME_NONNULL_END
