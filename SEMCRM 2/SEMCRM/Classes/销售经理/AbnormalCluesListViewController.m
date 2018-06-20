//
//  AbnormalCluesListViewController.m
//  SEMCRM
//
//  Created by 薛斯岐 on 16/2/24.
//  Copyright © 2016年 sem. All rights reserved.
//

#import "AbnormalCluesListViewController.h"
#import "ToBeContactedCell.h"
#import "YCCueModel.h"
#import "CueList.h"
@interface AbnormalCluesListViewController ()
{
    
        NSMutableArray *abnormalArr;
    
}
@end

@implementation AbnormalCluesListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    abnormalArr =[[NSMutableArray alloc]init];
    
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self getData];
}
-(void)getData{
    [abnormalArr removeAllObjects];
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSDictionary *dic = @{@"token":app.userModel.token};
    [HttpManageTool selectYCCueList:dic success:^(NSArray *ycCueList) {
        [abnormalArr addObjectsFromArray:ycCueList];
        [self.tableView reloadData];
    } failure:^(NSError *err) {
        [self.tableView reloadData];
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return abnormalArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    YCCueModel *modle = abnormalArr[section];
    return modle.cust_info.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 68;
}
- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    YCCueModel *modle = abnormalArr[section];
    return modle.EMPLOYEE_NAME;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ToBeContactedCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ToBeContactedCell" forIndexPath:indexPath];
    YCCueModel *modle = abnormalArr[indexPath.section];
    NSArray *arr= modle.cust_info;
    CueList *cueModle = arr[indexPath.row];
    [cell configureCell:cueModle];
    return cell;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    UIViewController * view = segue.destinationViewController;
    if ([view respondsToSelector:@selector(setCustid:)]) {
        
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        YCCueModel *modle = abnormalArr[indexPath.section];
        NSArray *arr= modle.cust_info;
        CueList *cueModle = arr[indexPath.row];
        [view setValue:cueModle.TARGET_CUST_ID forKey:@"custid"];
    }
    if ([view respondsToSelector:@selector(setSendFlag:)]) {
        
       [view setValue:@"1" forKey:@"sendFlag"];
    }
}


@end
