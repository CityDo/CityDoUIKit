//
//  NSString+CityDoCommon.h
//  CityDoCommon
//
//  Created by volientDuan on 2020/5/18.
//  Copyright © 2020 CityDo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (CityDoCommon)

- (NSString *)cd_md5;

//是否为空
+ (BOOL)cd_isEmpty:(NSString *)string;

/**
 compare two version
 @param sourVersion *.*.*.*
 @param desVersion *.*.*.*
 @returns No,sourVersion is less than desVersion; YES, the statue is opposed
 */
+(BOOL)cd_compareVerison:(NSString *)sourVersion withDes:(NSString *)desVersion;

//当前字符串是否只包含空白字符和换行符
- (BOOL)cd_isWhitespaceAndNewlines;

//去除字符串前后的空白,不包含换行符
- (NSString *)cd_trim;
- (NSString *)cd_removeWhiteSpace;


//去除字符串中所有空白
- (NSString *)cd_removeNewLine;

//将字符串以URL格式编码
- (NSString *)cd_stringByUrlEncoding;

- (NSURL *)cd_encodeUrl;

/*!
 @brief     大写第一个字符
 @return    格式化后的字符串
 */
- (NSString *)cd_capitalize;

//以给定字符串开始,忽略大小写
- (BOOL)cd_startsWith:(NSString *)str;
//以指定条件判断字符串是否以给定字符串开始
- (BOOL)cd_startsWith:(NSString *)str Options:(NSStringCompareOptions)compareOptions;


//以给定字符串结束，忽略大小写
- (BOOL)cd_endsWith:(NSString *)str;
//以指定条件判断字符串是否以给定字符串结尾
- (BOOL)cd_endsWith:(NSString *)str Options:(NSStringCompareOptions)compareOptions;

//包含给定的字符串, 忽略大小写
- (BOOL)cd_containsString:(NSString *)str;
//以指定条件判断是否包含给定的字符串
- (BOOL)cd_containsString:(NSString *)str Options:(NSStringCompareOptions)compareOptions;

//判断字符串是否相同，忽略大小写
- (BOOL)cd_equalsString:(NSString *)str;


- (NSString *)cd_emjoiText;

// 是否带有表情府
- (BOOL)cd_isContainsEmoji;

- (NSArray *)cd_rangsWithSubString:(NSString *)subString;

/// to 大写
- (NSString *)cd_stringToUpper;
/// to 小写
- (NSString *)cd_stringToLower;

/// 是否全为中文
- (BOOL)cd_isChinese;
/// 是否是数字
- (BOOL)cd_isNumber;
/// 中文转拼音
- (NSString *)cd_ChineseToPinyin;

@end
