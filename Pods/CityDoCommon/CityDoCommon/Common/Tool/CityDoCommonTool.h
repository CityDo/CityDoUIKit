//
//  CItyDoCommonTool.h
//  CityDoCommon
//
//  Created by volientDuan on 2020/5/18.
//  Copyright © 2020 CityDo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 设置页分类
 - VDSetPageTypeApp: 本项目
 - VDSetPageTypeBluetooth: 蓝牙
 - VDSetPageTypeLocation: 定位服务
 - VDSetPageTypeVPN: VPN
 - VDSetPageTypeWIFI: WIFI
 - VDSetPageTypeKeyboard: 键盘
 - VDSetPageTypeGeneral: 通用
 */
typedef NS_ENUM(NSInteger, VDSetPageType){
    VDSetPageTypeApp = 0,
    VDSetPageTypeBluetooth,
    VDSetPageTypeLocation,
    VDSetPageTypeVPN,
    VDSetPageTypeWIFI,
    VDSetPageTypeKeyboard,
    VDSetPageTypeGeneral
};

@interface CityDoCommonTool : NSObject

#pragma mark - 距离

+ (CGFloat)getStrWidthByHeight:(CGFloat)h font:(UIFont *)font str:(NSString *)str;
+ (CGFloat)getStrHeightByWidth:(CGFloat)w font:(UIFont *)font str:(NSString *)str;
+ (CGFloat)getStrHeightByWidth:(CGFloat)w str:(NSString *)str attributeDict:(NSMutableDictionary *)attr;
//设置行高
+ (NSMutableDictionary *)setLineHeightWithH:(CGFloat)h;
//改变字体的行间距
+ (NSMutableAttributedString *)changeLineSpaceWithString:(NSString *)str lineSpace:(CGFloat)lineSpace;
//改变字体的行间距
+ (NSMutableAttributedString *)changeLineSpaceWithString:(NSString *)str lineSpace:(CGFloat)lineSpace textAlignment:(NSTextAlignment)textAlignment;
+ (UIViewController *)getCurrentViewControllerOfView:(UIView *)theView;

#pragma mark - 二维码生成

+ (UIImage *)qrImageForString:(NSString *)string imageWidth:(CGFloat)ImageWidth;
+ (UIImage *)qrCodeImage:(UIImage *)codeImage logo:(UIImage *)logo;

#pragma mark - 视图

/// 虚线
+ (UIView *)createDashLine:(CGRect)frame lineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor;

#pragma mark - 其它

+ (void)toSetPage:(VDSetPageType)type;

@end
