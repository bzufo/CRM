//
//  SemCRMCaseShareListViewController.m
//  SEMCRM
//
//  Created by Sem on 2017/7/4.
//  Copyright © 2017年 sem. All rights reserved.
//

#import "SemCRMCaseShareListViewController.h"
#import "SupporListCell.h"
#import "CaseChooseCConditionViewDelegate.h"
@interface SemCRMCaseShareListViewController ()<CaseChooseCConditionDelegate>
{
    NSMutableDictionary *keyDic;
    NSMutableArray *dataArr;
}
@end

@implementation SemCRMCaseShareListViewController



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return dataArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SupporListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SupporListCell" forIndexPath:indexPath];
    SupporContentModle *model =dataArr[indexPath.row];
    [cell.phoneBtn addTarget:self action:@selector(telPhone:event:) forControlEvents:UIControlEventTouchUpInside];
    [cell configureCellTwo:model];
    return cell;
}
- (void)telPhone:(UIButton *)button event:(id)event{
    //    [self.contentView addSubview:self.moreView];
    NSSet *touches = [event allTouches];
    UITouch *touch = [touches anyObject];
    CGPoint currentTouchPosition = [touch locationInView:self.tableView];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint: currentTouchPosition];
    SupporContentModle *model =dataArr[indexPath.row];
    if([MyUtil isValidateTelephone:model.share_mobile]){
        NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",model.share_mobile];
        //            NSLog(@"str======%@",str);
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
        
    }
}

//
- (void)viewDidLoad {
    [super viewDidLoad];
    keyDic =[[NSMutableDictionary alloc]init];
    dataArr=[[NSMutableArray alloc]initWithCapacity:0];
    
    __weak __typeof(self)weakSelf = self;
    self.tableView.mj_header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
        
        [weakSelf ininData];
    }];
    [self ininData];
    // Do any additional setup after loading the view.
}
-(void)ininData{
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    //app.userModel.token
    // NSDictionary *dic = @{@"token":app.userModel.token};
    [keyDic setObject:app.userModel.token forKey:@"token"];
    [dataArr removeAllObjects];
    [HttpManageTool selectCaseList:keyDic success:^(NSArray *dataList) {
        [dataArr addObjectsFromArray:dataList];
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
    } failure:^(NSError *err) {
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
    }];
    
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
    if ([view respondsToSelector:@selector(setShNo:)]) {
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        SupporContentModle *model =dataArr[indexPath.row];
        [view setValue:model.sh_no forKey:@"shNo"];
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
