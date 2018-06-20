//
//  ReportManagerViewController.m
//  SEMCRM
//
//  Created by 薛斯岐 on 16/2/23.
//  Copyright © 2016年 sem. All rights reserved.
//

#import "ReportManagerViewController.h"

@interface ReportManagerViewController ()
{
    NSArray *reportArr;
}
@end

@implementation ReportManagerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   // AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    reportArr=@[@[@"8",@"11",@"9",@"10"],@[@"1",@"2"],@[@"3",@"5"]];
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
    titleView.text = @"报表管理";
    
    
    self.tabBarController.navigationItem.titleView = titleView;
    //    self.tabBarController.navigationItem.rightBarButtonItem = nil;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    UIViewController * view = segue.destinationViewController;
    
    if([view respondsToSelector:@selector(setType:)]){
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        NSArray *arr = reportArr[indexPath.section];
        NSString *type= arr[indexPath.row];
        [view setValue:type forKey:@"type"];
        
    }
}


@end
