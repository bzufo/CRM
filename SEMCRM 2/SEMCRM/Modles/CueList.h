//
//  CueList.h
//  SEMCRM
//
//  Created by 薛斯岐 on 16/2/29.
//  Copyright © 2016年 sem. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CueList : NSObject
/*{
    "cfrom": "展厅线索",
    "cname": "33",
    "sex": "",
    "mobile": "33555555555",
    "brand": "MMC",
    "series": "",
    "level": "",
    "forcast_date": "",
    "leadbatch": "",
    "RECIVE_DEALER": "BB0101",
    "SALE_ID": "180004",
    "EMPLOYEE_NAME": "范范",
    "STATE": "0",
    "TSTATE": "未联络",
    "TARGET_CUST_ID": "110000000582"
},
 */
@property(nonatomic,copy)NSString * WXFLAG;
@property(nonatomic,copy)NSString * cfrom;
@property(nonatomic,copy)NSString * cname;
@property(nonatomic,copy)NSString * sex;
@property(nonatomic,copy)NSString * mobile;
@property(nonatomic,copy)NSString * brand;
@property(nonatomic,copy)NSString * series;
@property(nonatomic,copy)NSString * level;
@property(nonatomic,copy)NSString * forcast_date;
@property(nonatomic,copy)NSString * leadbatch;
@property(nonatomic,copy)NSString * RECIVE_DEALER;
@property(nonatomic,copy)NSString * SALE_ID;
@property(nonatomic,copy)NSString * EMPLOYEE_NAME;
@property(nonatomic,copy)NSString * STATE;
@property(nonatomic,copy)NSString * TSTATE;
@property(nonatomic,copy)NSString * TARGET_CUST_ID;
@property(nonatomic,copy)NSString * REMARK;
@property(nonatomic,copy)NSString *FROM_FLAG;
@property(nonatomic,copy)NSString *CREATE_DATE;
@property(nonatomic,copy)NSArray * level_detail;
@property(nonatomic,copy)NSArray * data_detail;
@property(nonatomic,copy)NSArray * TRACE_TYPE;
@property(nonatomic,copy)NSString *FAIL_REASON;
@property(nonatomic,copy)NSString *MEDIA_NAME;
@property(nonatomic,assign)BOOL isSel;
@end
