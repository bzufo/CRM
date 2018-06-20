//
//  AddCustomerMainViewController.m
//  SEMCRM
//
//  Created by 薛斯岐 on 16/4/13.
//  Copyright © 2016年 sem. All rights reserved.
//

#import "AddCustomerMainViewController.h"

@interface AddCustomerMainViewController (){
    NSMutableArray *userArr;
}
@property (weak, nonatomic) IBOutlet UILabel *titleLal;

@end

@implementation AddCustomerMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
    titleView.text = @"添加线索";
    self.tabBarController.navigationItem.titleView = titleView;
    [self getDataFromCore];
    
}
-(void)getDataFromCore{
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSError *error;
    NSManagedObjectContext *context = [app managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:@"User"];
    userArr = [NSMutableArray arrayWithArray:[context executeFetchRequest:request error:&error]];
    if(userArr==nil){
        return;
    }
    
    _titleLal.text=[NSString stringWithFormat:@"点击上传潜在线索信息目前有%ld条线索待上传",userArr.count];
    [self.tableView reloadData];
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
