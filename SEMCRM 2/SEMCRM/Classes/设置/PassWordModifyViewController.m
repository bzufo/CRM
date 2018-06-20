//
//  PassWordModifyViewController.m
//  SEMCRM
//
//  Created by 薛斯岐 on 16/5/24.
//  Copyright © 2016年 sem. All rights reserved.
//

#import "PassWordModifyViewController.h"

@interface PassWordModifyViewController ()
@property (weak, nonatomic) IBOutlet UILabel *userLal;
@property (weak, nonatomic) IBOutlet UITextField *oldPassWordTex;
@property (weak, nonatomic) IBOutlet UITextField *passWordNowTex;
@property (weak, nonatomic) IBOutlet UITextField *passWordAgTex;


@end

@implementation PassWordModifyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    _userLal.text = app.userModel.employee_name;
    // Do any additional setup after loading the view.
}
- (IBAction)endEidt:(UITextField *)sender {
    [sender resignFirstResponder];
}
- (IBAction)modifyAct:(UIBarButtonItem *)sender {
    if([MyUtil isEmptyString:_oldPassWordTex.text]){
        [MyUtil showMessage:@"请输入旧密码"];
        return;
    }
    if([MyUtil isEmptyString:_passWordNowTex.text]){
        [MyUtil showMessage:@"请输入新密码"];
        return;
    }
    if([MyUtil isEmptyString:_passWordAgTex.text]){
        [MyUtil showMessage:@"请输入确认密码"];
        return;
    }
    if(![_passWordAgTex.text isEqualToString:_passWordNowTex.text]){
        [MyUtil showMessage:@"两次密码输入不一致"];
        return;
    }
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    NSString *oldPassWordmd5= [MyUtil md5HexDigest:_oldPassWordTex.text];
    NSString *nowPassWordmd5= [MyUtil md5HexDigest:_passWordNowTex.text];
    NSDictionary *dic =@{@"empno":app.userModel.employee_no,@"orgcode":app.userModel.dealer_code,@"oldPassword":oldPassWordmd5,@"newPassword":nowPassWordmd5,@"token":app.userModel.token};
    [HttpManageTool updataPassWord:dic success:^(BOOL isSuccess) {
        if(isSuccess){
            [MyUtil showMessage:@"修改成功"];
            [DEFAULTS setObject:_passWordNowTex.text forKey:@"password"];
        }
    } failure:^(NSError *err) {
        [MyUtil showMessage:@"系统异常"];
    }];
//    ([myu])
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
