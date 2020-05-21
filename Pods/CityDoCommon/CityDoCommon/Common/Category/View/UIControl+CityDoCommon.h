//
//  UIControl+CityDoCommon.h
//  CityDoCommon
//
//  Created by volientDuan on 2020/5/18.
//  Copyright © 2020 CityDo. All rights reserved.
//
#import <UIKit/UIKit.h>

typedef void (^CDControlEventBlock)(UIControl *sender);

@interface UIControl (CityDoCommon)

- (void)cd_touchUpInsideEvent:(CDControlEventBlock)block;

- (void)cd_valueChangedEvent:(CDControlEventBlock)block;

- (void)cd_event:(UIControlEvents)event block:(CDControlEventBlock)block;

@end
