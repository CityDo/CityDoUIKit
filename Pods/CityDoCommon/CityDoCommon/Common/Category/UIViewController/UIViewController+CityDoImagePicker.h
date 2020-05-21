//
//  UIViewController+CityDoImagePicker.h
//  CityDoCommon
//
//  Created by CityDoWCY on 2020/5/20.
//  Copyright © 2020 CityDo. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ImagePickerCompletionHandler)(NSData * _Nonnull imageData, UIImage * _Nonnull image);


NS_ASSUME_NONNULL_BEGIN

/// 一行代码调用系统相机相册
@interface UIViewController (CityDoImagePicker)

/// 调用相机相册 不带裁剪
/// @param completionHandler 回调会把图片data和image传回去
- (void)pickImageWithCompletionHandler:(ImagePickerCompletionHandler)completionHandler;

/// 调用相机相册 带裁剪尺寸
/// @param imageSize 图片的尺寸
/// @param completionHandler 回调会把图片data和image传回去
- (void)pickImageWithpickImageCutImageWithImageSize:(CGSize)imageSize CompletionHandler:(ImagePickerCompletionHandler)completionHandler;


@end

NS_ASSUME_NONNULL_END
