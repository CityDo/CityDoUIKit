//
//  UIColor+CityDoHexColor.h
//  CityDoCommon
//
//  Created by volientDuan on 2020/5/18.
//  Copyright © 2020 CityDo. All rights reserved.
//
#import <UIKit/UIKit.h>

@interface UIColor (CityDoHexColor)
/* eg: hexString  =  @"#FFFFFF", @"FFFFFF", @"0xFFFFFF" ... */
+ (UIColor *)cd_colorWithHexString:(NSString *)hexString;
+ (UIColor *)cd_colorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha;

@end
