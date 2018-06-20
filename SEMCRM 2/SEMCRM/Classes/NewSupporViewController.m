//
//  NewSupporViewController.m
//  SEMCRM
//
//  Created by Sem on 2017/5/15.
//  Copyright © 2017年 sem. All rights reserved.
//

#import "NewSupporViewController.h"
#import "SemCRMEnclosureListViewController.h"
#import "FileModle.h"
@interface NewSupporViewController ()<UIPickerViewDelegate,UIPickerViewDataSource,AddEnclosureDelegate>
{
    UIPickerView *modelsPicker;
    UIPickerView *errTypePicker;
    UIPickerView *teachPicker;
    NSMutableArray *dataArr;
    NSDictionary *modelsTemp;
    NSDictionary *errTypeTemp;
    NSDictionary *teachTemp;
    
    NSMutableArray *photoArr;
}
@property (weak, nonatomic) IBOutlet UITextField *titleTex;
@property (weak, nonatomic) IBOutlet UITextField *LicenseTex;
@property (weak, nonatomic) IBOutlet UITextField *modelTxt;
@property (weak, nonatomic) IBOutlet UITextField *vinTex;
@property (weak, nonatomic) IBOutlet UITextField *mileageTex;
@property (weak, nonatomic) IBOutlet UITextField *errTypeTex;
@property (weak, nonatomic) IBOutlet UITextView *symptomTex;
@property (weak, nonatomic) IBOutlet UITextView *processTex;
@property (weak, nonatomic) IBOutlet UITextField *teachTex;
@property (weak, nonatomic) IBOutlet UITextField *technicianTex;
@property (weak, nonatomic) IBOutlet UITextField *phoneTex;
@property (weak, nonatomic) IBOutlet UIButton *commitBtn;
@property (weak, nonatomic) IBOutlet UIButton *saveBtn;
@property (weak, nonatomic) IBOutlet UILabel *enLal;

@end

@implementation NewSupporViewController
-(void)addEnclosure:(NSMutableArray *)arrNew{
    photoArr = arrNew;
    _enLal.text =[NSString stringWithFormat:@"拥有%ld个附件",photoArr.count];
}
- (IBAction)saveAct:(id)sender {
    if([self checkData]){
        [self saveData];
        /*
        if(_LicenseTex.text.length<1){
            dic =@{@"vpn":_vinTex.text,@"series":modelsTemp!=nil?[modelsTemp objectForKey:@"series_code"]:@"",@"token":app.userModel.token};
            
        }else{
            dic =@{@"license_no":_LicenseTex.text,@"token":app.userModel.token};
        }
        [HttpManageTool selectCheckCarInf:dic success:^(BOOL isSuccess) {
            if(isSuccess){
                [self saveData];
            }else{
                [MyUtil showMessage:@"非SEM车辆"];
            }
        } failure:^(NSError *err) {
            
        }];*/
    }
    
}
-(void)saveData{
    NSDictionary *dic;
    if(_rhNo!=nil){
        dic = [self getKeyDic:@"U" withType:@"Y"];
    }else{
        dic = [self getKeyDic:@"A" withType:@"Y"];
    }
    [HttpManageTool updataSupporForWs:dic success:^(NSString *rhNO) {
        if(rhNO){
            _rhNo = rhNO;
        }
        [MyUtil showMessage:@"保存成功！"];
    } failure:^(NSError *err) {
        
    }];
}
-(void)commitData{
    NSDictionary *dic = [self getKeyDic:@"U" withType:@"U"];
    [HttpManageTool updataSupporForWs:dic success:^(NSString *rhNO) {
        [MyUtil showMessage:@"提交成功！"];
        _commitBtn.enabled=false;
        _saveBtn.enabled=false;
    } failure:^(NSError *err) {
        
    }];
}
- (IBAction)commitAct:(id)sender {
    if(_rhNo==nil){
        [MyUtil showMessage:@"提交前先保存！"];
        return;
    }
    if([self checkData]){
        NSDictionary *dic;
        AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        if(_LicenseTex.text.length<1){
            dic =@{@"vpn":_vinTex.text,@"series":modelsTemp!=nil?[modelsTemp objectForKey:@"series_code"]:@"",@"token":app.userModel.token};
            
        }else{
            dic =@{@"license_no":_LicenseTex.text,@"token":app.userModel.token};
        }
        [HttpManageTool selectCheckCarInf:dic success:^(BOOL isSuccess) {
            if(isSuccess){
                [self commitData];
            }else{
                [MyUtil showMessage:@"非SEM车辆"];
            }
        } failure:^(NSError *err) {
            
        }];
    }
}
-(void)getDetaile{
     AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSDictionary *dic=@{@"token":app.userModel.token,@"rh_no":_rhNo};
    [HttpManageTool selectSupporDetailForWs:dic success:^(SupporContentModle *supporModel) {
        if(supporModel){
            _technicianTex.text = supporModel.repair_name;
            _phoneTex.text = supporModel.repair_mobile;
            _titleTex.text = supporModel.trouble_title;
            _LicenseTex.text = supporModel.license_no;
            _modelTxt.text = supporModel.series_name;
            modelsTemp = @{@"series_name":supporModel.series_name,@"series_code":supporModel.series};
            _vinTex.text =supporModel.vpn;
            _mileageTex.text = supporModel.mileage;
            _errTypeTex.text = supporModel.trouble_type_name;
            errTypeTemp =@{@"trouble_type_name":supporModel.trouble_type_name,@"trouble_type":supporModel.trouble_type};
            _symptomTex.text = supporModel.trouble_des;
            _processTex.text = supporModel.process_memo;
            _teachTex.text = supporModel.help_teacher;
            if(!photoArr){
                photoArr =[[NSMutableArray alloc]initWithCapacity:0];
            }
            [photoArr  addObjectsFromArray:supporModel.file_list];
            _enLal.text =[NSString stringWithFormat:@"拥有%ld个附件",photoArr.count];
            teachTemp =@{@"employee_inf":supporModel.trouble_type_name!=nil?supporModel.trouble_type_name:@"",@"employee_no":supporModel.help_teacher_no!=nil?supporModel.help_teacher_no:@""};
            
        }
    } failure:^(NSError *err) {
        
    }];
}
-(NSDictionary *)getKeyDic:(NSString *)cmd withType:(NSString *)type{
    NSMutableArray *arrTemp =[[NSMutableArray alloc]initWithCapacity:0];
    NSString *jsonStr;
    if(photoArr){
        for (FileModle *fileModel in photoArr) {
            NSDictionary *dicTemp =@{@"file_id":fileModel.file_id,@"file_name":fileModel.file_name};
            [arrTemp addObject:dicTemp];
        }
        NSDictionary *jsonDic = @{@"file_list":arrTemp};
        jsonStr = [MyUtil dictionaryToJson:jsonDic];
    }
    
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSDictionary *dic=@{@"cmd":cmd,@"rh_no":_rhNo==nil?@"":_rhNo,@"repair_name":_technicianTex.text,@"repair_mobile":_phoneTex.text,@"trouble_title":_titleTex.text,@"license_no":_LicenseTex.text,@"series":modelsTemp!=nil?[modelsTemp objectForKey:@"series_code"]:@"",@"vpn":_vinTex.text,@"mileage":_mileageTex.text,@"trouble_type":errTypeTemp!=nil?[errTypeTemp objectForKey:@"trouble_type"]:@"",@"trouble_type_name":errTypeTemp!=nil?[errTypeTemp objectForKey:@"trouble_type_name"]:@"",@"trouble_des":_symptomTex.text,@"process_memo":_processTex.text,@"help_teacher":teachTemp!=nil?[teachTemp objectForKey:@"employee_no"]:@"",@"is_save":type,@"file_list":jsonStr==nil?@"":jsonStr,@"token":app.userModel.token};
    return dic;
}
-(BOOL)checkData{
    /*
    if(_technicianTex.text.length<1){
        [MyUtil showMessage:@"请填写维修技师！"];
        return false;
    }
     */
    if(_phoneTex.text.length<1){
        [MyUtil showMessage:@"请填写技师电话！"];
        return false;
    }
    if(![MyUtil isValidateTelephone:_phoneTex.text]){
        [MyUtil showMessage:@"请填写正确的手机号码！"];
        return false;
    }
    if(_titleTex.text.length<1){
        [MyUtil showMessage:@"请填写标题/故障！"];
        return false;
    }
    if(_modelTxt.text.length<1){
        [MyUtil showMessage:@"请填写车型！"];
        return false;
    }
    /*
    if(_LicenseTex.text.length<1){
        if(_modelTxt.text.length<1||_vinTex.text.length<1){
            [MyUtil showMessage:@"请填写车牌或者填写车型VIN！"];
            return false;
        }
        
    }
    
    if(_mileageTex.text.length<1){
        [MyUtil showMessage:@"请填写行驶里程！"];
        return false;
    }
    if(_errTypeTex.text.length<1){
        [MyUtil showMessage:@"请选择系统故障类别！"];
        return false;
    }
    if(_symptomTex.text.length<1){
        [MyUtil showMessage:@"请填写故障现象！"];
        return false;
    }
    if(_processTex.text.length<1){
        [MyUtil showMessage:@"请填写维修过程！"];
        return false;
    }
    */
    
    return true;
}
- (IBAction)chooseModelsAct:(id)sender {
    modelsPicker = [[UIPickerView alloc] init];
    [dataArr removeAllObjects];
    NSString *path =[MyUtil getFilePath:CAR_SERIES];
    NSArray *arr = [NSArray arrayWithContentsOfFile:path];
    if(arr){
        [dataArr addObjectsFromArray:arr];
    }
    modelsPicker.delegate=self;
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"\n\n\n\n\n\n\n\n\n\n\n\n" message:nil 　　preferredStyle:UIAlertControllerStyleActionSheet];
    //    alert.view.backgroundColor=[UIColor redColor];
    [alert.view addSubview:modelsPicker];
    
    [modelsPicker setCenter:CGPointMake(alert.view.frame.size.width/2-18, modelsPicker.center.y)];
    //NSUInteger value = [yearArr indexOfObject: choseTime];        //someString 是我想让uipicerview自动选中的值
    //[datePicker selectRow: value inComponent:0 animated:NO];
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSInteger row=[modelsPicker selectedRowInComponent:0];
        NSDictionary *dic =dataArr[row];
        modelsTemp =dic;
        _modelTxt.text =[dic objectForKey:@"series_name"];
    }];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        　 }];
    [alert addAction:ok];
    [alert addAction:cancel];
    
    [self presentViewController:alert animated:YES completion:^{ }];
}
- (IBAction)chooseErrTypeAct:(id)sender {
    errTypePicker = [[UIPickerView alloc] init];
    [dataArr removeAllObjects];
    NSString *path =[MyUtil getFilePath:TROUBLE_TYPE];
    NSArray *arr = [NSArray arrayWithContentsOfFile:path];
    if(arr){
        [dataArr addObjectsFromArray:arr];
    }
    errTypePicker.delegate=self;
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"\n\n\n\n\n\n\n\n\n\n\n\n" message:nil 　　preferredStyle:UIAlertControllerStyleActionSheet];
    //    alert.view.backgroundColor=[UIColor redColor];
    [alert.view addSubview:errTypePicker];
    
    [errTypePicker setCenter:CGPointMake(alert.view.frame.size.width/2-18, errTypePicker.center.y)];
    //NSUInteger value = [yearArr indexOfObject: choseTime];        //someString 是我想让uipicerview自动选中的值
    //[datePicker selectRow: value inComponent:0 animated:NO];
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSInteger row=[errTypePicker selectedRowInComponent:0];
        NSDictionary *dic =dataArr[row];
        errTypeTemp =dic;
        _errTypeTex.text =[dic objectForKey:@"trouble_type_name"];
    }];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        　 }];
    [alert addAction:ok];
    [alert addAction:cancel];
    
    [self presentViewController:alert animated:YES completion:^{ }];
    
}
- (IBAction)chooseTeachAct:(id)sender {
    teachPicker = [[UIPickerView alloc] init];
    [dataArr removeAllObjects];
    NSString *path =[MyUtil getFilePath:SEM_TEACHER];
    NSArray *arr = [NSArray arrayWithContentsOfFile:path];
    if(arr){
        [dataArr addObjectsFromArray:arr];
    }
    teachPicker.delegate=self;
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"\n\n\n\n\n\n\n\n\n\n\n\n" message:nil 　　preferredStyle:UIAlertControllerStyleActionSheet];
    //    alert.view.backgroundColor=[UIColor redColor];
    [alert.view addSubview:teachPicker];
    
    [teachPicker setCenter:CGPointMake(alert.view.frame.size.width/2-18, teachPicker.center.y)];
    //NSUInteger value = [yearArr indexOfObject: choseTime];        //someString 是我想让uipicerview自动选中的值
    //[datePicker selectRow: value inComponent:0 animated:NO];
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSInteger row=[teachPicker selectedRowInComponent:0];
        NSDictionary *dic =dataArr[row];
        teachTemp =dic;
        _teachTex.text =[dic objectForKey:@"employee_inf"];
    }];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        　 }];
    [alert addAction:ok];
    [alert addAction:cancel];
    
    [self presentViewController:alert animated:YES completion:^{ }];
}
// pickerView 列数
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

// pickerView 每列个数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    return [dataArr count];
}


// 返回选中的行
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSDictionary *dic =dataArr[row];
    if(modelsPicker==pickerView){
        
        modelsTemp = dic;
    }
    if(errTypePicker==pickerView){
        
        errTypeTemp = dic;
    }
    if(teachPicker==pickerView){
        
        teachTemp = dic;
    }

    
}

//返回当前行的内容,此处是将数组中数值添加到滚动的那个显示栏上
-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    
    NSDictionary *dic =dataArr[row];
    if(modelsPicker==pickerView){
        
        modelsTemp = dic;
        return [dic objectForKey:@"series_name"];
    }
    if(errTypePicker==pickerView){
        
        errTypeTemp = dic;
        return [dic objectForKey:@"trouble_type_name"];
    }else{
        teachTemp = dic;
        return [dic objectForKey:@"employee_inf"];
    }
    

    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    dataArr = [NSMutableArray arrayWithCapacity:0];
    if(_rhNo){
        [self getDetaile];
    }
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    UIViewController * view = segue.destinationViewController;
    if ([view respondsToSelector:@selector(setDelegate:)]) {
        [view setValue:self forKey:@"delegate"];
    }
    if ([view respondsToSelector:@selector(setEnclosureArr:)]) {
        if(photoArr){
            [view setValue:photoArr forKey:@"enclosureArr"];
        }
        
    }
    if ([view respondsToSelector:@selector(setIsAdd:)]) {
        [view setValue:@"1" forKey:@"isAdd"];
    }
}


@end
