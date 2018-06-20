//
//  UserLoginViewController.m
//  SEMCRM
//
//  Created by sem on 16/2/2.
//  Copyright © 2016年 sem. All rights reserved.
//

#import "UserLoginViewController.h"
#import "AppDelegate.h"
#import "CommonDefine.h"
#import "AFHttpTool.h"
#import "UserInfo.h"
#import "SemCRMNavigationController.h"
@interface UserLoginViewController ()<UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UILabel *versionLabel;

@property (weak, nonatomic) IBOutlet UITextField *orgcodeTextFIeld;

@end

@implementation UserLoginViewController
NSString *updateNew;
NSString *ISNOTFATAL;
MBProgressHUD* hud ;
UserInfo *userModel;
- (IBAction)clickLoginButton:(id)sender {
//    userModel=[[UserInfo alloc]init];
//    userModel.flag = self.userNameTextField.text;
//    [self chooseStoryBoard];
//    return;
    NSString *userName = self.userNameTextField.text;
    NSString *password = self.passwordTextField.text;
    NSString *orgcode = self.orgcodeTextFIeld.text;
        if([self validateUserName:userName userPwd:password orgcode:orgcode]){
        hud= [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.labelText = @"登录中...";
        [hud show:YES];
            NSString *md5Password;
            if([userName isEqualToString:orgcode]&&userName.length > 6){
                md5Password= password;
                
            }else{
                md5Password= [MyUtil md5HexDigest:password];
            }
        
            //userModel = [[UserInfo alloc]init];
           // [userModel setFlag:@"17"];
        //[self chooseStoryBoard];
           // return;
        [AFHttpTool loginWithUser:userName password:md5Password orgcode:orgcode
                          success:^(id response) {
                              //用户界面跳转
                              
                              [hud hide:YES];
                              if ([response[@"errorCode"] intValue] == 0) {
                                  //保存数据
                                  
                                  NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
                                  NSString *appVersion = [infoDic objectForKey:@"CFBundleVersion"];
                                  
                                  
                                  
                                  NSDictionary *dataDic =response[@"data"];
                                  userModel=[UserInfo mj_objectWithKeyValues:dataDic];
                                 //[userModel setFlag:@"17"];
                                  AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];

                                  app.userModel = userModel;
                                  [DEFAULTS setObject:self.passwordTextField.text forKey:@"password"];
                                  [DEFAULTS setObject:self.orgcodeTextFIeld.text forKey:@"orgcode"];
                                  //先删除别名，然后再注册新的－－－友盟 消息推送
                                  if ([DEFAULTS objectForKey:@"empno"]) {
                                      [UMessage removeAlias:[DEFAULTS objectForKey:@"empno"] type:kUMessageAliasTypeSina response:^(id responseObject, NSError *error) {
                                          NSLog(@"----pass-addAlias%@---%@",responseObject,error);
                                      }];
                                  }
                                  [DEFAULTS setObject:userModel.employee_no forKey:@"empno"];
                                  
                                  [UMessage addAlias:userModel.employee_no  type:kUMessageAliasTypeSina response:^(id responseObject, NSError *error) {
                                      NSLog(@"----pass-addAlias%@---%@",responseObject,error);
                                  }];
                                  
                                  if(![userModel.VERSIONNO isEqualToString:appVersion]){
                                      
                                      updateNew = userModel.T_DOWNLOADADDRESS ;
                                      ISNOTFATAL = userModel.ISNOTFATAL;
                                      UIAlertView *alertView1 = [[UIAlertView alloc] initWithTitle:@"有新的版本" message:@"是否更新" delegate:self  cancelButtonTitle:@"是" otherButtonTitles:@"否", nil];
                                      [alertView1 show];
                                      
                                      //[self chooseStoryBoard];
                                  }else{
                                      //[MyUtil showMessage:userModel.token];
                                      [self chooseStoryBoard];
                                  }
                                  
                                  
                                  
                                  
                                  
                                  
                                  
                                  
                                  
                                  
                              }else{
                                  [MyUtil showMessage:response[@"message"]];
                                  
                                  
                              }
                              
                          }
                          failure:^(NSError* err) {
                              //关闭HUD
                              [hud hide:YES];
                              NSLog(@"NSError is %ld",(long)err.code);
                              //                              if (err.code == 3840) {
                              //                                  _errorMsgLb.text=@"用户名或密码错误！";
                              //                                  [_pwdTextField shake];
                              //                              }else{
                              //                                  _errorMsgLb.text=@"DemoServer错误！";
                              //                                  [_pwdTextField shake];
                              //                              }
                              
                          }];
        
        
        
    }
}
//验证用户信息格式
- (BOOL)validateUserName:(NSString*)userName
                 userPwd:(NSString*)userPwd
                 orgcode:(NSString*)orgcode
{
    NSString* alertMessage = nil;
    if (userName.length == 0) {
        alertMessage = @"用户名不能为空!";
    }
    else if (userPwd.length == 0) {
        alertMessage = @"密码不能为空!";
    }
    else if (orgcode.length == 0) {
        orgcode = @"网点代码不能为空!";
    }
    
    if (alertMessage) {
        [MyUtil showMessage:alertMessage];
        return NO;
    }
    
    return YES;
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex==0){
        [self updateNewVersion];
        
    }
    if(buttonIndex==1){
        //ISNOTFATAL=@"1";
        if([ISNOTFATAL isEqualToString:@"1"]){
            [self performSelector:@selector(chooseStoryBoard) withObject:nil afterDelay:0.1f];
        }else{
            [MyUtil showMessage:@"你需要安装新版本后才能正常使用！"];
        }
//        [self chooseStoryBoard];
    }
}
-(void)chooseStoryBoard{
    int flag =userModel.flag.intValue;
    //flag=101;
    switch (flag) {
        case 1:
            //销售顾问
            [self chooseStoryBoardWithStoryBoardName:@"Main" identifier:@"rootNavi" otherRole:nil];
            break;
        case 2:
            //2-销售经理/展厅经理  或者 销售经理/展厅经理 &总经理
            [self chooseStoryBoardWithStoryBoardName:@"Main" identifier:@"dcsJlRootNavi" otherRole:nil];
            break;
        case 3:
            //3-总经理
            [self chooseStoryBoardWithStoryBoardName:@"Main" identifier:@"dcsZjlRootNavi" otherRole:nil];
            break;
        case 4:
            //2-销售经理/展厅经理  或者 销售经理/展厅经理 &总经理
            [self chooseStoryBoardWithStoryBoardName:@"Main" identifier:@"rootNavi" otherRole:@"2"];
            break;//
        case 7:
        case 8:
        case 9:
        case 10:
        case 11:
        case 12:
        case 13:
            //2-销售经理/展厅经理  或者 销售经理/展厅经理 &总经理
            [self chooseStoryBoardWithStoryBoardName:@"Main" identifier:@"wsRootNavi" otherRole:nil];
            break;
        case 14:
        case 15:
        case 16:
            [self chooseStoryBoardWithStoryBoardName:@"Main" identifier:@"wsRootNavi" otherRole:nil];
            //14-服管中心副总/服务经理  15-客服专员16-服管中心副总/服务经理&客服专员
//            [self chooseStoryBoardWithStoryBoardName:@"Main" identifier:@"DlrRootNavi" otherRole:nil];
            break;
        case 100:
            //[MyUtil showMessage:@"暂无开放！"];
            [self chooseStoryBoardWithStoryBoardName:@"Main" identifier:@"JFRootNavi" otherRole:nil];
            
            break;
        case 101:
            //[MyUtil showMessage:@"暂无开放！"];
            [self chooseStoryBoardWithStoryBoardName:@"main1" identifier:@"TCJRootNavi" otherRole:nil];
            
            break;
        default:
            [self chooseStoryBoardWithStoryBoardName:@"Main" identifier:@"wsRootNavi" otherRole:nil];
//            [self chooseStoryBoardWithStoryBoardName:@"Main" identifier:@"SemRootNavi" otherRole:nil];
            break;
    }
    
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
-(void)updateNewVersion{
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:updateNew]];
    //    if( [[UIApplication sharedApplication] respondsToSelector:@selector(terminate)] )
    //        [[UIApplication sharedApplication] performSelector:@selector(terminate)];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor=[UIColor whiteColor];
    //加载数据
    NSString *username=[DEFAULTS objectForKey:@"empno"];
    NSString *password=[DEFAULTS objectForKey:@"password"];
    NSString *orgcode=[DEFAULTS objectForKey:@"orgcode"];
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    NSString *appVersion = [infoDic objectForKey:@"CFBundleVersion"];
    self.versionLabel.text=appVersion;
    if(![MyUtil isEmptyString:username]){
        self.userNameTextField.text = username;
    }
    if(![MyUtil isEmptyString:password]){
        self.passwordTextField.text = password;
    }
    if(![MyUtil isEmptyString:orgcode]){
        self.orgcodeTextFIeld.text = orgcode;
    }
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 4;
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
