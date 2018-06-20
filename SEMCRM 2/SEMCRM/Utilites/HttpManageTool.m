//
//  HttpManageTool.m
//  SEMCRM
//
//  Created by 薛斯岐 on 16/2/26.
//  Copyright © 2016年 sem. All rights reserved.
//

#import "HttpManageTool.h"
#import "ActivityModel.h"
#import "FileModle.h"
#import "AFHttpTool.h"
#import "CueList.h"
#import "GroupModel.h"
#import "TimeModle.h"
#import "AccepMst.h"
#import "ProcessModel.h"
#import "ServAnserModel.h"
#import "ProcessModel.h"
#import "CustomerInfo.h"
#import "EvaluationInfoModle.h"
#import "VehicleLicenseModel.h"
#import "SupporContentModle.h"
#import "TeacherModel.h"
#import "VoucherinfoModel.h"
#import "JFPointSaleItemModle.h"
#import "PointFlowModel.h"
#import "VoucherModel.h"
//http://61.131.6.197:7001/app/   测试
//http://61.131.6.208:8080/app/
//积分测试http://172.16.38.190/qaweb/restDms/
#define SEM_UP_SERVER @"http://epm.soueast-motor.com:8080/EPMWeb/"
#define SEM_JF_SERVER @"http://epm.soueast-motor.com:8001/qaweb/restDms/" //http://epm.soueast-motor.com:8001/qaweb/restDms/  http://61.131.6.238/qaweb/restDms/  http://172.16.2.191:9080/SEM_DMS_OEM_WEB/restDms/
#define CRM_XSGW_ADDCUE  @"get_tar_cust_new.do"//添加线索
#define CRM_XSGW_GETEVENT  @"get_eventname.do"//添加线索
#define CRM_XSGW_ADDCUELIST  @"get_tar_cust_batchNew.do"//批量添加线索
#define CRM_XSGW_TOBCLIST  @"get_tar_cust_list.do"//待联络列表
#define CRM_XSGW_TOBCDETAIL  @"get_tar_cust_detail.do"//线索详情
#define CRM_XSGW_UPCUFOLLOW  @"get_tar_cust_detail_new.do"//上传线索跟进状态
#define CRM_XSGW_MYCUELIST  @"get_tar_cust_list_page.do"//我的线索
#define CRM_XSJL_STYCUELIST  @"get_tar_cust_udlist_page.do"//待分配线索
#define CRM_XSJL_SALELIST  @"get_sale_man.do"//获取销售顾问
#define CRM_XSJL_MTCUE  @"get_tar_cust_send.do"//分配线索
#define CRM_XSJL_ZBCUE  @"get_defeat_confirm.do"//战败确认
#define CRM_XSJL_ZBBH  @"get_defeat_reject.do"//战败驳回
#define CRM_XSJL_YCCUE  @"get_tar_cust_yichang.do"//异常线索
#define CRM_XSJL_LOSTCUE  @"get_defeat_cust_list.do"//异常线索
#define CRM_XSJL_CXCUEGROUP @"get_tar_cust_list_total.do"//重新分配线索列表
#define CRM_XSJL_CXCUEGROUP_LIST @"get_tar_cust_total_page.do"//分组列表

#define CRM_XSJL_TIME_QUERY @"get_tar_forcast_level.do"//设置时间查询
#define CRM_XSJL_TIME_SET @"get_tar_forcast_level_set.do"//设置时间
#define CRM_XSJL_SEND_SET @"get_tar_send_set.do"//线索分配规则
//
#define CRM_KS_ACCEPTMSG_LIST @"getUnendcaseAcceptMst.do"//客诉查询
#define CRM_KS_UNACCEPTMSG_LIST @"getAcceptMstList.do"//客诉处理查询
#define CRM_KS_ACCEPTMSG_CONTENT @"getAcceptMstDetail.do"//客诉详细信息
#define CRM_KS_ACCEPTMSG_SUBMIT_YD @"insertServAnswer.do"//业代回复
#define CRM_KS_ACCEPTMSG_SUBMIT @"insertAnswer.do"//业代回复
#define CRM_NOTICE @"get_tar_notice.do"//系统公告
#define CRM_VERSION @"get_tar_cust_version.do"//系统更新
#define CRM_VEHICLELICENSE_LIST @"get_unup_photo.do"//行驶证查询
#define CRM_VEHICLELICENSE_CONTENT @"get_unup_photo_detail.do"//行驶证具体内容
#define CRM_VEHICLELICENSE_UP @"ttYearPartyVoteAction.do"//行驶证上传

#define CRM_SERIES_CODE @"get_model_info.do"//行驶证上传
#define CRM_SERIES_COLOR @"get_color_info.do"//获取颜色
#define CRM_PASSWORD_CHANGE @"get_password_change.do"//密码修改
#define CRM_HELP_INIT @"get_ws_help_ini.do"//获取初始化数据
#define CRM_SEM_HELP_INIT @"get_sem_help_ini.do"//获取初始化数据SEM
#define CRM_WS_HELP_LIST @"get_ws_help_list.do"//获取技术支援申请
#define CRM_WS_HELP_DETAIL @"get_ws_help_detail.do"//获取技术支援申请明细WS
#define CRM_SAVE_WS_HELP @"get_save_ws_help.do"//保存/提交技术支援申请明细
#define CRM_SAVE_WS_HELP_END @"get_save_ws_help_end.do"//ws结案技术支援申请明细
#define CRM_SAVE_WS_HELP_REPLY @"get_save_ws_help_reply.do"//ws回复技术支援申请明细
#define CRM_SHARE_LIST @"get_share_list.do"//获取案例分享明细
#define CRM_SHARE_FILES @"get_share_files.do"//获取案例分享明细
#define CRM_SEM_HELP_LIST @"get_sem_help_list.do"//获取案例分享明细
#define CRM_SEM_HELP_DETAIL @"get_sem_help_detail.do"//获取技术支援申请明细
#define CRM_SEM_OTHER_TERACHER @"get_sem_other_teacher.do"//获取其他老师
#define CRM_SAVE_OTHER_TERACHER @"get_save_sem_other_teacher.do"//转发老师
#define CRM_SAVE_SEM_HELP_REPLY @"get_save_sem_help_reply.do"//sem回复技术支援申请明细
#define CRM_SAVE_ENCLOUSURE @"ttYearPartyVoteAction.do"//提交附件
#define CRM_HELP_FILE @"get_help_file.do"//获取附件
#define CRM_CHECK_CAR_INF @"get_check_car_inf.do"//获取附件
#define JF_POINT_INFO @"getPointForChange"//获取积分账号
#define JF_EMPLOY_INFO @"getDcsEmployInfo"//获取员工信息
#define JF_POINT_FLOW @"getPointChangeDone"//获取已结算积分
#define JF_POINT_ITEM @"getPointItem"//获取月结积分
#define JF_POINT_SAVE @"savePointChange"//保存兑换积分
#define DYJ_NET_VOUCHER @"getDcsSecNetVoucherItem"//抵用劵
#define DYJ_NET_SAVESECNNET @"saveSecnetApply"//兑换抵用劵
#define DYJ_NET_GETMESSAGE @"getDcsSecNetVoucherMsg"//查询抵用劵接口
#define DYJ_NET_SAVEPWD @"saveSecnetPwdChange"//修改密码

#define SMART360_GETTOKEN @"sys/login"//获取录音token
#define SMART360_CALLPHONE @"callback"//呼叫
#define SMART360_GETIPINFO @"ipInfo"//获取录音地址

#define SEM_VEHICLE_LOSS_LIST @"get_evaluation_info.do"//获取车损估价

#import "YCCueModel.h"
#import "NoticeModel.h"
@implementation HttpManageTool
//新增线索(添加)
+(void) insertNewCueOne:(NSDictionary *) params
                       success:(void (^)(NSDictionary *dic))dicType
                       failure:(void (^)(NSError* err))failure{
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [app startLoading];
    [AFHttpTool requestWihtMethod:RequestMethodTypePost baseurl:SEM_TEST_SERVER url:CRM_XSGW_ADDCUE params:params success:^(id response) {
        [app stopLoading];
       
        dispatch_async(dispatch_get_main_queue(), ^(void) {
                dicType(response);
        });
        
    } failure:^(NSError *err) {
        [app stopLoading];
        failure(err);
    }];
}
+(void) insertNewCue:(NSDictionary *) params
success:(void (^)(BOOL isSuccess))success
             failure:(void (^)(NSError* err))failure{
    
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [app startLoading];
    [AFHttpTool requestWihtMethod:RequestMethodTypePost baseurl:SEM_TEST_SERVER url:CRM_XSGW_ADDCUE params:params success:^(id response) {
        [app stopLoading];
        int  errorCode =[response[@"errorCode"] intValue];
        NSString *message =response[@"message"] ;
        if ( errorCode== 0) {
            dispatch_async(dispatch_get_main_queue(), ^(void) {
                success(true);
            });
        }else{
            success(false);
            [MyUtil showMessage:message];
        }
    } failure:^(NSError *err) {
        [app stopLoading];
        failure(err);
    }];
}
//获取活动参数
+(void) getEventName:(NSDictionary *) params
             success:(void (^)(NSArray *eventArr))success
             failure:(void (^)(NSError* err))failure{
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    //[app startLoading];
    [AFHttpTool requestWihtMethod:RequestMethodTypePost baseurl:SEM_TEST_SERVER url:CRM_XSGW_GETEVENT params:params success:^(id response) {
       // [app stopLoading];
        int  errorCode =[response[@"errorCode"] intValue];
        NSString *message =response[@"message"] ;
        if ( errorCode== 0) {
            NSArray *dataArr =response[@"data"];
            
            NSArray *resultArr = [ActivityModel mj_objectArrayWithKeyValuesArray:dataArr];
            dispatch_async(dispatch_get_main_queue(), ^(void) {
                success(resultArr);
            });
        }else{
            failure(nil);
            //[MyUtil showMessage:message];
        }
    } failure:^(NSError *err) {
       // [app stopLoading];
        failure(err);
    }];
}
//线索批量上传
+(void) insertNewCueList:(NSDictionary *) params
                 success:(void (^)(NSString *mobiles))success
                 failure:(void (^)(NSError* err))failure{
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [app startLoading];
    [AFHttpTool requestWihtMethod:RequestMethodTypePost baseurl:SEM_TEST_SERVER url:CRM_XSGW_ADDCUELIST params:params success:^(id response) {
        [app stopLoading];
        int  errorCode =[response[@"errorCode"] intValue];
        NSString *message =response[@"message"] ;
        if ( errorCode== 0) {
            NSString *mobiles =response[@"data"] ;
            dispatch_async(dispatch_get_main_queue(), ^(void) {
                success(mobiles);
            });
        }else{
            failure(nil);
            [MyUtil showMessage:message];
        }
    } failure:^(NSError *err) {
        [app stopLoading];
        failure(err);
    }];
}
+(void) updataCue:(NSDictionary *) params
          success:(void (^)(BOOL isSuccess))success
          failure:(void (^)(NSError* err))failure{
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [app startLoading];
    [AFHttpTool requestWihtMethod:RequestMethodTypePost baseurl:SEM_TEST_SERVER url:CRM_XSGW_ADDCUE params:params success:^(id response) {
        [app stopLoading];
        int  errorCode =[response[@"errorCode"] intValue];
        NSString *message =response[@"message"] ;
        if ( errorCode== 0) {
            dispatch_async(dispatch_get_main_queue(), ^(void) {
                success(true);
            });
        }else{
            success(false);
            [MyUtil showMessage:message];
        }
    } failure:^(NSError *err) {
        [app stopLoading];
        failure(err);
    }];
}
+(void) selectToBeConTactList:(NSDictionary *) params
                      success:(void (^)(NSDictionary *toBCList))success
                      failure:(void (^)(NSError* err))failure{
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [app startLoading];
    [AFHttpTool requestWihtMethod:RequestMethodTypePost baseurl:SEM_TEST_SERVER url:CRM_XSGW_TOBCLIST params:params success:^(id response) {
        [app stopLoading];
        int  errorCode =[response[@"errorCode"] intValue];
        NSString *message =response[@"message"] ;
        if ( errorCode== 0) {
            NSArray *arr =response[@"data"];
            NSMutableArray *arrTemp =[[NSMutableArray alloc]initWithCapacity:0];
            NSArray *resultArr = [CueList mj_objectArrayWithKeyValuesArray:arr];
            [arrTemp addObjectsFromArray:resultArr];
            NSString *ss =response[@"count"]==NULL?@"0":response[@"count"] ;
            dispatch_async(dispatch_get_main_queue(), ^(void) {
                success(@{@"count":ss,@"data":resultArr});
            });
        }else{
            failure(nil);
            [MyUtil showMessage:message];
        }
    } failure:^(NSError *err) {
        [app stopLoading];
        failure(err);
    }];
}
+(void) selectCueInfo:(NSDictionary *) params
              success:(void (^)(CueList *cueModel))success
              failure:(void (^)(NSError* err))failure{
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [app startLoading];
    [AFHttpTool requestWihtMethod:RequestMethodTypePost baseurl:SEM_TEST_SERVER url:CRM_XSGW_TOBCDETAIL params:params success:^(id response) {
        [app stopLoading];
        int  errorCode =[response[@"errorCode"] intValue];
        NSString *message =response[@"message"] ;
        if ( errorCode== 0) {
            NSArray *arr =response[@"data"];
            CueList *cueModel = nil;
            if(arr.count>0){
                NSDictionary *dic = arr[0];
                cueModel = [CueList mj_objectWithKeyValues:dic];
            }
            dispatch_async(dispatch_get_main_queue(), ^(void) {
                success(cueModel);
            });
        }else{
            failure(nil);
            [MyUtil showMessage:message];
        }
    } failure:^(NSError *err) {
        [app stopLoading];
        failure(err);
    }];


}
+(void) insertNewCueFollow:(NSDictionary *) params
                   success:(void (^)(BOOL isSuccess))success
                   failure:(void (^)(NSError* err))failure{
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [app startLoading];
    [AFHttpTool requestWihtMethod:RequestMethodTypePost baseurl:SEM_TEST_SERVER url:CRM_XSGW_UPCUFOLLOW params:params success:^(id response) {
        [app stopLoading];
        int  errorCode =[response[@"errorCode"] intValue];        NSString *message =response[@"message"] ;
        if ( errorCode== 0) {
            dispatch_async(dispatch_get_main_queue(), ^(void) {
                success(true);
            });
        }else{
            dispatch_async(dispatch_get_main_queue(), ^(void) {
                success(false);
            });
            [MyUtil showMessage:message];
        }
    } failure:^(NSError *err) {
        [app stopLoading];
        failure(err);
    }];

}
+(void) selectMyCueList:(NSDictionary *) params
                success:(void (^)(NSDictionary *toBCList))success
                failure:(void (^)(NSError* err))failure{
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [app startLoading];
    [AFHttpTool requestWihtMethod:RequestMethodTypePost baseurl:SEM_TEST_SERVER url:CRM_XSGW_MYCUELIST params:params success:^(id response) {
        [app stopLoading];
        int  errorCode =[response[@"errorCode"] intValue];
        NSString *message =response[@"message"] ;
        if ( errorCode== 0) {
            NSArray *arr =response[@"data"];
            NSMutableArray *arrTemp =[[NSMutableArray alloc]initWithCapacity:0];
            NSArray *resultArr = [CueList mj_objectArrayWithKeyValuesArray:arr];
            [arrTemp addObjectsFromArray:resultArr];
            NSString *ss =response[@"count"]==NULL?@"0":response[@"count"] ;
           // NSArray *resultArr = [CueList mj_objectArrayWithKeyValuesArray:arr];
             dispatch_async(dispatch_get_main_queue(), ^(void) {
                success(@{@"count":ss,@"data":resultArr});
              });
        }else{
            failure(nil);
            [MyUtil showMessage:message];
        }
    } failure:^(NSError *err) {
        [app stopLoading];
        failure(err);
    }];
}

+(void) selectStayCueList:(NSDictionary *) params
                  success:(void (^)(CueStayModel *stayModel))success
                  failure:(void (^)(NSError* err))failure{
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [app startLoading];
    [AFHttpTool requestWihtMethod:RequestMethodTypePost baseurl:SEM_TEST_SERVER url:CRM_XSJL_STYCUELIST params:params success:^(id response) {
        [app stopLoading];
        int  errorCode =[response[@"errorCode"] intValue];
        NSString *message =response[@"message"] ;
        if ( errorCode== 0) {
            NSDictionary *dataDic =response[@"data"];
             CueStayModel *stayModelNow  = [CueStayModel mj_objectWithKeyValues:dataDic];
            
            dispatch_async(dispatch_get_main_queue(), ^(void) {
                success(stayModelNow);
            });
        }else{
            failure(nil);
            [MyUtil showMessage:message];
        }
    } failure:^(NSError *err) {
        [app stopLoading];
        failure(err);
    }];
}
+(void) selectCXCueByGroupList:(NSDictionary *) params
                       success:(void (^)(NSArray *cxList))success
                       failure:(void (^)(NSError* err))failure{
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [app startLoading];
    [AFHttpTool requestWihtMethod:RequestMethodTypePost baseurl:SEM_TEST_SERVER url:CRM_XSJL_CXCUEGROUP params:params success:^(id response) {
        [app stopLoading];
        int  errorCode =[response[@"errorCode"] intValue];
        NSString *message =response[@"message"] ;
        if ( errorCode== 0) {
            NSArray *dataArr =response[@"data"];
            
            NSArray *resultArr = [GroupModel mj_objectArrayWithKeyValuesArray:dataArr];
            dispatch_async(dispatch_get_main_queue(), ^(void) {
                success(resultArr);
            });
        }else{
            failure(nil);
            [MyUtil showMessage:message];
        }
    } failure:^(NSError *err) {
        [app stopLoading];
        failure(err);
    }];
}

//异常线索
+(void) selectYCCueList:(NSDictionary *) params
                success:(void (^)(NSArray *ycCueList))success
                failure:(void (^)(NSError* err))failure{
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [app startLoading];
    [AFHttpTool requestWihtMethod:RequestMethodTypePost baseurl:SEM_TEST_SERVER url:CRM_XSJL_YCCUE params:params success:^(id response) {
        [app stopLoading];
        int  errorCode =[response[@"errorCode"] intValue];
        NSString *message =response[@"message"] ;
        if ( errorCode== 0) {
            NSArray *dataArr =response[@"data"];
            
            NSArray *resultArr = [YCCueModel mj_objectArrayWithKeyValuesArray:dataArr];
            dispatch_async(dispatch_get_main_queue(), ^(void) {
                success(resultArr);
            });
        }else{
            failure(nil);
            [MyUtil showMessage:message];
        }
    } failure:^(NSError *err) {
        [app stopLoading];
        failure(err);
    }];

}
//重新分配分组列表
+(void) selectCXGroupList:(NSDictionary *) params
                  success:(void (^)(NSArray *fzList))success
                  failure:(void (^)(NSError* err))failure{
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [app startLoading];
    [AFHttpTool requestWihtMethod:RequestMethodTypePost baseurl:SEM_TEST_SERVER url:CRM_XSJL_CXCUEGROUP_LIST params:params success:^(id response) {
        [app stopLoading];
        int  errorCode =[response[@"errorCode"] intValue];
        NSString *message =response[@"message"] ;
        if ( errorCode== 0) {
            NSDictionary *dataDic =response[@"data"];
            NSArray *dataArr = dataDic[@"info"];
            NSArray *resultArr = [CueList mj_objectArrayWithKeyValuesArray:dataArr];
            dispatch_async(dispatch_get_main_queue(), ^(void) {
                success(resultArr);
            });
        }else{
            failure(nil);
            [MyUtil showMessage:message];
        }
    } failure:^(NSError *err) {
        [app stopLoading];
        failure(err);
    }];
}
+(void) selectSaleList:(NSDictionary *) params
               success:(void (^)(NSArray *saleList))success
               failure:(void (^)(NSError* err))failure{
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [app startLoading];
    [AFHttpTool requestWihtMethod:RequestMethodTypePost baseurl:SEM_TEST_SERVER url:CRM_XSJL_SALELIST params:params success:^(id response) {
        [app stopLoading];
        int  errorCode =[response[@"errorCode"] intValue];
        NSString *message =response[@"message"] ;
        if ( errorCode== 0) {
            NSArray *arr =response[@"data"];
            NSArray *resultArr = [UserInfo mj_objectArrayWithKeyValuesArray:arr];
            dispatch_async(dispatch_get_main_queue(), ^(void) {
                success(resultArr);
            });
        }else{
            failure(nil);
            [MyUtil showMessage:message];
        }
    } failure:^(NSError *err) {
        [app stopLoading];
        failure(err);
    }];
}
+(void) selectSaleDic:(NSDictionary *) params
              success:(void (^)(NSDictionary *dic))success
              failure:(void (^)(NSError* err))failure{
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [app startLoading];
    [AFHttpTool requestWihtMethod:RequestMethodTypePost baseurl:SEM_TEST_SERVER url:CRM_XSJL_SALELIST params:params success:^(id response) {
        [app stopLoading];
        int  errorCode =[response[@"errorCode"] intValue];
        NSString *message =response[@"message"] ;
        NSString *SEND_RULE =response[@"SEND_RULE"] ;
        if ( errorCode== 0) {
            NSArray *arr =response[@"data"];
            
            NSArray *resultArr = [UserInfo mj_objectArrayWithKeyValuesArray:arr];
            NSDictionary *newdic = @{@"data":resultArr,@"SEND_RULE":SEND_RULE};
            dispatch_async(dispatch_get_main_queue(), ^(void) {
                success(newdic);
            });
        }else{
            failure(nil);
            [MyUtil showMessage:message];
        }
    } failure:^(NSError *err) {
        [app stopLoading];
        failure(err);
    }];
}
+(void) updataCueForMT:(NSDictionary *) params
               success:(void (^)(BOOL isSuccess))success
               failure:(void (^)(NSError* err))failure{
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [app startLoading];
    [AFHttpTool requestWihtMethod:RequestMethodTypePost baseurl:SEM_TEST_SERVER url:CRM_XSJL_MTCUE params:params success:^(id response) {
        [app stopLoading];
        int  errorCode =[response[@"errorCode"] intValue];
        NSString *message =response[@"message"] ;
        if ( errorCode== 0) {
            dispatch_async(dispatch_get_main_queue(), ^(void) {
                success(true);
                [MyUtil showMessage:message];
            });
        }else{
            success(false);
            [MyUtil showMessage:message];
        }
    } failure:^(NSError *err) {
        [app stopLoading];
        failure(err);
    }];
}
+(void) updataCueReject:(NSDictionary *) params
               success:(void (^)(BOOL isSuccess))success
               failure:(void (^)(NSError* err))failure{
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [app startLoading];
    [AFHttpTool requestWihtMethod:RequestMethodTypePost baseurl:SEM_TEST_SERVER url:CRM_XSJL_ZBBH params:params success:^(id response) {
        [app stopLoading];
        int  errorCode =[response[@"errorCode"] intValue];
        NSString *message =response[@"message"] ;
        if ( errorCode== 0) {
            dispatch_async(dispatch_get_main_queue(), ^(void) {
                success(true);
            });
        }else{
            success(false);
            [MyUtil showMessage:message];
        }
    } failure:^(NSError *err) {
        [app stopLoading];
        failure(err);
    }];
}
+(void) confirmCueForZB:(NSDictionary *) params
                success:(void (^)(BOOL isSuccess))success
                failure:(void (^)(NSError* err))failure{
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [app startLoading];
    [AFHttpTool requestWihtMethod:RequestMethodTypePost baseurl:SEM_TEST_SERVER url:CRM_XSJL_ZBCUE params:params success:^(id response) {
        [app stopLoading];
        int  errorCode =[response[@"errorCode"] intValue];
        NSString *message =response[@"message"] ;
        if ( errorCode== 0) {
            dispatch_async(dispatch_get_main_queue(), ^(void) {
                success(true);
            });
        }else{
            success(false);
            [MyUtil showMessage:message];
        }
    } failure:^(NSError *err) {
        [app stopLoading];
        failure(err);
    }];
}
//设置时间查询
+(void) selectTimeList:(NSDictionary *) params
               success:(void (^)(NSArray *timeList))success
               failure:(void (^)(NSError* err))failure{
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [app startLoading];
    [AFHttpTool requestWihtMethod:RequestMethodTypePost baseurl:SEM_TEST_SERVER url:CRM_XSJL_TIME_QUERY params:params success:^(id response) {
        [app stopLoading];
        int  errorCode =[response[@"errorCode"] intValue];
        NSString *message =response[@"message"] ;
        if ( errorCode== 0) {
            NSArray *arr =response[@"data"];
            NSArray *resultArr = [TimeModle mj_objectArrayWithKeyValuesArray:arr];
            dispatch_async(dispatch_get_main_queue(), ^(void) {
                success(resultArr);
            });
        }else{
            failure(nil);
            [MyUtil showMessage:message];
        }
    } failure:^(NSError *err) {
        [app stopLoading];
        failure(err);
    }];
}
//级别时间配置
+(void) updataTimeSet:(NSDictionary *) params
              success:(void (^)(BOOL isSuccess))success
              failure:(void (^)(NSError* err))failure{
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [app startLoading];
    [AFHttpTool requestWihtMethod:RequestMethodTypePost baseurl:SEM_TEST_SERVER url:CRM_XSJL_TIME_SET params:params success:^(id response) {
        [app stopLoading];
        int  errorCode =[response[@"errorCode"] intValue];
        NSString *message =response[@"message"] ;
        if ( errorCode== 0) {
            dispatch_async(dispatch_get_main_queue(), ^(void) {
                success(true);
            });
        }else{
            success(false);
            [MyUtil showMessage:message];
        }
    } failure:^(NSError *err) {
        [app stopLoading];
        failure(err);
    }];
}
//线索分配设置
+(void) updataSendSet:(NSDictionary *) params
              success:(void (^)(BOOL isSuccess))success
              failure:(void (^)(NSError* err))failure{
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [app startLoading];
    [AFHttpTool requestWihtMethod:RequestMethodTypePost baseurl:SEM_TEST_SERVER url:CRM_XSJL_SEND_SET params:params success:^(id response) {
        [app stopLoading];
        int  errorCode =[response[@"errorCode"] intValue];
        NSString *message =response[@"message"] ;
        if ( errorCode== 0) {
            dispatch_async(dispatch_get_main_queue(), ^(void) {
                success(true);
            });
        }else{
            success(false);
            [MyUtil showMessage:message];
        }
    } failure:^(NSError *err) {
        [app stopLoading];
        failure(err);
    }];
}

//客诉查询
+(void) selectUnAcceptMstList:(NSDictionary *) params
                      success:(void (^)(NSArray *kxList))success
                      failure:(void (^)(NSError* err))failure{
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [app startLoading];
    [AFHttpTool requestWihtMethod:RequestMethodTypePost baseurl:SEM_TEST_SERVER url:CRM_KS_ACCEPTMSG_LIST params:params success:^(id response) {
        [app stopLoading];
        int  errorCode =[response[@"errorCode"] intValue];
        NSString *message =response[@"message"] ;
        if ( errorCode== 0) {
            NSArray *arr =response[@"data"];
            NSArray *resultArr = [AccepMst mj_objectArrayWithKeyValuesArray:arr];
            dispatch_async(dispatch_get_main_queue(), ^(void) {
                success(resultArr);
            });
        }else{
            failure(nil);
            [MyUtil showMessage:message];
        }
    } failure:^(NSError *err) {
        [app stopLoading];
        failure(err);
    }];
}
//客诉处理查询
+(void) selectAcceptMst:(NSDictionary *) params
                success:(void (^)(NSArray *kxList))success
                failure:(void (^)(NSError* err))failure{
//
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [app startLoading];
    [AFHttpTool requestWihtMethod:RequestMethodTypePost baseurl:SEM_TEST_SERVER url:CRM_KS_UNACCEPTMSG_LIST params:params success:^(id response) {
        [app stopLoading];
        int  errorCode =[response[@"errorCode"] intValue];
        NSString *message =response[@"message"] ;
        if ( errorCode== 0) {
            NSArray *arr =response[@"data"];
            NSArray *resultArr = [AccepMst mj_objectArrayWithKeyValuesArray:arr];
            dispatch_async(dispatch_get_main_queue(), ^(void) {
                success(resultArr);
            });
        }else{
            failure(nil);
            [MyUtil showMessage:message];
        }
    } failure:^(NSError *err) {
        [app stopLoading];
        failure(err);
    }];
}
//客诉处理信息
+(void) selectAcceptMstDic:(NSDictionary *) params
                   success:(void (^)(NSDictionary *dic))success
                   failure:(void (^)(NSError* err))failure{
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [app startLoading];
    [AFHttpTool requestWihtMethod:RequestMethodTypePost baseurl:SEM_TEST_SERVER url:CRM_KS_ACCEPTMSG_CONTENT params:params success:^(id response) {
        [app stopLoading];
        int  errorCode =[response[@"errorCode"] intValue];
        NSString *message =response[@"message"] ;
        
        if ( errorCode== 0) {
            
            NSArray *mainlist=response[@"mainlist"];
            NSArray *processlist=response[@"processlist"];
            NSArray *serv_anser_list=response[@"serv_anser_list"];
            NSArray *processlistNew = [ProcessModel mj_objectArrayWithKeyValuesArray:processlist];
            NSArray *serv_anser_listNew = [ServAnserModel mj_objectArrayWithKeyValuesArray:serv_anser_list];
            NSArray *mainlisNew=[CustomerInfo mj_objectArrayWithKeyValuesArray:mainlist];
            CustomerInfo *model = mainlisNew.count>0?mainlisNew[0]:[[CustomerInfo alloc]initWithTrue:YES] ;
            NSDictionary *newdic = @{@"CustomerInfo":model,@"processlist":processlistNew,@"serv_anser_list":serv_anser_listNew};
            dispatch_async(dispatch_get_main_queue(), ^(void) {
                success(newdic);
            });
        }else{
            failure(nil);
            [MyUtil showMessage:message];
        }
    } failure:^(NSError *err) {
        [app stopLoading];
        failure(err);
    }];
}
//提交业代回复
+(void) insertServAnswer:(NSDictionary *) params
                 success:(void (^)(BOOL isSuccess))success
                 failure:(void (^)(NSError* err))failure{
    [AFHttpTool requestWihtMethod:RequestMethodTypePost baseurl:SEM_TEST_SERVER url:CRM_KS_ACCEPTMSG_SUBMIT_YD params:params success:^(id response) {
        
        int  errorCode =[response[@"errorCode"] intValue];
        NSString *message =response[@"message"] ;
      
        if ( errorCode== 0) {
            dispatch_async(dispatch_get_main_queue(), ^(void) {
                success(true);
            });
        }else{
            dispatch_async(dispatch_get_main_queue(), ^(void) {
                success(false);
                [MyUtil showMessage:message];
            });
            //            [MyUtil showMessage:message];
        }
    } failure:^(NSError *err) {
        
        failure(err);
    }];
}
//提交回复
+(void) insertAnswer:(NSDictionary *) params
             success:(void (^)(BOOL isSuccess))success
             failure:(void (^)(NSError* err))failure{
    [AFHttpTool requestWihtMethod:RequestMethodTypePost baseurl:SEM_TEST_SERVER url:CRM_KS_ACCEPTMSG_SUBMIT params:params success:^(id response) {
        
        int  errorCode =[response[@"errorCode"] intValue];
        NSString *message =response[@"message"] ;
        if ( errorCode== 0) {
            dispatch_async(dispatch_get_main_queue(), ^(void) {
                success(true);
            });
        }else{
            dispatch_async(dispatch_get_main_queue(), ^(void) {
                success(false);
                [MyUtil showMessage:message];
            });
            //            [MyUtil showMessage:message];
        }
    } failure:^(NSError *err) {
        
        failure(err);
    }];
}
//系统公告查询
+(void) selectNotice:(NSDictionary *) params
             success:(void (^)(NSArray *noticeList))success
             failure:(void (^)(NSError* err))failure{
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [app startLoading];
    [AFHttpTool requestWihtMethod:RequestMethodTypePost baseurl:SEM_TEST_SERVER url:CRM_NOTICE params:params success:^(id response) {
        [app stopLoading];
        int  errorCode =[response[@"errorCode"] intValue];
        NSString *message =response[@"message"] ;
        if ( errorCode== 0) {
            NSArray *arr =response[@"data"];
            NSArray *resultArr = [NoticeModel mj_objectArrayWithKeyValuesArray:arr];
            dispatch_async(dispatch_get_main_queue(), ^(void) {
                success(resultArr);
            });
        }else{
            failure(nil);
            [MyUtil showMessage:message];
        }
    } failure:^(NSError *err) {
        [app stopLoading];
        failure(err);
    }];
}
//系统更新
+(void) selectVersionDic:(NSDictionary *) params
                 success:(void (^)(NSDictionary *dic))success
                 failure:(void (^)(NSError* err))failure{
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [app startLoading];
    [AFHttpTool requestWihtMethod:RequestMethodTypePost baseurl:SEM_TEST_SERVER url:CRM_VERSION params:params success:^(id response) {
        [app stopLoading];
        int  errorCode =[response[@"errorCode"] intValue];
        NSString *message =response[@"message"] ;
        
        if ( errorCode== 0) {
            NSString *versionNo =response[@"versionNo"] ;
            NSString *downloadUrl =response[@"downloadUrl"] ;
            NSDictionary *newdic = @{@"versionNo":versionNo,@"downloadUrl":downloadUrl};
            dispatch_async(dispatch_get_main_queue(), ^(void) {
                success(newdic);
            });
        }else{
            failure(nil);
            [MyUtil showMessage:message];
        }
    } failure:^(NSError *err) {
        [app stopLoading];
        failure(err);
    }];
}
//查询行驶证
+(void) selectVehicleLicenseList:(NSDictionary *) params
                         success:(void (^)(NSArray *vehicleLicenseList))success
                         failure:(void (^)(NSError* err))failure{
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [app startLoading];
    [AFHttpTool requestWihtMethod:RequestMethodTypePost baseurl:SEM_TEST_SERVER url:CRM_VEHICLELICENSE_LIST params:params success:^(id response) {
        [app stopLoading];
        int  errorCode =[response[@"errorCode"] intValue];
        NSString *message =response[@"message"] ;
        if ( errorCode== 0) {
            NSArray *arr =response[@"data"];
            NSArray *resultArr = [VehicleLicenseModel mj_objectArrayWithKeyValuesArray:arr];
            dispatch_async(dispatch_get_main_queue(), ^(void) {
                success(resultArr);
            });
        }else{
            failure(nil);
            [MyUtil showMessage:message];
        }
    } failure:^(NSError *err) {
        [app stopLoading];
        failure(err);
    }];
}
//行驶证详情
+(void) selectVehicleLicenContent:(NSDictionary *) params
                          success:(void (^)(VehicleLicenseModel *vehicleLicenseModel))success
                          failure:(void (^)(NSError* err))failure{
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [app startLoading];
    [AFHttpTool requestWihtMethod:RequestMethodTypePost baseurl:SEM_TEST_SERVER url:CRM_VEHICLELICENSE_CONTENT params:params success:^(id response) {
        [app stopLoading];
        int  errorCode =[response[@"errorCode"] intValue];
        NSString *message =response[@"message"] ;
        if ( errorCode== 0) {
            NSDictionary *dic =response[@"data"];
            
            VehicleLicenseModel *model = [VehicleLicenseModel mj_objectWithKeyValues:dic];
            dispatch_async(dispatch_get_main_queue(), ^(void) {
                success(model);
            });
        }else{
            failure(nil);
            [MyUtil showMessage:message];
        }
    } failure:^(NSError *err) {
        [app stopLoading];
        failure(err);
    }];
}
+(void) upVehicleLicen:(NSDictionary*)params block:(void (^)(id <AFMultipartFormData> formData))block success:(void (^)(BOOL result))success
               failure:(void (^)(NSError* err))failure{
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [app startLoading];
    [AFHttpTool requestFileWihtUrl:CRM_VEHICLELICENSE_UP baseURL:SEM_UP_SERVER params:params block:block success:^(id response) {
        NSString *code = [NSString stringWithFormat:@"%@",response[@"errorCode"]];
        NSString *message=[NSString stringWithFormat:@"%@",response[@"message"]];
        if ([code isEqualToString:@"0"]) {
            dispatch_async(dispatch_get_main_queue(), ^(void) {
                success(YES);
            });
            [app stopLoading];
        }else{
            success(NO);
            [app stopLoading];
            [MyUtil showMessage:message];
        }
    } failure:^(NSError *err) {
        [app stopLoading];
        failure(err);
    }];
    }
//查询车型代码
+(void) selectSeriesCodeList:(NSDictionary *) params
                     success:(void (^)(NSArray *seriesCodeList))success
                     failure:(void (^)(NSError* err))failure{
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [app startLoading];
    [AFHttpTool requestWihtMethod:RequestMethodTypePost baseurl:SEM_TEST_SERVER url:CRM_SERIES_CODE params:params success:^(id response) {
        [app stopLoading];
        int  errorCode =[response[@"errorCode"] intValue];
        NSString *message =response[@"message"] ;
        if ( errorCode== 0) {
            NSArray *arr =response[@"data"];
            dispatch_async(dispatch_get_main_queue(), ^(void) {
                success(arr);
            });
        }else{
            failure(nil);
            [MyUtil showMessage:message];
        }
    } failure:^(NSError *err) {
        [app stopLoading];
        failure(err);
    }];
}
//查询车型颜色代码
+(void) selectSeriesColorList:(NSDictionary *) params
                      success:(void (^)(NSArray *colorList))success
                      failure:(void (^)(NSError* err))failure{
//    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
//    [app startLoading];
    [AFHttpTool requestWihtMethod:RequestMethodTypePost baseurl:SEM_TEST_SERVER url:CRM_SERIES_COLOR params:params success:^(id response) {
//        [app stopLoading];
        int  errorCode =[response[@"errorCode"] intValue];
        NSString *message =response[@"message"] ;
        if ( errorCode== 0) {
            NSArray *arr =response[@"data"];
            
            dispatch_async(dispatch_get_main_queue(), ^(void) {
                success(arr);
            });
        }else{
            failure(nil);
            [MyUtil showMessage:message];
        }
    } failure:^(NSError *err) {
//        [app stopLoading];
        failure(err);
    }];
}
//修改密码
+(void) updataPassWord:(NSDictionary *) params
               success:(void (^)(BOOL isSuccess))success
               failure:(void (^)(NSError* err))failure{
    [AFHttpTool requestWihtMethod:RequestMethodTypePost baseurl:SEM_TEST_SERVER url:CRM_PASSWORD_CHANGE params:params success:^(id response) {
        
        int  errorCode =[response[@"errorCode"] intValue];
        NSString *message =response[@"message"] ;
        if ( errorCode== 0) {
            dispatch_async(dispatch_get_main_queue(), ^(void) {
                success(true);
            });
        }else{
            dispatch_async(dispatch_get_main_queue(), ^(void) {
                success(false);
                [MyUtil showMessage:message];
            });
            //            [MyUtil showMessage:message];
        }
    } failure:^(NSError *err) {
        
        failure(err);
    }];
}
//获取初始化参数
+(void) getHelpInitList:(NSDictionary *) params
                success:(void (^)(NSDictionary *dic))success
                failure:(void (^)(NSError* err))failure{
    [AFHttpTool requestWihtMethod:RequestMethodTypePost baseurl:SEM_TEST_SERVER url:CRM_HELP_INIT params:params success:^(id response) {
        //        [app stopLoading];
        int  errorCode =[response[@"errorCode"] intValue];
        NSString *message =response[@"message"] ;
        if ( errorCode== 0) {
            
            
            dispatch_async(dispatch_get_main_queue(), ^(void) {
                success(response);
            });
        }else{
            failure(nil);
            [MyUtil showMessage:message];
        }
    } failure:^(NSError *err) {
        //        [app stopLoading];
        failure(err);
    }];

}
//获取初始化SEM参数
+(void) getHelpInitListForSem:(NSDictionary *) params
                      success:(void (^)(NSDictionary *dic))success
                      failure:(void (^)(NSError* err))failure{
    [AFHttpTool requestWihtMethod:RequestMethodTypePost baseurl:SEM_TEST_SERVER url:CRM_SEM_HELP_INIT params:params success:^(id response) {
        //        [app stopLoading];
        int  errorCode =[response[@"errorCode"] intValue];
        NSString *message =response[@"message"] ;
        if ( errorCode== 0) {
            
            
            dispatch_async(dispatch_get_main_queue(), ^(void) {
                success(response);
            });
        }else{
            failure(nil);
            [MyUtil showMessage:message];
        }
    } failure:^(NSError *err) {
        //        [app stopLoading];
        failure(err);
    }];
}
//战败线索
+(void) selectLostCueList:(NSDictionary *) params
                  success:(void (^)(NSDictionary *dataListDic))success
                  failure:(void (^)(NSError* err))failure{
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [app startLoading];
    [AFHttpTool requestWihtMethod:RequestMethodTypePost baseurl:SEM_TEST_SERVER url:CRM_XSJL_LOSTCUE params:params success:^(id response) {
        [app stopLoading];
        int  errorCode =[response[@"errorCode"] intValue];
        NSString *message =response[@"message"] ;
        if ( errorCode== 0) {
            
            dispatch_async(dispatch_get_main_queue(), ^(void) {
                success(response);
            });
        }else{
            failure(nil);
            [MyUtil showMessage:message];
        }
    } failure:^(NSError *err) {
        [app stopLoading];
        failure(err);
    }];
}
//查询技术资源申请单
+(void) selectSupporListForWs:(NSDictionary *) params
                      success:(void (^)(NSArray *supporList))success
                      failure:(void (^)(NSError* err))failure{
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [app startLoading];
    [AFHttpTool requestWihtMethod:RequestMethodTypePost baseurl:SEM_TEST_SERVER url:CRM_WS_HELP_LIST params:params success:^(id response) {
        [app stopLoading];
        int  errorCode =[response[@"errorCode"] intValue];
        NSString *message =response[@"message"] ;
        if ( errorCode== 0) {
            NSArray *dataArr =response[@"data_list"];
            
            NSArray *resultArr = [SupporContentModle mj_objectArrayWithKeyValuesArray:dataArr];
            dispatch_async(dispatch_get_main_queue(), ^(void) {
                success(resultArr);
            });
        }else{
            failure(nil);
            [MyUtil showMessage:message];
        }
    } failure:^(NSError *err) {
        [app stopLoading];
        failure(err);
    }];

}
//查询技术资源申请单SEM
+(void) selectSupporListForSem:(NSDictionary *) params
                       success:(void (^)(NSArray *supporList))success
                       failure:(void (^)(NSError* err))failure{
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [app startLoading];
    [AFHttpTool requestWihtMethod:RequestMethodTypePost baseurl:SEM_TEST_SERVER url:CRM_SEM_HELP_LIST params:params success:^(id response) {
        [app stopLoading];
        int  errorCode =[response[@"errorCode"] intValue];
        NSString *message =response[@"message"] ;
        if ( errorCode== 0) {
            NSArray *dataArr =response[@"data_list"];
            
            NSArray *resultArr = [SupporContentModle mj_objectArrayWithKeyValuesArray:dataArr];
            dispatch_async(dispatch_get_main_queue(), ^(void) {
                success(resultArr);
            });
        }else{
            failure(nil);
            [MyUtil showMessage:message];
        }
    } failure:^(NSError *err) {
        [app stopLoading];
        failure(err);
    }];
}
//保存/提交技术资源申请单
+(void) updataSupporForWs:(NSDictionary *) params
                  success:(void (^)(NSString *rhNO))success
                  failure:(void (^)(NSError* err))failure{
    [AFHttpTool requestWihtMethod:RequestMethodTypePost baseurl:SEM_TEST_SERVER url:CRM_SAVE_WS_HELP params:params success:^(id response) {
        
        int  errorCode =[response[@"errorCode"] intValue];
        NSString *rhNO=response[@"rh_no_new"];
        NSString *message =response[@"message"] ;
        if ( errorCode== 0) {
            dispatch_async(dispatch_get_main_queue(), ^(void) {
                success(rhNO);
            });
        }else{
            failure(nil);
            [MyUtil showMessage:message];
            //            [MyUtil showMessage:message];
        }
    } failure:^(NSError *err) {
        
        failure(err);
    }];
}
//查询技术资源申请单明细
+(void) selectSupporDetailForWs:(NSDictionary *) params
                        success:(void (^)(SupporContentModle *supporModel))success
                        failure:(void (^)(NSError* err))failure{
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [app startLoading];
    [AFHttpTool requestWihtMethod:RequestMethodTypePost baseurl:SEM_TEST_SERVER url:CRM_WS_HELP_DETAIL params:params success:^(id response) {
        [app stopLoading];
        int  errorCode =[response[@"errorCode"] intValue];
        NSString *message =response[@"message"] ;
        if ( errorCode== 0) {
            NSDictionary *dic =response[@"data_list"];
            SupporContentModle *model = [SupporContentModle mj_objectWithKeyValues:dic];
            dispatch_async(dispatch_get_main_queue(), ^(void) {
                success(model);
            });
        }else{
            failure(nil);
            [MyUtil showMessage:message];
        }
    } failure:^(NSError *err) {
        [app stopLoading];
        failure(err);
    }];

}
//查询技术资源申请单明细SEM
+(void) selectSupporDetailForSem:(NSDictionary *) params
                         success:(void (^)(SupporContentModle *supporModel))success
                         failure:(void (^)(NSError* err))failure{
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [app startLoading];
    [AFHttpTool requestWihtMethod:RequestMethodTypePost baseurl:SEM_TEST_SERVER url:CRM_SEM_HELP_DETAIL params:params success:^(id response) {
        [app stopLoading];
        int  errorCode =[response[@"errorCode"] intValue];
        NSString *message =response[@"message"] ;
        if ( errorCode== 0) {
            NSDictionary *dic =response[@"data_list"];
            SupporContentModle *model = [SupporContentModle mj_objectWithKeyValues:dic];
            dispatch_async(dispatch_get_main_queue(), ^(void) {
                success(model);
            });
        }else{
            failure(nil);
            [MyUtil showMessage:message];
        }
    } failure:^(NSError *err) {
        [app stopLoading];
        failure(err);
    }];
}
//ws站结案技术资源申请单
+(void) updataSupporEndForWs:(NSDictionary *) params
                     success:(void (^)(NSString *rhNO))success
                     failure:(void (^)(NSError* err))failure{
    [AFHttpTool requestWihtMethod:RequestMethodTypePost baseurl:SEM_TEST_SERVER url:CRM_SAVE_WS_HELP_END params:params success:^(id response) {
        
        int  errorCode =[response[@"errorCode"] intValue];
        NSString *rhNO=response[@"rh_no_new"];
        NSString *message =response[@"message"] ;
        if ( errorCode== 0) {
            dispatch_async(dispatch_get_main_queue(), ^(void) {
                success(rhNO);
            });
        }else{
            failure(nil);
            [MyUtil showMessage:message];
            //            [MyUtil showMessage:message];
        }
    } failure:^(NSError *err) {
        
        failure(err);
    }];
}
//ws站回复技术资源申请单
+(void) updataSupporReplyForWs:(NSDictionary *) params
                       success:(void (^)(NSString *rhNO))success
                       failure:(void (^)(NSError* err))failure{
    [AFHttpTool requestWihtMethod:RequestMethodTypePost baseurl:SEM_TEST_SERVER url:CRM_SAVE_WS_HELP_REPLY params:params success:^(id response) {
        
        int  errorCode =[response[@"errorCode"] intValue];
        NSString *rhNO=response[@"rh_no_new"];
        NSString *message =response[@"message"] ;
        if ( errorCode== 0) {
            dispatch_async(dispatch_get_main_queue(), ^(void) {
                success(rhNO);
            });
        }else{
            failure(nil);
            [MyUtil showMessage:message];
            //            [MyUtil showMessage:message];
        }
    } failure:^(NSError *err) {
        
        failure(err);
    }];
}

//查询案例分享列表
+(void) selectCaseList:(NSDictionary *) params
               success:(void (^)(NSArray *supporList))success
               failure:(void (^)(NSError* err))failure{
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [app startLoading];
    [AFHttpTool requestWihtMethod:RequestMethodTypePost baseurl:SEM_TEST_SERVER url:CRM_SHARE_LIST params:params success:^(id response) {
        [app stopLoading];
        int  errorCode =[response[@"errorCode"] intValue];
        NSString *message =response[@"message"] ;
        if ( errorCode== 0) {
            NSArray *dataArr =response[@"data_list"];
            
            NSArray *resultArr = [SupporContentModle mj_objectArrayWithKeyValuesArray:dataArr];
            dispatch_async(dispatch_get_main_queue(), ^(void) {
                success(resultArr);
            });
        }else{
            failure(nil);
            [MyUtil showMessage:message];
        }
    } failure:^(NSError *err) {
        [app stopLoading];
        failure(err);
    }];
}
//查询案例分享明细
+(void) selectCaseDetail:(NSDictionary *) params
                 success:(void (^)(SupporContentModle *supporModel))success
                 failure:(void (^)(NSError* err))failure{
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [app startLoading];
    [AFHttpTool requestWihtMethod:RequestMethodTypePost baseurl:SEM_TEST_SERVER url:CRM_SHARE_FILES params:params success:^(id response) {
        [app stopLoading];
        int  errorCode =[response[@"errorCode"] intValue];
        NSString *message =response[@"message"] ;
        if ( errorCode== 0) {
            NSDictionary *dic =response[@"data_list"];
            SupporContentModle *model = [SupporContentModle mj_objectWithKeyValues:dic];
            dispatch_async(dispatch_get_main_queue(), ^(void) {
                success(model);
            });
        }else{
            failure(nil);
            [MyUtil showMessage:message];
        }
    } failure:^(NSError *err) {
        [app stopLoading];
        failure(err);
    }];
}
//查询Sem其他老师
+(void) selectOtherTeacher:(NSDictionary *) params
                   success:(void (^)(NSArray *teacherArr))success
                   failure:(void (^)(NSError* err))failure{
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [app startLoading];
    [AFHttpTool requestWihtMethod:RequestMethodTypePost baseurl:SEM_TEST_SERVER url:CRM_SEM_OTHER_TERACHER params:params success:^(id response) {
        [app stopLoading];
        int  errorCode =[response[@"errorCode"] intValue];
        NSString *message =response[@"message"] ;
        if ( errorCode== 0) {
            NSArray *dataArr =response[@"sem_teacher"];
            
            NSArray *resultArr = [TeacherModel mj_objectArrayWithKeyValuesArray:dataArr];
            dispatch_async(dispatch_get_main_queue(), ^(void) {
                success(resultArr);
            });
        }else{
            failure(nil);
            [MyUtil showMessage:message];
        }
    } failure:^(NSError *err) {
        [app stopLoading];
        failure(err);
    }];
}
//转发
+(void)commitTeacher:(NSDictionary *) params
             success:(void (^)(BOOL isSuccess))success
             failure:(void (^)(NSError* err))failure{
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [app startLoading];
    [AFHttpTool requestWihtMethod:RequestMethodTypePost baseurl:SEM_TEST_SERVER url:CRM_SAVE_OTHER_TERACHER params:params success:^(id response) {
        [app stopLoading];
        int  errorCode =[response[@"errorCode"] intValue];
        NSString *message =response[@"message"] ;
        if ( errorCode== 0) {
            dispatch_async(dispatch_get_main_queue(), ^(void) {
                success(true);
            });
        }else{
            success(false);
            [MyUtil showMessage:message];
        }
    } failure:^(NSError *err) {
        [app stopLoading];
        failure(err);
    }];
}
//sem回复技术资源申请单
+(void) updataSupporReplyForSem:(NSDictionary *) params
                       success:(void (^)(BOOL isflag))success
                       failure:(void (^)(NSError* err))failure{
    [AFHttpTool requestWihtMethod:RequestMethodTypePost baseurl:SEM_TEST_SERVER url:CRM_SAVE_SEM_HELP_REPLY params:params success:^(id response) {
        
        int  errorCode =[response[@"errorCode"] intValue];
        
        NSString *message =response[@"message"] ;
        if ( errorCode== 0) {
            dispatch_async(dispatch_get_main_queue(), ^(void) {
                success(true);
            });
        }else{
            failure(nil);
            [MyUtil showMessage:message];
            //            [MyUtil showMessage:message];
        }
    } failure:^(NSError *err) {
        
        failure(err);
    }];
}
//上传附件
+(void) upEnclousure:(NSDictionary*)params block:(void (^)(id <AFMultipartFormData> formData))block success:(void (^)(NSArray *resultArr))result
             failure:(void (^)(NSError* err))failure{
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [app startLoading];
    [AFHttpTool requestFileWihtUrl:CRM_SAVE_ENCLOUSURE baseURL:SEM_SERVER_UP params:params block:block success:^(id response) {
        NSString *code = [NSString stringWithFormat:@"%@",response[@"errorCode"]];
        NSString *message=[NSString stringWithFormat:@"%@",response[@"message"]];
        if ([code isEqualToString:@"0"]) {
            NSArray *dataArr =response[@"help_files"];
            
            NSArray *resultArr = [FileModle mj_objectArrayWithKeyValuesArray:dataArr];
            dispatch_async(dispatch_get_main_queue(), ^(void) {
                result(resultArr);
            });
            [app stopLoading];
        }else{
            
            [app stopLoading];
            [MyUtil showMessage:message];
        }
    } failure:^(NSError *err) {
        [app stopLoading];
        failure(err);
    }];
}
//查询技术支援单各类附件
+(void) selectEnclousureList:(NSDictionary *) params
                     success:(void (^)(NSArray *enclousureList))success
                     failure:(void (^)(NSError* err))failure{
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [app startLoading];
    [AFHttpTool requestWihtMethod:RequestMethodTypePost baseurl:SEM_TEST_SERVER url:CRM_HELP_FILE params:params success:^(id response) {
        [app stopLoading];
        int  errorCode =[response[@"errorCode"] intValue];
        NSString *message =response[@"message"] ;
        if ( errorCode== 0) {
            NSArray *dataArr =response[@"file_list"];
            
            NSArray *resultArr = [FileModle mj_objectArrayWithKeyValuesArray:dataArr];
            dispatch_async(dispatch_get_main_queue(), ^(void) {
                success(resultArr);
            });
        }else{
            failure(nil);
            [MyUtil showMessage:message];
        }
    } failure:^(NSError *err) {
        [app stopLoading];
        failure(err);
    }];
}
//ws车辆检核
+(void) selectCheckCarInf:(NSDictionary *) params
                  success:(void (^)(BOOL isSuccess))success
                  failure:(void (^)(NSError* err))failure{
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [app startLoading];
    [AFHttpTool requestWihtMethod:RequestMethodTypePost baseurl:SEM_TEST_SERVER url:CRM_CHECK_CAR_INF params:params success:^(id response) {
        [app stopLoading];
        int  errorCode =[response[@"errorCode"] intValue];
        NSString *message =response[@"message"] ;
        if ( errorCode== 0) {
            NSString *isSemCar =response[@"is_sem_car"];
            
            
            dispatch_async(dispatch_get_main_queue(), ^(void) {
                if(isSemCar && [isSemCar isEqualToString:@"Y"]){
                    success(true);
                }else{
                    success(false);
                }
                
            });
        }else{
            success(false);
            [MyUtil showMessage:message];
        }
    } failure:^(NSError *err) {
        [app stopLoading];
        failure(err);
    }];

}
//查询积分账户
+(void) selectpointForChange:(NSDictionary *) params
                     success:(void (^)(UserInfo *info))success
                     failure:(void (^)(NSError* err))failure{
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [app startLoading];
    [AFHttpTool requestWihtMethod:RequestMethodTypeGet baseurl:SEM_JF_SERVER url:JF_POINT_INFO params:params success:^(id response) {
        [app stopLoading];
        int  errorCode =[response[@"errorCode"] intValue];
        NSString *message =response[@"message"] ;
        if ( errorCode== 1) {
            NSArray *dataArr =response[@"point_for_change"];
            
            NSArray *resultArr = [UserInfo mj_objectArrayWithKeyValuesArray:dataArr];
            dispatch_async(dispatch_get_main_queue(), ^(void) {
                UserInfo *info;
                if(resultArr&&resultArr.count>0){
                    info = resultArr[0];
                }
                success(info);
            });
        }else{
            failure(nil);
            
        }
    } failure:^(NSError *err) {
        [app stopLoading];
        failure(err);
    }];
}
//查询员工信息
+(void) selectDcsEmployInfo:(NSDictionary *) params
                    success:(void (^)(NSArray *employInfo))success
                    failure:(void (^)(NSError* err))failure{
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
   
    [AFHttpTool requestWihtMethod:RequestMethodTypeGet baseurl:SEM_JF_SERVER url:JF_EMPLOY_INFO params:params success:^(id response) {
        
        int  errorCode =[response[@"errorCode"] intValue];
        NSString *message =response[@"message"] ;
        if ( errorCode== 1) {
            NSArray *dataArr =response[@"employeeinfo"];
            
            NSArray *resultArr = [UserInfo mj_objectArrayWithKeyValuesArray:dataArr];
            dispatch_async(dispatch_get_main_queue(), ^(void) {
                success(resultArr);
            });
        }else{
            failure(nil);
            
        }
    } failure:^(NSError *err) {
        [app stopLoading];
        failure(err);
    }];
}
//查询已结算积分
+(void) selectPointChangeDone:(NSDictionary *) params
                      success:(void (^)(NSArray *flowArr))success
                      failure:(void (^)(NSError* err))failure{
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [app startLoading];
    [AFHttpTool requestWihtMethod:RequestMethodTypeGet baseurl:SEM_JF_SERVER url:JF_POINT_FLOW params:params success:^(id response) {
        [app stopLoading];
        int  errorCode =[response[@"errorCode"] intValue];
        NSString *message =response[@"message"] ;
        if ( errorCode== 1) {
            NSArray *dataArr =response[@"pointflow"];
            
            NSArray *resultArr = [PointFlowModel mj_objectArrayWithKeyValuesArray:dataArr];
            dispatch_async(dispatch_get_main_queue(), ^(void) {
                success(resultArr);
            });
        }else{
            failure(nil);
            
        }
    } failure:^(NSError *err) {
        [app stopLoading];
        failure(err);
    }];

}
//查询月积分
+(void) selectPointSaleitme:(NSDictionary *) params
                    success:(void (^)(NSArray *itmeArr))success
                    failure:(void (^)(NSError* err))failure{
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [app startLoading];
    [AFHttpTool requestWihtMethod:RequestMethodTypeGet baseurl:SEM_JF_SERVER url:JF_POINT_ITEM params:params success:^(id response) {
        [app stopLoading];
        int  errorCode =[response[@"errorCode"] intValue];
        NSString *message =response[@"message"] ;
        if ( errorCode== 1) {
            NSArray *dataArr =response[@"tm_dcs_point_saleitem"];
            
            NSArray *resultArr = [JFPointSaleItemModle mj_objectArrayWithKeyValuesArray:dataArr];
            dispatch_async(dispatch_get_main_queue(), ^(void) {
                success(resultArr);
            });
        }else{
            failure(nil);
            
        }
    } failure:^(NSError *err) {
        [app stopLoading];
        failure(err);
    }];

}
//保存兑换积分
+(void) savePointChange:(NSDictionary *) params
                success:(void (^)(NSString *type))success
                failure:(void (^)(NSError* err))failure{
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [app startLoading];
    [AFHttpTool requestWihtMethod:RequestMethodTypePost baseurl:SEM_JF_SERVER url:JF_POINT_SAVE params:params success:^(id response) {
        [app stopLoading];
        
        dispatch_async(dispatch_get_main_queue(), ^(void) {
            success(response[@"errorCode"]);
        });
    } failure:^(NSError *err) {
        [app stopLoading];
        failure(err);
    }];
}
//查询已抵用卷
+(void) selectdyzList:(NSDictionary *) params
              success:(void (^)(NSArray *dyzArr))success
              failure:(void (^)(NSError* err))failure{
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [app startLoading];
    [AFHttpTool requestWihtMethod:RequestMethodTypeGet baseurl:SEM_JF_SERVER url:DYJ_NET_VOUCHER params:params success:^(id response) {
        [app stopLoading];
        int  errorCode =[response[@"errorCode"] intValue];
        NSString *message =response[@"message"] ;
        if ( errorCode== 1) {
            NSArray *dataArr =response[@"voucheritem"];
            
            NSArray *resultArr = [VoucherModel mj_objectArrayWithKeyValuesArray:dataArr];
            dispatch_async(dispatch_get_main_queue(), ^(void) {
                success(resultArr);
            });
        }else{
            failure(nil);
            
        }
    } failure:^(NSError *err) {
        [app stopLoading];
        failure(err);
    }];
}
//申请使用抵用卷
+(void) savedyz:(NSDictionary *) params
        success:(void (^)(NSString *type))success
        failure:(void (^)(NSError* err))failure{
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [app startLoading];
    [AFHttpTool requestWihtMethod:RequestMethodTypePost baseurl:SEM_JF_SERVER url:DYJ_NET_SAVESECNNET params:params success:^(id response) {
        [app stopLoading];
        
        dispatch_async(dispatch_get_main_queue(), ^(void) {
            success(response[@"errorCode"]);
        });
    } failure:^(NSError *err) {
        [app stopLoading];
        failure(err);
    }];
}
//消息
+(void) getDyjMsg:(NSDictionary *) params
          success:(void (^)(NSArray *dyzArr))success
          failure:(void (^)(NSError* err))failure{
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    //[app startLoading];
    [AFHttpTool requestWihtMethod:RequestMethodTypeGet baseurl:SEM_JF_SERVER url:DYJ_NET_GETMESSAGE params:params success:^(id response) {
        //[app stopLoading];
        int  errorCode =[response[@"errorCode"] intValue];
       // NSString *message =response[@"message"] ;
        if ( errorCode== 1) {
            NSArray *dataArr =response[@"voucherinfo"];
            
            NSArray *resultArr = [VoucherinfoModel mj_objectArrayWithKeyValuesArray:dataArr];
            dispatch_async(dispatch_get_main_queue(), ^(void) {
                success(resultArr);
            });
        }else{
            failure(nil);
            
        }
    } failure:^(NSError *err) {
        //[app stopLoading];
        failure(err);
    }];
}
//修改密码
+(void) updataPassword:(NSDictionary *) params
               success:(void (^)(BOOL issuccess))success
               failure:(void (^)(NSError* err))failure{
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [app startLoading];
    [AFHttpTool requestWihtMethod:RequestMethodTypePost baseurl:SEM_JF_SERVER url:DYJ_NET_SAVEPWD params:params success:^(id response) {
        [app stopLoading];
        int  errorCode =[response[@"errorCode"] intValue];
        
        if ( errorCode== 1) {
            
            dispatch_async(dispatch_get_main_queue(), ^(void) {
                
                success(true);
            });
        }else{
            success(false);
           
            
            failure(nil);
            
        }
    } failure:^(NSError *err) {
        [app stopLoading];
        failure(err);
    }];
}
//录音
//获取token接口
+(void) get360Token:(NSDictionary *) params
            success:(void (^)(NSString *token))success
            failure:(void (^)(NSError* err))failure{
    
    [AFHttpTool requestWihtMethodforJson:RequestMethodTypePost baseurl:SMART360_SERVER url:SMART360_GETTOKEN token:nil params:params success:^(id response) {
        
        int  errorCode =[response[@"status"] intValue];
        NSString *message =response[@"message"] ;
        if ( errorCode== 0) {
            NSString *token =response[@"token"] ;
            dispatch_async(dispatch_get_main_queue(), ^(void) {
                success(token);
            });
        }else{
            failure(nil);
            [MyUtil showMessage:message];
        }
    } failure:^(NSError *err) {
        
        failure(err);
    }];
}
//呼叫接口
+(void) callPhone360:(NSDictionary *) params
             success:(void (^)(BOOL issuccess))success
             failure:(void (^)(NSError* err))failure{
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    [AFHttpTool requestWihtMethodforJson:RequestMethodTypePost baseurl:SMART360_SERVER url:SMART360_CALLPHONE token:app.smart360Token params:params success:^(id response) {
        
        int  errorCode =[response[@"status"] intValue];
        
        if ( errorCode== 0) {
            
            dispatch_async(dispatch_get_main_queue(), ^(void) {
                
                success(true);
            });
        }else{
            success(false);
            
            
            failure(nil);
            
        }
    } failure:^(NSError *err) {
       
        failure(err);
    }];
}
//获取录音地址
+(void) getIpInfo:(NSDictionary *) params
          success:(void (^)(NSDictionary * dic))success
          failure:(void (^)(NSError* err))failure{
    //AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    [AFHttpTool requestWihtMethod360:RequestMethodTypeGet baseurl:SMART360_SERVER url:SMART360_GETIPINFO params:params success:^(id response) {
        
       
         success(response);
    } failure:^(NSError *err) {
        
        failure(err);
    }];
}
//获取车损估计列表
+(void) getEvaluationList:(NSDictionary *) params
                  success:(void (^)( NSArray* arr))success
                  failure:(void (^)(NSError* err))failure{
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [app startLoading];
    [AFHttpTool requestWihtMethod:RequestMethodTypePost baseurl:SEM_TEST_SERVER url:SEM_VEHICLE_LOSS_LIST params:params success:^(id response) {
        [app stopLoading];
        
        int  errorCode =[response[@"errorCode"] intValue];
        NSString *message =response[@"message"] ;
        if ( errorCode== 0) {
            NSArray *dataArr =response[@"data"];
            
            NSArray *resultArr = [EvaluationInfoModle mj_objectArrayWithKeyValuesArray:dataArr];
            dispatch_async(dispatch_get_main_queue(), ^(void) {
                success(resultArr);
            });
        }else{
            [MyUtil showMessage:message];
            failure(nil);
            //[MyUtil showMessage:message];
        }
    } failure:^(NSError *err) {
        [app stopLoading];
        failure(err);
    }];
}
@end
