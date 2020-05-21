//
//  UIButton+CDPosition.h
//  CityDoCommon
//
//  Created by volientDuan on 2020/5/19.
//  Copyright © 2020 CityDo. All rights reserved.
//
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, CDButtonImagePositionType) {
    CDButtonImagePositionTypeTop, // image在上，label在下
    CDButtonImagePositionTypeLeft, // image在左，label在右
    CDButtonImagePositionTypeRight, // image在右，label在左
    CDButtonImagePositionTypeBottom // image在下，label在上
};

@interface UIButton (CDPosition)

- (void)cd_setEdgeStyle:(CDButtonImagePositionType)style space:(CGFloat)space;

@end
