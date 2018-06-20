//
//  SettingViewController.m
//  SEMCRM
//
//  Created by sem on 16/2/2.
//  Copyright © 2016年 sem. All rights reserved.
//
#import "HideBtn.h"
#import "SettingViewController.h"
#import "UserLoginViewController.h"
@interface SettingViewController ()<UIAlertViewDelegate>
{
    NSString * updateNew;
}
@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UILabel *nameLal;
@property (weak, nonatomic) IBOutlet UILabel *addrssLal;
@property (weak, nonatomic) IBOutlet UILabel *versionLal;
@property (weak, nonatomic) IBOutlet UILabel *phoneLal;

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    NSString *appVersion = [infoDic objectForKey:@"CFBundleVersion"];
    _topView.layer.borderColor = [[UIColor colorWithRed:102.0/255.0 green:102.0/255.0 blue:102.0/255.0 alpha:1.0]CGColor];
    
    _topView.layer.borderWidth = 1.0;
    
    _topView.layer.cornerRadius = 8.0f;
    
    [_topView.layer setMasksToBounds:YES];
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    _nameLal.text =app.userModel.employee_name;
    _addrssLal.text =app.userModel.dealer_name;
    _versionLal.text =appVersion;
    _phoneLal.text =[NSString stringWithFormat:@"手机 %@",app.userModel.s_mobile];
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
    titleView.text = @"个人设置";
    self.tabBarController.navigationItem.titleView = titleView;
//    self.tabBarController.navigationItem.rightBarButtonItem = nil;
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
- (IBAction)upVersion:(HideBtn *)sender {
    NSDictionary *dic =@{@"mobile_system":@"I"};
    [HttpManageTool selectVersionDic:dic success:^(NSDictionary *dic) {
        NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
        NSString *appVersion = [infoDic objectForKey:@"CFBundleVersion"];
        NSString *versionNo =dic[@"versionNo"] ;
        NSString *downloadUrl =dic[@"downloadUrl"] ;
        if(![versionNo isEqualToString:appVersion]){
            updateNew = downloadUrl ;
            UIAlertView *alertView1 = [[UIAlertView alloc] initWithTitle:@"有新的版本" message:@"是否更新" delegate:self  cancelButtonTitle:@"是" otherButtonTitles:@"否", nil];
            [alertView1 show];
        }else{
            [MyUtil showMessage:@"已经是最新版本！"];
        }
    } failure:^(NSError *err) {
        
    }];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex==0){
        [self updateNewVersion];
        
    }
    
}
-(void)updateNewVersion{
    if(updateNew){
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:updateNew]];
    }
    
    //    if( [[UIApplication sharedApplication] respondsToSelector:@selector(terminate)] )
    //        [[UIApplication sharedApplication] performSelector:@selector(terminate)];
}
- (IBAction)loginOutAct:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UserLoginViewController *rootNavi = [storyboard instantiateViewControllerWithIdentifier:@"BNTableViewController_iPhone_login"];
    
    [ShareApplicationDelegate window].rootViewController = rootNavi;
}

@end
