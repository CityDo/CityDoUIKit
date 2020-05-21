//
//  CityDoAppTool.m
//  CityDoCommon
//
//  Created by CityDoWCY on 2020/5/20.
//  Copyright © 2020 CityDo. All rights reserved.
//

#import "CityDoAppTool.h"

@implementation CityDoAppTool

#pragma mark - 打开App Store
+ (BOOL)openAppStoreWithAppId:(NSString *)appId {
    
    NSString *urlPath = [@"itms-apps://itunes.apple.com/cn/app/id" stringByAppendingString:appId];
    return [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlPath]];
    
}

+ (BOOL)openAPPCommenWithAppId:(NSString *)appid {
    
    NSString *str = [NSString stringWithFormat:
                     @"http://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?id=%@&pageNumber=0&sortOrdering=2&type=Purple+Software&mt=8",
                     appid];
    return [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    
}

#pragma mark - 拨打电话
+ (void)telWithPhoneNumber:(NSString *)phoneNumber {
    // 拨打电话的几种方法 请详看我的博客----iOS 拨打电话（解决openURL延迟和不同方法比较）[https://www.cnblogs.com/weicyNo-1/p/7151605.html]
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[@"tel:" stringByAppendingString: phoneNumber]]];
}

#pragma mark - 打开链接
+ (void)gotoSafariBrowserWithURL:(NSString *)urlStr {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlStr]];
}

#pragma mark - 计算缓存
// 显示缓存大小
+ (CGFloat)calculateCacheSize {
    NSString *cachPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask,YES) firstObject];
    return [[CityDoAppTool new] folderSizeAtPath:cachPath];
}


//1:首先我们计算一下 单个文件的大小
- (long long)fileSizeAtPath:(NSString *)filePath{
    NSFileManager * manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath :filePath]){
        return [[manager attributesOfItemAtPath: filePath error: nil ] fileSize];
    }
    return 0;
}

//2:遍历文件夹获得文件夹大小，返回多少 M（提示：你可以在工程界设置（)m）
- (CGFloat)folderSizeAtPath:(NSString *) folderPath{
    NSFileManager *manager = [NSFileManager defaultManager];
    
    if (![manager fileExistsAtPath:folderPath]) return 0;
    
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:folderPath] objectEnumerator];
    NSString * fileName;
    long long folderSize = 0;
    while ((fileName = [childFilesEnumerator nextObject]) != nil){
        NSString *fileAbsolutePath = [folderPath stringByAppendingPathComponent: fileName];
        folderSize += [self fileSizeAtPath: fileAbsolutePath];
    }
    
    return folderSize/(1024.0 * 1024.0);
}

// 清理缓存
+ (void)clearAllCacheEndClearBlock:(void(^)(BOOL isSuccess))block {
    NSString *cachPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask,YES) firstObject];
    NSArray *files = [[NSFileManager defaultManager] subpathsAtPath:cachPath];
    
    for (NSString *p in files) {
        NSError *error = nil;
        NSString *path = [cachPath stringByAppendingPathComponent:p];
        if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
            [[NSFileManager defaultManager] removeItemAtPath:path error:&error];
        }
        if (error) {
            block(NO);
            return;
        }
    }
    block(YES);
}

@end
