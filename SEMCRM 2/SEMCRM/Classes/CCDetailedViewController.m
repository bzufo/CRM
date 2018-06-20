//
//  CCDetailedViewController.m
//  SEMCRM
//
//  Created by 薛斯岐 on 16/2/24.
//  Copyright © 2016年 sem. All rights reserved.
//

#import "CCDetailedViewController.h"
#import "AttenceTimelineCell.h"
#import "CustomerInfoCell.h"
#import "CustomerInfo.h"
#import "ProcessModel.h"
#import "ServAnserModel.h"
#import "CCSolveReplyViewController.h"
@interface CCDetailedViewController ()<SolveReplyDelegate>
{
    NSArray *titleArr;
    CustomerInfo *customerInfo;
    NSMutableArray *processArr;
    NSMutableArray *servArr;
}
@property (weak, nonatomic) IBOutlet UILabel *msgNoLal;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *replyBtn;
@end

@implementation CCDetailedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if([self.replyType isEqual:@"1"]){
        
        [self.replyBtn setEnabled:YES];
    }else{
        
        [self.replyBtn setEnabled:false];
    }
    
    titleArr = @[@"客户以及车辆信息",@"商谈内容",@"处理过程",@"业代回复"];
    [self queryAccMstDetail:_acceptNo];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
    //    self.tabBarController.navigationItem.rightBarButtonItem = nil;
}
-(void)queryAccMstDetail:(NSString *)accept_mst_no{
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [dic setObject:accept_mst_no forKey:@"accept_mst_no"];
    [dic setObject:app.userModel.token forKey:@"token"];
//    [dic setObject:@"14580275096806ubx5q9cp0byn8h92o8fowff" forKey:@"token"];
    
    NSString *idfv =[[[UIDevice currentDevice] identifierForVendor] UUIDString];
    if([self.replyType isEqual:@"1"]){
        [dic setObject:idfv forKey:@"mobile_id"];
    }
    
    [HttpManageTool selectAcceptMstDic:dic success:^(NSDictionary *dic) {
        customerInfo = dic[@"CustomerInfo"];
        processArr=dic[@"processlist"];
        servArr=dic[@"serv_anser_list"];
        if(!customerInfo.isTrue){
            _msgNoLal.text=[NSString stringWithFormat:@"%@",customerInfo.accept_mst_no];
            if(![self.replyType isEqual:@"1"]){
                if([customerInfo.Is_sale_flag isEqualToString:@"1"]){
                    [self.replyBtn setEnabled:YES];
                    [self.replyBtn setTitle:@"业代回复"];
                }else{
                    [self.replyBtn setEnabled:NO];
                }
            }
        }
        [self.tableView reloadData ];
    } failure:^(NSError *err) {
        
    }];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
     AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    if([app.userModel.flag isEqualToString:@"17"]||[app.userModel.flag isEqualToString:@"18"]){
        return 4;
    }
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(section==2){
        if(processArr){
            return processArr.count;
        }else{
            return 0;
        }
    }else if(section==3){
        if(servArr){
            return servArr.count;
        }else{
            return 0;
        }
    }
    return 1;
}
//设置cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section==0){
        return 143;
    }else if(indexPath.section==1){
        NSString *text = @"";
        if(customerInfo){
            if(customerInfo.accur_content){
                text=customerInfo.accur_content;
            }
        }
        //下句中(CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2)  表示显示内容的label的长度 ，20000.0f 表示允许label的最大高度
        float height = [text sizeWithFont:[UIFont systemFontOfSize:15] constrainedToSize:CGSizeMake(SCREEN_WIDTH - 30, 1000)].height;
        return height + 30;
    }else if (indexPath.section==2){
        ProcessModel *processModel = processArr[indexPath.row];
        NSMutableString *ss=[[NSMutableString alloc]init];
        [ss appendString:@"处理时间:"];
        [ss appendString:processModel.solve_dt==nil?@"":processModel.solve_dt];
        [ss appendString:@"\n"];
        [ss appendString:@"处理类型:"];
        [ss appendString:processModel.SOLVE_TYPE==nil?@"":processModel.SOLVE_TYPE];
        [ss appendString:@"\n"];
        [ss appendString:@"处理部门:"];
        [ss appendString:processModel.solve_dept_name==nil?@"":processModel.solve_dept_name];
        [ss appendString:@"\n"];
        [ss appendString:@"处理人:"];
        [ss appendString:processModel.solve_name==nil?@"":processModel.solve_name];
        [ss appendString:@"\n"];
        [ss appendString:@"处理内容:"];
        [ss appendString:processModel.solve_content==nil?@"":processModel.solve_content];
        return [AttenceTimelineCell cellHeightWithString:ss isContentHeight:NO];
    }else {
        ServAnserModel *processModel = servArr[indexPath.row];
        NSMutableString *ss=[[NSMutableString alloc]init];
        [ss appendString:@"处理时间:"];
        [ss appendString:processModel.anser_dt==nil?@"":processModel.anser_dt];
        [ss appendString:@"\n"];
        [ss appendString:@"处理人:"];
        [ss appendString:processModel.serv_name==nil?@"":processModel.serv_name];
        [ss appendString:@"\n"];
        [ss appendString:@"处理内容:"];
        [ss appendString:processModel.content==nil?@"":processModel.content];
        
        return [AttenceTimelineCell cellHeightWithString:ss isContentHeight:NO];
    }
    
}
- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return titleArr[section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    switch (indexPath.section) {
        case 0:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:@"CustomerInfoCell" forIndexPath:indexPath];
            CustomerInfoCell *cusCell =(CustomerInfoCell *)cell;
            [cusCell configureCell:customerInfo];
        }
            break;
        case 1:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:@"STContentCell"];
            NSString *text = @"";
            if(customerInfo){
                if(customerInfo.accur_content){
                    text=customerInfo.accur_content;
                }
            }
            cell.textLabel.text=text;
        }
            break;
        case 2:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:@"TableViewCellID"];
            AttenceTimelineCell *attenceTimelineCell=(AttenceTimelineCell *)cell;
            
            bool isFirst = indexPath.row == 0;
            bool isLast = indexPath.row == processArr.count - 1;
            ProcessModel *processModel = processArr[indexPath.row];
            NSMutableString *ss=[[NSMutableString alloc]init];
            [ss appendString:@"处理时间:"];
            [ss appendString:processModel.solve_dt==nil?@"":processModel.solve_dt];
            [ss appendString:@"\n"];
            [ss appendString:@"处理类型:"];
            [ss appendString:processModel.SOLVE_TYPE==nil?@"":processModel.SOLVE_TYPE];
            [ss appendString:@"\n"];
            [ss appendString:@"处理部门:"];
            [ss appendString:processModel.solve_dept_name==nil?@"":processModel.solve_dept_name];
            [ss appendString:@"\n"];
            [ss appendString:@"处理人:"];
            [ss appendString:processModel.solve_name==nil?@"":processModel.solve_name];
            [ss appendString:@"\n"];
            [ss appendString:@"处理内容:"];
            [ss appendString:processModel.solve_content==nil?@"":processModel.solve_content];
            
            [attenceTimelineCell setDataSource:ss isFirst:isFirst isLast:isLast];
            break;
        }
        case 3:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:@"TableViewCellID"];
            AttenceTimelineCell *attenceTimelineCell=(AttenceTimelineCell *)cell;
            ServAnserModel *processModel = servArr[indexPath.row];
            bool isFirst = indexPath.row == 0;
            bool isLast = indexPath.row == servArr.count - 1;
            
            NSMutableString *ss=[[NSMutableString alloc]init];
            [ss appendString:@"处理时间:"];
            [ss appendString:processModel.anser_dt==nil?@"":processModel.anser_dt];
            [ss appendString:@"\n"];
            [ss appendString:@"处理人:"];
            [ss appendString:processModel.serv_name==nil?@"":processModel.serv_name];
            [ss appendString:@"\n"];
            [ss appendString:@"处理内容:"];
            [ss appendString:processModel.content==nil?@"":processModel.content];

            [attenceTimelineCell setDataSource:ss isFirst:isFirst isLast:isLast];
        }
            break;
        default:
            break;
    }
    
    
    return cell;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    UIViewController * view = segue.destinationViewController;
    //    if ([view respondsToSelector:@selector(setManageDic:)]) {
    //        [view setValue:manageDic forKey:@"manageDic"];
    //    }
    
    if([view respondsToSelector:@selector(setCustomerInfo:)]){
        [view setValue:customerInfo forKey:@"customerInfo"];
    }
    if([view respondsToSelector:@selector(setIsYeDai:)]){
        if([customerInfo.Is_sale_flag isEqualToString:@"1"]){
            [view setValue:@"1" forKey:@"isYeDai"];
            
        }else{
            [view setValue:@"0" forKey:@"isYeDai"];
        }
        
    }
    if ([view respondsToSelector:@selector(setDelegate:)]) {
        [view setValue:self forKey:@"delegate"];
    }

}
-(void)rePly{
    [MyUtil showMessage:@"回复成功！"];
    [self queryAccMstDetail:_acceptNo];
}

@end
