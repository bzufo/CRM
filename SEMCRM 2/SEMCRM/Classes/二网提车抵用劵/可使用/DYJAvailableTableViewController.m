//
//  DYJAvailableTableViewController.m
//  SEMCRM
//
//  Created by Sem on 2017/11/22.
//  Copyright © 2017年 sem. All rights reserved.
//

#import "DYJAvailableTableViewController.h"
#import "VoucherModel.h"
#import "DYJAvailableCell.h"
#import "KYAlertView.h"
@interface DYJAvailableTableViewController ()
{
    
    NSMutableArray *dataArr;
    UILabel *titleView;
}
@end

@implementation DYJAvailableTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    dataArr=[[NSMutableArray alloc]initWithCapacity:0];
    self.tableView.rowHeight=100;
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    titleView = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 44)];
    titleView.backgroundColor = [UIColor clearColor];
    titleView.font = [UIFont boldSystemFontOfSize:19];
    titleView.textColor = [UIColor blackColor];
    titleView.textAlignment = NSTextAlignmentCenter;
    titleView.text = @"可使用抵用卷";
    
    
    self.tabBarController.navigationItem.titleView = titleView;
    [self getData];
}
-(void)getData{
    //[MyUtil getUserInfo].employee_no BB010102&STATUS=0
    NSDictionary *dic=@{@"SECNET_CODE":[MyUtil getUserInfo].employee_no,@"STATUS":@"0"};
    [HttpManageTool selectdyzList:dic success:^(NSArray *dyzArr) {
        [dataArr removeAllObjects];
        [dataArr addObjectsFromArray:dyzArr];
        titleView.text = [NSString stringWithFormat:@"可使用抵用卷(%ld)",dataArr.count];
        [self.tableView reloadData];
    } failure:^(NSError *err) {
        
    }
     ];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return dataArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DYJAvailableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DYJAvailableCell" forIndexPath:indexPath];
    VoucherModel *model =dataArr[indexPath.section];
    [cell.accBtn addTarget:self action:@selector(commit:event:) forControlEvents:UIControlEventTouchUpInside];
    [cell configureCell:model];
    
    return cell;
}
- (void)commit:(UIButton *)button event:(id)event{
    //    [self.contentView addSubview:self.moreView];
    NSSet *touches = [event allTouches];
    UITouch *touch = [touches anyObject];
    CGPoint currentTouchPosition = [touch locationInView:self.tableView];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint: currentTouchPosition];
    VoucherModel *model =dataArr[indexPath.section];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"输入VIN" message:@"请输入17位VIN" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"好",nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    [[alert textFieldAtIndex:0] setKeyboardType:UIKeyboardTypeDefault];
    [[alert textFieldAtIndex:0] setPlaceholder:@"请输入17位VIN！"];
    alert.alertViewClickedButtonAtIndexBlock = ^(UIAlertView *alert ,NSUInteger index) {
        
        if (index == 0) {
            
            NSLog(@"取消");
            
        }else  if (index == 1) {
            UITextField *nameField = [alert textFieldAtIndex:0];
            if(nameField.text.length<17){
                [MyUtil showMessage:@"请输入正确的VIN"];
               
            }else{
                NSDictionary *dic=@{@"VOUCHER_NO":model.voucher_no,@"VIN":nameField.text};
                [HttpManageTool savedyz:dic success:^(NSString *type) {
                    if([type integerValue]==1){
                        [MyUtil showMessage:@"申请提交成功！"];
                        [self getData];
                    }else if ([type integerValue]==3){
                        [MyUtil showMessage:@"申请异常！"];
                    }else if ([type integerValue]==6){
                        [MyUtil showMessage:@"无法申请该车（车辆不存在或不是合法库存）！"];
                    }else if ([type integerValue]==9){
                        [MyUtil showMessage:@"该劵不存在或不可用"];
                    }else{
                        
                    }
                } failure:^(NSError *err) {
                    
                }];
            }
            
            
        }
        
    };
    
    [alert show];
}

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
