//
//  CityDoCommonEncryptTool.m
//  CityDoCommon
//
//  Created by CityDoWCY on 2020/5/21.
//  Copyright © 2020 CityDo. All rights reserved.
//

#import "CityDoCommonEncryptTool.h"

@implementation CityDoCommonEncryptTool

+ (NSString *)cd_encryptNameFront:(NSString *)name {
    NSMutableString *str = [NSMutableString string];
    NSInteger num = name.length;
    for (int i = 0; i < num - 1; i ++) {
        [str appendString:@"*"];
    }
    [str appendString:[name substringFromIndex:name.length-1]];
    return [str copy];
}

+ (NSString *)cd_encryptNameBack:(NSString *)name {
    NSMutableString *str = [NSMutableString string];
    [str appendString:[name substringToIndex:1]];
    NSInteger num = name.length;
    for (int i = 1; i < num ; i ++) {
        [str appendString:@"*"];
    }
    return [str copy];
}

+ (NSString *)cd_encryptMobile:(NSString *)mobile {
    
    if (mobile.length != 11) {
        return mobile;
    } else {
        return [mobile stringByReplacingCharactersInRange:NSMakeRange(4, 4) withString:@"****"];
    }
}

+ (NSString *)cd_encryptString:(NSString *)string range:(NSRange)range {
    return [CityDoCommonEncryptTool cd_encryptString:string encryStr:@"*" range:range];
}

+ (NSString *)cd_encryptString:(NSString *)string encryStr:(NSString *)encryChar range:(NSRange)range {
    if (string.length == 0) {
        return @"";
    }
    if (string.length < range.location || range.location < 0) {
        return string;
    }
    if (range.length <= 0 || range.length > string.length) {
        return string;
    }
    if (string.length < range.length+range.location) {
        return string;
    }
    
    NSMutableString *mutableStr = [NSMutableString stringWithString:string];
    NSMutableString *encryStr = [NSMutableString string];
    for (int i = 0; i < range.length; i++) {
        if (encryChar.length == 1) {
            [encryStr appendString:encryChar];
        } else {
            [encryStr appendString:@"*"];
        }
    }
    return [mutableStr stringByReplacingCharactersInRange:range withString:encryStr];
}

@end
