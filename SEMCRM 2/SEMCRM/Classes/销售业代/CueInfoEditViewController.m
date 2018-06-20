//
//  CueInfoEditViewController.m
//  SEMCRM
//
//  Created by 薛斯岐 on 16/2/29.
//  Copyright © 2016年 sem. All rights reserved.
//

#import "CueInfoEditViewController.h"
#import "CarsChooseViewController.h"
@interface CueInfoEditViewController ()<CarsChooseDelegate>
@property (weak, nonatomic) IBOutlet UITextField *cnameTex;
@property (weak, nonatomic) IBOutlet UITextField *mobileTex;
@property (weak, nonatomic) IBOutlet UISegmentedControl *sexSeg;
@property (weak, nonatomic) IBOutlet UISegmentedControl *brandSeg;
@property (weak, nonatomic) IBOutlet UILabel *carsLal;

@property (weak, nonatomic) IBOutlet UILabel *stateLal;
@property (weak, nonatomic) IBOutlet UILabel *fromLal;
@property (weak, nonatomic) IBOutlet UILabel *timeLal;
@property (weak, nonatomic) IBOutlet UILabel *levLal;
@property (weak, nonatomic) IBOutlet UITextField *remarkLalTex;

@end

@implementation CueInfoEditViewController
- (IBAction)endEidtAct:(UITextField *)sender {
    [sender resignFirstResponder];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setData];
    // Do any additional setup after loading the view.
}
- (IBAction)midifyAct:(UIBarButtonItem *)sender {
    if([[_cnameTex.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]length]==0) {
        [MyUtil showMessage:@"请输入正确姓名！"];
        return;
        
    }
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setObject:_cnameTex.text forKey:@"cname"];
    if(_sexSeg.selectedSegmentIndex == 0){
        [dic setObject:@"1" forKey:@"sex"];
    }else{
        [dic setObject:@"2" forKey:@"sex"];
    }
    if(_brandSeg.selectedSegmentIndex == 0){
        [dic setObject:@"东南" forKey:@"brand"];
    }else{
        [dic setObject:@"三菱" forKey:@"brand"];
    }
    NSString *remark =_remarkLalTex.text;
    [dic setObject:remark forKey:@"REMARK"];
    [dic setObject:_carsLal.text forKey:@"series"];
    [dic setObject:_cueModel.TARGET_CUST_ID forKey:@"custid"];
    [dic setObject:@"M" forKey:@"cmd"];
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [dic setObject:app.userModel.token forKey:@"token"];
    [HttpManageTool insertNewCue:dic success:^(BOOL isSuccess) {
        if(isSuccess){
            [MyUtil showMessage:@"修改成功!"];
            
        }
    } failure:^(NSError *err) {
        
        [MyUtil showMessage:@"很抱歉，因网络连接不畅，无法修改数据，请在Wifi连接下再试"];
    }];
}
-(void)setData{
    _cnameTex.text = _cueModel.cname;
    _mobileTex.text = _cueModel.mobile;
    if([_cueModel.sex isEqualToString:@"男"]){
        _sexSeg.selectedSegmentIndex = 0;
    }else{
        _sexSeg.selectedSegmentIndex = 1;
    }
    if([_cueModel.brand isEqualToString:@"东南"]){
        _brandSeg.selectedSegmentIndex = 0;
    }else{
        _brandSeg.selectedSegmentIndex = 1;
    }
    _carsLal.text =_cueModel.series;
    _stateLal.text = _cueModel.TSTATE;
//    _fromLal.text = _cueModel.cfrom;
    if(_cueModel.WXFLAG!=NULL && [_cueModel.WXFLAG isEqualToString:@"1"] ){
        _fromLal.text = [NSString stringWithFormat:@"%@(%@)",_cueModel.cfrom,@"网销"];
    }else{
        _fromLal.text = [NSString stringWithFormat:@"%@(%@)",_cueModel.cfrom,@"非网销"];
    }

    _levLal.text = _cueModel.level;
    _timeLal.text = _cueModel.forcast_date;
    _remarkLalTex.text=_cueModel.REMARK;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    setCarsEdit
    UIViewController * view = segue.destinationViewController;
    if ([view respondsToSelector:@selector(setCars:)]) {
        NSInteger falg = _brandSeg.selectedSegmentIndex;
        switch (falg) {
            case 0:
                [view setValue:@"SEM" forKey:@"cars"];
                break;
            case 1:
                [view setValue:@"MMC" forKey:@"cars"];
                break;
            default:
                break;
        }
        
    }
    if ([view respondsToSelector:@selector(setDelegate:)]) {
        [view setValue:self forKey:@"delegate"];
    }

    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
-(void)updataCarsInfo:(NSString *)chooseCars{
    _carsLal.text = chooseCars;
}
- (IBAction)carsChangeAct:(UISegmentedControl *)sender {
    NSInteger falg = sender.selectedSegmentIndex;
    switch (falg) {
        case 0:
            _carsLal.text = @"DX7";
            break;
        case 1:
            _carsLal.text = @"翼神";
            break;
        default:
            break;
    }
}
@end
