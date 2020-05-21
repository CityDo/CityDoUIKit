//
//  UIView+CDInitialize.m
//  CityDoCommon
//
//  Created by volientDuan on 2020/5/19.
//  Copyright © 2020 CityDo. All rights reserved.
//

#import "UIView+CDInitialize.h"

@implementation UIView (CDInitialize)

+ (instancetype)cd_buttonWithFrame:(CGRect)frame
                             image:(UIImage *)image
                             title:(NSString *)title
                        titleColor:(UIColor *)titleColor
                              font:(UIFont *)font {
    
    UIButton *btn = [[UIButton alloc]initWithFrame:frame];
    [btn setImage:image forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    btn.titleLabel.font = font;
    return btn;
}

+ (instancetype)cd_labelWithFrame:(CGRect)frame
                            title:(NSString *)title
                            color:(UIColor *)color
                             font:(UIFont *)font {
    
    UILabel *label = [[UILabel alloc]initWithFrame:frame];
    label.textColor = color;
    label.font = font;
    label.text = title;
    return label;
}

+ (instancetype)cd_textFieldWithFrame:(CGRect)frame
                            textColor:(UIColor *)textColor
                                 font:(UIFont *)font
                          placeholder:(NSString *)placeholder {
    
    UITextField *textField = [[UITextField alloc]initWithFrame:frame];
    textField.textColor = textColor;
    textField.font = font;
    textField.placeholder = placeholder;
    return textField;
}

@end
