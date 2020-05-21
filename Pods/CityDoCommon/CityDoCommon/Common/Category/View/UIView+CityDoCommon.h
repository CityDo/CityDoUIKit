//
//  UIView+CityDoCommon.h
//  CityDoCommon
//
//  Created by volientDuan on 2020/5/18.
//  Copyright © 2020 CityDo. All rights reserved.
//
#import <UIKit/UIKit.h>

@interface UIView (CityDoCommon)
#pragma mark [frame]

/**
 *  view的x(横)坐标
 */
@property (nonatomic, assign)CGFloat cd_x;
/**
 *  view的y(纵)坐标
 */
@property (nonatomic, assign)CGFloat cd_y;
/**
 *  view的宽度
 */
@property (nonatomic, assign)CGFloat cd_w;
/**
 *  view的高度
 */
@property (nonatomic, assign)CGFloat cd_h;
/**
 *  view的中心横坐标
 */
@property (nonatomic, assign)CGFloat cd_centerX;
/**
 *  view的中心纵坐标
 */
@property (nonatomic, assign)CGFloat cd_centerY;
/**
 *  view的上部
 */
@property (nonatomic, assign, readonly)CGFloat cd_top;
/**
 *  view的左部
 */
@property (nonatomic, assign, readonly)CGFloat cd_left;
/**
 *  view的底部
 */
@property (nonatomic, assign, readonly)CGFloat cd_bottom;
/**
 *  view的右部
 */
@property (nonatomic, assign, readonly)CGFloat cd_right;

/**
 *  view的size
 */
@property (nonatomic, assign)CGSize cd_size;
/**
 *  view的origin
 */
@property (nonatomic, assign)CGPoint cd_origin;


#pragma mark [layer]

/**
 *  view的圆角半径
 */
@property (nonatomic, assign)CGFloat cd_cornerRadius;

/**
 获取渐变layer：注意frame问题
 ps: 通过设置此渐变图层的mask可以实现多重形状的渐变图形：文字，边框，多边形等；是通过裁剪mask图层的透明部分保留不透明部分而实现不同的渐变效果
 
 @param colors 颜色组合 →
 @param frame 颜色覆盖位置
 @param isHorizontal 水平排列 or 竖直排列
 @return CAGradientLayer 渐变图层
 */
- (CAGradientLayer *)cd_getColorsLayer:(NSArray *)colors frame:(CGRect)frame isHorizontal:(BOOL)isHorizontal;

/**
 清除渐变色
 */
- (void)cd_clearColors;

/**
 设置渐变背景色：注意frame问题
 如果需要清除渐变背景色，设置nil即可
 */
@property (nonatomic, copy)NSArray<UIColor *> *cd_backgroundColors;

/**
 字体颜色渐变 针对label
 如果需要清除渐变背景色，设置nil即可
 */
@property (nonatomic, copy)NSArray<UIColor *> *cd_textColors;


- (void)cd_singleTap:(void(^)(UITapGestureRecognizer *tap))tap;

@end
