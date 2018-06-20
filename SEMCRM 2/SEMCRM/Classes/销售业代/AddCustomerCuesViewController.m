//
//  AddCustomerCuesViewController.m
//  SEMCRM
//
//  Created by sem on 16/2/2.
//  Copyright © 2016年 sem. All rights reserved.
//

#import "AddCustomerCuesViewController.h"
#import "CarsChooseViewController.h"
#import "TimeChooseViewController.h"
#import "CueInfoActivationViewController.h"
#import "MHActionSheet.h"
#import "ActivityModel.h"
@interface AddCustomerCuesViewController ()<CarsChooseDelegate,TimeChooseDelegate,UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *userNameTex;
@property (weak, nonatomic) IBOutlet UITextField *phoneTex;
@property (weak, nonatomic) IBOutlet UISegmentedControl *sexSeg;
@property (weak, nonatomic) IBOutlet UISegmentedControl *brandSeg;
@property (weak, nonatomic) IBOutlet UILabel *carsLal;
@property (weak, nonatomic) IBOutlet UITextField *isNetSaleTex;
@property (weak, nonatomic) IBOutlet UISegmentedControl *levSeg;
@property (weak, nonatomic) IBOutlet UITextField *fromTex;
@property (weak, nonatomic) IBOutlet UISegmentedControl *fromSeg;
@property (weak, nonatomic) IBOutlet UITextField *fromProjectTex;
@property (weak, nonatomic) IBOutlet UILabel *timeLal;
@property (weak, nonatomic) IBOutlet UITextField *remarkText;


@end

@implementation AddCustomerCuesViewController
{
    NSString  *sNo;
    CueList *cueModel;
}
NSDateFormatter * dateFormatter;
UIPickerView *pickerView;

- (void)viewDidLoad {
    [super viewDidLoad];
    fromSelStr=@"";
    actID=@"";
    actTitle=@"";
    fromArr = @[@"自然到店",@"来电",@"店头活动",@"车展",@"外展外拓",@"线上活动",@"转介绍",@"其他"];
    
    dateFormatter =[[NSDateFormatter alloc]init];
    eArr=[[NSMutableArray alloc]initWithCapacity:0];
    eArrTitle =[[NSMutableArray alloc]initWithCapacity:0];
    [self setInitData];
    // Do any additional setup after loading the view.
}
-(void)setInitData{
    if(_userModel){
        self.phoneTex.text =_userModel.mobile?_userModel.mobile:@"";
        self.userNameTex.text =_userModel.cname?_userModel.cname:@"";
        NSString *cfrom =_userModel.cfrom;
        _fromTex.text=cfrom;
        if(cfrom!=NULL && [cfrom isEqualToString:@"线上活动"]){
            _isNetSaleTex.text = @"是";
        }else{
            _isNetSaleTex.text = @"否";
        }
        if(cfrom!=NULL && [cfrom isEqualToString:@"转介绍"]){
            _fromProjectTex.enabled=false;
        }else{
            _fromProjectTex.enabled=YES;
        }
        _remarkText.text =_userModel.remark?_userModel.remark:@"";
        self.fromProjectTex.text =_userModel.leadbatch?_userModel.leadbatch:@"";
        if([_userModel.sex isEqualToString:@"1"]){
            _sexSeg.selectedSegmentIndex = 0;
        }else{
            _sexSeg.selectedSegmentIndex = 1;
        }
        
        if([_userModel.brand isEqualToString:@"东南"]){
            _brandSeg.selectedSegmentIndex = 0;
        }else{
            _brandSeg.selectedSegmentIndex = 1;
        }
        self.carsLal.text =_userModel.series?_userModel.series:@"";
        if([_userModel.level isEqual:@"H"]){
            _levSeg.selectedSegmentIndex =0;
        }else if ([_userModel.level isEqual:@"A"]){
            _levSeg.selectedSegmentIndex =1;
        }else if ([_userModel.level isEqual:@"B"]){
            _levSeg.selectedSegmentIndex =2;
        }else if ([_userModel.level isEqual:@"C"]){
            _levSeg.selectedSegmentIndex =3;
        }else if ([_userModel.level isEqual:@"W"]){
            _levSeg.selectedSegmentIndex =4;
        }
        self.timeLal.text =_userModel.forcast_date?_userModel.forcast_date:@"";
    }else{
        NSDate *nowDate = [NSDate date];
        NSTimeInterval  interval =24*60*60; //1:天数
        NSDate *date1 = [nowDate initWithTimeIntervalSinceNow:+interval];
        [dateFormatter setDateFormat:@"yyyy-MM-dd kk:mm:ss"];
        
        self.timeLal.text=[NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:date1]];
    }
    NSDictionary *dic = @{@"token":[MyUtil getUserInfo].token};
    [HttpManageTool getEventName:dic success:^(NSArray *eventArr) {
        [eArr removeAllObjects];
        [eArr addObjectsFromArray:eventArr];
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
    titleView.text = @"添加线索";
    self.tabBarController.navigationItem.titleView = titleView;
//    self.tabBarController.navigationItem.rightBarButtonItem = nil;
}

- (IBAction)backAct:(UIBarButtonItem *)sender {
    if([self checkSaveData]){
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"是否不保存数据离开" delegate:self
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:@"取消", nil];
        [alertView show];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if(buttonIndex==0){
//        [self saveDataToCore];
        if(alertView.tag==3){
            AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
            NSDictionary *dic = @{@"custid":sNo,@"token":app.userModel.token};
            cueModel=nil;
            [HttpManageTool selectCueInfo:dic success:^(CueList *cueModelTemp) {
                if(cueModelTemp){
                    cueModel = cueModelTemp;
                    CueInfoActivationViewController *viewViewController=[[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"CueInfoActivationViewController"];
                    viewViewController.cueModel = cueModel;
                    [self.navigationController pushViewController:viewViewController animated:YES];
                }else{
                    [self.navigationController popViewControllerAnimated:YES];
                }
            } failure:^(NSError *err) {
                
            }];
        }else{
            [self.navigationController popViewControllerAnimated:YES];
        }
        
    }else{
//        [self.navigationController popViewControllerAnimated:YES];
    }
}
-(void)saveDataToCore{
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSError *error;
    NSManagedObjectContext *context = [app managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:@"User"];
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"%K=%@",@"mobile",self.phoneTex.text];
    [request setPredicate:pred];
    NSArray *objects = [context executeFetchRequest:request error:&error];
    if(objects==nil){
    
    }
    NSManagedObject *newObject = nil;
    if([objects count]>0){
        newObject = [objects objectAtIndex:0];
    }else{
        newObject = [NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:context];
    }
    [newObject setValue:self.phoneTex.text forKey:@"mobile"];
    [newObject setValue:self.userNameTex.text forKey:@"cname"];
    NSString *cfrom = _fromTex.text;
    NSString *remark = _remarkText.text;
    [newObject setValue:cfrom forKey:@"cfrom"];
    [newObject setValue:remark forKey:@"remark"];
    [newObject setValue:_fromProjectTex.text forKey:@"leadbatch"];
    if(_sexSeg.selectedSegmentIndex == 0){
        [newObject setValue:@"1" forKey:@"sex"];
    }else{
        [newObject setValue:@"2" forKey:@"sex"];
    }
    if(_brandSeg.selectedSegmentIndex == 0){
        [newObject setValue:@"东南" forKey:@"brand"];
    }else{
        [newObject setValue:@"三菱" forKey:@"brand"];
    }
    [newObject setValue:_carsLal.text forKey:@"series"];
    switch (_levSeg.selectedSegmentIndex) {
        case 0:
            [newObject setValue:@"H" forKey:@"level"];
            break;
        case 1:
            [newObject setValue:@"A" forKey:@"level"];
            break;
        case 2:
            [newObject setValue:@"B" forKey:@"level"];
            break;
        case 3:
            [newObject setValue:@"C" forKey:@"level"];
            break;
        case 4:
            [newObject setValue:@"W" forKey:@"level"];
            break;
        default:
            break;
    }
    [newObject setValue:_timeLal.text forKey:@"forcast_date"];
    [app saveContext];
}
-(BOOL) checkSaveData{
    if(![MyUtil isEmptyString:self.phoneTex.text]){
        return YES;
    }else{
        return false;
    }
    
}
- (IBAction)cueFromChange:(UISegmentedControl *)sender {
//    NSInteger falg = sender.selectedSegmentIndex;
//    switch (falg) {
//        case 2:
//        case 3:
//            _fromProjectTex.enabled=YES;
//            break;
//            
//        default:
//        {
//            _fromProjectTex.enabled=NO;
//            _fromProjectTex.text =@"";
//        }
//            
//            break;
//    }
}

- (IBAction)completeAct:(UIBarButtonItem *)sender {
    //判断数据
    
    if ([self checkData]){
        NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
        NSString *cfrom = _fromTex.text;
        NSString *remark =_remarkText.text;
        [dic setObject:cfrom forKey:@"cfrom"];
        [dic setObject:remark forKey:@"REMARK"];
        [dic setObject:_fromProjectTex.text forKey:@"leadbatch"];
        [dic setObject:actID forKey:@"activity_id"];
        [dic setObject:_userNameTex.text forKey:@"cname"];
        if(_sexSeg.selectedSegmentIndex == 0){
            [dic setObject:@"1" forKey:@"sex"];
        }else{
            [dic setObject:@"2" forKey:@"sex"];
        }
        [dic setObject:_phoneTex.text forKey:@"mobile"];
        if(_brandSeg.selectedSegmentIndex == 0){
            [dic setObject:@"东南" forKey:@"brand"];
        }else{
            [dic setObject:@"三菱" forKey:@"brand"];
        }
        [dic setObject:_carsLal.text forKey:@"series"];
        switch (_levSeg.selectedSegmentIndex) {
            case 0:
                [dic setObject:@"H" forKey:@"level"];
                break;
            case 1:
                [dic setObject:@"A" forKey:@"level"];
                break;
            case 2:
                [dic setObject:@"B" forKey:@"level"];
                break;
            case 3:
                [dic setObject:@"C" forKey:@"level"];
                break;
            case 4:
                [dic setObject:@"W" forKey:@"level"];
                break;
            default:
                break;
        }
        [dic setObject:_timeLal.text forKey:@"forcast_date"];
        [dic setObject:@"A" forKey:@"cmd"];
        sNo=@"";
        AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        [dic setObject:app.userModel.token forKey:@"token"];
        [HttpManageTool insertNewCueOne:dic success:^(NSDictionary *dic) {
            int  errorCode =[dic[@"errorCode"] intValue];
            //NSString *message =dic[@"message"] ;
            if(errorCode==0){
                [MyUtil showMessage:@"添加成功!"];
                [self clearDataCore];
                [self clearData];
            }else if(errorCode==5){
                sNo =dic[@"TARGET_CUST_ID"] ;
                UIAlertView *alertView1 = [[UIAlertView alloc] initWithTitle:@"已存在相同手机号的线索" message:@"是否激活" delegate:self  cancelButtonTitle:@"激活" otherButtonTitles:@"退出", nil];
                    alertView1.tag=3;
                    [alertView1 show];
            }else if(errorCode==3){
                [MyUtil showMessage:@"已存在相同手机号的线索!"];
            }
        } failure:^(NSError *err) {
            [self saveDataToCore];
            [self clearData];
            [MyUtil showMessage:@"很抱歉，因网络连接不畅，线索无法上传服务器，请在Wifi连接下再试,数据已保存本地"];
        }];
    }
    
}
-(void)clearDataCore{
     // 1. 实例化查询请求
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
   
    NSManagedObjectContext *context = [app managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:@"User"];

   
    
    
    // 2. 设置谓词条件
     NSPredicate *pred = [NSPredicate predicateWithFormat:@"%K=%@",@"mobile",self.phoneTex.text];
    request.predicate = pred;
    
    // 3. 由上下文查询数据
    NSArray *result = [context executeFetchRequest:request error:nil];
    
    // 4. 输出结果
    NSManagedObject *newObject = nil;
    if([result count]>0){
        newObject = [result objectAtIndex:0];
        [context deleteObject:newObject];
    }
    // 5. 通知_context保存数据
    if ([context save:nil]) {
        NSLog(@"删除成功");
    } else {
        NSLog(@"删除失败");
    }
    
}
-(void)clearData{
    _userNameTex.text=@"";
    _phoneTex.text=@"";
    
}
-(BOOL)checkData{
    
    if([[self.userNameTex.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]length]==0) {
        [MyUtil showMessage:@"请输入姓名！"];
        return false;
        
    }
    if(_sexSeg.selectedSegmentIndex==-1) {
        [MyUtil showMessage:@"请选择性别！"];
        return false;
        
    }
    if(![MyUtil isValidateTelephone:self.phoneTex.text]){
        [MyUtil showMessage:@"请输入正确的手机号"];
        return false;
    }
    if([self.fromTex.text isEqualToString:@""]){
        [MyUtil showMessage:@"请选择线索来源！"];
        return false;
    }
    if([self.fromTex.text isEqualToString:@"店头活动"]||[self.fromTex.text isEqualToString:@"车展"]||[self.fromTex.text isEqualToString:@"外展外拓"]||[self.fromTex.text isEqualToString:@"线上活动"]){
        if([self.fromProjectTex.text isEqualToString:@""]){
            [MyUtil showMessage:@"请输入活动名称！"];
            return false;
        }
    }
        return true;
    
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
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

-(void)updataCarsInfo:(NSString *)chooseCars{
    _carsLal.text = chooseCars;
}
-(void)updataTimeInfo:(NSString *)timeStr{
    _timeLal.text = timeStr;
}
- (IBAction)changeForm:(UIButton *)sender {
    MHActionSheet *actionSheet = [[MHActionSheet alloc] initSheetWithTitle:nil style:MHSheetStyleWeiChat itemTitles:fromArr];
    __weak typeof(self) weakSelf = self;
    [actionSheet didFinishSelectIndex:^(NSInteger index, NSString *title) {
        weakSelf.fromTex.text=title;
        actID=@"";
        actTitle=@"";
        [eArrTitle removeAllObjects];
        weakSelf.fromProjectTex.text=@"";
        for (ActivityModel *model in eArr) {
            if([model.activity_kind isEqualToString:title]){
                [eArrTitle addObject:model.activity_from_name];
            }
        }
        if(title!=NULL && [title isEqualToString:@"线上活动"]){
            weakSelf.isNetSaleTex.text = @"是";
        }else{
            weakSelf.isNetSaleTex.text = @"否";
        }
        if(title!=NULL && [title isEqualToString:@"转介绍"]){
            _fromProjectTex.enabled=false;
        }else{
            _fromProjectTex.enabled=YES;
        }
    }];
   
}
- (IBAction)changeEvent:(id)sender {
    MHActionSheet *actionSheet = [[MHActionSheet alloc] initSheetWithTitle:nil style:MHSheetStyleWeiChat itemTitles:eArrTitle];
    __weak typeof(self) weakSelf = self;
    [actionSheet didFinishSelectIndex:^(NSInteger index, NSString *title) {
        
        for (ActivityModel *model in eArr) {
            if([model.activity_from_name isEqualToString:title]){
                actID=model.activity_id;
                actTitle=model.activity_from_name;
                weakSelf.fromProjectTex.text=model.activity_name;
                break;
            }
        }
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
