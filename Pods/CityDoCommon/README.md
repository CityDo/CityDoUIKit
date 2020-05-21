# CityDoCommon
> CityDo iOS 通用组件 : 基础通用组件，变化不大，而且基本上每个项目都用到，项目中都要围绕这些组件来实现业务功能的组件

### 如何使用 

* CocoaPods 导入

```
pod 'CityDoCommon'
```

### 目录结构

```

-- CityDoCommon
    ---Network
        ---- CityDoNetWork // 网络请求管理类
    ---Helper
        ---- CityDoNotiHelper // 通知绑定和回调帮助类
    ---Category
        ---- UIViewController // 控制器扩展
             ---- CityDoImagePicker 相机相册快捷工具
        ---- UIView // 常见视图扩展
        ---- UIImage // 图片处理
        ---- UIApplication
        ---- UIDevice // 读取设备信息
        ---- Color  // 颜色扩展
        ---- NSDictionary  // 字典扩展
        ....
    ---Tool
        ---- CityDoDateFormatTool //时间格式化工具
        ---- CityDoFileTool // 文件管理工具
        ---- CityDoJumpTool // 跳转管理
        ---- CityDoCommonTool // 常用工具方法
        ---- CityDoAppTool // 常用APP调起外部和清理缓存工具

```


### 网络请求工具(CityDoNetWork)

> 对 [AFNetworking](https://github.com/AFNetworking/AFNetworking) 的二次封装，主要对`AFHTTPSessionManager`提供的方法进行重写和扩展并独立出通用的请求方法

#### 核心方法介绍

>  主要针对请求方式和参数传递方式的细分，后续的GET，POST独立方法都是通过调用此通用方法实现
```
- (NSURLSessionDataTask *)request:(NSString *)url
                           method:(CDMethod)method
                             type:(CDParamsType)type
                       parameters:(id)parameters
                   uploadProgress:(void (^)(NSProgress *uploadProgress))uploadProgress
                          success:(void (^)(id responseObject))success
                          failure:(void (^)(NSError *error))failure;
```
#### 参数详解

##### 常规参数
* timeoutInterval: 设置超时时间

* networkStatus: 网络状态读取

##### 处理回调入参

###### **headerHandler**

每次请求前会触发此回调，用于设置通用参数，建议在初始化后统一设置

###### **requestHandler**

每次请求前会触发此回调，用于请求处理，建议在初始化后统一设置

###### **responseHandler**

每次请求完成会触发此回调，用于返回结果的预处理，建议在初始化后统一设置
1. 可对结果的错误码进行处理: 登录失效等
2. 返回结果统一解析 字典转Model等
   
###### **networkStatusChangeBlock**

每次本地网络环境变动会触发此回调, 建议在初始化后统一设置

#### 使用示例

* 新创建 `NetworkHelper`类并引入头文件`#import "CityDoNetWork.h"`
* 初始化代码中处理header公共入参：比如token
  
```
// 设置请求头 一般是通用参数
    self.network.headerHandler = ^NSDictionary *{
        
        NSMutableDictionary *headers = [NSMutableDictionary dictionary];
        [headers setValue:@"hdhgjkasdhsajfhdjsahj" forKey:@"token"];
        [headers setValue:[@([UIDevice currentDevice].systemVersion.doubleValue) stringValue] forKey:@"systemVersion"];
        return [headers copy];
    };

```

* 初始化代码中拦截返回结果并解析

```
// 返回结果预处理
    self.network.responseHandler = ^BOOL(id resp, NSError *err, CDSuccessBlock success, CDFailureBlock fail) {
        
        BaseResponseModel *model = [BaseResponseModel new];
        if (err) {
            
            model.code = err.code;
            switch (model.code) {
                case -1009:
                    model.msg = @"无网络连接，请检查网络";
                    break;
                default:
                    model.msg = @"服务器开小差了，请稍候再试";
                    break;
            }
            
        } else {
            
            model = [BaseResponseModel mj_objectWithKeyValues:resp];
            if (model.code == 101) {
                // 登录失效
                // 1. 清除token 2.去登录 。。。。
            }
        }
        
        if (model.code == 200) { // 请求成功
            if (success) {
                success(model.data);
            } else {
                return NO;
            }
        } else {
            if (fail) {
                fail((id)model);
            } else {
                return NO;
            }
        }
        
        return YES;
    };
```
* 自定义成功失败回调block
* 自定义独立请求方式比如POST请求

```
- (void)POST:(NSString *)path parameters:(id)parameters success:(SMNetworkSuccessBlock)success fail:(SMNetworkFailBlock)fail {
    [self.network POST:[NSString stringWithFormat:@"%@%@",SMBaseURL, path] params:parameters success:success failuer:^(NSError *error) {
        if (fail) {
            fail((BaseResponseModel *)error);
        }
    }];
}
```

* 定义类方法-写业务请求

```
+ (void)login:(NSDictionary *)params success:(SMNetworkSuccessBlock)success fail:(SMNetworkFailBlock)fail {
    [[SMNetworkHelper shareHelper]POST:@"/login" parameters:params success:success fail:fail];
}
```

更多细节请参考demo中 [NetworkHelper](https://github.com/CityDo/CityDoCommon/tree/master/CityDoCommon/Network) 实现

