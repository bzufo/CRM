//
//  SemCRMTableViewController.m
//  SEMCRM
//
//  Created by sem on 16/2/2.
//  Copyright © 2016年 sem. All rights reserved.
//

#import "SemCRMTableViewController.h"
#import "UIColor+RCColor.h"
@interface SemCRMTableViewController ()

@end

@implementation SemCRMTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = YES;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    UIView *view = [UIView new];
    
    view.backgroundColor = [UIColor clearColor];
    
    [self.tableView setTableFooterView:view];
    self.tableView.separatorColor = [UIColor colorWithHexString:@"dfdfdf" alpha:1.0f];
    self.tableView.tableFooterView = [UIView new];
    self.tableView.backgroundColor=RGBA(242, 242, 242, 1);
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
-(void)initMJRefeshHeaderForGif:(MJRefreshGifHeader *) header{
    header.lastUpdatedTimeLabel.hidden = YES;
    header.stateLabel.hidden = YES;
    // 设置普通状态的动画图片
    [header setImages:@[[UIImage imageNamed:@"mjRefresh"]] forState:MJRefreshStateIdle];
    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
    [header setImages:@[[UIImage imageNamed:@"refresh1"],[UIImage imageNamed:@"refresh2"],[UIImage imageNamed:@"refresh3"],[UIImage imageNamed:@"refresh4"],[UIImage imageNamed:@"refresh5"],[UIImage imageNamed:@"refresh6"],[UIImage imageNamed:@"refresh7"],[UIImage imageNamed:@"refresh8"],[UIImage imageNamed:@"refresh9"],[UIImage imageNamed:@"refresh10"],[UIImage imageNamed:@"refresh11"],[UIImage imageNamed:@"refresh12"]] forState:MJRefreshStatePulling];
    // 设置正在刷新状态的动画图片
    [header setImages:@[[UIImage imageNamed:@"refresh1"],[UIImage imageNamed:@"refresh2"],[UIImage imageNamed:@"refresh3"],[UIImage imageNamed:@"refresh4"],[UIImage imageNamed:@"refresh5"],[UIImage imageNamed:@"refresh6"],[UIImage imageNamed:@"refresh7"],[UIImage imageNamed:@"refresh8"],[UIImage imageNamed:@"refresh9"],[UIImage imageNamed:@"refresh10"],[UIImage imageNamed:@"refresh11"],[UIImage imageNamed:@"refresh12"]] forState:MJRefreshStateRefreshing];
}

-(void)initMJRefeshFooterForGif:(MJRefreshBackGifFooter *) footer{
    
    // 设置普通状态的动画图片
    [footer setImages:@[[UIImage imageNamed:@"mjRefresh"]] forState:MJRefreshStateIdle];
    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
    [footer setImages:@[[UIImage imageNamed:@"refresh1"],[UIImage imageNamed:@"refresh2"],[UIImage imageNamed:@"refresh3"],[UIImage imageNamed:@"refresh4"],[UIImage imageNamed:@"refresh5"],[UIImage imageNamed:@"refresh6"],[UIImage imageNamed:@"refresh7"],[UIImage imageNamed:@"refresh8"],[UIImage imageNamed:@"refresh9"],[UIImage imageNamed:@"refresh10"],[UIImage imageNamed:@"refresh11"],[UIImage imageNamed:@"refresh12"]] forState:MJRefreshStatePulling];
    // 设置正在刷新状态的动画图片
    [footer setImages:@[[UIImage imageNamed:@"refresh1"],[UIImage imageNamed:@"refresh2"],[UIImage imageNamed:@"refresh3"],[UIImage imageNamed:@"refresh4"],[UIImage imageNamed:@"refresh5"],[UIImage imageNamed:@"refresh6"],[UIImage imageNamed:@"refresh7"],[UIImage imageNamed:@"refresh8"],[UIImage imageNamed:@"refresh9"],[UIImage imageNamed:@"refresh10"],[UIImage imageNamed:@"refresh11"],[UIImage imageNamed:@"refresh12"]] forState:MJRefreshStateRefreshing];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
//
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Incomplete implementation, return the number of sections
//    return 0;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of rows
//    return 0;
//}

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


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
}


@end
