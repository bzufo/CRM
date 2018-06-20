//
//  ActivityModel.h
//  SEMCRM
//
//  Created by Sem on 2017/12/14.
//  Copyright © 2017年 sem. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ActivityModel : NSObject
@property(nonatomic,copy)NSString *activity_id;
@property(nonatomic,copy)NSString *activity_from_name;
@property(nonatomic,copy)NSString *activity_name;
@property(nonatomic,copy)NSString *activity_kind;
@end
