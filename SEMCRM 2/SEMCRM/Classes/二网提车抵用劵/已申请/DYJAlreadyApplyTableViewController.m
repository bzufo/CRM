//
//  DYJAlreadyApplyTableViewController.m
//  SEMCRM
//
//  Created by Sem on 2018/3/23.
//  Copyright © 2018年 sem. All rights reserved.
//

#import "DYJAlreadyApplyTableViewController.h"
#import "DYJAvailableCell.h"
@interface DYJAlreadyApplyTableViewController ()
{
    UILabel *titleView;
    NSMutableArray *dataArr;
}
@end

@implementation DYJAlreadyApplyTableViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    titleView = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 44)];
    titleView.backgroundColor = [UIColor clearColor];
    titleView.font = [UIFont boldSystemFontOfSize:19];
    titleView.textColor = [UIColor blackColor];
    titleView.textAlignment = NSTextAlignmentCenter;
    titleView.text = @"已申请抵用卷";
    
    
    self.tabBarController.navigationItem.titleView = titleView;
    [self getData];
}
-(void)getData{
    //[MyUtil getUserInfo].employee_no BB010102&STATUS=0
    NSDictionary *dic=@{@"SECNET_CODE":[MyUtil getUserInfo].employee_no,@"STATUS":@"1"};
    [HttpManageTool selectdyzList:dic success:^(NSArray *dyzArr) {
        [dataArr removeAllObjects];
        [dataArr addObjectsFromArray:dyzArr];
        titleView.text = [NSString stringWithFormat:@"已申请抵用卷(%ld)",dataArr.count];
        [self.tableView reloadData];
    } failure:^(NSError *err) {
        
    }
     ];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    dataArr=[[NSMutableArray alloc]initWithCapacity:0];
    self.tableView.rowHeight=100;
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return dataArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DYJAvailableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DYJAvailableCell" forIndexPath:indexPath];
    VoucherModel *model =dataArr[indexPath.section];
    [cell configureCell:model];
    
    return cell;
}

@end
