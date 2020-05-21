//
//  UIView+CityDoCorners.h
//  CityDoCommon
//
//  Created by CityDoWCY on 2020/5/20.
//  Copyright © 2020 CityDo. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, CDCornerRadiusType) {
    // 全部角都切圆角
    CDCornerRadiusTypeAll = 0,
   
    // 切三个角
    CDCornerRadiusTypeExceptTopLeft = 1,
    CDCornerRadiusTypeExceptTopRight = 2,
    CDCornerRadiusTypeExceptBottomLeft = 3,
    CDCornerRadiusTypeExceptBottomRight = 4,
    
    // 切两个角（同一边）
    CDCornerRadiusTypeTop = 5,
    CDCornerRadiusTypeLeft = 6,
    CDCornerRadiusTypeRight = 7,
    CDCornerRadiusTypeBottom = 8,
    
    // 切一个角
    CDCornerRadiusTypeTopLeft = 9,
    CDCornerRadiusTypeTopRight = 10,
    CDCornerRadiusTypeBottomLeft = 11,
    CDCornerRadiusTypeBottomRight = 12,
    
    // 对角线
    CDCornerRadiusTypeTopLeftToBottomRight = 13,
    CDCornerRadiusTypeTopRightToBottomLeft = 14,
};

NS_ASSUME_NONNULL_BEGIN

/**
UIView的扩展类
主要提供贝塞尔曲线切割圆角的方法
*/
@interface UIView (CityDoCorners)

/**
 切割圆角方法

 @param cornerType 切割类型
 @param cornerRadius 切割角度
 */
- (void)useBezierPathClipCornerWithType:(CDCornerRadiusType)cornerType WithCornerRadius:(CGFloat)cornerRadius;

/**
 切割圆角方法和添加边框

 @param cornerType 切割类型
 @param cornerRadius 切割角度
 @param color 颜色 例：[UIColor BlackColor] 方法里会转成CGColor
 @param width 宽度 例：1.0f
 
 */
- (void)useBezierPathClipCornerWithType:(CDCornerRadiusType)cornerType WithCornerRadius:(CGFloat)cornerRadius WithColor:(UIColor *)color withBorderWidth:(CGFloat)width;

/**
 添加边框
 使用CALayer添加边框 可以做到不切割圆角加线
 
 @param color 颜色 例：[UIColor BlackColor] 方法里会转成CGColor
 @param width 宽度 例：1.0f
 */
- (void)useCALayerMakeBorderLineWithColor:(UIColor *)color borderWidth:(CGFloat)width;


@end

NS_ASSUME_NONNULL_END
