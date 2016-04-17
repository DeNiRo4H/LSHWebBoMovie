//
//  LSHHTTPTool.h
//  LSHWebMovie
//
//  Created by kiki on 16/4/14.
//  Copyright © 2016年 LSH. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^HttpRequestSuccess)(id json);
typedef void (^HttpRequestFailure)(NSError *error);


@interface LSHHTTPTool : NSObject


+ (void)postWithURL:(NSString *)url params:(NSDictionary *)params success:(HttpRequestSuccess)success failure:(HttpRequestFailure)failure;

+ (void)getWithURL:(NSString *)url params:(NSDictionary *)params success:(HttpRequestSuccess)success failure:(HttpRequestFailure)failure;

@end
