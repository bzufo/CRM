//
//  MyCustomerReportViewController.m
//  SEMCRM
//
//  Created by sem on 16/8/1.
//  Copyright © 2016年 sem. All rights reserved.
//

#import "MyCustomerReportViewController.h"

@interface MyCustomerReportViewController ()
{
    NSArray *reportArr;
}
@end

@implementation MyCustomerReportViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    reportArr=@[@"6",@"7"];
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    UILabel *titleView = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 44)];
    titleView.backgroundColor = [UIColor clearColor];
    titleView.font = [UIFont boldSystemFontOfSize:19];
    titleView.textColor = [UIColor blackColor];
    titleView.textAlignment = NSTextAlignmentCenter;
    titleView.text = @"个人统计";
    self.tabBarController.navigationItem.titleView = titleView;
    
    //    self.tabBarController.navigationItem.rightBarButtonItem = nil;
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    UIViewController * view = segue.destinationViewController;
    
    if([view respondsToSelector:@selector(setType:)]){
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        NSString *type= reportArr[indexPath.row];
        [view setValue:type forKey:@"type"];
        
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
