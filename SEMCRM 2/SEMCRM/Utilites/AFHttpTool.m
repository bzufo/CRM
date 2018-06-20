//
//  AFHttpTool.m
//  RCloud_liv_demo
//
//  Created by Liv on 14-10-22.
//  Copyright (c) 2014年 RongCloud. All rights reserved.
//


#import "AFHttpTool.h"
#import "AFNetworking.h"
#import "UserLoginViewController.h"


#define LOGIN_URL @"get_login_user.do"
//#define ContentType @"text/plain"
#define ContentType @"text/html"

@implementation AFHttpTool

+ (void)requestWihtMethod:(RequestMethodType)methodType
                      baseurl:(NSString*)baseurl
                      url:(NSString*)url
                   params:(NSDictionary*)params
                  success:(void (^)(id response))success
                  failure:(void (^)(NSError* err))failure
{
    NSURL* baseURL = [NSURL URLWithString:baseurl];
    //获得请求管理者
    AFHTTPSessionManager* mgr = [[AFHTTPSessionManager alloc] initWithBaseURL:baseURL];

#ifdef ContentType
    mgr.responseSerializer.acceptableContentTypes = [NSSet setWithObject:ContentType];
#endif
    mgr.requestSerializer.HTTPShouldHandleCookies = YES;
    mgr.requestSerializer.timeoutInterval = 10.f;
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    //mgr.responseSerializer=[AFJSONResponseSerializer serializer];
//    NSString *cookieString = [[NSUserDefaults standardUserDefaults] objectForKey:@"UserCookies"];
//
//    if(cookieString)
//       [mgr.requestSerializer setValue: cookieString forHTTPHeaderField:@"Cookie"];
 
    switch (methodType) {
        case RequestMethodTypeGet:
        {
            //GET请求
            [mgr GET:url parameters:params
             success:^(NSURLSessionDataTask* operation, NSDictionary* responseObj) {
                 if (success) {
                     NSString *code = [NSString stringWithFormat:@"%@",responseObj[@"errorCode"]];
                     if ([code isEqualToString:@"2"]) {
                         [app stopLoading];
                         UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                         UserLoginViewController *rootNavi = [storyboard instantiateViewControllerWithIdentifier:@"BNTableViewController_iPhone_login"];
                         
                         [ShareApplicationDelegate window].rootViewController = rootNavi;
                         [MyUtil showMessage:@"你的账户在其他地方登录!"];
                         return;
                     }
                     success(responseObj);
                 }
             } failure:^(NSURLSessionDataTask* operation, NSError* error) {
                 if (failure) {
                     failure(error);
                 }
             }];

        }
            break;
        case RequestMethodTypePost:
        {
            //POST请求
            //mgr.responseSerializer = [AFHTTPResponseSerializer serializer];
            [mgr POST:url parameters:params
              success:^(NSURLSessionDataTask* operation, NSDictionary* responseObj) {
                  if (success) {
                     // NSString *result = [[NSString alloc]initWithData:responseObj encoding:NSUTF8StringEncoding];
                      //NSLog(@"%@",result);
                      NSString *code = [NSString stringWithFormat:@"%@",responseObj[@"errorCode"]];
                      if ([code isEqualToString:@"2"]) {
                          [app stopLoading];
                          UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                          UserLoginViewController *rootNavi = [storyboard instantiateViewControllerWithIdentifier:@"BNTableViewController_iPhone_login"];
                          
                          [ShareApplicationDelegate window].rootViewController = rootNavi;
                          [MyUtil showMessage:@"你的账户在其他地方登录!"];
                          return;
                      }

//                      NSString *cookieString = [[operation.response allHeaderFields] valueForKey:@"Set-Cookie"];
//                      NSData *data = [NSKeyedArchiver archivedDataWithRootObject:cookieString];
//                      [[NSUserDefaults standardUserDefaults] setObject:cookieString forKey:@"UserCookies"];
                      success(responseObj);
                  }
              } failure:^(NSURLSessionDataTask* operation, NSError* error) {
                  if (failure) {
                      failure(error);
                  }
              }];
        }
            break;
        default:
            break;
    }
}
+(void) requestWihtMethod360:(RequestMethodType)
    methodType
                     baseurl:(NSString*)baseurl
                        url : (NSString *)url
                      params:(NSDictionary *)params
                     success:(void (^)(id response))success
                     failure:(void (^)(NSError *err))failure{
    NSURL* baseURL = [NSURL URLWithString:baseurl];
    //获得请求管理者
    AFHTTPSessionManager* mgr = [[AFHTTPSessionManager alloc] initWithBaseURL:baseURL];
    
#ifdef ContentType
    mgr.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    
#endif
    mgr.requestSerializer.HTTPShouldHandleCookies = YES;
    mgr.requestSerializer.timeoutInterval = 10.f;
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    //mgr.responseSerializer=[AFJSONResponseSerializer serializer];
    //    NSString *cookieString = [[NSUserDefaults standardUserDefaults] objectForKey:@"UserCookies"];
    //
    //    if(cookieString)
    //       [mgr.requestSerializer setValue: cookieString forHTTPHeaderField:@"Cookie"];
     [mgr.requestSerializer setValue:app.smart360Token forHTTPHeaderField:@"X-XSRF-TOKEN"];
    switch (methodType) {
        case RequestMethodTypeGet:
        {
            //GET请求
            [mgr GET:url parameters:params
             success:^(NSURLSessionDataTask* operation, NSDictionary* responseObj) {
                 if (success) {
                     
                     success(responseObj);
                 }
             } failure:^(NSURLSessionDataTask* operation, NSError* error) {
                 if (failure) {
                     failure(error);
                 }
             }];
            
        }
            break;
        case RequestMethodTypePost:
        {
            //POST请求
            //mgr.responseSerializer = [AFHTTPResponseSerializer serializer];
            [mgr POST:url parameters:params
              success:^(NSURLSessionDataTask* operation, NSDictionary* responseObj) {
                  if (success) {
                      // NSString *result = [[NSString alloc]initWithData:responseObj encoding:NSUTF8StringEncoding];
                      //NSLog(@"%@",result);
                      
                      success(responseObj);
                  }
              } failure:^(NSURLSessionDataTask* operation, NSError* error) {
                  if (failure) {
                      failure(error);
                  }
              }];
        }
            break;
        default:
            break;
    }
}
//login
+(void) loginWithUser:(NSString *) user
              password:(NSString *) password
                   orgcode:(NSString *) orgcode
               success:(void (^)(id response))success
               failure:(void (^)(NSError* err))failure
{
//    NSString *mobile_id =[[[UIDevice currentDevice] identifierForVendor] UUIDString];
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    NSString *appVersion = [infoDic objectForKey:@"CFBundleVersion"];
    NSDictionary *params = @{@"empno":user,@"password":password,@"orgcode":orgcode,@"mobile_id":app.deviceToken==nil?@"":app.deviceToken,@"mobile_system":@"I",@"VERSION_NO":appVersion};
    [AFHttpTool requestWihtMethod:RequestMethodTypePost
                            baseurl:SEM_TEST_SERVER
                              url:LOGIN_URL
                           params:params
                          success:success
                          failure:failure];
}
+ (void)requestWihtMethodWithTwo:(RequestMethodType)methodType
                         baseurl:(NSString*)baseurl
                             url:(NSString*)url
                          params:(NSDictionary*)params
                         success:(void (^)(id response))success
                         failure:(void (^)(NSError* err))failure{
    NSURL* baseURL = [NSURL URLWithString:baseurl];
    //获得请求管理者
    AFHTTPSessionManager* mgr = [[AFHTTPSessionManager alloc] initWithBaseURL:baseURL];
    
#ifdef ContentType
    mgr.responseSerializer.acceptableContentTypes = [NSSet setWithObject:ContentType];
#endif
    mgr.requestSerializer.HTTPShouldHandleCookies = YES;
    mgr.requestSerializer.timeoutInterval = 10.f;
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    //mgr.responseSerializer=[AFJSONResponseSerializer serializer];
    //    NSString *cookieString = [[NSUserDefaults standardUserDefaults] objectForKey:@"UserCookies"];
    //
    //    if(cookieString)
    //       [mgr.requestSerializer setValue: cookieString forHTTPHeaderField:@"Cookie"];
    
    switch (methodType) {
        case RequestMethodTypeGet:
        {
            //GET请求
            [mgr GET:url parameters:params
             success:^(NSURLSessionDataTask* operation, NSDictionary* responseObj) {
                 if (success) {
                     NSString *code = [NSString stringWithFormat:@"%@",responseObj[@"errorCode"]];
                     if ([code isEqualToString:@"2"]) {
                         [app stopLoading];
                         UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                         UserLoginViewController *rootNavi = [storyboard instantiateViewControllerWithIdentifier:@"BNTableViewController_iPhone_login"];
                         
                         [ShareApplicationDelegate window].rootViewController = rootNavi;
                         [MyUtil showMessage:@"你的账户在其他地方登录!"];
                         return;
                     }
                     success(responseObj);
                 }
             } failure:^(NSURLSessionDataTask* operation, NSError* error) {
                 if (failure) {
                     failure(error);
                 }
             }];
            
        }
            break;
        case RequestMethodTypePost:
        {
            //POST请求
            //mgr.responseSerializer = [AFHTTPResponseSerializer serializer];
            [mgr POST:url parameters:params
              success:^(NSURLSessionDataTask* operation, NSDictionary* responseObj) {
                  if (success) {
                      // NSString *result = [[NSString alloc]initWithData:responseObj encoding:NSUTF8StringEncoding];
                      //NSLog(@"%@",result);
                      NSString *code = [NSString stringWithFormat:@"%@",responseObj[@"errorCode"]];
                      if ([code isEqualToString:@"2"]) {
                          [app stopLoading];
                          UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                          UserLoginViewController *rootNavi = [storyboard instantiateViewControllerWithIdentifier:@"BNTableViewController_iPhone_login"];
                          
                          [ShareApplicationDelegate window].rootViewController = rootNavi;
                          [MyUtil showMessage:@"你的账户在其他地方登录!"];
                          return;
                      }
                      
                      //                      NSString *cookieString = [[operation.response allHeaderFields] valueForKey:@"Set-Cookie"];
                      //                      NSData *data = [NSKeyedArchiver archivedDataWithRootObject:cookieString];
                      //                      [[NSUserDefaults standardUserDefaults] setObject:cookieString forKey:@"UserCookies"];
                      success(responseObj);
                  }
              } failure:^(NSURLSessionDataTask* operation, NSError* error) {
                  if (failure) {
                      failure(error);
                  }
              }];
        }
            break;
        default:
            break;
    }
}
//get token
+(void) getTokenSuccess:(void (^)(id response))success
                failure:(void (^)(NSError* err))failure
{
    [AFHttpTool requestWihtMethod:RequestMethodTypeGet
                            baseurl:SEM_TEST_SERVER
                              url:@"token"
                           params:nil
                          success:success
                          failure:failure];
}

//文件上传
+ (void)requestFileWihtUrl:(NSString*)url
                   baseURL:(NSString*)baseStr
                    params:(NSDictionary*)params block:(void (^)(id <AFMultipartFormData> formData))block
                   success:(void (^)(id response))success
                   failure:(void (^)(NSError* err))failure
{
    //添加userid
   
    
    
    NSURL* baseURL = [NSURL URLWithString:baseStr];
    //获得请求管理者
    AFHTTPSessionManager* mgr = [[AFHTTPSessionManager alloc] initWithBaseURL:baseURL];
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
#ifdef ContentType
    mgr.responseSerializer.acceptableContentTypes = [NSSet setWithObject:ContentType];
#endif
    mgr.requestSerializer.HTTPShouldHandleCookies = YES;
    mgr.requestSerializer.timeoutInterval = 10.f;
    
    //    mgr.requestSerializer = [AFHTTPRequestSerializer serializer];
    //    mgr.responseSerializer = [AFHTTPResponseSerializer serializer];
    [mgr POST:url parameters:params constructingBodyWithBlock:block progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            NSString *code = [NSString stringWithFormat:@"%@",responseObject[@"errorCode"]];
            if ([code isEqualToString:@"2"]) {
                [app stopLoading];
                UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                UserLoginViewController *rootNavi = [storyboard instantiateViewControllerWithIdentifier:@"BNTableViewController_iPhone_login"];
                
                [ShareApplicationDelegate window].rootViewController = rootNavi;
                [MyUtil showMessage:@"你的账户在其他地方登录!"];
                return;
            }
            success(responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            [MyUtil showMessage:[NSString stringWithFormat:@"%@",error.userInfo[@"NSLocalizedDescription"]]];
            failure(error);
            
        }
    }];
    
    
    
    
    
    
}
+ (void)requestWihtMethodforJson:(RequestMethodType)methodType
                         baseurl:(NSString*)baseurl
                             url:(NSString*)url
                           token:(NSString*)token
                          params:(NSDictionary*)params
                         success:(void (^)(id response))success
                         failure:(void (^)(NSError* err))failure{
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSString *typeMethod=@"POST";
    if(methodType==RequestMethodTypeGet){
        typeMethod=@"GET";
    }
    NSMutableURLRequest *req = [[AFJSONRequestSerializer serializer] requestWithMethod:typeMethod URLString:[NSString stringWithFormat:@"%@%@",baseurl,url] parameters:nil error:nil];
    NSData *data =    [NSJSONSerialization dataWithJSONObject:params options:NSJSONWritingPrettyPrinted error:nil];
    req.timeoutInterval= [[[NSUserDefaults standardUserDefaults] valueForKey:@"timeoutInterval"] longValue];
    [req setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [req setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    if(token){
        [req setValue:token forHTTPHeaderField:@"X-XSRF-TOKEN"];
    }
    [req setHTTPBody:data];
    
    [[manager dataTaskWithRequest:req completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
        if (!error) {
            success(responseObject);
        } else {
            if(responseObject){
                success(responseObject);
            }
            NSLog(@"Error: %@, %@, %@", error, response, responseObject);
        }
    }] resume];
    
    
}
@end
