//
//  NSMutableAttributedString+CityDoCommon.m
//  CityDoCommon
//
//  Created by volientDuan on 2020/5/18.
//  Copyright © 2020 CityDo. All rights reserved.
//

#import "NSMutableAttributedString+CityDoCommon.h"
#import "NSString+CityDoCommon.h"

@implementation NSMutableAttributedString (CityDoCommon)

- (NSMutableAttributedString *)cd_setColor:(UIColor *)color range:(NSRange)range{
    [self addAttribute:NSForegroundColorAttributeName value:color range:range];
    return self;
}
- (NSMutableAttributedString *)cd_setFont:(UIFont *)font range:(NSRange)range{
    [self addAttribute:NSFontAttributeName value:font range:range];
    return self;
}
- (NSMutableAttributedString *)cd_setUnderline:(NSRange)range{
    [self addAttribute:NSUnderlineStyleAttributeName value:@1 range:range];
    return self;
}

- (NSMutableAttributedString *)cd_setFont:(UIFont *)font color:(UIColor *)color range:(NSRange)range {
    if (font) {
        [self cd_setFont:font range:range];
    }
    if (color) {
        [self cd_setColor:color range:range];
    }
    return self;
}

- (NSMutableAttributedString *)cd_setFont:(UIFont *)font color:(UIColor *)color text:(NSString *)text index:(NSInteger)index {
    
    if (index < 0) {
        NSArray *rangs = [self.string cd_rangsWithSubString:text];
        for (NSString *rangStr in rangs) {
            [self cd_setFont:font color:color range:NSRangeFromString(rangStr)];
        }
    } else if (index == 0) {
        NSRange range = [self.string rangeOfString:text];
        if (range.location != NSNotFound) {
            [self cd_setFont:font color:color range:range];
        }
    } else {
        NSArray *rangs = [self.string cd_rangsWithSubString:text];
        if (rangs.count > index) {
            [self cd_setFont:font color:color range:NSRangeFromString(rangs[index])];
        }
    }
    return self;
}

@end
