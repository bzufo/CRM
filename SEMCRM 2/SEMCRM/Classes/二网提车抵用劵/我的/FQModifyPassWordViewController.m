//
//  FQModifyPassWordViewController.m
//  PartyBuildingFQ
//
//  Created by Sem on 2017/8/30.
//  Copyright © 2017年 SEM. All rights reserved.
//

#import "FQModifyPassWordViewController.h"

@interface FQModifyPassWordViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nowPassTex;
@property (weak, nonatomic) IBOutlet UITextField *userNameTex;
@property (weak, nonatomic) IBOutlet UITextField *oldPassWordTex;


@property (weak, nonatomic) IBOutlet UITextField *againTex;

@end

@implementation FQModifyPassWordViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [super.navigationController setNavigationBarHidden:false animated:false];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *username=[MyUtil getUserInfo].employee_no;
    self.userNameTex.text =username;
    // Do any additional setup after loading the view.
}
-(BOOL)checkStr{
    BOOL isRightStr=YES;
    //    NSScanner* scan = [NSScanner scannerWithString:str];
    //
    //    int val;
    if((self.againTex.text.length<=0) ){
        isRightStr=NO;
        
    }
    if((self.oldPassWordTex.text.length<=0) ){
        isRightStr=NO;
        
    }
    if((self.nowPassTex.text.length<=0) ){
        isRightStr=NO;
        
    }
    if((self.userNameTex.text.length<=0) ){
        isRightStr=NO;
        
    }
    if(!isRightStr){
        UIAlertView *alertView1=[[UIAlertView alloc]initWithTitle:@"提示" message:@"请输入正确的数值" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertView1 show];
    }
    return isRightStr;
}
-(BOOL)checkpassWord{
    BOOL isRightStr=YES;
    //    NSScanner* scan = [NSScanner scannerWithString:str];
    //
    //    int val;
    if(![self.againTex.text isEqualToString:self.nowPassTex.text] ){
        isRightStr=NO;
    }
    if(!isRightStr){
        UIAlertView *alertView1=[[UIAlertView alloc]initWithTitle:@"提示" message:@"两次密码输入不一致" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertView1 show];
    }
    return isRightStr;
}
- (IBAction)endEdit:(UITextField *)sender {
    [sender resignFirstResponder];
}
- (IBAction)modifyAct:(id)sender {
    if([self checkStr]){
        if ([self checkpassWord]) {
             NSDictionary *dic=@{@"SECNET_CODE":[MyUtil getUserInfo].employee_no,@"OLD_PWD":_oldPassWordTex.text,@"NEW_PWD":_nowPassTex.text};
            [HttpManageTool updataPassword:dic success:^(BOOL issuccess) {
                if(issuccess){
                    [MyUtil showMessage:@"修改成功！"];
                }
            } failure:^(NSError *err) {
                [MyUtil showMessage:@"修改失败！"];
            }];
        }
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
