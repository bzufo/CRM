//
//  SemCRMSupportListSemViewController.m
//  SEMCRM
//
//  Created by Sem on 2017/7/10.
//  Copyright © 2017年 sem. All rights reserved.
//

#import "SemCRMSupportListSemViewController.h"
#import "SupporListCell.h"
#import "SupporContentModle.h"
#import "SemChooseCConditionViewDelegate.h"
@interface SemCRMSupportListSemViewController ()<SemChooseCConditionDelegate>
{
    NSMutableDictionary *keyDic;
    NSMutableArray *dataArr;
}
@end

@implementation SemCRMSupportListSemViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self ininData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    keyDic =[[NSMutableDictionary alloc]init];
    dataArr=[[NSMutableArray alloc]initWithCapacity:0];
    
    __weak __typeof(self)weakSelf = self;
    self.tableView.mj_header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
        
        [weakSelf ininData];
    }];
    
    // Do any additional setup after loading the view.
}
-(void)ininData{
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    //app.userModel.token
    // NSDictionary *dic = @{@"token":app.userModel.token};
    [keyDic setObject:app.userModel.token forKey:@"token"];
    [HttpManageTool selectSupporListForSem:keyDic success:^(NSArray *dataList) {
        [dataArr removeAllObjects];
        [dataArr addObjectsFromArray:dataList];
        [self.tableView reloadData];
         [self.tableView.mj_header endRefreshing];
    } failure:^(NSError *err) {
        [self.tableView reloadData];
         [self.tableView.mj_header endRefreshing];
    }];
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return dataArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SupporListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SupporListCell" forIndexPath:indexPath];
    SupporContentModle *model =dataArr[indexPath.row];
    [cell configureCellSem:model];
    return cell;
}
-(void)chooseCCondition:(NSDictionary *)dic{
    [keyDic removeAllObjects];
    [keyDic setDictionary:dic];
    [self ininData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    UIViewController * view = segue.destinationViewController;
    if ([view respondsToSelector:@selector(setDelegate:)]) {
        [view setValue:self forKey:@"delegate"];
    }
    if ([view respondsToSelector:@selector(setRhNo:)]) {
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        SupporContentModle *model =dataArr[indexPath.row];
        [view setValue:model.rh_no forKey:@"rhNo"];
    }
    if ([view respondsToSelector:@selector(setIsSem:)]) {
        [view setValue:@"1" forKey:@"isSem"];
    }
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
