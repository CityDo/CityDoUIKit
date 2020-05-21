//
//  CityDoNetWork.m
//  CityDoCommon
//
//  Created by volientDuan on 2020/5/19.
//  Copyright © 2020 CityDo. All rights reserved.
//

#import "CityDoNetWork.h"

@interface CityDoNetWork()
@property (nonatomic, strong)AFHTTPSessionManager *manager;
@property (nonatomic, assign)AFNetworkReachabilityStatus safeNetworkStatus;

@end
@implementation CityDoNetWork

+ (instancetype)shareInstance {
    
    static dispatch_once_t onceToken;
    static CityDoNetWork *instance = nil;
    dispatch_once(&onceToken, ^{
        instance = [[CityDoNetWork alloc] init];
    });
    return instance;
}

- (instancetype)init {
    if (self = [super init]) {
        self.timeoutInterval = 30;
        [[AFNetworkReachabilityManager sharedManager] startMonitoring];
        [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            self.safeNetworkStatus = status;
            if (self.networkStatusChangeBlock) {
                self.networkStatusChangeBlock(status);
            }
        }];
    }
    return self;
}

- (AFHTTPSessionManager *)manager {
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
        _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/json", @"text/plain", @"text/javascript", @"text/xml", @"image/*", nil];
    }
    return _manager;
}

- (NSDictionary *)setPublicParams {
    
    if (self.headerHandler) {
        return self.headerHandler();
    }
    return @{};
    
}

- (NSURLSessionDataTask *)request:(NSString *)url method:(CDMethod)method type:(CDParamsType)type parameters:(id)parameters uploadProgress:(void (^)(NSProgress *uploadProgress))uploadProgress success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    
    
    return [self.manager cd_requestWithHTTPMethod:method URLString:url headers:[self setPublicParams] paramsType:type parameters:parameters handler:^(AFHTTPSessionManager * manager) {
        // 额外配置
        // 设置请求超时时间
        manager.requestSerializer.timeoutInterval = self.timeoutInterval;
        if (self.requestHandler) {
            self.requestHandler(manager);
        }
        
    } uploadProgress:uploadProgress success:^(id resp) {
        BOOL callbacked = NO;
        if (self.responseHandler) {
            callbacked = self.responseHandler(resp, nil, success, failure);
        }
        if (!callbacked && success){
            success(resp);
        }
        
        
    } failure:^(NSError *err) {
        BOOL callbacked = NO;
        if (self.responseHandler) {
            callbacked = self.responseHandler(nil, err, success, failure);
        }
        if (!callbacked && failure) {
            failure(err);
        }
        
    }];
}

- (void)GET:(NSString *)path params:(id)params success:(CDSuccessBlock)success failuer:(CDFailureBlock)fail {
    
    [self request:path method:CDMethodGET type:CDParamsTypeQuery parameters:params uploadProgress:nil success:success failure:fail];
}

- (void)POST:(NSString *)path params:(id)params success:(CDSuccessBlock)success failuer:(CDFailureBlock)fail {
    
    [self request:path method:CDMethodPOST type:CDParamsTypeURL parameters:params uploadProgress:nil success:success failure:fail];
}

- (void)PUT:(NSString *)path params:(id)params success:(CDSuccessBlock)success failuer:(CDFailureBlock)fail {
    
    [self request:path method:CDMethodPUT type:CDParamsTypeURL parameters:params uploadProgress:nil success:success failure:fail];
}

- (void)DELETE:(NSString *)path params:(id)params success:(CDSuccessBlock)success failuer:(CDFailureBlock)fail {
    
    [self request:path method:CDMethodDELETE type:CDParamsTypeURL parameters:params uploadProgress:nil success:success failure:fail];
}

- (void)PUT_JSON:(NSString *)path params:(id)params success:(CDSuccessBlock)success failuer:(CDFailureBlock)fail {
    
    [self request:path method:CDMethodPUT type:CDParamsTypeJSON parameters:params uploadProgress:nil success:success failure:fail];
}

- (void)POST_JSON:(NSString *)path params:(id)params success:(CDSuccessBlock)success failuer:(CDFailureBlock)fail {
    
    [self request:path method:CDMethodPOST type:CDParamsTypeJSON parameters:params uploadProgress:nil success:success failure:fail];
}

- (void)DELETE_JSON:(NSString *)path params:(id)params success:(CDSuccessBlock)success failuer:(CDFailureBlock)fail {
    
    [self request:path method:CDMethodDELETE type:CDParamsTypeJSON parameters:params uploadProgress:nil success:success failure:fail];
}

/// 自建证书
- (void)setSecurityPolicyWithCerPath:(NSString *)cerPath validatesDomainName:(BOOL)validatesDomainName {
    NSData *cerData = [NSData dataWithContentsOfFile:cerPath];
    // 使用证书验证模式
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
    // 如果需要验证自建证书(无效证书)，需要设置为YES
    securityPolicy.allowInvalidCertificates = YES;
    // 是否需要验证域名，默认为YES;
    securityPolicy.validatesDomainName = validatesDomainName;
    securityPolicy.pinnedCertificates = [[NSSet alloc] initWithObjects:cerData, nil];
    
    [self.manager setSecurityPolicy:securityPolicy];
}



@end
