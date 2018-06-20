//
//  TimeChooseViewController.m
//  SEMCRM
//
//  Created by 薛斯岐 on 16/2/26.
//  Copyright © 2016年 sem. All rights reserved.
//

#import "TimeChooseViewController.h"

@interface TimeChooseViewController ()
{
    NSDateFormatter * dateFormatter;
}

@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UISegmentedControl *shaiXuanSeq;
@end

@implementation TimeChooseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    dateFormatter = [[NSDateFormatter alloc]init];
    if(_typeStr!=NULL && [_typeStr isEqualToString:@"A"] ){
        [_shaiXuanSeq setHidden:YES];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    }else{
        [_shaiXuanSeq setHidden:NO];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    }
    

    // Do any additional setup after loading the view.
}
- (IBAction)chooseTimeAct:(UIBarButtonItem *)sender {
    NSDate *dateTemp =self.datePicker.date;
    if(_typeStr!=NULL && [_typeStr isEqualToString:@"A"] ){
        NSDate *now = [NSDate date];
       
        
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSUInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit ;
        NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:now];
        NSDateComponents *dateComponent1 = [calendar components:unitFlags fromDate:dateTemp];
        NSInteger year = [dateComponent year];
        NSInteger month = [dateComponent month];
        NSInteger year1 = [dateComponent1 year];
        NSInteger month1 = [dateComponent1 month];
        NSInteger day = [dateComponent day];
        NSInteger day1 = [dateComponent1 day];
        if(year1!=year){
            [MyUtil showMessage:@"请选择今年！"];
            return;
        }
        if(month!=month1){
            [MyUtil showMessage:@"请选择本月！"];
            return;
        }
        if(day1>day){
            [MyUtil showMessage:@"不能大于当天"];
            return;
        }
    }else{
        if ([dateTemp timeIntervalSinceDate:[NSDate date]]<0.0 ) {
            [MyUtil showMessage:@"不能比当前时间早！"];
            return;
        }
    }
    
    
    NSString *dateStr= [dateFormatter stringFromDate:dateTemp];
    [self.delegate updataTimeInfo:dateStr];
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)chageDateTupe:(UISegmentedControl *)sender {
    if(sender.selectedSegmentIndex==0){
        [self.datePicker setDatePickerMode:UIDatePickerModeDate];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    }else{
        [self.datePicker setDatePickerMode:UIDatePickerModeDateAndTime];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
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
