//
//  UIColor+CityDoCommon.m
//  CityDoCommon
//
//  Created by volientDuan on 2020/5/18.
//  Copyright © 2020 CityDo. All rights reserved.
//

#import "UIColor+CityDoCommon.h"

@implementation UIColor (CityDoCommon)

+ (UIColor *)cd_randomColor {
    return [UIColor vd_randomColorWithAlpha:1.0];
}

+ (UIColor *)vd_randomColorWithAlpha:(CGFloat)alpha {
    int R = (arc4random() % 256);
    int G = (arc4random() % 256);
    int B = (arc4random() % 256);
    return [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:alpha];
}

@end
