//
//  JFExchangeIViewController.m
//  SEMCRM
//
//  Created by Sem on 2017/8/14.
//  Copyright © 2017年 sem. All rights reserved.
//

#import "JFExchangeIViewController.h"

@interface JFExchangeIViewController ()
{
    
    UserInfo  *useInfo;
     NSString *sfzStr;
}

@property (weak, nonatomic) IBOutlet UILabel *idCardLal;
@property (weak, nonatomic) IBOutlet UILabel *bankNolal;
@property (weak, nonatomic) IBOutlet UILabel *nowPointLal;
@property (weak, nonatomic) IBOutlet UILabel *okPointLal;
@property (weak, nonatomic) IBOutlet UITextField *moneyITex;
@property (weak, nonatomic) IBOutlet UITextField *carITex;
@property (weak, nonatomic) IBOutlet UILabel *moneyLal;
@property (weak, nonatomic) IBOutlet UILabel *carLal;

@end

@implementation JFExchangeIViewController
- (IBAction)saveAct:(id)sender {
    if((_moneyITex.text.length<1)||(_carITex.text.length<1)){
        [MyUtil showMessage:@"请输入要兑换的内容！"];
        return;
    }
     AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSDictionary *dic =@{@"ID_CARD":[MyUtil getUserInfo].ID_CARD,@"CASH":_moneyLal.text,@"VOUCHER":_carLal.text,@"POINT_CASH":_moneyITex.text,@"POINT_VOUCHER":_carITex.text,@"DEALER_CODE":app.userModel.dealer_code,@"EMPNO":app.userModel.employee_no};
    [HttpManageTool savePointChange:dic success:^(NSString *type) {
        if([type isEqualToString:@"1"]){
            [MyUtil showMessage:@"兑换成功！"];
            [self getPointForChange];
        }else if ([type isEqualToString:@"3"]){
            [MyUtil showMessage:@"兑换异常！"];
        }else if ([type isEqualToString:@"6"]){
            [MyUtil showMessage:@"已经存在兑换记录！"];
        }else if ([type isEqualToString:@"9"]){
            [MyUtil showMessage:@"不在兑换区间内！"];
        }else{
            [MyUtil showMessage:type];
        }
    } failure:^(NSError *err) {
        
    }];
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    if(_moneyITex==textField){
        if(textField.text.length>0){
            if([textField.text integerValue]>[_okPointLal.text integerValue]){
                _moneyITex.text=@"";
                _carITex.text=@"";
            }else{
                _carITex.text =[NSString stringWithFormat:@"%ld",[_okPointLal.text integerValue]-[_moneyITex.text integerValue]];
                _moneyLal.text=_moneyITex.text;
                _carLal.text =[NSString stringWithFormat:@"%.1f",[_carITex.text integerValue]*1.5];
                
            }
        }
    }else{
        if(textField.text.length>0){
            if([textField.text integerValue]>[_okPointLal.text integerValue]){
                _moneyITex.text=@"";
                _carITex.text=@"";
            }else{
                _moneyITex.text =[NSString stringWithFormat:@"%ld",[_okPointLal.text integerValue]-[_carITex.text integerValue]];
                _moneyLal.text=_moneyITex.text;
                _carLal.text =[NSString stringWithFormat:@"%.1f",[_carITex.text integerValue]*1.5];
            }
        }
    }
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    return [self validateNumber:string];
}

- (BOOL)validateNumber:(NSString*)number {
    BOOL res = YES;
    NSCharacterSet* tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    int i = 0;
    while (i < number.length) {
        NSString * string = [number substringWithRange:NSMakeRange(i, 1)];
        NSRange range = [string rangeOfCharacterFromSet:tmpSet];
        if (range.length == 0) {
            res = NO;
            break;
        }
        i++;
    }
    return res;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    sfzStr=[MyUtil getUserInfo].ID_CARD;
    
    _idCardLal.text =[NSString stringWithFormat:@"%@",sfzStr==nil?@"":[NSString stringWithFormat:@"%@******%@", [sfzStr substringToIndex:4], [sfzStr substringFromIndex:10]]];
    // Do any additional setup after loading the view.
}
-(void)getPointForChange{
    NSDictionary *dic =@{@"ID_CARD":[MyUtil getUserInfo].ID_CARD};
    [HttpManageTool selectpointForChange:dic success:^(UserInfo *info) {
        useInfo =info;
        _bankNolal.text =useInfo.bank_no==nil?@"":[NSString stringWithFormat:@"%@******%@", [useInfo.bank_no substringToIndex:4], [useInfo.bank_no substringFromIndex:10]];
        
        _nowPointLal.text =useInfo.now_point;
        _okPointLal.text =useInfo.okpoint;
    } failure:^(NSError *err) {
        
    }];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    UILabel *titleView = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 44)];
    titleView.backgroundColor = [UIColor clearColor];
    titleView.font = [UIFont boldSystemFontOfSize:19];
    titleView.textColor = [UIColor blackColor];
    titleView.textAlignment = NSTextAlignmentCenter;
    titleView.text = @"积分兑换";
    
    
    self.tabBarController.navigationItem.titleView = titleView;
    useInfo=nil;
   
    [self getPointForChange];
    
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

@end
