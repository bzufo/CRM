//
//  CaseChooseCConditionViewDelegate.m
//  SEMCRM
//
//  Created by Sem on 2017/7/4.
//  Copyright © 2017年 sem. All rights reserved.
//

#import "CaseChooseCConditionViewDelegate.h"

@interface CaseChooseCConditionViewDelegate ()<UIPickerViewDelegate,UIPickerViewDataSource>
{
    NSMutableArray *modelArr;
    NSDictionary *typeATemp;
    NSMutableArray *sortArr;
    NSDictionary *sortATemp;
    NSMutableArray *troubleArr;
    NSDictionary *troubleTemp;
    UIPickerView *modelPicker;
    UIPickerView *sortPicker;
    UIPickerView *troublePicker;
}
@property (weak, nonatomic) IBOutlet UITextField *typeTex;
@property (weak, nonatomic) IBOutlet UITextField *keyTex;
@property (weak, nonatomic) IBOutlet UITextField *beginTex;
@property (weak, nonatomic) IBOutlet UITextField *endTex;
@property (weak, nonatomic) IBOutlet UITextField *ModelsTex;
@property (weak, nonatomic) IBOutlet UITextField *shareKeyTex;
@property (weak, nonatomic) IBOutlet UITextField *troubleTex;

@end

@implementation CaseChooseCConditionViewDelegate
- (IBAction)commitAct:(id)sender {
    NSMutableDictionary *keyDic=[[NSMutableDictionary alloc]initWithCapacity:0];
    if(_typeTex.text.length>0){
        [keyDic setObject:[sortATemp objectForKey:@"sort_code"] forKey:@"sort_code"];
    }
    if(_keyTex.text.length>0){
        [keyDic setObject:@"2" forKey:@"query_type"];
        [keyDic setObject:_keyTex.text forKey:@"query_memo"];
    }
    if(_beginTex.text.length>0){
        [keyDic setObject:_beginTex.text forKey:@"begin_date"];
    }
    if(_endTex.text.length>0){
        [keyDic setObject:_endTex.text forKey:@"end_date"];
    }
    if(_ModelsTex.text.length>0){
        [keyDic setObject:[typeATemp objectForKey:@"series_code"] forKey:@"series"];
    }
    if(_troubleTex.text.length>0){
        [keyDic setObject:[troubleTemp objectForKey:@"trouble_type"] forKey:@"trouble_type"];
    }
    if(_shareKeyTex.text.length>0){
        [keyDic setObject:@"3" forKey:@"query_type"];
        [keyDic setObject:_shareKeyTex.text forKey:@"query_memo"];
    }
    if ([self.delegate respondsToSelector:@selector(chooseCCondition:)]) {
        [self.delegate chooseCCondition:keyDic];
        [self.navigationController popViewControllerAnimated:YES];
    }
    
    
}
- (IBAction)trouebleAct:(id)sender {
    troublePicker = [[UIPickerView alloc] init];
    
    troublePicker.delegate=self;
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"\n\n\n\n\n\n\n\n\n\n\n\n" message:nil 　　preferredStyle:UIAlertControllerStyleActionSheet];
    //    alert.view.backgroundColor=[UIColor redColor];
    [alert.view addSubview:troublePicker];
    
    [troublePicker setCenter:CGPointMake(alert.view.frame.size.width/2-18, troublePicker.center.y)];
    //NSUInteger value = [yearArr indexOfObject: choseTime];        //someString 是我想让uipicerview自动选中的值
    //[datePicker selectRow: value inComponent:0 animated:NO];
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSInteger row=[troublePicker selectedRowInComponent:0];
        NSDictionary *dic =troubleArr[row];
        troubleTemp =dic;
        _troubleTex.text =[dic objectForKey:@"trouble_type_name"];
    }];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        　 }];
    [alert addAction:ok];
    [alert addAction:cancel];
    
    [self presentViewController:alert animated:YES completion:^{ }];
}
- (IBAction)beginACt:(id)sender {
    UIDatePicker *datePicker = [[UIDatePicker alloc] init]; datePicker.datePickerMode = UIDatePickerModeDate;
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"\n\n\n\n\n\n\n\n\n\n\n\n" message:nil 　　preferredStyle:UIAlertControllerStyleActionSheet];
    [alert.view addSubview:datePicker];
    [datePicker setCenter:CGPointMake(alert.view.frame.size.width/2-10, datePicker.center.y)];
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
        //实例化一个NSDateFormatter对象
        [dateFormat setDateFormat:@"yyyy-MM-dd"];//设定时间格式
        NSString *dateString = [dateFormat stringFromDate:datePicker.date];
        self.beginTex.text =dateString;
        //求出当天的时间字符串
        NSLog(@"%@",dateString);
    }];
    UIAlertAction *clearBtn = [UIAlertAction actionWithTitle:@"清除" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        self.beginTex.text =@"";
        　 }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        　 }];
    [alert addAction:ok];
    [alert addAction:clearBtn];
    [alert addAction:cancel];
    [self presentViewController:alert animated:YES completion:^{ }];
}
- (IBAction)entAct:(id)sender {
    UIDatePicker *datePicker = [[UIDatePicker alloc] init]; datePicker.datePickerMode = UIDatePickerModeDate;
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"\n\n\n\n\n\n\n\n\n\n\n\n" message:nil 　　preferredStyle:UIAlertControllerStyleActionSheet];
    [alert.view addSubview:datePicker];
    [datePicker setCenter:CGPointMake(alert.view.frame.size.width/2-10, datePicker.center.y)];
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
        //实例化一个NSDateFormatter对象
        [dateFormat setDateFormat:@"yyyy-MM-dd"];//设定时间格式
        NSString *dateString = [dateFormat stringFromDate:datePicker.date];
        self.endTex.text =dateString;
        //求出当天的时间字符串
        NSLog(@"%@",dateString);
    }];
    UIAlertAction *clearBtn = [UIAlertAction actionWithTitle:@"清除" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        self.endTex.text =@"";
        　 }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        　 }];
    [alert addAction:ok];
    [alert addAction:clearBtn];
    [alert addAction:cancel];
    [self presentViewController:alert animated:YES completion:^{ }];
}
- (IBAction)modelsAct:(id)sender {
    modelPicker = [[UIPickerView alloc] init];
    
    modelPicker.delegate=self;
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"\n\n\n\n\n\n\n\n\n\n\n\n" message:nil 　　preferredStyle:UIAlertControllerStyleActionSheet];
    //    alert.view.backgroundColor=[UIColor redColor];
    [alert.view addSubview:modelPicker];
    
    [modelPicker setCenter:CGPointMake(alert.view.frame.size.width/2-18, modelPicker.center.y)];
    //NSUInteger value = [yearArr indexOfObject: choseTime];        //someString 是我想让uipicerview自动选中的值
    //[datePicker selectRow: value inComponent:0 animated:NO];
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSInteger row=[modelPicker selectedRowInComponent:0];
        NSDictionary *dic =modelArr[row];
        typeATemp =dic;
        _ModelsTex.text =[dic objectForKey:@"series_name"];
    }];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        　 }];
    [alert addAction:ok];
    [alert addAction:cancel];
    
    [self presentViewController:alert animated:YES completion:^{ }];
}
- (IBAction)typeAct:(id)sender {
    sortPicker = [[UIPickerView alloc] init];
    
    sortPicker.delegate=self;
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"\n\n\n\n\n\n\n\n\n\n\n\n" message:nil 　　preferredStyle:UIAlertControllerStyleActionSheet];
    //    alert.view.backgroundColor=[UIColor redColor];
    [alert.view addSubview:sortPicker];
    
    [sortPicker setCenter:CGPointMake(alert.view.frame.size.width/2-18, sortPicker.center.y)];
    //NSUInteger value = [yearArr indexOfObject: choseTime];        //someString 是我想让uipicerview自动选中的值
    //[datePicker selectRow: value inComponent:0 animated:NO];
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSInteger row=[sortPicker selectedRowInComponent:0];
        NSDictionary *dic =sortArr[row];
        sortATemp =dic;
        
        _typeTex.text =[dic objectForKey:@"sort_name"];
    }];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        　 }];
    [alert addAction:ok];
    [alert addAction:cancel];
    
    [self presentViewController:alert animated:YES completion:^{ }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    modelArr =[NSMutableArray arrayWithCapacity:0];
    NSString *path =[MyUtil getFilePath:CAR_SERIES];
    NSArray *arr = [NSArray arrayWithContentsOfFile:path];
    if(arr){
        [modelArr addObjectsFromArray:arr];
    }
    sortArr =[NSMutableArray arrayWithCapacity:0];
    path =[MyUtil getFilePath:SEM_SORTTYPE];
    NSArray *arr1 = [NSArray arrayWithContentsOfFile:path];
    if(arr1){
        [sortArr addObjectsFromArray:arr1];
    }
    
    troubleArr =[NSMutableArray arrayWithCapacity:0];
    path =[MyUtil getFilePath:TROUBLE_TYPE];
    NSArray *arr2 = [NSArray arrayWithContentsOfFile:path];
    if(arr2){
        [troubleArr addObjectsFromArray:arr2];
    }
    // Do any additional setup after loading the view.
}
// pickerView 列数
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

// pickerView 每列个数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if(pickerView==sortPicker){
        return [sortArr count];
    }
    if(pickerView==troublePicker){
        return [troubleArr count];
    }
    return [modelArr count];
}


// 返回选中的行
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if(pickerView==sortPicker){
        NSDictionary *dic =sortArr[row];
        sortATemp = dic;
    }else if(pickerView==troublePicker){
        NSDictionary *dic =troubleArr[row];
        troubleTemp = dic;
        
    }else{
        NSDictionary *dic =modelArr[row];
        typeATemp = dic;
    }
    
    
}

//返回当前行的内容,此处是将数组中数值添加到滚动的那个显示栏上
-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if(pickerView==sortPicker){
        NSDictionary *dic =sortArr[row];
        return [dic objectForKey:@"sort_name"];
    }else if(pickerView==troublePicker){
        NSDictionary *dic =troubleArr[row];
        return [dic objectForKey:@"trouble_type_name"];
        
    }else{
        NSDictionary *dic =modelArr[row];
        return [dic objectForKey:@"series_name"];
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
