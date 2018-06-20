//
//  HelpInit.m
//  SEMCRM
//
//  Created by Sem on 2017/5/16.
//  Copyright © 2017年 sem. All rights reserved.
//

#import "HelpInit.h"

@implementation HelpInit

+ (NSDictionary *)mj_objectClassInArray
{
    return @{
             @"car_series" : @"CarSeriesModel",
             @"trouble_type" : @"TroubleTypeModel",
             @"sem_teacher" : @"TeacherModel",
             @"sort_type" : @"SortTypeModel"
             };
}
@end
