//
//  VoucherModel.h
//  SEMCRM
//
//  Created by Sem on 2017/11/23.
//  Copyright © 2017年 sem. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VoucherModel : NSObject
@property(nonatomic,copy)NSString *voucher_no;
@property(nonatomic,copy)NSString *over_date;
@property(nonatomic,copy)NSString *amount;
@property(nonatomic,copy)NSString *dealer_shortname;
@property(nonatomic,copy)NSString *vin;
@property(nonatomic,copy)NSString *engine_no;
@property(nonatomic,copy)NSString *series;
@property(nonatomic,copy)NSString *send_date;
@property(nonatomic,copy)NSString *apply_date;
@property(nonatomic,copy)NSString *CHECK_STATUS;
@end
