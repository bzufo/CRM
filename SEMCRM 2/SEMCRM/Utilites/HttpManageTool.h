//
//  HttpManageTool.h
//  SEMCRM
//
//  Created by 薛斯岐 on 16/2/26.
//  Copyright © 2016年 sem. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CueList.h"
#import "CueStayModel.h"
#import "VehicleLicenseModel.h"
#import "AFURLRequestSerialization.h"
#import "SupporContentModle.h"
#import "UserInfo.h"
@interface HttpManageTool : NSObject
//新增线索(添加)
+(void) insertNewCueOne:(NSDictionary *) params
             success:(void (^)(NSDictionary *dic))dicType
             failure:(void (^)(NSError* err))failure;
//新增线索（修改）
+(void) insertNewCue:(NSDictionary *) params
               success:(void (^)(BOOL isSuccess))success
               failure:(void (^)(NSError* err))failure;
//获取活动参数
+(void) getEventName:(NSDictionary *) params
          success:(void (^)(NSArray *eventArr))success
          failure:(void (^)(NSError* err))failure;
//线索批量上传
+(void) insertNewCueList:(NSDictionary *) params
               success:(void (^)(NSString *mobiles))success
               failure:(void (^)(NSError* err))failure;
//修改线索
+(void) updataCue:(NSDictionary *) params
             success:(void (^)(BOOL isSuccess))success
             failure:(void (^)(NSError* err))failure;
//待联络列表
+(void) selectToBeConTactList:(NSDictionary *) params
success:(void (^)(NSDictionary *toBCList))success
failure:(void (^)(NSError* err))failure;
//线索详情
+(void) selectCueInfo:(NSDictionary *) params
                      success:(void (^)(CueList *cueModel))success
                      failure:(void (^)(NSError* err))failure;
//上传商谈信息
+(void) insertNewCueFollow:(NSDictionary *) params
             success:(void (^)(BOOL isSuccess))success
             failure:(void (^)(NSError* err))failure;
//我的线索
+(void) selectMyCueList:(NSDictionary *) params
                      success:(void (^)(NSDictionary *toBCList))success
                      failure:(void (^)(NSError* err))failure;
//待分配线索
+(void) selectStayCueList:(NSDictionary *) params
                success:(void (^)(CueStayModel *stayModel))success
                failure:(void (^)(NSError* err))failure;

//销售顾问列表
+(void) selectSaleList:(NSDictionary *) params
                success:(void (^)(NSArray *saleList))success
                failure:(void (^)(NSError* err))failure;
//手动分配线索
+(void) updataCueForMT:(NSDictionary *) params
          success:(void (^)(BOOL isSuccess))success
          failure:(void (^)(NSError* err))failure;
//战败驳回
+(void) updataCueReject:(NSDictionary *) params
                success:(void (^)(BOOL isSuccess))success
                failure:(void (^)(NSError* err))failure ;
//战败确认
+(void) confirmCueForZB:(NSDictionary *) params
               success:(void (^)(BOOL isSuccess))success
               failure:(void (^)(NSError* err))failure;
//异常线索
+(void) selectYCCueList:(NSDictionary *) params
                  success:(void (^)(NSArray *ycCueList))success
                  failure:(void (^)(NSError* err))failure;
//战败线索
+(void) selectLostCueList:(NSDictionary *) params
                success:(void (^)(NSDictionary *dataListDic))success
                  failure:(void (^)(NSError* err))failure;
//重新分配线索列表
+(void) selectCXCueByGroupList:(NSDictionary *) params
                success:(void (^)(NSArray *cxList))success
                failure:(void (^)(NSError* err))failure;
//重新分配分组列表
+(void) selectCXGroupList:(NSDictionary *) params
                       success:(void (^)(NSArray *fzList))success
                       failure:(void (^)(NSError* err))failure;
//设置时间查询
+(void) selectTimeList:(NSDictionary *) params
               success:(void (^)(NSArray *timeList))success
               failure:(void (^)(NSError* err))failure;
//级别时间配置
+(void) updataTimeSet:(NSDictionary *) params
                  success:(void (^)(BOOL isSuccess))success
                  failure:(void (^)(NSError* err))failure;
//线索分配设置
+(void) updataSendSet:(NSDictionary *) params
              success:(void (^)(BOOL isSuccess))success
              failure:(void (^)(NSError* err))failure;
//销售顾问设置列表
+(void) selectSaleDic:(NSDictionary *) params
               success:(void (^)(NSDictionary *dic))success
               failure:(void (^)(NSError* err))failure;

//客诉查询
+(void) selectUnAcceptMstList:(NSDictionary *) params
                success:(void (^)(NSArray *kxList))success
                failure:(void (^)(NSError* err))failure;
//客诉处理查询
+(void) selectAcceptMst:(NSDictionary *) params
                success:(void (^)(NSArray *kxList))success
                failure:(void (^)(NSError* err))failure;
//客诉处理信息
+(void) selectAcceptMstDic:(NSDictionary *) params
              success:(void (^)(NSDictionary *dic))success
              failure:(void (^)(NSError* err))failure;

//提交业代回复
+(void) insertServAnswer:(NSDictionary *) params
                   success:(void (^)(BOOL isSuccess))success
                   failure:(void (^)(NSError* err))failure;
//提交回复
+(void) insertAnswer:(NSDictionary *) params
                   success:(void (^)(BOOL isSuccess))success
                   failure:(void (^)(NSError* err))failure;
//系统公告查询
+(void) selectNotice:(NSDictionary *) params
                success:(void (^)(NSArray *noticeList))success
                failure:(void (^)(NSError* err))failure;
//系统更新
+(void) selectVersionDic:(NSDictionary *) params
                   success:(void (^)(NSDictionary *dic))success
                   failure:(void (^)(NSError* err))failure;
//查询行驶证
+(void) selectVehicleLicenseList:(NSDictionary *) params
                 success:(void (^)(NSArray *vehicleLicenseList))success
                 failure:(void (^)(NSError* err))failure;
//行驶证详情
+(void) selectVehicleLicenContent:(NSDictionary *) params
              success:(void (^)(VehicleLicenseModel *vehicleLicenseModel))success
              failure:(void (^)(NSError* err))failure;
//上传行驶证
+(void) upVehicleLicen:(NSDictionary*)params block:(void (^)(id <AFMultipartFormData> formData))block success:(void (^)(BOOL result))result
               failure:(void (^)(NSError* err))failure;
//查询车型代码
+(void) selectSeriesCodeList:(NSDictionary *) params
                         success:(void (^)(NSArray *seriesCodeList))success
                         failure:(void (^)(NSError* err))failure;
//查询车型颜色代码
+(void) selectSeriesColorList:(NSDictionary *) params
                         success:(void (^)(NSArray *colorList))success
                         failure:(void (^)(NSError* err))failure;
//修改密码
+(void) updataPassWord:(NSDictionary *) params
             success:(void (^)(BOOL isSuccess))success
             failure:(void (^)(NSError* err))failure;

//获取初始化WS参数
+(void) getHelpInitList:(NSDictionary *) params
                      success:(void (^)(NSDictionary *dic))success
                      failure:(void (^)(NSError* err))failure;

//获取初始化SEM参数
+(void) getHelpInitListForSem:(NSDictionary *) params
                success:(void (^)(NSDictionary *dic))success
                failure:(void (^)(NSError* err))failure;

//查询技术资源申请单WS
+(void) selectSupporListForWs:(NSDictionary *) params
                      success:(void (^)(NSArray *supporList))success
                      failure:(void (^)(NSError* err))failure;

//保存/提交技术资源申请单
+(void) updataSupporForWs:(NSDictionary *) params
                      success:(void (^)(NSString *rhNO))success
                      failure:(void (^)(NSError* err))failure;
//查询技术资源申请单明细WS
+(void) selectSupporDetailForWs:(NSDictionary *) params
                      success:(void (^)(SupporContentModle *supporModel))success
                      failure:(void (^)(NSError* err))failure;
//ws站结案技术资源申请单
+(void) updataSupporEndForWs:(NSDictionary *) params
                  success:(void (^)(NSString *rhNO))success
                  failure:(void (^)(NSError* err))failure;

//ws站回复技术资源申请单
+(void) updataSupporReplyForWs:(NSDictionary *) params
                     success:(void (^)(NSString *rhNO))success
                     failure:(void (^)(NSError* err))failure;

//查询案例分享列表
+(void) selectCaseList:(NSDictionary *) params
                      success:(void (^)(NSArray *supporList))success
                      failure:(void (^)(NSError* err))failure;
//查询案例分享明细
+(void) selectCaseDetail:(NSDictionary *) params
                        success:(void (^)(SupporContentModle *supporModel))success
                        failure:(void (^)(NSError* err))failure;
//查询技术资源申请单SEM
+(void) selectSupporListForSem:(NSDictionary *) params
                      success:(void (^)(NSArray *supporList))success
                      failure:(void (^)(NSError* err))failure;
//查询技术资源申请单明细SEM
+(void) selectSupporDetailForSem:(NSDictionary *) params
                        success:(void (^)(SupporContentModle *supporModel))success
                        failure:(void (^)(NSError* err))failure;
//查询Sem其他老师
+(void) selectOtherTeacher:(NSDictionary *) params
                         success:(void (^)(NSArray *teacherArr))success
                         failure:(void (^)(NSError* err))failure;

//转发
+(void)commitTeacher:(NSDictionary *) params
             success:(void (^)(BOOL isSuccess))success
             failure:(void (^)(NSError* err))failure;
//sem站回复技术资源申请单
+(void) updataSupporReplyForSem:(NSDictionary *) params
                        success:(void (^)(BOOL isflag))success
                        failure:(void (^)(NSError* err))failure;
//上传附件
+(void) upEnclousure:(NSDictionary*)params block:(void (^)(id <AFMultipartFormData> formData))block success:(void (^)(NSArray *resultArr))result
          failure:(void (^)(NSError* err))failure;
//查询技术支援单各类附件
+(void) selectEnclousureList:(NSDictionary *) params
                       success:(void (^)(NSArray *enclousureList))success
                       failure:(void (^)(NSError* err))failure;
//ws车辆检核
+(void) selectCheckCarInf:(NSDictionary *) params
                     success:(void (^)(BOOL isSuccess))success
                     failure:(void (^)(NSError* err))failure;
//查询积分账户
+(void) selectpointForChange:(NSDictionary *) params
                  success:(void (^)(UserInfo *info))success
                  failure:(void (^)(NSError* err))failure;
//查询员工信息
+(void) selectDcsEmployInfo:(NSDictionary *) params
                     success:(void (^)(NSArray *employInfo))success
                     failure:(void (^)(NSError* err))failure;
//查询已结算积分
+(void) selectPointChangeDone:(NSDictionary *) params
                    success:(void (^)(NSArray *flowArr))success
                    failure:(void (^)(NSError* err))failure;
//查询月积分
+(void) selectPointSaleitme:(NSDictionary *) params
                      success:(void (^)(NSArray *itmeArr))success
                      failure:(void (^)(NSError* err))failure;
//保存兑换积分
+(void) savePointChange:(NSDictionary *) params
                    success:(void (^)(NSString *type))success
                    failure:(void (^)(NSError* err))failure;
//二网抵用卷
//查询已抵用卷
+(void) selectdyzList:(NSDictionary *) params
                      success:(void (^)(NSArray *dyzArr))success
                      failure:(void (^)(NSError* err))failure;
//申请使用抵用卷
+(void) savedyz:(NSDictionary *) params
                success:(void (^)(NSString *type))success
                failure:(void (^)(NSError* err))failure;
//消息
+(void) getDyjMsg:(NSDictionary *) params
        success:(void (^)(NSArray *dyzArr))success
        failure:(void (^)(NSError* err))failure;
//修改密码
+(void) updataPassword:(NSDictionary *) params
               success:(void (^)(BOOL issuccess))success
               failure:(void (^)(NSError* err))failure;

//录音
//获取token接口
+(void) get360Token:(NSDictionary *) params 
          success:(void (^)(NSString *token))success
          failure:(void (^)(NSError* err))failure;
//呼叫接口
+(void) callPhone360:(NSDictionary *) params
            success:(void (^)(BOOL issuccess))success
            failure:(void (^)(NSError* err))failure;
//获取录音地址
+(void) getIpInfo:(NSDictionary *) params
             success:(void (^)(NSDictionary * dic))success
             failure:(void (^)(NSError* err))failure;

//获取车损估计列表
+(void) getEvaluationList:(NSDictionary *) params
          success:(void (^)(NSArray * arr))success
          failure:(void (^)(NSError* err))failure;
@end
