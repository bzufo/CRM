//
//  DYJMyInfoTableViewController.m
//  SEMCRM
//
//  Created by Sem on 2017/11/22.
//  Copyright © 2017年 sem. All rights reserved.
//

#import "DYJMyInfoTableViewController.h"
#import "VoucherinfoModel.h"
@interface DYJMyInfoTableViewController ()
{
   
    NSMutableArray *dataArr;
}
@property (weak, nonatomic) IBOutlet UILabel *ewmcLal;
@property (weak, nonatomic) IBOutlet UILabel *gsjxsLal;
@property (weak, nonatomic) IBOutlet UILabel *dateLal;
@property (weak, nonatomic) IBOutlet UILabel *sxLal;
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation DYJMyInfoTableViewController
- (IBAction)showMes:(UIButton *)sender {
    [MyUtil showMessage:@"1、专营二网认定后当季度提车抵用券将在认定日次日发放，次季度起提车抵用券将于每季度第一个月1号发放；\n2、提车抵用券补助上限分2年（即8季度）发放，每季度发放额度为补助上限/8；\n3、若专营二网认定之日起2年后继续经营东南汽车，则东南汽车每季度发放9000元提车抵用券；\n4、专营二网自认定之日起可申请使用提车抵用券，凭该提车抵用券向一级经销商提车时可冲抵车款，单台车最多可使用2张（即2000元）\n5、专营二网申请提车抵用券时，需维护所抵车辆准确的VIN号码信息；\n6、提车抵用券自东南汽车发放之日起半年（6个月）内有效，过期失效。专营二网撤点后，抵用券失效；\n7、提车抵用券使用问题咨询电话：东南汽车渠道客户部 吴女士0591-22766566-2291；\n8、本抵用券最终解释权归东南汽车所有。"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    dataArr=[[NSMutableArray alloc]initWithCapacity:0];
    _ewmcLal.text=[MyUtil getUserInfo].secnet_name;
    _dateLal.text=[MyUtil getUserInfo].c_data;
    _sxLal.text=[NSString stringWithFormat:@"%@元",[MyUtil getUserInfo].max_amount];
    _gsjxsLal.text=[MyUtil getUserInfo].parent_dealer_shortname;
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    UILabel *titleView = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 44)];
    titleView.backgroundColor = [UIColor clearColor];
    titleView.font = [UIFont boldSystemFontOfSize:19];
    titleView.textColor = [UIColor blackColor];
    titleView.textAlignment = NSTextAlignmentCenter;
    titleView.text = @"网点信息";
    
    
    self.tabBarController.navigationItem.titleView = titleView;
    [self getData];
}
-(void)getData{
    //[MyUtil getUserInfo].employee_no BB010102&STATUS=0
    NSDictionary *dic=@{@"SECNET_CODE":[MyUtil getUserInfo].employee_no};
    [HttpManageTool getDyjMsg:dic success:^(NSArray *dyzArr) {
        [dataArr removeAllObjects];
        [dataArr addObjectsFromArray:dyzArr];
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"yyyy-MM-dd"];//自定义时间格式
        NSString *currentDateStr = [formatter stringFromDate:[NSDate date]];
        //**年**月**日收到新提车抵用券*张（金额*元）
        if(dataArr.count>0){
            
            VoucherinfoModel *model =dataArr[0];
            
            _textView.text=[NSString stringWithFormat:@"消息：\n1.%@收到新提车抵用券%ld张（金额%ld元）\n2.您有提车抵用券%ld张（金额%ld元）即将过期，请尽快使用。",currentDateStr,model.ff.integerValue,model.ff.integerValue*1000,model.gq.integerValue,model.gq.integerValue*1000];
        }
        [self.tableView reloadData];
    } failure:^(NSError *err) {
        
    }
     ];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
