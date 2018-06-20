//
//  SemCRMCaseDetailViewController.m
//  SEMCRM
//
//  Created by Sem on 2017/7/4.
//  Copyright © 2017年 sem. All rights reserved.
//

#import "SemCRMCaseDetailViewController.h"
#import "SemCRMEnclosureListViewController.h"
@interface SemCRMCaseDetailViewController ()
{
    SupporContentModle *model;
    
}

@end

@implementation SemCRMCaseDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.tableFooterView= [[UIView alloc] initWithFrame:CGRectZero];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 44;
    [self ininData];
    // Do any additional setup after loading the view.
}
-(void)ininData{
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSDictionary *dic=@{@"token":app.userModel.token,@"sh_no":_shNo};
    [HttpManageTool selectCaseDetail:dic success:^(SupporContentModle *supporModel) {
        if(supporModel){
            model = supporModel;
            [self.tableView reloadData];
        }
    } failure:^(NSError *err) {
        
    }];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if(model){
        return 9;
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(model){
        return 1;
    }
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"titleCell" forIndexPath:indexPath];
    cell.accessoryType=UITableViewCellAccessoryNone;
    if(indexPath.section==0){
        cell.textLabel.text = [NSString stringWithFormat:@"案例主题：%@",model.trouble_title];
        
    }else if(indexPath.section==1){
        cell.textLabel.text = [NSString stringWithFormat:@"故障码：%@",model.trouble_code];
    }else if(indexPath.section==2){
        cell.textLabel.text = [NSString stringWithFormat:@"故障描述：%@",model.trouble_des];
    }else if(indexPath.section==3){
        cell.textLabel.text = [NSString stringWithFormat:@"故障现象附件：%ld个附件",model.trouble_file_list==nil?0:model.trouble_file_list.count];
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    }else if(indexPath.section==4){
        cell.textLabel.text = [NSString stringWithFormat:@"维修过程：%@",model.deal_memo];
    }else if(indexPath.section==5){
        cell.textLabel.text = [NSString stringWithFormat:@"维修过程附件：%ld个附件",model.deal_file_list==nil?0:model.deal_file_list.count];
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    }else if(indexPath.section==6){
        cell.textLabel.text = [NSString stringWithFormat:@"诊断结论：%@",model.process_memo];
    }else if(indexPath.section==7){
        cell.textLabel.text = [NSString stringWithFormat:@"分享心得：%@",model.experience];
    }else{
        
        cell.textLabel.text = [NSString stringWithFormat:@"该案例拥有%ld个附件",model.file_list==nil?0:model.file_list.count];
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    }
        return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section==3){
        SemCRMEnclosureListViewController *viewViewController=[[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"SemCRMEnclosureListViewController"];
        NSMutableArray *arr =[[NSMutableArray alloc]initWithCapacity:0];
        [arr addObjectsFromArray:model.trouble_file_list];
        viewViewController.enclosureArr = arr;
        [self.navigationController pushViewController:viewViewController animated:YES];
    }
    if(indexPath.section==5){
        SemCRMEnclosureListViewController *viewViewController=[[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"SemCRMEnclosureListViewController"];
        NSMutableArray *arr =[[NSMutableArray alloc]initWithCapacity:0];
        [arr addObjectsFromArray:model.deal_file_list];
        viewViewController.enclosureArr = arr;
        [self.navigationController pushViewController:viewViewController animated:YES];
    }
    if(indexPath.section==8){
        SemCRMEnclosureListViewController *viewViewController=[[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"SemCRMEnclosureListViewController"];
        NSMutableArray *arr =[[NSMutableArray alloc]initWithCapacity:0];
        [arr addObjectsFromArray:model.file_list];
        viewViewController.enclosureArr = arr;
        [self.navigationController pushViewController:viewViewController animated:YES];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
