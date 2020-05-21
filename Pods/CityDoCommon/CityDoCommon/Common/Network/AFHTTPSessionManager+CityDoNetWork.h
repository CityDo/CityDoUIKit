//
//  AFHTTPSessionManager+CityDoNetWork.h
//  CityDoCommon
//
//  Created by volientDuan on 2020/5/18.
//  Copyright © 2020 CityDo. All rights reserved.
//

#import "AFHTTPSessionManager.h"

typedef NS_ENUM(NSInteger, CDMethod) {
    CDMethodGET = 0,
    CDMethodPOST,
    CDMethodPUT,
    CDMethodDELETE
};


typedef NS_ENUM(NSInteger, CDParamsType) {
    CDParamsTypeDefault = 100,
    CDParamsTypeQuery,
    CDParamsTypeURL,
    CDParamsTypeJSON,
    CDParamsTypeFormData // 表单上传 - 现仅支持图片上传
};

@interface AFHTTPSessionManager (CityDoNetWork)

- (NSURLSessionDataTask *)cd_requestWithHTTPMethod:(CDMethod)method
     URLString:(NSString *)URLString
       headers:(id)headers
    paramsType:(CDParamsType)paramsType
    parameters:(id)parameters
       handler:(void (^)(AFHTTPSessionManager *))handler
uploadProgress:(void (^)(NSProgress *uploadProgress))uploadProgress
       success:(void (^)(id))success
       failure:(void (^)(NSError *))failure;

@end
