//
//  AFHTTPSessionManager+CityDoNetWork.m
//  CityDoCommon
//
//  Created by volientDuan on 2020/5/18.
//  Copyright © 2020 CityDo. All rights reserved.
//

#import "AFHTTPSessionManager+CityDoNetWork.h"

@implementation AFHTTPSessionManager (CityDoNetWork)


- (NSURLSessionDataTask *)dataTaskWithHTTPMethod:(NSString *)method
                                       URLString:(NSString *)URLString
                                      parameters:(id)parameters
                                  uploadProgress:(nullable void (^)(NSProgress *uploadProgress)) uploadProgress
                                downloadProgress:(nullable void (^)(NSProgress *downloadProgress)) downloadProgress
                                         success:(void (^)(NSURLSessionDataTask *, id))success
                                         failure:(void (^)(NSURLSessionDataTask *, NSError *))failure
{
    NSError *serializationError = nil;
    NSMutableURLRequest *request = [self.requestSerializer requestWithMethod:method URLString:[[NSURL URLWithString:URLString relativeToURL:self.baseURL] absoluteString] parameters:parameters error:&serializationError];
    if (serializationError) {
        if (failure) {
            dispatch_async(self.completionQueue ?: dispatch_get_main_queue(), ^{
                failure(nil, serializationError);
            });
        }

        return nil;
    }

    __block NSURLSessionDataTask *dataTask = nil;
    dataTask = [self dataTaskWithRequest:request
                          uploadProgress:uploadProgress
                        downloadProgress:downloadProgress
                       completionHandler:^(NSURLResponse * __unused response, id responseObject, NSError *error) {
        if (error) {
            if (failure) {
                failure(dataTask, error);
            }
        } else {
            if (success) {
                success(dataTask, responseObject);
            }
        }
    }];

    return dataTask;
}

#pragma mark - custom

- (NSURLSessionDataTask *)cd_requestWithHTTPMethod:(CDMethod)method
                                      URLString:(NSString *)URLString
                                        headers:(id)headers
                                     paramsType:(CDParamsType)paramsType
                                     parameters:(id)parameters
                                        handler:(void (^)(AFHTTPSessionManager *))handler
                                 uploadProgress:(void (^)(NSProgress *uploadProgress))uploadProgress
                                        success:(void (^)(id))success
                                        failure:(void (^)(NSError *))failure{
    
    // 请求方法
    NSString *methodName = @"GET";
    switch (method) {
        case CDMethodGET:
            methodName = @"GET";
            break;
        case CDMethodPOST:
            methodName = @"POST";
            break;
        case CDMethodPUT:
            methodName = @"PUT";
            break;
        case CDMethodDELETE:
            methodName = @"DELETE";
            break;
        default:
            break;
    }
    
    // 参数方式
    
    switch (paramsType) {
        case CDParamsTypeURL:
            self.requestSerializer = [[AFHTTPRequestSerializer alloc]init];
            break;
        case CDParamsTypeJSON:
            self.requestSerializer = [[AFJSONRequestSerializer alloc]init];
            break;
        case CDParamsTypeQuery:
            self.requestSerializer = [[AFHTTPRequestSerializer alloc]init];
            break;
        default:
        {
            if (method == CDMethodGET || method == CDMethodDELETE) {
                // 设置GET和DELETE方法传递参数 urlencoded
                self.requestSerializer = [[AFHTTPRequestSerializer alloc]init];
            } else {
                // 设置POST和PUT方法传递参数为 JSON
                self.requestSerializer = [[AFJSONRequestSerializer alloc]init];
            }
        }
            break;
    }
    
    if (paramsType == CDParamsTypeQuery && method == CDMethodPOST) {
        if ([parameters isKindOfClass:[NSDictionary class]]) {
            NSMutableString *mutableStr = [[NSMutableString alloc]init];
            for (NSString *key in ((NSDictionary *)parameters).allKeys) {
                [mutableStr appendFormat:@"%@%@=%@",mutableStr.length?@"&":@"",key,[parameters valueForKey:key]];
            }
            if (mutableStr.length) {
                URLString = [NSString stringWithFormat:@"%@%@%@",URLString,[URLString containsString:@"?"]?@"&":@"?",mutableStr];
                parameters = nil;
            }
        }
       
    }
    
    // 设置header
    if (headers && [headers isKindOfClass:[NSDictionary class]]) {
        
        for (NSString *key in ((NSDictionary *)headers).allKeys) {
            
            [self.requestSerializer setValue:[headers valueForKey:key] forHTTPHeaderField:key];
        }
    }
    
    // 最后添加个额外handler
    if (handler) {
        handler(self);
    }
    
    NSURLSessionDataTask *dataTask = nil;
    
    // 如果是表单数据 强制POST 并调用图片上传接口
    if (paramsType == CDParamsTypeFormData) {
        
        return [self uploadImagesWithURL:URLString parameters:parameters uploadProgress:uploadProgress success:success failure:failure];
        
    }
    
    dataTask = [self dataTaskWithHTTPMethod:methodName URLString:URLString parameters:parameters uploadProgress:^(NSProgress *uploadProgress) {
        
    } downloadProgress:^(NSProgress *downloadProgress) {
        
    } success:^(NSURLSessionDataTask *task, id resp) {
        
        if (success) {
            success(resp);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *err) {
        
        if (failure) {
            failure(err);
        }
    }];
    
    if (dataTask) {
        [dataTask resume];
    }
    return dataTask;
}

- (NSURLSessionDataTask *)uploadImagesWithURL:(NSString *)url
                 parameters:(id)parameters
             uploadProgress:(void (^)(NSProgress *uploadProgress))uploadProgress
                    success:(void (^)(id))success
                    failure:(void (^)(NSError *))failure  {
    
    NSMutableDictionary *images = [NSMutableDictionary dictionary];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if (parameters && [parameters isKindOfClass:[NSDictionary class]]) {
        for (NSString *key in ((NSDictionary *)parameters).allKeys) {
            
            id value = [parameters valueForKey:key];
            if ([value isKindOfClass:[NSData class]]) {
                
                [images setValue:value forKey:key];
            } else if ([value isKindOfClass:[UIImage class]]) {
                
                [images setValue:UIImageJPEGRepresentation(value, 0.1) forKey:key];
            } else {
                [params setValue:value forKey:key];
            }
        }
    }
    return [self POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        //参数介绍
        //fileData : 图片资源  name : 预定key   fileName  : 文件名  mimeType    : 资源类型(根据后台进行对应配置)
        for (NSString *key in images.allKeys) {
            [formData appendPartWithFileData:[images valueForKey:key] name:key  fileName:@"default.jpg" mimeType:@"image/jpeg"];
        }
    } progress:uploadProgress success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
    
}

@end
