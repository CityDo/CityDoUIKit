//
//  CityDoNotiHelper.h
//  CityDoCommon
//
//  Created by volientDuan on 2020/5/18.
//  Copyright © 2020 CityDo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CityDoNotiHelper : NSObject
@property (nonatomic, copy)NSMutableDictionary *notiBlockDic;

+ (void)postNotiWithName:(NSNotificationName)name object:(id)object;

- (void)addNotiWithName:(NSNotificationName)notiName block:(void (^)(id))block;
- (void)removeWithName:(NSNotificationName)name;
- (void)remove;

@end

@interface NSObject (cdNotiHelper)
- (void)cd_notiWithName:(NSNotificationName)name block:(void(^)(id info))block;

@end
