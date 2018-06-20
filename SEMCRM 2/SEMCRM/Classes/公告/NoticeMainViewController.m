//
//  NoticeMainViewController.m
//  SEMCRM
//
//  Created by 薛斯岐 on 16/3/11.
//  Copyright © 2016年 sem. All rights reserved.
//

#import "NoticeMainViewController.h"
#import "NoticeModel.h"
@interface NoticeMainViewController ()
{
    NSMutableArray *ggList;
}
@end

@implementation NoticeMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    ggList =[[NSMutableArray alloc]init];
    [self getData];
    // Do any additional setup after loading the view.
}
#pragma mark - Table view data source
-(void)getData{
    [ggList removeAllObjects];
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    //1456101228854zl62uqujl60wc9d259yc9zz5
    //app.userModel.token
    NSDictionary *dic = @{@"token":app.userModel.token};
    [HttpManageTool selectNotice:dic success:^(NSArray *noticeList) {
        [ggList addObjectsFromArray:noticeList];
        [self.tableView reloadData];
    } failure:^(NSError *err) {
        [self.tableView reloadData];
    }];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return ggList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NoticeCell" forIndexPath:indexPath];
    NoticeModel *noticeModel= ggList[indexPath.row];
    cell.textLabel.text=noticeModel.MOTIF;
    cell.detailTextLabel.text=noticeModel.RELEASE_DEPARTMENT;
    if([noticeModel.IS_READ isEqualToString:@"1"]){
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"new_32px"]];
        cell.accessoryView = imageView;
    }else{
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"newed_32px"]];
        cell.accessoryView = imageView;
    }
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NoticeModel *noticeModel= ggList[indexPath.row];
    [MyUtil showMessage:noticeModel.MOTIF];
//    [self.navigationController popViewControllerAnimated:YES];
    
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
