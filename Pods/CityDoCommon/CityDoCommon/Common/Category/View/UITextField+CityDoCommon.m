//
//  UITextField+CityDoCommon.m
//  CityDoCommon
//
//  Created by volientDuan on 2020/5/19.
//  Copyright © 2020 CityDo. All rights reserved.
//

#import "UITextField+CityDoCommon.h"
#import "UIControl+CityDoCommon.h"
#import <objc/runtime.h>

static char *CDPlaceholderColorKey = "cd_placeholderColor_key";
static char *CDPlaceholderFontKey = "cd_placeholderFont_key";
static char *CDPlaceholderKey = "cd_placeholder_key";

@implementation UITextField (CityDoCommon)

- (NSString *)cd_placeholder {
    NSString *str = objc_getAssociatedObject(self, CDPlaceholderKey);
    if (!str) {
        str = self.placeholder;
    }
    return str?:@"";
}

- (void)setCd_placeholder:(NSString *)cd_placeholder {
    objc_setAssociatedObject(self, CDPlaceholderKey, cd_placeholder, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    NSAttributedString *attrStr = [[NSAttributedString alloc]initWithString:cd_placeholder attributes:@{NSForegroundColorAttributeName:self.cd_placeholderColor
                                                                                                        , NSFontAttributeName:self.cd_placeholderFont}];
    self.attributedPlaceholder = attrStr;
}

- (UIColor *)cd_placeholderColor {
    UIColor *color = objc_getAssociatedObject(self, CDPlaceholderColorKey);
    return color?:UIColor.lightGrayColor;
}

- (void)setCd_placeholderColor:(UIColor *)cd_placeholderColor {
    objc_setAssociatedObject(self, CDPlaceholderColorKey, cd_placeholderColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    NSAttributedString *attrStr = [[NSAttributedString alloc]initWithString:self.cd_placeholder attributes:@{NSForegroundColorAttributeName:cd_placeholderColor, NSFontAttributeName:self.cd_placeholderFont}];
    self.attributedPlaceholder = attrStr;
}

- (UIFont *)cd_placeholderFont {
    UIFont *font = objc_getAssociatedObject(self, CDPlaceholderFontKey);
    return font?:self.font;
}

- (void)setCd_placeholderFont:(UIFont *)cd_placeholderFont {
    objc_setAssociatedObject(self, CDPlaceholderFontKey, cd_placeholderFont, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    NSAttributedString *attrStr = [[NSAttributedString alloc]initWithString:self.cd_placeholder attributes:@{NSForegroundColorAttributeName:self.cd_placeholderColor, NSFontAttributeName:cd_placeholderFont}];
    self.attributedPlaceholder = attrStr;
    
}

- (void)cd_textChanged:(CDTextValueCallBack)callback {
    [self cd_valueChangedEvent:^(UIControl *sender) {
        NSString *lang = [[UIApplication sharedApplication]textInputMode].primaryLanguage; // 键盘输入模
        UITextField *field = (UITextField *)sender;
        if ([lang isEqualToString:@"zh-Hans"]) { // 简体中文输入，包括简体拼音，健体五笔，简体手写
            UITextRange *selectedRange = [field markedTextRange];
            if (!selectedRange) {
                callback(field.text);
            }
        } else {
            callback(field.text);
        }
    }];
}

@end
