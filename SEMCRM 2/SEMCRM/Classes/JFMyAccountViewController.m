//
//  JFMyAccountViewController.m
//  SEMCRM
//
//  Created by Sem on 2017/8/14.
//  Copyright © 2017年 sem. All rights reserved.
//

#import "JFMyAccountViewController.h"
#import "UserInfo.h"
#import "JFPostInfoCell.h"
@interface JFMyAccountViewController ()
{
    NSMutableArray *dataArr;
    UserInfo  *useInfo;
    NSString *sfzStr;
}
@end

@implementation JFMyAccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    dataArr =[[NSMutableArray alloc]initWithCapacity:0];
    //[MyUtil getUserInfo].ID_CARD=@"340323198310214246";
    sfzStr=[MyUtil getUserInfo].ID_CARD;
    
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
   
    UILabel *titleView = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 44)];
    titleView.backgroundColor = [UIColor clearColor];
    titleView.font = [UIFont boldSystemFontOfSize:19];
    titleView.textColor = [UIColor blackColor];
    titleView.textAlignment = NSTextAlignmentCenter;
    titleView.text = @"我的账户";
    
    
    self.tabBarController.navigationItem.titleView = titleView;
    useInfo=nil;
    [dataArr removeAllObjects];
    [self getPointForChange];
    
    //    self.tabBarController.navigationItem.rightBarButtonItem = nil;
}

-(void)getPointForChange{
    NSDictionary *dic =@{@"ID_CARD":[MyUtil getUserInfo].ID_CARD};
    [HttpManageTool selectpointForChange:dic success:^(UserInfo *info) {
        useInfo =info;
        [self getDcsEmployInfo];
        
    } failure:^(NSError *err) {
        
    }];
}
-(void)getDcsEmployInfo{
    
    NSDictionary *dic =@{@"ID_CARD":[MyUtil getUserInfo].ID_CARD,@"DEALER_CODE":[MyUtil getUserInfo].dealer_code};
    [HttpManageTool selectDcsEmployInfo:dic success:^(NSArray *employInfo) {
        [dataArr addObjectsFromArray:employInfo];
        [self.tableView reloadData];
    } failure:^(NSError *err) {
        [self.tableView reloadData];
    }];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if(useInfo){
        if(dataArr&&dataArr.count>0){
            return 3;
        }else{
            return 2;
        }
        
    }
    return 1;
}
- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if(section==0){
        return @"  ";
    }else if(section==1){
        return @"账户信息";
    }else{
        return @"员工信息";
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section==2){
        return 120;
    }
    return 44;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(section==0){
        return 1;
    }else if(section==1){
        
        return 3;
    }else{
        return dataArr.count;
    }
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    if(indexPath.section==0){
        cell =[tableView dequeueReusableCellWithIdentifier:@"titleInfoCell" forIndexPath:indexPath];
        cell.textLabel.text= [NSString stringWithFormat:@"身份证号码:%@",sfzStr==nil?@"":[NSString stringWithFormat:@"%@******%@", [sfzStr substringToIndex:4], [sfzStr substringFromIndex:10]]];
        
    }else if ( indexPath.section==1){
        cell =[tableView dequeueReusableCellWithIdentifier:@"titleInfoCell" forIndexPath:indexPath];
        if(indexPath.row==0){
            cell.textLabel.text= [NSString stringWithFormat:@"当前账户累计积分总额:%@",useInfo.now_point==nil?@"":useInfo.now_point];
            
        }else if (indexPath.row==1){
            cell.textLabel.text= [NSString stringWithFormat:@"当前账户现金余额:%@",useInfo.now_cash==nil?@"":useInfo.now_cash];
        }else{
            cell.textLabel.text= [NSString stringWithFormat:@"当前账户购车劵余额:%@",useInfo.now_voucher==nil?@"":useInfo.now_voucher];
        }
       
        
    }else{
        cell = [tableView dequeueReusableCellWithIdentifier:@"JFPostInfoCell" forIndexPath:indexPath];
        JFPostInfoCell *cellTemp =(JFPostInfoCell*)cell;
        UserInfo *info =dataArr[indexPath.row];
        [cellTemp configureCell:info];
    }

    return cell;
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
