//
//  JFMonthIViewController.m
//  SEMCRM
//
//  Created by Sem on 2017/8/14.
//  Copyright © 2017年 sem. All rights reserved.
//

#import "JFMonthIViewController.h"
#import "QFDatePickerView.h"
#import "JFPointSaleItemModle.h"
#import "JFSaleItmeCell.h"
@interface JFMonthIViewController ()
{
    UILabel *titleView;
    NSString *yearStr;
    NSString *monthStr;
    NSMutableArray *dataArr;
}
@property (weak, nonatomic) IBOutlet UITextField *dateTex;
@property (weak, nonatomic) IBOutlet UIButton *chooseTimeBtn;
@property (weak, nonatomic) IBOutlet UILabel *countILal;

@end

@implementation JFMonthIViewController
- (IBAction)chooseTimeAct:(id)sender {
    QFDatePickerView *datePickerView = [[QFDatePickerView alloc]initDatePackerWithResponse:^(NSString *str) {
        NSString *string = str;
        NSArray *dateArray = [string componentsSeparatedByString:@"-"];
        if (dateArray.count == 2) {
            yearStr=[dateArray firstObject];
            monthStr=[dateArray[1] integerValue]>9?dateArray[1]:[NSString stringWithFormat:@"0%@",dateArray[1]];
            titleView.text = [NSString stringWithFormat:@"%@/%ld月积分明细",yearStr,monthStr!=nil?[monthStr integerValue]:0];
            self.dateTex.text= [NSString stringWithFormat:@"%@/%ld月",yearStr,monthStr!=nil?[monthStr integerValue]:0];
            [self getPointItem];
        }

    }];
    [datePickerView show];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    dataArr =[NSMutableArray arrayWithCapacity:0];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM"];//自定义时间格式
    NSString *currentDateStr = [formatter stringFromDate:[NSDate date]];
    NSArray *dateArray = [currentDateStr componentsSeparatedByString:@"-"];
   
    if (dateArray.count == 2) {
        yearStr=[dateArray firstObject];
        monthStr=dateArray[1];
    }
     self.dateTex.text= [NSString stringWithFormat:@"%@/%ld月",yearStr,monthStr!=nil?[monthStr integerValue]:0];
    // Do any additional setup after loading the view.
}
-(void)getPointItem{
    NSDictionary *dic =@{@"ID_CARD":[MyUtil getUserInfo].ID_CARD,@"STR_MON":[NSString stringWithFormat:@"%@%@",yearStr,monthStr]};
    [HttpManageTool selectPointSaleitme:dic success:^(NSArray *itmeArr) {
        [dataArr addObjectsFromArray:itmeArr];
        int count =0;
        for (JFPointSaleItemModle *model in dataArr) {
            if(model.point){
                count +=[model.point integerValue];
            }
        }
        self.countILal.text=[NSString stringWithFormat:@"%d",count];
        [self.tableView reloadData];
    } failure:^(NSError *err) {
        [self.tableView reloadData];
    }];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [dataArr removeAllObjects];
    titleView = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 44)];
    titleView.backgroundColor = [UIColor clearColor];
    titleView.font = [UIFont boldSystemFontOfSize:19];
    titleView.textColor = [UIColor blackColor];
    titleView.textAlignment = NSTextAlignmentCenter;
    titleView.text = [NSString stringWithFormat:@"%@/%ld月积分明细",yearStr,monthStr!=nil?[monthStr integerValue]:0];
    
    
    self.tabBarController.navigationItem.titleView = titleView;
    [self getPointItem];
    //    self.tabBarController.navigationItem.rightBarButtonItem = nil;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return dataArr.count;
    
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    JFSaleItmeCell *  cell = [tableView dequeueReusableCellWithIdentifier:@"JFSaleItmeCell" forIndexPath:indexPath];
    JFPointSaleItemModle *model = dataArr[indexPath.row];
    [cell configureCell:model];
    return cell;
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
