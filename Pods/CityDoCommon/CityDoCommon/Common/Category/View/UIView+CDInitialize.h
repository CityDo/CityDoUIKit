//
//  UIView+CDInitialize.h
//  CityDoCommon
//
//  Created by volientDuan on 2020/5/19.
//  Copyright © 2020 CityDo. All rights reserved.
//
#import <UIKit/UIKit.h>

@interface UIView (CDInitialize)

+ (instancetype)cd_buttonWithFrame:(CGRect)frame
                             image:(UIImage *)image
                             title:(NSString *)title
                        titleColor:(UIColor *)titleColor
                              font:(UIFont *)font;

+ (instancetype)cd_labelWithFrame:(CGRect)frame
                            title:(NSString *)title
                            color:(UIColor *)color
                             font:(UIFont *)font;

+ (instancetype)cd_textFieldWithFrame:(CGRect)frame
                            textColor:(UIColor *)textColor
                                 font:(UIFont *)font
                          placeholder:(NSString *)placeholder;


@end
