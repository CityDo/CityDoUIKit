//
//  NSDictionary+CityDoCommon.h
//  CityDoCommon
//
//  Created by CityDoWCY on 2020/5/20.
//  Copyright © 2020 CityDo. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDictionary (CityDoCommon)

/**
 返回BOOL判断是否含有某个key

 @param key 需判断的key
 @return 是否含有
 */
- (BOOL)containsObjectForKey:(id)key;

/**
 是否为空
 
 @return 返回是否是空
 */
- (BOOL)isEmpty;


/// 把字典转换成json字符串
/// @param dict 需转换的字典
+ (NSString *)convertToJsonData:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
