//
//  SemCRMWSReplyViewController.m
//  SEMCRM
//
//  Created by Sem on 2017/6/30.
//  Copyright © 2017年 sem. All rights reserved.
//

#import "SemCRMWSReplyViewController.h"
#import "SemCRMEnclosureListViewController.h"
#import "FileModle.h"
@interface SemCRMWSReplyViewController ()<AddEnclosureDelegate,UIPickerViewDelegate,UIPickerViewDataSource>
{
    NSMutableArray *photoArr;
    NSArray *timeArr;
    NSString *timeStr;
}
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UILabel *EnclosureLal;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *commitBtn;
@property (weak, nonatomic) IBOutlet UIButton *timeChooseBtn;
@property (weak, nonatomic) IBOutlet UILabel *timeLal;
@property (weak, nonatomic) IBOutlet UITableViewCell *timeCell;

@end

@implementation SemCRMWSReplyViewController
-(void)addEnclosure:(NSMutableArray *)arrNew{
    photoArr = arrNew;
    _EnclosureLal.text =[NSString stringWithFormat:@"拥有%ld个附件",photoArr.count];
}
- (IBAction)timeChooseAct:(UIButton *)sender {
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
        NSString *str =[NSString stringWithFormat:@"%@小时",timeArr[row]];
        timeStr =timeArr[row];
        _timeLal.text =[NSString stringWithFormat:@"期望WS回复时间：%@",str];
        
    }];
    UIAlertAction *clearBtn = [UIAlertAction actionWithTitle:@"清除" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        timeStr =@"";
        _timeLal.text =@"期望WS回复时间：";
        　 }];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        　 }];
    [alert addAction:ok];
    [alert addAction:clearBtn];
    [alert addAction:cancel];
    
    [self presentViewController:alert animated:YES completion:^{
        
    }];
}
// pickerView 列数
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

// pickerView 每列个数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    return [timeArr count];
}


// 返回选中的行
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSString *str =[NSString stringWithFormat:@"%@小时",timeArr[row]];
    timeStr = timeArr[row];
    
}

//返回当前行的内容,此处是将数组中数值添加到滚动的那个显示栏上
-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString *str =[NSString stringWithFormat:@"%@小时",timeArr[row]];
    return str;
}

- (IBAction)commitAct:(UIBarButtonItem *)sender {
    if(_textView.text.length<1){
        [MyUtil showMessage:@"请填写回复意见！"];
        return;
    }
    NSString *jsonStr;
    NSMutableArray *arrTemp =[[NSMutableArray alloc]initWithCapacity:0];
    if(photoArr){
        for (FileModle *fileModel in photoArr) {
            NSDictionary *dicTemp =@{@"file_id":fileModel.file_id,@"file_name":fileModel.file_name,@"file_list":jsonStr==nil?@"":jsonStr};
            [arrTemp addObject:dicTemp];
        }
        NSDictionary *jsonDic = @{@"file_list":arrTemp};
        jsonStr = [MyUtil dictionaryToJson:jsonDic];
    }

    if(_isSem){
        AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        NSDictionary *dic=@{@"rh_no":_rhNo,@"reply_memo":_textView.text,@"file_list":jsonStr==nil?@"":jsonStr,@"token":app.userModel.token,@"auto_encase_hours":timeStr.length>0?timeStr:@""};
        [HttpManageTool updataSupporReplyForSem:dic success:^(BOOL isflag) {
            if ([self.delegate respondsToSelector:@selector(replyCase)]) {
                [self.delegate replyCase];
                [self.navigationController popViewControllerAnimated:YES];
            }
        } failure:^(NSError *err) {
            
        }];
    }else{
        AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        NSDictionary *dic=@{@"rh_no":_rhNo,@"reply_memo":_textView.text,@"file_list":jsonStr==nil?@"":jsonStr,@"token":app.userModel.token};
        [HttpManageTool updataSupporReplyForWs:dic success:^(NSString *rhNO) {
            if ([self.delegate respondsToSelector:@selector(replyCase)]) {
                [self.delegate replyCase];
                [self.navigationController popViewControllerAnimated:YES];
            }
        } failure:^(NSError *err) {
            
        }];
    }
    

}

- (void)viewDidLoad {
    [super viewDidLoad];
    timeStr=@"";
    timeArr =@[@"2",@"4",@"6",@"8",@"10",@"12",@"24",@"36",@"48"];
    if(!_isSem){
        [_timeCell setHidden:YES];
    }
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
