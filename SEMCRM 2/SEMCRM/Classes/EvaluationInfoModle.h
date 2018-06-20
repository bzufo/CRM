//
//  EvaluationInfoModle.h
//  SEMCRM
//
//  Created by Sem on 2018/4/17.
//  Copyright © 2018年 sem. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EvaluationInfoModle : NSObject
@property(nonatomic,copy)NSString * eva_id;
@property(nonatomic,copy)NSString * name;
@property(nonatomic,copy)NSString * licenseNO;
@property(nonatomic,copy)NSString * desinfo;
@property(nonatomic,copy)NSString * vin;
@property(nonatomic,copy)NSString * series;
@property(nonatomic,copy)NSString * contactorname;
@property(nonatomic,copy)NSString * mobile;
@property(nonatomic,copy)NSString * insurance_fall_date;
@property(nonatomic,copy)NSString * last_start_time;
@property(nonatomic,copy)NSString * update_date;
@property(nonatomic,copy)NSString *status;

@property(nonatomic,copy)NSString * evaluation_date;
@property(nonatomic,copy)NSString * evaluation_amount;
@property(nonatomic,copy)NSString * evaluation_time;
@property(nonatomic,copy)NSString * evaluation_remark;
//@property(nonatomic,copy)NSString * description;
@property(nonatomic,copy)NSString * picfile1;
@property(nonatomic,copy)NSString * picfile2;
@property(nonatomic,copy)NSString * picfile3;
@property(nonatomic,copy)NSString * picfile4;
@property(nonatomic,copy)NSString * picfile5;
@end
