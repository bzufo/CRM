//
//  AFHttpTool.h
//  RCloud_liv_demo
//
//  Created by Liv on 14-10-22.
//  Copyright (c) 2014年 RongCloud. All rights reserved.
//http://61.131.6.208:8080/app/

#define SEM_TEST_SERVER @"http://61.131.6.208:8080/app/" //测试地址http://61.131.6.197:7001
#define SMART360_SERVER @"http://api.smart360.cn/api/"
#define SEM_SERVER @"http://61.131.6.208:8080/app/"//@"http://119.254.110.241:80/" //Login 正式地址
#define SEM_SERVER_UP @"http://epm.soueast-motor.com:8080/EPMWeb/"//http://61.131.6.238:7001/EPMWeb/
#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, RequestMethodType){
    RequestMethodTypePost = 1,
    RequestMethodTypeGet = 2
};

@interface AFHttpTool : NSObject

/**
 *  发送一个请求
 *
 *  @param methodType   请求方法
 *  @param url          请求路径
 *  @param params       请求参数
 *  @param success      请求成功后的回调（请将请求成功后想做的事情写到这个block中）
 *  @param failure      请求失败后的回调（请将请求失败后想做的事情写到这个block中）
 */
+(void) requestWihtMethod:(RequestMethodType)
          methodType
                     baseurl:(NSString*)baseurl
                     url : (NSString *)url
                   params:(NSDictionary *)params
                  success:(void (^)(id response))success
                  failure:(void (^)(NSError *err))failure;

+(void) requestWihtMethod360:(RequestMethodType)
methodType
                  baseurl:(NSString*)baseurl
                     url : (NSString *)url
                   params:(NSDictionary *)params
                  success:(void (^)(id response))success
                  failure:(void (^)(NSError *err))failure;
//login
+(void) loginWithUser:(NSString *) user
              password:(NSString *) password
              orgcode:(NSString *) orgcode
               success:(void (^)(id response))success
               failure:(void (^)(NSError* err))failure;


//get token
+(void) getTokenSuccess:(void (^)(id response))success
                failure:(void (^)(NSError* err))failure;
//文件上传
+ (void)requestFileWihtUrl:(NSString*)url
                   baseURL:(NSString*)baseStr
                    params:(NSDictionary*)params block:(void (^)(id <AFMultipartFormData> formData))block
                   success:(void (^)(id response))success
                   failure:(void (^)(NSError* err))failure;
+ (void)requestWihtMethodWithTwo:(RequestMethodType)methodType
                  baseurl:(NSString*)baseurl
                      url:(NSString*)url
                   params:(NSDictionary*)params
                  success:(void (^)(id response))success
                  failure:(void (^)(NSError* err))failure;
+ (void)requestWihtMethodforJson:(RequestMethodType)methodType
                         baseurl:(NSString*)baseurl
                             url:(NSString*)url
                            token:(NSString*)token
                          params:(NSDictionary*)params
                         success:(void (^)(id response))success
                         failure:(void (^)(NSError* err))failure;
@end

