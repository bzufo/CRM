//
//  SalesConsultantViewController.m
//  SEMCRM
//
//  Created by sem on 16/2/2.
//  Copyright © 2016年 sem. All rights reserved.
//

#import "SalesConsultantViewController.h"
#import "SemCRMNavigationController.h"

@interface SalesConsultantViewController ()

@end

@implementation SalesConsultantViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    SemCRMNavigationController *navigationController = (SemCRMNavigationController *)self.navigationController;
    int otherRole = navigationController.otherRole;
    if(otherRole ==2){
        UIBarButtonItem *barButtonItem =[[UIBarButtonItem alloc]initWithTitle:@">销售经理" style:UIBarButtonItemStylePlain target:self action:@selector(changeRole)];
        
        self.navigationItem.rightBarButtonItem=barButtonItem;
    }
    
    // Do any additional setup after loading the view.
}
-(void)changeRole{
    [self chooseStoryBoardWithStoryBoardName:@"Main" identifier:@"dcsJlRootNavi" otherRole:@"1"];
    NSLog(@"****");
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
