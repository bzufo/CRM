//
//  SemCRMBaseTabBarController.m
//  SEMCRM
//
//  Created by sem on 16/2/2.
//  Copyright © 2016年 sem. All rights reserved.
//

#import "SemCRMBaseTabBarController.h"
#import "SemCRMNavigationController.h"
@interface SemCRMBaseTabBarController ()

@end

@implementation SemCRMBaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = YES;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.tabBar.backgroundColor=[UIColor whiteColor];
    // Do any additional setup after loading the view.
}
-(void)chooseStoryBoardWithStoryBoardName:(NSString *)boardName
                               identifier:(NSString *)identifier
                                otherRole:(NSString *)otherRole

{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:boardName bundle:nil];
    SemCRMNavigationController *rootNavi = [storyboard instantiateViewControllerWithIdentifier:identifier];
    if(otherRole){
        rootNavi.otherRole = otherRole.intValue;
    }
    [ShareApplicationDelegate window].rootViewController = rootNavi;
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
