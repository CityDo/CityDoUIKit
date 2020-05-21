//
//  NSString+CityDoCommon.m
//  CityDoCommon
//
//  Created by volientDuan on 2020/5/18.
//  Copyright © 2020 CityDo. All rights reserved.
//

#import "NSString+CityDoCommon.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (CityDoCommon)

+ (NSString *)cd_md5String:(NSString *)str;
{
    const char *cStr = [str UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (uint32_t)strlen(cStr), result);
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3], result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11], result[12], result[13], result[14], result[15]
            ];
    
}

- (NSString *)cd_md5
{
    return [NSString cd_md5String:self];
}


#pragma mark - Utils
+ (BOOL)cd_isEmpty:(NSString *)string
{
    return string == nil || string.length == 0;
}

- (BOOL)cd_isWhitespaceAndNewlines
{
    NSCharacterSet* whitespace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    for (NSInteger i = 0; i < self.length; ++i)
    {
        unichar c = [self characterAtIndex:i];
        if (![whitespace characterIsMember:c])
        {
            return NO;
        }
    }
    return YES;
}

- (NSString *)cd_trim
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (NSString *)cd_removeWhiteSpace
{
    return [[self componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] componentsJoinedByString:@""];
}

- (NSString *)cd_removeNewLine
{
    return [[self componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]] componentsJoinedByString:@""];
}

- (NSString *)cd_stringByUrlEncoding
{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    NSString *url = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL,  (CFStringRef)self,  NULL,  (CFStringRef)@"!*'();:@&=+$,/?%#[]",  kCFStringEncodingUTF8));
#pragma clang diagnostic pop
    
    return url;
}

- (NSURL *)cd_encodeUrl{
    NSString *str = [self cd_removeWhiteSpace];
    str = [str cd_removeNewLine];
    return [NSURL URLWithString:[str cd_stringByUrlEncoding]];
}

- (NSString *)cd_capitalize
{
    if (self == nil || [self length] == 0) return self;
    return [[self substringToIndex:1].uppercaseString stringByAppendingString:[self substringFromIndex:1]];
}

- (BOOL)cd_startsWith:(NSString *)str
{
    return [self cd_startsWith:str Options:NSCaseInsensitiveSearch];
}

- (BOOL)cd_startsWith:(NSString *)str Options:(NSStringCompareOptions)compareOptions
{
    return (str != nil) && ([str length] > 0) && ([self length] >= [str length])
    && ([self rangeOfString:str options:compareOptions].location == 0);
}

- (BOOL)cd_endsWith:(NSString *)str
{
    return [self cd_endsWith:str Options:NSCaseInsensitiveSearch];
}

- (BOOL)cd_endsWith:(NSString *)str Options:(NSStringCompareOptions)compareOptions
{
    return (str != nil) && ([str length] > 0) && ([self length] >= [str length])
    && ([self rangeOfString:str options:(compareOptions | NSBackwardsSearch)].location == ([self length] - [str length]));
}

- (BOOL)cd_containsString:(NSString *)str
{
    return [self cd_containsString:str Options:NSCaseInsensitiveSearch];
}

- (BOOL)cd_containsString:(NSString *)str Options:(NSStringCompareOptions)compareOptions
{
    return (str != nil) && ([str length] > 0) && ([self length] >= [str length]) && ([self rangeOfString:str options:compareOptions].location != NSNotFound);
}

- (BOOL)cd_equalsString:(NSString *)str
{
    return (str != nil) && ([self length] == [str length]) && ([self rangeOfString:str options:NSCaseInsensitiveSearch].location == 0);
}

#pragma mark XML Extensions
+ (NSString *)cd_encodeXMLCharactersIn:(NSString *)source
{
    if (![source isKindOfClass:[NSString class]] || !source)
    {
        return @"";
    }
    
    NSString *result = [NSString stringWithString:source];
    
    if ([result rangeOfString:@"&"].location != NSNotFound)
    {
        result = [[result componentsSeparatedByString:@"&"] componentsJoinedByString:@"&amp;"];
    }
    
    if ([result rangeOfString:@"<"].location != NSNotFound)
    {
        result = [[result componentsSeparatedByString:@"<"] componentsJoinedByString:@"&lt;"];
    }
    
    if ([result rangeOfString:@">"].location != NSNotFound)
    {
        result = [[result componentsSeparatedByString:@">"] componentsJoinedByString:@"&gt;"];
    }
    
    if ([result rangeOfString:@"\""].location != NSNotFound)
    {
        result = [[result componentsSeparatedByString:@"\""] componentsJoinedByString:@"&quot;"];
    }
    
    if ([result rangeOfString:@"'"].location != NSNotFound)
    {
        result = [[result componentsSeparatedByString:@"'"] componentsJoinedByString:@"&apos;"];
    }
    
    return result;
}

+ (NSString *)cd_decodeXMLCharactersIn:(NSString *)source
{
    if (![source isKindOfClass:[NSString class]] || !source)
    {
        return @"";
    }
    
    NSString *result = [NSString stringWithString:source];
    
    if ([result rangeOfString:@"&amp;"].location != NSNotFound)
    {
        result = [[result componentsSeparatedByString:@"&amp;"] componentsJoinedByString:@"&"];
    }
    
    if ([result rangeOfString:@"&lt;"].location != NSNotFound)
    {
        result = [[result componentsSeparatedByString:@"&lt;"] componentsJoinedByString:@"<"];
    }
    
    if ([result rangeOfString:@"&gt;"].location != NSNotFound)
    {
        result = [[result componentsSeparatedByString:@"&gt;"] componentsJoinedByString:@">"];
    }
    
    if ([result rangeOfString:@"&quot;"].location != NSNotFound)
    {
        result = [[result componentsSeparatedByString:@"&quot;"] componentsJoinedByString:@"\""];
    }
    
    if ([result rangeOfString:@"&apos;"].location != NSNotFound)
    {
        result = [[result componentsSeparatedByString:@"&apos;"] componentsJoinedByString:@"'"];
    }
    
    if ([result rangeOfString:@"&nbsp;"].location != NSNotFound)
    {
        result = [[result componentsSeparatedByString:@"&nbsp;"] componentsJoinedByString:@" "];
    }
    
    if ([result rangeOfString:@"&#8220;"].location != NSNotFound)
    {
        result = [[result componentsSeparatedByString:@"&#8220;"] componentsJoinedByString:@"\""];
    }
    
    if ([result rangeOfString:@"&#8221;"].location != NSNotFound)
    {
        result = [[result componentsSeparatedByString:@"&#8221;"] componentsJoinedByString:@"\""];
    }
    
    if ([result rangeOfString:@"&#039;"].location != NSNotFound)
    {
        result = [[result componentsSeparatedByString:@"&#039;"] componentsJoinedByString:@"'"];
    }
    return result;
}

/**
 compare two version
 @param sourVersion *.*.*.*
 @param desVersion *.*.*.*
 @returns No,sourVersion is less than desVersion; YES, the statue is opposed
 */
+(BOOL)cd_compareVerison:(NSString *)sourVersion withDes:(NSString *)desVersion
{
    NSArray * sourArr = [sourVersion componentsSeparatedByString:@"."];
    NSArray * desArr = [desVersion componentsSeparatedByString:@"."];
    int sourInt, desInt;
    NSMutableString * sourStr = [[NSMutableString alloc] init];
    NSMutableString * desStr = [[NSMutableString alloc] init];
    
    if ([sourArr count] < [desArr count])
    {
        return YES;
    }
    else
    {
        
    }
    
    for (int i = 0; i < [sourArr count]; i ++)
    {
        [sourStr appendFormat:@"%@", [sourArr objectAtIndex:i]];
        [desStr appendFormat:@"%@", [desArr objectAtIndex:i]];
    }
    sourInt = [sourStr intValue];
    desInt = [desStr intValue];
    if (sourInt < desInt)
    {
        return YES;
    }
    else
    {
        return NO;
    }
    return NO;
    
}

- (NSString *)cd_emjoiText
{
    if (self.length)
    {
        
        NSData *data = [self dataUsingEncoding:NSNonLossyASCIIStringEncoding];
        NSString *valueUnicode = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSData *dataa = [valueUnicode dataUsingEncoding:NSUTF8StringEncoding];
        NSString *valueEmoj = [[NSString alloc] initWithData:dataa encoding:NSNonLossyASCIIStringEncoding];
        return valueEmoj;
    }
    else
    {
        return self;
    }
    
}

- (NSUInteger)cd_utf8Length
{
    size_t length = strlen([self UTF8String]);
    return length;
}

- (BOOL)cd_isContainsEmoji;
{
    __block BOOL returnValue = NO;
    
    [self enumerateSubstringsInRange:NSMakeRange(0, [self length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
        const unichar hs = [substring characterAtIndex:0];
        if (0xd800 <= hs && hs <= 0xdbff)
        {
            if (substring.length > 1)
            {
                const unichar ls = [substring characterAtIndex:1];
                const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                if (0x1d000 <= uc && uc <= 0x1f77f)
                {
                    returnValue = YES;
                }
            }
        }
        else if (substring.length > 1)
        {
            const unichar ls = [substring characterAtIndex:1];
            if (ls == 0x20e3)
            {
                returnValue = YES;
            }
        }
        else
        {
            if (0x2100 <= hs && hs <= 0x27ff)
            {
                returnValue = YES;
            }
            else if (0x2B05 <= hs && hs <= 0x2b07)
            {
                returnValue = YES;
            }
            else if (0x2934 <= hs && hs <= 0x2935)
            {
                returnValue = YES;
            }
            else if (0x3297 <= hs && hs <= 0x3299)
            {
                returnValue = YES;
            }
            else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50)
            {
                returnValue = YES;
            }
        }
        
        *stop = returnValue;
    }];
    
    return returnValue;
}

- (NSArray *)cd_rangsWithSubString:(NSString *)subString {
    int location = 0;
    NSMutableArray *locationArr = [NSMutableArray new];
    NSRange range = [self rangeOfString:subString];
    //声明一个临时字符串,记录截取之后的字符串
    NSString * subStr = self;
    while (range.location != NSNotFound) {
        [locationArr addObject:NSStringFromRange(NSMakeRange(range.location+location, range.length))];
        subStr = [subStr substringFromIndex:range.location+range.length];
        location += range.location + subString.length;
        range = [subStr rangeOfString:subString];
    }
    return [locationArr copy];
}

- (NSString *)cd_stringToUpper {
    NSString *str = self;
    for (NSInteger i =0 ; i < str.length ; i++) {
        if ([str characterAtIndex:i] >='a' & [str characterAtIndex:i] <='z') {
            char temp = [str characterAtIndex:i] -32;
            NSRange range =NSMakeRange(i,1);
            str = [str stringByReplacingCharactersInRange:range withString:[NSString stringWithFormat:@"%c",temp]];
        }
    }
    return str;
}

- (NSString *)cd_stringToLower {
    NSString *str = self;
    for(NSInteger i = 0 ; i < str.length ; i++) {
        if([str characterAtIndex:i] >='A'& [str characterAtIndex:i] <='Z') {
            char temp = [str characterAtIndex:i]+32;
            NSRange range =NSMakeRange(i,1);
            str = [str stringByReplacingCharactersInRange:range withString:[NSString stringWithFormat:@"%c",temp]];
        }
    }
    return str;
}
 
/**
 *  字符串是否是中文
 */
- (BOOL)cd_isChinese
{
    NSString *match = @"(^[\u4e00-\u9fa5]+$)";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF matches %@", match];
    return [predicate evaluateWithObject:self];
}
 
/**
 *  中文转拼音
 */
- (NSString *)cd_ChineseToPinyin {
    NSMutableString *pinyin = [self mutableCopy];
    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformMandarinLatin, NO);
    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformStripCombiningMarks, NO);
    pinyin = (NSMutableString *)[pinyin stringByReplacingOccurrencesOfString:@" " withString:@""];
    return pinyin;
}
 
/**
 *  字符串是否是数字
 *
 */
- (BOOL)cd_isNumber {
    if (!self) {
        return NO;
    }
    NSString *regex = @"^\\-?[0-9]+(\\.[0-9]+)?$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    if ([pred evaluateWithObject:self]) {
        return YES;
    }
    return NO;
}

@end
