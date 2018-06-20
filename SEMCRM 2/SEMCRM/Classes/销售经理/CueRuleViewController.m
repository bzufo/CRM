//
//  CueRuleViewController.m
//  SEMCRM
//
//  Created by 薛斯岐 on 16/2/24.
//  Copyright © 2016年 sem. All rights reserved.
//

#import "CueRuleViewController.h"
#import "UserInfo.h"
@interface CueRuleViewController ()
{
    NSMutableArray *saleList;
}
@property (weak, nonatomic) IBOutlet UISegmentedControl *typeSeg;
@end

@implementation CueRuleViewController

- (IBAction)typeChangedAct:(UISegmentedControl *)sender {
    [self.tableView reloadData];
}
- (IBAction)completeAct:(id)sender {
    if(_typeSeg.selectedSegmentIndex==1){
        BOOL flag=false;
        for (UserInfo *userInfo in saleList) {
            if(userInfo.isSel){
                flag=true;
                break;
            }
        }
        if (!flag) {
            [MyUtil showMessage:@"至少选择一个业代！"];
        }
    }
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSMutableDictionary *dic =[[NSMutableDictionary alloc]init];
    [dic setObject:app.userModel.token forKey:@"token"];
    if(_typeSeg.selectedSegmentIndex==1){
        [dic setObject:@"1" forKey:@"sendrule"];
        NSMutableString *ss =[[NSMutableString alloc]init];
        for (int i=0;i<saleList.count;i++) {
            UserInfo *model = saleList[i];
            if(model.isSel){
                [ss appendString:model.employee_no];
                [ss appendString:@";"];
                
            }
            
        }
        [dic setObject:ss forKey:@"saleids"];
    }else{
        [dic setObject:@"0" forKey:@"sendrule"];
        
    }
    [HttpManageTool updataSendSet:dic success:^(BOOL isSuccess) {
        if(isSuccess){
            [MyUtil showMessage:@"保存成功"];
            [self getData];
        }
    } failure:^(NSError *err) {
        
    }];
    

}

- (void)viewDidLoad {
    [super viewDidLoad];
    saleList=[[NSMutableArray alloc]init];
    [self getData];
    // Do any additional setup after loading the view.
}
-(void)getData{
    [saleList removeAllObjects];
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSDictionary *dic = @{@"token":app.userModel.token};
    [HttpManageTool selectSaleDic:dic success:^(NSDictionary *newDic) {
        NSArray *arr =[newDic objectForKey:@"data"];
        [saleList addObjectsFromArray:arr];
        for (UserInfo *userInfo in saleList) {
            if([userInfo.flag isEqualToString:@"1"]){
                userInfo.isSel=true;
            }
        }
        NSString *sendRule= [newDic objectForKey:@"SEND_RULE"];
        if([sendRule isEqualToString:@"1"]){
            [_typeSeg setSelectedSegmentIndex:1];
        }else{
            [_typeSeg setSelectedSegmentIndex:0];
        }
        [self.tableView reloadData];
    } failure:^(NSError *err) {
        [self.tableView reloadData];
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(_typeSeg.selectedSegmentIndex==0){
        return 0;
    }else{
        return saleList.count;
    }
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SCcell" forIndexPath:indexPath];
    UserInfo *userInfo = saleList[indexPath.row];
    cell.textLabel.text=userInfo.employee_name;
    if (userInfo.isSel) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }else{
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UserInfo *userInfo = saleList[indexPath.row];
    userInfo.isSel=!userInfo.isSel;
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
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
