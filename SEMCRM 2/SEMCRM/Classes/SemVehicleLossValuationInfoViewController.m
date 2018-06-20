//
//  SemVehicleLossValuationInfoViewController.m
//  SEMCRM
//
//  Created by Sem on 2018/4/17.
//  Copyright © 2018年 sem. All rights reserved.
//

#import "SemVehicleLossValuationInfoViewController.h"
#import "EvaluationInfoModle.h"
#import "EnWebShowViewController.h"
@interface SemVehicleLossValuationInfoViewController ()
{
    
    EvaluationInfoModle *eModle;
}
@end

@implementation SemVehicleLossValuationInfoViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}
-(void)getData{
    
    //[MyUtil getUserInfo].employee_no BB010102&STATUS=0
    NSDictionary *dic=@{@"token":[MyUtil getUserInfo].token,@"state":@"detail",@"eval_id":_evalId};
    [HttpManageTool getEvaluationList:dic success:^(NSArray *dyzArr) {
        eModle=nil;
        if(dyzArr.count>0){
            eModle = dyzArr[0];
        }
        [self.tableView reloadData];
    } failure:^(NSError *err) {
        
    }
     ];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if(eModle){
        return 3;
    }
    return 0;
}
- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if(eModle){
        if(section==0){
             return @"车损估价明细";
        }else if (section==1){
            return @"上次回复记录";
        }else{
            return @"图片";
        }
    }
    return @"";
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(eModle){
        if (section==0){
            return 9;
        }else if (section==1){
            return 4;
        }else{
            return 5;
        }
    }
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"titleCell" forIndexPath:indexPath];
    cell.accessoryType=UITableViewCellAccessoryNone;
    if(indexPath.section==0){
        if(indexPath.row==0){
           cell.textLabel.text = [NSString stringWithFormat:@"车牌号：%@",eModle.licenseNO];
        }else if(indexPath.row==1){
            cell.textLabel.text = [NSString stringWithFormat:@"VIN：%@",eModle.vin];
        }else if(indexPath.row==2){
            cell.textLabel.text = [NSString stringWithFormat:@"车系：%@",eModle.series];
        }else if(indexPath.row==3){
            cell.textLabel.text = [NSString stringWithFormat:@"上次进厂日期：%@",eModle.last_start_time];
        }else if(indexPath.row==4){
            cell.textLabel.text = [NSString stringWithFormat:@"保险到期日：%@",eModle.insurance_fall_date];
        }else if(indexPath.row==5){
            cell.textLabel.text = [NSString stringWithFormat:@"车主姓名：%@",eModle.contactorname];
        }else if(indexPath.row==6){
            cell.textLabel.text = [NSString stringWithFormat:@"手机：%@",eModle.mobile];
        }else if(indexPath.row==7){
            cell.textLabel.text = [NSString stringWithFormat:@"提交时间：%@",eModle.update_date];
        }else{
            cell.textLabel.text = [NSString stringWithFormat:@"车损说明：%@",eModle.desinfo];
        }
    }else if (indexPath.section==1){
        if(indexPath.row==0){
            cell.textLabel.text = [NSString stringWithFormat:@"回复时间：%@",eModle.evaluation_date];
        }else if(indexPath.row==1){
            cell.textLabel.text = [NSString stringWithFormat:@"估价金额(元)：%@",eModle.evaluation_amount];
        }else if(indexPath.row==2){
            cell.textLabel.text = [NSString stringWithFormat:@"预估维修时间(小时)：%@",eModle.evaluation_time];
        }else if(indexPath.row==3){
            cell.textLabel.text = [NSString stringWithFormat:@"估价说明：%@",eModle.evaluation_remark];
        }
    }else{
       
        if(indexPath.row==0){
            if(eModle.picfile1!=nil && eModle.picfile1.length>0 ){
                 cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
                cell.textLabel.text =@"图片1";
            }else{
                cell.textLabel.text = @"暂无";
            }
            
        }else if(indexPath.row==1){
            if(eModle.picfile2!=nil && eModle.picfile2.length>0 ){
                 cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
                cell.textLabel.text =@"图片2";
            }else{
                cell.textLabel.text = @"暂无";
            }
        }else if(indexPath.row==2){
            if(eModle.picfile3!=nil && eModle.picfile3.length>0 ){
                 cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
                cell.textLabel.text =@"图片3";
            }else{
                cell.textLabel.text = @"暂无";
            }
        }else if(indexPath.row==3){
            if(eModle.picfile4!=nil && eModle.picfile4.length>0 ){
                 cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
                cell.textLabel.text =@"图片4";
            }else{
                cell.textLabel.text = @"暂无";
            }
        }else{
            if(eModle.picfile5!=nil && eModle.picfile5.length>0 ){
                 cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
                cell.textLabel.text =@"图片5";
            }else{
                cell.textLabel.text = @"暂无";
            }
        }
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section==2){
        if(indexPath.row==0){
            if(eModle.picfile1!=nil && eModle.picfile1.length>0 ){
                EnWebShowViewController *viewController = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]]instantiateViewControllerWithIdentifier:@"EnWebShowViewController"];
                viewController.urlShow=eModle.picfile1;
                [self.navigationController pushViewController:viewController animated:YES];
            }
            
        }else if(indexPath.row==1){
            if(eModle.picfile2!=nil && eModle.picfile2.length>0 ){
                EnWebShowViewController *viewController = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]]instantiateViewControllerWithIdentifier:@"EnWebShowViewController"];
                viewController.urlShow=eModle.picfile2;
                [self.navigationController pushViewController:viewController animated:YES];
            }
        }else if(indexPath.row==2){
            if(eModle.picfile3!=nil && eModle.picfile3.length>0 ){
                EnWebShowViewController *viewController = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]]instantiateViewControllerWithIdentifier:@"EnWebShowViewController"];
                viewController.urlShow=eModle.picfile3;
                [self.navigationController pushViewController:viewController animated:YES];
            }
        }else if(indexPath.row==3){
            if(eModle.picfile4!=nil && eModle.picfile4.length>0 ){
                EnWebShowViewController *viewController = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]]instantiateViewControllerWithIdentifier:@"EnWebShowViewController"];
                viewController.urlShow=eModle.picfile4;
                [self.navigationController pushViewController:viewController animated:YES];
            }
        }else{
            if(eModle.picfile5!=nil && eModle.picfile5.length>0 ){
                EnWebShowViewController *viewController = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]]instantiateViewControllerWithIdentifier:@"EnWebShowViewController"];
                viewController.urlShow=eModle.picfile5;
                [self.navigationController pushViewController:viewController animated:YES];
            }
        }
    }
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"明细";
    self.tableView.tableFooterView= [[UIView alloc] initWithFrame:CGRectZero];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 44;
    [self getData];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    UIViewController * view = segue.destinationViewController;
    if ([view respondsToSelector:@selector(setEvalId:)]) {
        //NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        [view setValue:_evalId forKey:@"evalId"];
    }
}
@end
