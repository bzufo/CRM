//
//  ChooseCConditionViewController.m
//  SEMCRM
//
//  Created by Sem on 2017/5/15.
//  Copyright © 2017年 sem. All rights reserved.
//

#import "ChooseCConditionViewController.h"

@interface ChooseCConditionViewController ()<UIPickerViewDelegate,UIPickerViewDataSource>
{
    NSMutableArray *modelArr;
    NSDictionary *typeATemp;
}
@property (weak, nonatomic) IBOutlet UITextField *LicenseNoTex;
@property (weak, nonatomic) IBOutlet UITextField *keyTex;
@property (weak, nonatomic) IBOutlet UITextField *beginTex;
@property (weak, nonatomic) IBOutlet UITextField *endTex;
@property (weak, nonatomic) IBOutlet UITextField *ModelsTex;

@end

@implementation ChooseCConditionViewController
- (IBAction)commitAct:(id)sender {
    NSMutableDictionary *keyDic=[[NSMutableDictionary alloc]initWithCapacity:0];
    if(_LicenseNoTex.text.length>0){
        [keyDic setObject:_LicenseNoTex.text forKey:@"license_no"];
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
    if ([self.delegate respondsToSelector:@selector(chooseCCondition:)]) {
        [self.delegate chooseCCondition:keyDic];
        [self.navigationController popViewControllerAnimated:YES];
    }
    
    
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
    UIPickerView *datePicker = [[UIPickerView alloc] init];
    
    datePicker.delegate=self;
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"\n\n\n\n\n\n\n\n\n\n\n\n" message:nil 　　preferredStyle:UIAlertControllerStyleActionSheet];
    //    alert.view.backgroundColor=[UIColor redColor];
    [alert.view addSubview:datePicker];
    
    [datePicker setCenter:CGPointMake(alert.view.frame.size.width/2-18, datePicker.center.y)];
    //NSUInteger value = [yearArr indexOfObject: choseTime];        //someString 是我想让uipicerview自动选中的值
    //[datePicker selectRow: value inComponent:0 animated:NO];
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSInteger row=[datePicker selectedRowInComponent:0];
        NSDictionary *dic =modelArr[row];
        typeATemp =dic;
        _ModelsTex.text =[dic objectForKey:@"series_name"];
    }];
    UIAlertAction *clearBtn = [UIAlertAction actionWithTitle:@"清除" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        _ModelsTex.text =@"";
        　 }];

    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        　 }];
    [alert addAction:ok];
     [alert addAction:clearBtn];
    [alert addAction:cancel];
    
    [self presentViewController:alert animated:YES completion:^{ }];
}
// pickerView 列数
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

// pickerView 每列个数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    return [modelArr count];
}


// 返回选中的行
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSDictionary *dic =modelArr[row];
    typeATemp = dic;
    
}

//返回当前行的内容,此处是将数组中数值添加到滚动的那个显示栏上
-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
     NSDictionary *dic =modelArr[row];
    return [dic objectForKey:@"series_name"];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    modelArr =[NSMutableArray arrayWithCapacity:0];
    NSString *path =[MyUtil getFilePath:CAR_SERIES];
    NSArray *arr = [NSArray arrayWithContentsOfFile:path];
    if(arr){
        [modelArr addObjectsFromArray:arr];
    }
    // Do any additional setup after loading the view.
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
