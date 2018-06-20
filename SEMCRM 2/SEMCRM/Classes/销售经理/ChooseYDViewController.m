//
//  ChooseYDViewController.m
//  SEMCRM
//
//  Created by 薛斯岐 on 16/3/4.
//  Copyright © 2016年 sem. All rights reserved.
//

#import "ChooseYDViewController.h"
#import "UserInfo.h"
@interface ChooseYDViewController ()
{
    NSMutableArray *saleList;
}
@property (weak, nonatomic) IBOutlet UIBarButtonItem *compleBtn;
@end

@implementation ChooseYDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    saleList =[[NSMutableArray alloc]init];
    if(_isOnly){
        //[_compleBtn setEnabled:false];
    }
    [self getData];
    // Do any additional setup after loading the view.
}
- (IBAction)completAct:(UIBarButtonItem *)sender {
    NSMutableString *ss =[[NSMutableString alloc]init];
    for (int i=0;i<saleList.count;i++) {
        UserInfo *model = saleList[i];
        if(model.isSel){
            if(_isOnly){
                [ss appendString:model.employee_no];
                break;
            }else{
                [ss appendString:model.employee_no];
                [ss appendString:@";"];
            }
            
            
        }
        
    }
    if(ss.length<1){
        
        return;
    }
    if ([self.delegate respondsToSelector:@selector(chooseYD:)]) {
        [self.delegate chooseYD:ss];
    }

    [self.navigationController popViewControllerAnimated:YES];
}
-(void)getData{
    [saleList removeAllObjects];
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSDictionary *dic = @{@"token":app.userModel.token};//app.userModel.token
    [HttpManageTool selectSaleList:dic success:^(NSArray *toBCList) {
        [saleList addObjectsFromArray:toBCList];
        if(_employee_no!=NULL){
            for (  UserInfo *model  in saleList) {
                if([model.employee_no isEqualToString:_employee_no] ){
                    model.isSel=YES;
                }
            }
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
    
    return saleList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YDcells" forIndexPath:indexPath];
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
   
    if(_isOnly){
        for (int i=0;i<saleList.count;i++) {
             UserInfo *userInfo = saleList[i];
            if(indexPath.row ==i){
                userInfo.isSel=YES;
            }else{
                userInfo.isSel=false;
            }
        }
        [self.tableView reloadData];
        /*
        if ([self.delegate respondsToSelector:@selector(chooseYD:)]) {
            [self.delegate chooseYD:userInfo.employee_no];
        }
        [self.navigationController popViewControllerAnimated:YES];
         */
    }else{
        UserInfo *userInfo = saleList[indexPath.row];
        userInfo.isSel=!userInfo.isSel;
        [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
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
