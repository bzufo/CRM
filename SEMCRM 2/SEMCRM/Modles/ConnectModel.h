//
//  ConnectModel.h
//  SEMCRM
//
//  Created by 薛斯岐 on 16/2/29.
//  Copyright © 2016年 sem. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ConnectModel : NSObject
/*
"DEFEATED_REASON": "",
"FORWARD_DATE": "",
"IS_TRY": "",
"RECIVE_DEALER": "BB0101",
"REMARK": "新增客户",
"SALE_ID": "180004",
"EMPLOYEE_NAME": "范范",
"STATE": "0",
"TSTATE": "未联络",
"TARGET_CUST_ID": "110000000102",
"CREATE_BY": "1",
"CREATE_DATE": "2014-10-28 12:15:23"
 */
@property(nonatomic,copy)NSString * DEFEATED_REASON;
@property(nonatomic,copy)NSString * FORWARD_DATE;
@property(nonatomic,copy)NSString * IS_TRY;
@property(nonatomic,copy)NSString * RECIVE_DEALER;
@property(nonatomic,copy)NSString * REMARK;
@property(nonatomic,copy)NSString * SALE_ID;
@property(nonatomic,copy)NSString * EMPLOYEE_NAME;
@property(nonatomic,copy)NSString * STATE;
@property(nonatomic,copy)NSString * TSTATE;
@property(nonatomic,copy)NSString * TARGET_CUST_ID;
@property(nonatomic,copy)NSString * CREATE_BY;
@property(nonatomic,copy)NSString * CREATE_DATE;
@property(nonatomic,copy)NSString *COLOR;
@property(nonatomic,copy)NSString * TRACE_TYPE;
@property(nonatomic,copy)NSString *CONTACT_TYPE;

@property(nonatomic,copy)NSString * CID;
@property(nonatomic,copy)NSString * DURATION;
@property(nonatomic,copy)NSString * DURATION_R;
@property(nonatomic,copy)NSString * START_TIME;
@property(nonatomic,copy)NSString * START_TIME_R;
@end
