//
//  CustomerInfo.h
//  SemCC
//
//  Created by SEM on 15/5/30.
//  Copyright (c) 2015年 SEM. All rights reserved.
//



@interface CustomerInfo : NSObject
@property(nonatomic,copy)NSString *accept_mst_no;
@property(nonatomic,copy)NSString *car_owner;
@property(nonatomic,copy)NSString *tel_cstm_tel;
@property(nonatomic,copy)NSString *vin;
@property(nonatomic,copy)NSString *license_no;
@property(nonatomic,copy)NSString *series;
@property(nonatomic,copy)NSString *miles;
@property(nonatomic,copy)NSString *sale_date;
@property(nonatomic,copy)NSString *accur_content;
@property(nonatomic,copy)NSString *Is_sale_flag;
@property(nonatomic,assign)BOOL isTrue;
-(id)initWithTrue:(BOOL)flag;
@end
