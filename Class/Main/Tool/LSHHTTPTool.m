//
//  LSHHTTPTool.m
//  LSHWebMovie
//
//  Created by kiki on 16/4/14.
//  Copyright © 2016年 LSH. All rights reserved.
//

#import "LSHHTTPTool.h"
#import "AFNetworking.h"
#import "MBProgressHUD.h"

@interface LSHHTTPTool()
@property(nonatomic, strong)AFHTTPSessionManager *manager;

@end
@implementation LSHHTTPTool

-(AFHTTPSessionManager *)manager{
    if (_manager == nil) {
        _manager = [AFHTTPSessionManager manager];
        
        _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json", nil];
    }
    return _manager;
    
}

// 单例
+ (id)allocWithZone:(struct _NSZone *)zone{

    static LSHHTTPTool *instance;
    if(!instance){
        instance = [super allocWithZone:zone];
    }
    return instance;
}

//同一名称成类方法
+(instancetype)sharedAFN{
    return [[self alloc]init];
}

- (void)postWithURL:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    // 1.创建请求管理对象
//    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
//     mgr.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
//    // 2.发送请求
//    [mgr POST:url parameters:params
//      success:^(AFHTTPRequestOperation *operation, id responseObject) {
//          if (success) {
//              success(responseObject);
//          }
//      } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//          LSHLog(@"%@",error);
//      }];
    
    [self.manager  POST:url parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        LSHLog(@"%@",error);
    }];
    
}

// 暂时用不上
- (void)postWithURL:(NSString *)url params:(NSDictionary *)params formDataArray:(NSArray *)formDataArray success:(void (^)(id))success failure:(void (^)(NSError *))failure
{

    // 1.创建请求管理对象
//    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
//      mgr.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
//    // 2.发送请求
//    [mgr POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> totalFormData) {
//        for (LSHFormData *formData in formDataArray) {
//            [totalFormData appendPartWithFileData:formData.data name:formData.name fileName:formData.filename mimeType:formData.mimeType];
//        }
//    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        if (success) {
//            success(responseObject);
//        }
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        if (failure) {
//            failure(error);
//        }
//    }];
}

- (void)getWithURL:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    
    [self.manager GET:url parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    
//    // 1.创建请求管理对象
//    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
//    
//    // 2.发送请求
//    [mgr GET:url parameters:params
//     success:^(AFHTTPRequestOperation *operation, id responseObject) {
//         if (success) {
//             success(responseObject);
//         }
//     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//         if (failure) {
//             failure(error);
//         }
//     }];
}


@end

/**
 *  用来封装文件数据的模型
 */
@implementation LSHFormData

@end

