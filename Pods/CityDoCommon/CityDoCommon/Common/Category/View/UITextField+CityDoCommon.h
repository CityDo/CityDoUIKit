//
//  UITextField+CityDoCommon.h
//  CityDoCommon
//
//  Created by volientDuan on 2020/5/19.
//  Copyright © 2020 CityDo. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^CDTextValueCallBack)(NSString *value);

@interface UITextField (CityDoCommon)

@property (nonatomic, strong)UIColor *cd_placeholderColor;
@property (nonatomic, strong)UIFont *cd_placeholderFont;
@property (nonatomic, copy)NSString *cd_placeholder;

/// 监听textField文本输入 自动忽略中文输入高亮文字
- (void)cd_textChanged:(CDTextValueCallBack)callback;

@end
