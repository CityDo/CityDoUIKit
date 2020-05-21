//
//  UIControl+CityDoCommon.m
//  CityDoCommon
//
//  Created by volientDuan on 2020/5/18.
//  Copyright © 2020 CityDo. All rights reserved.
//

#import "UIControl+CityDoCommon.h"
#import <objc/runtime.h>

/**
 事件回调响应类
 */
@interface CDEventCallbackMaker : NSObject
@property (nonatomic, copy)CDControlEventBlock callback;
+ (instancetype)makeWithControl:(UIControl *)target event:(UIControlEvents)evt callback:(CDControlEventBlock)callback;
- (void)controlEventAction:(id)sender;

@end
@implementation CDEventCallbackMaker

+ (instancetype)makeWithControl:(UIControl *)control event:(UIControlEvents)evt callback:(CDControlEventBlock)callback {
    
    CDEventCallbackMaker *maker = [[CDEventCallbackMaker alloc]init];
    maker.callback = callback;
    [control addTarget:maker action:@selector(controlEventAction:) forControlEvents:evt];
    return maker;
}

- (void)controlEventAction:(id)sender {
    
    if (self.callback) {
        self.callback(sender);
    }
}

@end

static char *CDEventCallbacksKey = "CDEventCallbacksKey";

/**
 事件回调管理者
 */
@interface UIControl (CDEventCallbacks)
@property (nonatomic, strong)NSMutableDictionary *cdEventcallBacks;

@end

@implementation UIControl (CDEventCallbacks)

- (void)setCdEventcallBacks:(NSMutableDictionary *)cdEventcallBacks {
    objc_setAssociatedObject(self, CDEventCallbacksKey, cdEventcallBacks, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSMutableDictionary *)cdEventcallBacks {
    NSMutableDictionary *dic = objc_getAssociatedObject(self, CDEventCallbacksKey);
    if (!dic) {
        dic = [NSMutableDictionary dictionary];
        self.cdEventcallBacks = dic;
    }
    return dic;
}

@end

@implementation UIControl (CityDoCommon)

- (void)cd_setEvt:(UIControlEvents)evt callback:(CDControlEventBlock)callback {
    CDEventCallbackMaker *maker = [CDEventCallbackMaker makeWithControl:self event:evt callback:callback];
    [self.cdEventcallBacks setValue:maker forKey:[@(evt) stringValue]];
}

- (void)cd_touchUpInsideEvent:(CDControlEventBlock)block {
    [self cd_setEvt:UIControlEventTouchUpInside callback:block];
}

- (void)cd_valueChangedEvent:(CDControlEventBlock)block {
    [self cd_valueChangedEvent:block];
}

- (void)cd_event:(UIControlEvents)event block:(CDControlEventBlock)block {
    [self cd_setEvt:event callback:block];
}

@end
