//
//  CueList.m
//  SEMCRM
//
//  Created by 薛斯岐 on 16/2/29.
//  Copyright © 2016年 sem. All rights reserved.
//

#import "CueList.h"

@implementation CueList
+ (NSDictionary *)objectClassInArray
{
    return @{
             @"data_detail" : @"ConnectModel",@"level_detail":@"LevelModel",
             };
}
@end
