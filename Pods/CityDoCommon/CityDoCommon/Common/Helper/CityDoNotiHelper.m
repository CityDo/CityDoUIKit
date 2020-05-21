//
//  CityDoNotiHelper.m
//  CityDoCommon
//
//  Created by volientDuan on 2020/5/18.
//  Copyright © 2020 CityDo. All rights reserved.
//

#import "CityDoNotiHelper.h"
#import <objc/runtime.h>

@implementation CityDoNotiHelper

- (NSMutableDictionary *)notiBlockDic {
    if (!_notiBlockDic) {
        _notiBlockDic = [NSMutableDictionary dictionary];
    }
    return _notiBlockDic;
}

+ (void)postNotiWithName:(NSNotificationName)name object:(id)object {
    [[NSNotificationCenter defaultCenter]postNotificationName:name object:object];
}

- (void)addNotiWithName:(NSNotificationName)notiName block:(void (^)(id))block {
    [self.notiBlockDic setValue:block forKey:notiName];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(cdNotiAction:) name:notiName object:nil];
}

- (void)cdNotiAction:(NSNotification *)noti {
    ((void(^)(id info))[self.notiBlockDic valueForKey:noti.name])(noti.object);
}

- (void)removeWithName:(NSNotificationName)name {
    [self.notiBlockDic removeObjectForKey:name];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:name object:nil];
}

- (void)remove {
    [self.notiBlockDic removeAllObjects];
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (void)dealloc {
    [self remove];
}

@end

@interface NSObject()
@property (nonatomic, strong)CityDoNotiHelper *cdNotiHelper;

@end

static char *cdNotiHelperKey = "cdNotiHelper";

@implementation NSObject (cdNotiHelper)

- (void)cd_notiWithName:(NSNotificationName)name block:(void (^)(id))block {
    [self.cdNotiHelper addNotiWithName:name block:block];
}

#pragma mark - preperty

- (void)setcdNotiHelper:(CityDoNotiHelper *)cdNotiHelper {
    objc_setAssociatedObject(self, cdNotiHelperKey, cdNotiHelper, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CityDoNotiHelper *)cdNotiHelper {
    CityDoNotiHelper *helper = objc_getAssociatedObject(self, cdNotiHelperKey);
    if (!helper) {
        helper = [[CityDoNotiHelper alloc]init];
        objc_setAssociatedObject(self, cdNotiHelperKey, helper, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return helper;
}

@end
