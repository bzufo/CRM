//
//  DYJOutDateTableViewController.m
//  SEMCRM
//
//  Created by Sem on 2017/11/22.
//  Copyright © 2017年 sem. All rights reserved.
//

#import "DYJOutDateTableViewController.h"
#import "VoucherModel.h"
#import "DYJAvailableCell.h"
@interface DYJOutDateTableViewController ()
{
    UILabel *titleView;
    NSMutableArray *dataArr;
}
@end

@implementation DYJOutDateTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    dataArr=[[NSMutableArray alloc]initWithCapacity:0];
    self.tableView.rowHeight=100;
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    titleView = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 44)];
    titleView.backgroundColor = [UIColor clearColor];
    titleView.font = [UIFont boldSystemFontOfSize:19];
    titleView.textColor = [UIColor blackColor];
    titleView.textAlignment = NSTextAlignmentCenter;
    titleView.text = @"已过期抵用卷";
    
    
    self.tabBarController.navigationItem.titleView = titleView;
    [self getData];
}
-(void)getData{
    //[MyUtil getUserInfo].employee_no BB010102&STATUS=0
    NSDictionary *dic=@{@"SECNET_CODE":[MyUtil getUserInfo].employee_no,@"STATUS":@"2"};
    [HttpManageTool selectdyzList:dic success:^(NSArray *dyzArr) {
        [dataArr removeAllObjects];
        [dataArr addObjectsFromArray:dyzArr];
         titleView.text = [NSString stringWithFormat:@"已过期抵用卷(%ld)",dataArr.count];
        [self.tableView reloadData];
    } failure:^(NSError *err) {
        
    }
     ];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

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
/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
