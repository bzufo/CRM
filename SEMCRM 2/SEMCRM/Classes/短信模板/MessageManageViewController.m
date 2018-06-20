//
//  MessageManageViewController.m
//  SEMCRM
//
//  Created by 薛斯岐 on 16/3/1.
//  Copyright © 2016年 sem. All rights reserved.
//

#import "MessageManageViewController.h"

@interface MessageManageViewController ()
{
    NSArray *msgArr;
}
@end

@implementation MessageManageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    msgArr = [[NSArray alloc]init];
    
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self getData];
}
-(void)getData{
    
   msgArr = [[NSUserDefaults standardUserDefaults]objectForKey:@"msg"];
    [self.tableView reloadData];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return msgArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MsgManageCell" forIndexPath:indexPath];
    NSDictionary *dic  = msgArr [indexPath.row];
    NSString *title = [dic objectForKey:@"title"];
    NSString *subtitle = [dic objectForKey:@"subtitle"];
    cell.textLabel.text=title;
    cell.detailTextLabel.text =subtitle;
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
    if ([view respondsToSelector:@selector(setMsgDic:)]) {
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        NSDictionary *dic  = msgArr [indexPath.row];
        [view setValue:dic forKey:@"msgDic"];
    }

}


@end
