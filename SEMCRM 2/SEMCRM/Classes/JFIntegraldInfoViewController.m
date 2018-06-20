//
//  JFIntegraldInfoViewController.m
//  SEMCRM
//
//  Created by Sem on 2017/8/14.
//  Copyright © 2017年 sem. All rights reserved.
//

#import "JFIntegraldInfoViewController.h"
#import "PointFlowModel.h"
@interface JFIntegraldInfoViewController ()<UIPickerViewDelegate,UIPickerViewDataSource>
{
    NSMutableArray *yearArray;
    NSString *yearStr;
    NSString *nowStr;
    NSString *typeStr;
    NSMutableArray *dataArr;
    UILabel *titleView ;
}
@property (weak, nonatomic) IBOutlet UISegmentedControl *typeSeg;

@end

@implementation JFIntegraldInfoViewController
- (IBAction)typeChangeAct:(UISegmentedControl *)sender {
    if (sender.selectedSegmentIndex==0){
       typeStr =@"C";
    }else{
        typeStr =@"V";
    }
    titleView.text = [NSString stringWithFormat:@"%@%@",yearStr,_typeSeg.selectedSegmentIndex==0?@"现金":@"购车劵"];
    [self getPointFlow];
}
- (IBAction)chooseTimeAct:(id)sender {
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
        NSString *str =yearArray[row];
        yearStr =str;
        titleView.text = [NSString stringWithFormat:@"%@%@",yearStr,_typeSeg.selectedSegmentIndex==0?@"现金":@"购车劵"];
        [self getPointFlow];
    }];
    
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        　 }];
    [alert addAction:ok];
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
    
    return [yearArray count];
}


// 返回选中的行
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSString *str =yearArray[row];
    yearStr = str;
    
}

//返回当前行的内容,此处是将数组中数值添加到滚动的那个显示栏上
-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
     NSString *str =yearArray[row];
    return str;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    typeStr=@"C";
    dataArr =[NSMutableArray arrayWithCapacity:0];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy"];//自定义时间格式
    NSString *currentDateStr = [formatter stringFromDate:[NSDate date]];
    yearStr = currentDateStr;
    nowStr= currentDateStr;
    yearArray = [[NSMutableArray alloc]init];
    NSInteger currentYear = [currentDateStr integerValue];
    NSMutableArray *arr=[NSMutableArray arrayWithCapacity:0];
    for (NSInteger i = 2010; i <= currentYear ; i++) {
        NSString *yearTemp = [NSString stringWithFormat:@"%ld",i];
        [arr addObject:yearTemp];
    }
    [yearArray addObjectsFromArray: [[arr reverseObjectEnumerator] allObjects]];
    // Do any additional setup after loading the view.
}
-(void)getPointFlow{
    [dataArr removeAllObjects];
    NSDictionary *dic =@{@"ID_CARD":[MyUtil getUserInfo].ID_CARD,@"STR_YEAR":yearStr,@"TYPE":typeStr};
    [HttpManageTool selectPointChangeDone:dic success:^(NSArray *flowArr) {
        [dataArr addObjectsFromArray:flowArr];
        [self.tableView reloadData];
    } failure:^(NSError *err) {
        [self.tableView reloadData];
    }];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
        return dataArr.count;
   
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
      UITableViewCell *  cell = [tableView dequeueReusableCellWithIdentifier:@"titleCell" forIndexPath:indexPath];
    PointFlowModel *model = dataArr[indexPath.row];
    cell.textLabel.text =[NSString stringWithFormat:@"%@:%@",model.mark,model.cash];
    cell.detailTextLabel.text =model.create_date;
    return cell;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    titleView = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 44)];
    titleView.backgroundColor = [UIColor clearColor];
    titleView.font = [UIFont boldSystemFontOfSize:19];
    titleView.textColor = [UIColor blackColor];
    titleView.textAlignment = NSTextAlignmentCenter;
    titleView.text = [NSString stringWithFormat:@"%@%@查询",yearStr,_typeSeg.selectedSegmentIndex==0?@"现金":@"购车劵"];
    
    
    self.tabBarController.navigationItem.titleView = titleView;
    [self getPointFlow];
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
