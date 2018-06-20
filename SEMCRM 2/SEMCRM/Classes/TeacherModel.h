//
//  TeacherModel.h
//  SEMCRM
//
//  Created by Sem on 2017/5/16.
//  Copyright © 2017年 sem. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WZLSerializeKit.h"
@interface TeacherModel : NSObject<NSCopying, NSCoding>
@property(nonatomic,copy)NSString *employee_no;
@property(nonatomic,copy)NSString *employee_inf;
@property(nonatomic,copy)NSString *is_busy;
@end
