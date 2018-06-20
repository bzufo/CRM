//
//  CarSeriesModel.h
//  SEMCRM
//
//  Created by Sem on 2017/5/16.
//  Copyright © 2017年 sem. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WZLSerializeKit.h"
@interface CarSeriesModel : NSObject<NSCopying, NSCoding>
@property(nonatomic,copy)NSString *series_code;
@property(nonatomic,copy)NSString *series_name;
@end
