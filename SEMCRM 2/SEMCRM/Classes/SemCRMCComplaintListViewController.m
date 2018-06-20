//
//  SemCRMCComplaintListViewController.m
//  SEMCRM
//
//  Created by 薛斯岐 on 16/2/23.
//  Copyright © 2016年 sem. All rights reserved.
//

#import "SemCRMCComplaintListViewController.h"
#import "CCMainCell.h"
#import "AccepMst.h"
@interface SemCRMCComplaintListViewController (){
    NSMutableArray *itemArray;
}

@end

@implementation SemCRMCComplaintListViewController
UISegmentedControl *ksSeg;
- (void)viewDidLoad {
    [super viewDidLoad];
    itemArray =[[NSMutableArray alloc]init];
    
    ksSeg =[[UISegmentedControl alloc]initWithItems:@[@"客诉处理",@"客诉查询"]];
    ksSeg.tag = 100;
    [ksSeg addTarget:self action:@selector(ksSegValueChange:) forControlEvents:UIControlEventValueChanged];
    [ksSeg setSelectedSegmentIndex:0];
    // Do any additional setup after loading the view.
}
#pragma mark - Table view data source
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    UILabel *titleView = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 44)];
    titleView.backgroundColor = [UIColor clearColor];
    titleView.font = [UIFont boldSystemFontOfSize:19];
    titleView.textColor = [UIColor blackColor];
    titleView.textAlignment = NSTextAlignmentCenter;
    titleView.text = @"客诉管理";
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSString *flag = app.userModel.right_flag;
    //8 15 17
//    if([right_flag isEqualToString:@"2"]||[flag isEqualToString:@"4"]||[flag isEqualToString:@"8"]||[flag isEqualToString:@"15"]||[flag isEqualToString:@"17"]){
    if([flag isEqualToString:@"1"]){
        self.tabBarController.navigationItem.titleView = ksSeg;
        self.navigationItem.titleView = ksSeg;
//        [ksSeg setSelectedSegmentIndex:0];
    }else{
        [ksSeg setSelectedSegmentIndex:1];

        self.tabBarController.navigationItem.titleView = titleView;
         self.navigationItem.titleView = titleView;
    }
    [self getData];
    self.tableView.mj_header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
       [self getData];
    }];
    //    self.tabBarController.navigationItem.rightBarButtonItem = nil;
}
- (void)getData{
    __weak __typeof(self)weakSelf = self;
    
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
//    NSDictionary *dic =@{@"token":app.userModel.token};
    NSDictionary *dic =@{@"token":app.userModel.token};
    
    
    if(ksSeg.selectedSegmentIndex==1){
        [HttpManageTool selectUnAcceptMstList:dic success:^(NSArray *kxList) {
            [itemArray removeAllObjects];
            if(kxList!=nil &&kxList.count>0){
                [itemArray addObjectsFromArray:kxList];
            }
            [weakSelf.tableView reloadData];
            [weakSelf.tableView.mj_header endRefreshing];
        } failure:^(NSError *err) {
            [itemArray removeAllObjects];
            [weakSelf.tableView reloadData];
            [weakSelf.tableView.mj_header endRefreshing];
        }];
    }else{
        [HttpManageTool selectAcceptMst:dic success:^(NSArray *kxList) {
            [itemArray removeAllObjects];
            if(kxList!=nil &&kxList.count>0){
                [itemArray addObjectsFromArray:kxList];
            }
            [weakSelf.tableView reloadData];
            [weakSelf.tableView.mj_header endRefreshing];
        } failure:^(NSError *err) {
            [itemArray removeAllObjects];
            [weakSelf.tableView reloadData];
            [weakSelf.tableView.mj_header endRefreshing];
        }];
    }
}

- (void)ksSegValueChange:(UISegmentedControl *)sender {
    [self getData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return itemArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CCMainCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CCMainCell" forIndexPath:indexPath];
    AccepMst *accepMst=itemArray[indexPath.row];
    cell.msgNOlal.text=accepMst.short_mst_no;
    cell.userNameLal.text = accepMst.car_owner;
    cell.typeLal.text =accepMst.deal_time;
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
   
    if([view respondsToSelector:@selector(setReplyType:)]){
        if(ksSeg.selectedSegmentIndex==1){
            [view setValue:@"0" forKey:@"replyType"];
        }else{
            [view setValue:@"1" forKey:@"replyType"];
        }
        
    }
    if([view respondsToSelector:@selector(setAcceptNo:)]){
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        AccepMst *accepMst=itemArray[indexPath.row];
        [view setValue:accepMst.accept_mst_no forKey:@"acceptNo"];
    }
}

@end
