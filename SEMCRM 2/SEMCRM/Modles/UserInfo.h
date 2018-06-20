//
//  UserInfo.h
//  SEMCRM
//
//  Created by sem on 16/2/20.
//  Copyright © 2016年 sem. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfo : NSObject
@property(nonatomic,copy)NSString *parent_dealer_shortname;
@property(nonatomic,copy)NSString * dealer_code;
@property(nonatomic,copy)NSString * dealer_name;
@property(nonatomic,copy)NSString * employee_no;
@property(nonatomic,copy)NSString * employee_name;
@property(nonatomic,copy)NSString * s_mobile;
@property(nonatomic,copy)NSString * line_unit;//是否开通
@property(nonatomic,copy)NSString * is_unit;//是否缴费单位
@property(nonatomic,copy)NSString * is_open;//是否开通
@property(nonatomic,copy)NSString * spepwd;//是否开通
@property(nonatomic,copy)NSString * spename;//是否开通
@property(nonatomic,copy)NSString * right_flag;
@property(nonatomic,copy)NSString * flag;//1-销售顾问 2-销售经理/展厅经理  或者 销售经理/展厅经理 &总经理 3-总经理 4-销售顾问&销售经理/展厅经理 7-站长/服务经理8-客服中心经理 9-接待人员（职位为[接待主管/快速保养/日常维修/事故车/索赔专员]）10-站长/服务经理&客服中心经理 11-站长/服务经理&接待人员 12-客服中心经理&接待人员 13-站长/服务经理&客服中心经理&接待人员 14-服管中心副总/服务经理  15-客服专员16-服管中心副总/服务经理&客服专员 17-SEM服务代表 /销售代表18-SEM特定人员  }
//1,2,3，4-DCS   7,8,9,10,11,12,13-ws,14,15,16-dlr 17,18-sem
@property(nonatomic,copy)NSString * ID_CARD;
@property(nonatomic,copy)NSString * position;
@property(nonatomic,copy)NSString * UNDEAL_NUM;//未处理客诉
@property(nonatomic,copy)NSString * SUNDEAL_NUM;//未处理线索
@property(nonatomic,copy)NSString * ORG_TYPE;//S:销售 F:服务
@property(nonatomic,copy)NSString * VERSIONNO;//版本号
@property(nonatomic,copy)NSString * T_DOWNLOADADDRESS;
@property(nonatomic,copy)NSString * ISNOTFATAL;
@property(nonatomic,copy)NSString *isteach;
@property(nonatomic,copy)NSString * token;
@property(nonatomic,assign)BOOL isSel;
@property(nonatomic,copy)NSString *cxgj;
@property(nonatomic,copy)NSString * netname;
@property(nonatomic,copy)NSString * dealername;
@property(nonatomic,copy)NSString * enter_date;
@property(nonatomic,copy)NSString * position_level;

@property(nonatomic,copy)NSString * bank_no;
@property(nonatomic,copy)NSString * id_card;
@property(nonatomic,copy)NSString * now_point;
@property(nonatomic,copy)NSString * now_voucher;
@property(nonatomic,copy)NSString * now_cash;
@property(nonatomic,copy)NSString * is_dimission;
@property(nonatomic,copy)NSString * calpos;
@property(nonatomic,copy)NSString * flow_flag;
@property(nonatomic,copy)NSString * lastpoint;
@property(nonatomic,copy)NSString * point_cash;
@property(nonatomic,copy)NSString * point_voucher;
@property(nonatomic,copy)NSString * voucher;
@property(nonatomic,copy)NSString * isok;
@property(nonatomic,copy)NSString * okpoint;
@property(nonatomic,copy)NSString * begin_date;
@property(nonatomic,copy)NSString * create_date;

@property(nonatomic,copy)NSString * secnet_name;
@property(nonatomic,copy)NSString * c_data;
@property(nonatomic,copy)NSString * max_amount;
//"dealer_code": "BB0101",
//"employee_no": "180004",
//"employee_name": "",
//"flag": "3",
//"position": ".~顋Q瓜",
//"UNDEAL_NUM": "10",
//"SUNDEAL_NUM": "2",
//"ORG_TYPE": "S",
//"VERSIONNO": "V1.0.1",
//"T_DOWNLOADADDRESS": "http://61.131.6.204/testinterface/download_SemOA.html"
@end
