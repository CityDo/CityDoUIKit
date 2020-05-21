//
//  UIImage+CityDoCommon.h
//  CityDoCommon
//
//  Created by volientDuan on 2020/5/19.
//  Copyright © 2020 CityDo. All rights reserved.
//
#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, CDImageQuality){
    CDImageQualityHigh = 0,
    CDImageQualityMedium,
    CDImageQualityLow
};
@interface UIImage (CityDoCommon)

- (UIImage *)cd_imageBlackToTransparent;

/// 将指定视图生成图片
+ (UIImage *)cd_imageWithView:(UIView *)view scale:(CGFloat)scale;

// 通过颜色生成一张图片
+ (UIImage *)cd_imageWithColor:(UIColor *)color size:(CGSize)size;
/// 给图片切割圆角
+ (UIImage *)cd_setCornerWithImage:(UIImage *)image cornerRadius:(CGFloat)cornerRadius;
/// 根据颜色生成一张带圆角的图片
+ (UIImage *)cd_imageWithColor:(UIColor *)color size:(CGSize)size cornerRadius:(CGFloat)cornerRadius;

/// 压缩图片
- (UIImage *)cd_compress:(CDImageQuality)quality;

/// 压缩到指定大小,谨慎使用,过小可能会影响图片质量
- (UIImage *)cd_compressToByte:(NSUInteger)maxLength;

@end
