//
//  SupporContentModle.m
//  SEMCRM
//
//  Created by Sem on 2017/6/26.
//  Copyright © 2017年 sem. All rights reserved.
//

#import "SupporContentModle.h"

@implementation SupporContentModle
+ (NSDictionary *)objectClassInArray
{
    return @{
             @"file_list" : @"FileModle",@"ws_list":@"ReplyModel",@"sem_list":@"ReplyModel",@"trouble_file_list" : @"FileModle",@"deal_file_list" : @"FileModle",
             };
}
@end
