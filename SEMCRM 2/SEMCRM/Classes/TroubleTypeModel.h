//
//  TroubleTypeModel.h
//  SEMCRM
//
//  Created by Sem on 2017/5/16.
//  Copyright © 2017年 sem. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WZLSerializeKit.h"
@interface TroubleTypeModel : NSObject<NSCopying, NSCoding>
@property(nonatomic,copy)NSString *trouble_type;
@property(nonatomic,copy)NSString *trouble_type_name;
@end
