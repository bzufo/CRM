//
//  SemCRMBaseViewController.m
//  SEMCRM
//
//  Created by sem on 16/2/21.
//  Copyright © 2016年 sem. All rights reserved.
//

#import "SemCRMBaseViewController.h"
#import "UIColor+RCColor.h"
@interface SemCRMBaseViewController ()

@end

@implementation SemCRMBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = YES;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    if(self.tableView){
        UIView *view = [UIView new];
        
        view.backgroundColor = [UIColor clearColor];
        [self.tableView setTableFooterView:view];
        self.tableView.separatorColor = [UIColor colorWithHexString:@"dfdfdf" alpha:1.0f];
        self.tableView.tableFooterView = [UIView new];
        self.tableView.backgroundColor=RGBA(242, 242, 242, 1);
    }
    // Do any additional setup after loading the view.
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
