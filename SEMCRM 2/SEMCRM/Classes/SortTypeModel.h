//
//  SortTypeModel.h
//  SEMCRM
//
//  Created by Sem on 2017/7/5.
//  Copyright © 2017年 sem. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WZLSerializeKit.h"
@interface SortTypeModel : NSObject<NSCopying, NSCoding>
@property(nonatomic,copy)NSString *sort_code;
@property(nonatomic,copy)NSString *sort_name;
@end
