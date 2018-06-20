//
//  SemCRMSupporDetailViewControllerTableViewController.m
//  SEMCRM
//
//  Created by Sem on 2017/6/28.
//  Copyright © 2017年 sem. All rights reserved.
//

#import "SemCRMSupporDetailViewControllerTableViewController.h"
#import "MemoCell.h"
#import "ReplyModel.h"
#import "SnailFullView.h"
#import "SnailSheetViewConfig.h"
#import "SnailCurtainView.h"
#import "SnailPopupController.h"
#import "SemCRMWSReplyViewController.h"
#import "SemCRMWsClosedCaseViewController.h"
#import "TeacherModel.h"
#import "SemCRMEnclosureListViewController.h"
@interface SemCRMSupporDetailViewControllerTableViewController ()<ReplyCaseDelegate,ClosedCaseDelegate,UIPickerViewDelegate,UIPickerViewDataSource>
{
    SupporContentModle *model;
    NSMutableArray *teacherArr;
    TeacherModel *teacherATemp;
}
@end

@implementation SemCRMSupporDetailViewControllerTableViewController
-(void)giveTeacher{
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSDictionary *dic=@{@"token":app.userModel.token,@"rh_no":_rhNo,@"help_teacher_no":teacherATemp.employee_no};
    [HttpManageTool commitTeacher:dic success:^(BOOL isSuccess) {
        if(isSuccess){
            [self getDetaile];
            [MyUtil showMessage:@"转交成功！"];
        }
    } failure:^(NSError *err) {
        
    }];
}
-(void)getTeacher{
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
        TeacherModel *model1 =teacherArr[row];
        teacherATemp =model1;
        [self giveTeacher];
    }];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        　 }];
    [alert addAction:ok];
    [alert addAction:cancel];
    
    [self presentViewController:alert animated:YES completion:^{ }];

}
- (IBAction)moreAct:(UIBarButtonItem *)sender {
    SnailCurtainView *curtainView = [self curtainView];
    curtainView.closeClicked = ^(UIButton *closeButton) {
        [self.sl_popupController dismissWithDuration:0.25 elasticAnimated:NO];
    };
    @weakify(self);
    curtainView.didClickItems = ^(SnailCurtainView *curtainView, NSInteger index) {
        
        [weak_self.sl_popupController dismissWithDuration:0 elasticAnimated:NO];
        if(_isSem){
            AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
            if(![model.help_teacher_no isEqualToString:app.userModel.employee_no]){
                [MyUtil showMessage:@"不能操作其他老师的单子！"];
                return ;
            }
            if([model.help_status isEqualToString:@"已结案"]){
                [MyUtil showMessage:@"已结案不能进行其他操作！"];
                return ;
            }
            if(index==0){
                
                SemCRMWSReplyViewController *viewController = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]]instantiateViewControllerWithIdentifier:@"SemCRMWSReplyViewController"];
                viewController.delegate=self;
                viewController.rhNo=_rhNo;
                viewController.isSem=@"1";
                [self.navigationController pushViewController:viewController animated:YES];
            }else{
                [teacherArr removeAllObjects];
                AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
                NSDictionary *dic=@{@"token":app.userModel.token};
                [HttpManageTool selectOtherTeacher:dic success:^(NSArray *arr) {
                    [teacherArr addObjectsFromArray:arr];
                    [self getTeacher];
                } failure:^(NSError *err) {
                    
                }];
            }
        }else{
            
            if(index==0){
                if([model.help_status isEqualToString:@"已结案"]){
                    [MyUtil showMessage:@"已结案不能进行其他操作！"];
                    return ;
                }
                if(model){
                    
                }
                SemCRMWsClosedCaseViewController *viewController = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]]instantiateViewControllerWithIdentifier:@"SemCRMWsClosedCaseViewController"];
                viewController.delegate=self;
                viewController.rhNo=_rhNo;
                [self.navigationController pushViewController:viewController animated:YES];
            }else if (index==1){
                if([model.help_status isEqualToString:@"已结案"]){
                    [MyUtil showMessage:@"已结案不能进行其他操作！"];
                    return ;
                }
                SemCRMWSReplyViewController *viewController = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]]instantiateViewControllerWithIdentifier:@"SemCRMWSReplyViewController"];
                viewController.rhNo=_rhNo;
                viewController.delegate=self;
                [self.navigationController pushViewController:viewController animated:YES];
            }else{
                if([model.system_encase isEqualToString:@"1"]){
                    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
                    NSDictionary *dic=@{@"rh_no":_rhNo,@"is_active":@"Y",@"token":app.userModel.token};
                    [HttpManageTool updataSupporEndForWs:dic success:^(NSString *rhNO) {
                        [self getDetaile];
                    } failure:^(NSError *err) {
                        
                    }];
                }else{
                    [MyUtil showMessage:@"系统自动结案才能激活！"];
                    return ;
                }
            }
        }
        
    };
    
    self.sl_popupController = [SnailPopupController new];
    self.sl_popupController.layoutType = PopupLayoutTypeTop;
    self.sl_popupController.allowPan = YES;
    //@weakify(self);
    self.sl_popupController.maskTouched = ^(SnailPopupController * _Nonnull popupController) {
        [weak_self.sl_popupController dismissWithDuration:0 elasticAnimated:NO];
    };
    [self.sl_popupController presentContentView:curtainView duration:0.75 elasticAnimated:YES];
}
- (SnailCurtainView *)curtainView {
    SnailCurtainView *curtainView = [[SnailCurtainView alloc] init];
    if(_isSem){
        curtainView.width = [UIScreen width];
        [curtainView.closeButton setImage:[UIImage imageNamed:@"qzone_close"] forState:UIControlStateNormal];
        NSArray *imageNames = @[ @"回复", @"转交"];
        NSMutableArray *models = [NSMutableArray arrayWithCapacity:imageNames.count];
        for (NSString *imageName in imageNames) {
            UIImage *image = [UIImage imageNamed:[@"sina_" stringByAppendingString:imageName]];
            [models addObject:[SnailIconLabelModel modelWithTitle:imageName image:image]];
        }
        curtainView.models = models;
    }else{
        curtainView.width = [UIScreen width];
        [curtainView.closeButton setImage:[UIImage imageNamed:@"qzone_close"] forState:UIControlStateNormal];
        NSArray *imageNames = @[@"结案", @"回复",@"激活"];
        NSMutableArray *models = [NSMutableArray arrayWithCapacity:imageNames.count];
        for (NSString *imageName in imageNames) {
            UIImage *image = [UIImage imageNamed:[@"sina_" stringByAppendingString:imageName]];
            [models addObject:[SnailIconLabelModel modelWithTitle:imageName image:image]];
        }
        curtainView.models = models;
    }
    
    
    return curtainView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    teacherArr =[[NSMutableArray alloc]initWithCapacity:0];
    self.tableView.tableFooterView= [[UIView alloc] initWithFrame:CGRectZero];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 44;
    [self getDetaile];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
-(void)getDetaile{
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSDictionary *dic=@{@"token":app.userModel.token,@"rh_no":_rhNo};
    if(_isSem){
        [HttpManageTool selectSupporDetailForSem:dic success:^(SupporContentModle *supporModel) {
            if(supporModel){
                model = supporModel;
                [self.tableView reloadData];
            }
        } failure:^(NSError *err) {
            
        }];
    }else{
        [HttpManageTool selectSupporDetailForWs:dic success:^(SupporContentModle *supporModel) {
            if(supporModel){
                model = supporModel;
                [self.tableView reloadData];
            }
        } failure:^(NSError *err) {
            
        }];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if(model){
        return 3;
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(model){
      if(section==0){
         return 11;
      }
      if(section==1){
        return model.sem_list.count;
      }
      if(section==2){
        return model.ws_list.count;
      }
    }
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    
    if(indexPath.section == 0){
       
        switch (indexPath.row) {
            case 0:
            {
                cell = [tableView dequeueReusableCellWithIdentifier:@"tilteCell" forIndexPath:indexPath];
                cell.textLabel.text=[NSString stringWithFormat:@"标题/故障:%@", model.trouble_title!=nil?model.trouble_title:@""];
                cell.accessoryType =UITableViewCellAccessoryNone;
            }
                break;
            case 1:
            {
                cell = [tableView dequeueReusableCellWithIdentifier:@"tilteCell" forIndexPath:indexPath];
                cell.textLabel.text=[NSString stringWithFormat:@"车型:%@", model.series_name!=nil?model.series_name:@""];
                cell.accessoryType =UITableViewCellAccessoryNone;
            }
                break;
            case 2:
            {
                 cell = [tableView dequeueReusableCellWithIdentifier:@"tilteCell" forIndexPath:indexPath];
                cell.textLabel.text=[NSString stringWithFormat:@"里程:%@", model.mileage!=nil?model.mileage:@""];
                cell.accessoryType =UITableViewCellAccessoryNone;
            }
                break;
            case 3:
            {
                 cell = [tableView dequeueReusableCellWithIdentifier:@"tilteCell" forIndexPath:indexPath];
                cell.textLabel.text=[NSString stringWithFormat:@"维修站:%@", model.ws_shortname!=nil?model.ws_shortname:@""];
                cell.accessoryType =UITableViewCellAccessoryNone;
            }
                break;
            case 4:
            {
                 cell = [tableView dequeueReusableCellWithIdentifier:@"tilteCell" forIndexPath:indexPath];
                 cell.textLabel.text=[NSString stringWithFormat:@"维修技师:%@", model.repair_name!=nil?model.repair_name:@""];
                cell.accessoryType =UITableViewCellAccessoryNone;
            }
                break;
            case 5:
            {
                 cell = [tableView dequeueReusableCellWithIdentifier:@"tilteCell" forIndexPath:indexPath];
                cell.textLabel.text=[NSString stringWithFormat:@"联系电话:%@", model.repair_mobile!=nil?model.repair_mobile:@""];
                cell.accessoryType =UITableViewCellAccessoryNone;
            }
                break;
            case 6:
            {
                 cell = [tableView dequeueReusableCellWithIdentifier:@"tilteCell" forIndexPath:indexPath];
                cell.textLabel.text=[NSString stringWithFormat:@"系统故障类别:%@", model.trouble_type_name!=nil?model.trouble_type_name:@""];
                cell.accessoryType =UITableViewCellAccessoryNone;
            }
                break;
            
            case 7:
            {
                cell = [tableView dequeueReusableCellWithIdentifier:@"tilteCell" forIndexPath:indexPath];
               
                
                
                cell.textLabel.text =[NSString stringWithFormat:@"故障现象:\n%@",model.trouble_des!=nil?model.trouble_des:@""];
                //cell.detailTextLabel.text = model.trouble_des;
                /*
               MemoCell *gzCell = [tableView dequeueReusableCellWithIdentifier:@"GZMemoCell" forIndexPath:indexPath];
            
                 NSMutableAttributedString * aAttributedString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"故障现象:\n%@",model.trouble_des!=nil?model.trouble_des:@""]];
                [aAttributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(0, 4)];
                gzCell.memTxt.attributedText =aAttributedString;
                cell = gzCell;
                cell.accessoryType =UITableViewCellAccessoryNone;
                 */
            }
                break;
            case 8:
            {
                cell = [tableView dequeueReusableCellWithIdentifier:@"tilteCell" forIndexPath:indexPath];
                
                
                
                cell.textLabel.text =[NSString stringWithFormat:@"维修过程:\n%@",model.process_memo!=nil?model.process_memo:@""];
                //cell.detailTextLabel.text = model.process_memo;
                /*
                MemoCell *wxMemoCell = [tableView dequeueReusableCellWithIdentifier:@"WXMemoCell" forIndexPath:indexPath];
                
                NSMutableAttributedString * aAttributedString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"维修过程:\n%@",model.process_memo!=nil?model.process_memo:@""]];
                [aAttributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(0, 4)];
                wxMemoCell.memTxt.attributedText =aAttributedString;
                cell = wxMemoCell;
                cell.accessoryType =UITableViewCellAccessoryNone;
                 */
            }
                break;
            case 9:
            {
                
                 cell = [tableView dequeueReusableCellWithIdentifier:@"tilteCell" forIndexPath:indexPath];
                cell.textLabel.text=[NSString stringWithFormat:@"拥有:%ld个附件", model.file_list!=nil?model.file_list.count:0];
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                
            }
                break;
            case 10:
            {
                cell = [tableView dequeueReusableCellWithIdentifier:@"tilteCell" forIndexPath:indexPath];
                
                
                
                cell.textLabel.text =[NSString stringWithFormat:@"故障结论:\n%@",model.ws_endcase_memo!=nil?model.ws_endcase_memo:@""];
                //cell.detailTextLabel.text = model.ws_endcase_memo;
                /*
                MemoCell *wxMemoCell = [tableView dequeueReusableCellWithIdentifier:@"WXMemoCell" forIndexPath:indexPath];
                
                NSMutableAttributedString * aAttributedString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"故障结论:\n%@",model.ws_endcase_memo!=nil?model.ws_endcase_memo:@""]];
                [aAttributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(0, 4)];
                wxMemoCell.memTxt.attributedText =aAttributedString;
                cell = wxMemoCell;
                cell.accessoryType =UITableViewCellAccessoryNone;
                 */
                
            }
                break;
            default:
                break;
        }
    }else if(indexPath.section ==1 ){
        cell = [tableView dequeueReusableCellWithIdentifier:@"subTilteCell" forIndexPath:indexPath];
        ReplyModel *replymodel = model.sem_list[indexPath.row];
        ;
        
        
        cell.textLabel.text =replymodel.reply_memo;
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@   %@",[replymodel.have_file_inf isEqualToString:@""]?@"无附件":replymodel.have_file_inf,replymodel.create_date];
    }else if(indexPath.section ==2 ){
        cell = [tableView dequeueReusableCellWithIdentifier:@"subTilteCell" forIndexPath:indexPath];
        ReplyModel *replymodel = model.ws_list[indexPath.row];
        ;
        cell.textLabel.text =replymodel.reply_memo;
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@   %@",[replymodel.have_file_inf isEqualToString:@""]?@"无附件":replymodel.have_file_inf,replymodel.create_date];
    }
    
    // Configure the cell...
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}
/*
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row ==7||indexPath.row ==8||indexPath.row ==10){
        return 100;
    }else{
        return 44;
    }
}
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0){
        if(indexPath.row==5){
            if([MyUtil isValidateTelephone:model.repair_mobile]){
                NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",model.repair_mobile];
                //            NSLog(@"str======%@",str);
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
                
            }
        }
        if(indexPath.row==9){
            SemCRMEnclosureListViewController *viewViewController=[[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"SemCRMEnclosureListViewController"];
            NSMutableArray *arr =[[NSMutableArray alloc]initWithCapacity:0];
            [arr addObjectsFromArray:model.file_list];
            viewViewController.enclosureArr = arr;
            [self.navigationController pushViewController:viewViewController animated:YES];
        }
    }else if(indexPath.section == 1){
        ReplyModel *replymodel = model.sem_list[indexPath.row];
        if(![replymodel.have_file_inf isEqualToString:@""]){
            [self showEnclosure:@"3" rhNo:_rhNo rhReplyNo:replymodel.rh_reply_no];
        }
        
    }else{
        ReplyModel *replymodel = model.ws_list[indexPath.row];
        if(![replymodel.have_file_inf isEqualToString:@""]){
            [self showEnclosure:@"2" rhNo:_rhNo rhReplyNo:replymodel.rh_reply_no];
        }
    }
}
- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if(model){
        if(section==0){
            if (!_isSem) {
                if(model.auto_encase_time&&model.auto_encase_time.length>0){
                    return [NSString stringWithFormat:@"详细(SEM要求回复时间：%@)",model.auto_encase_time];
                }else{
                    
                    return @"详细";
                }
            }else{
                return [NSString stringWithFormat:@"详细(激活次数：%@)",model.active_num!=nil?model.active_num:@"0"];
            }
            
            
        }
        if(section==1){
            return @"SEM意见";
        }
        if(section==2){
            return @"维修站回复意见";
        }
    }
    return @"";

}
-(void)showEnclosure:(NSString *)type rhNo:(NSString *)rh_no rhReplyNo:(NSString *)rh_reply_no{
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSDictionary *dic=@{@"token":app.userModel.token,@"rh_no":rh_no,@"query_type":type,@"rh_reply_no":rh_reply_no};
    [HttpManageTool selectEnclousureList:dic success:^(NSArray *enclousureList) {
        if(enclousureList&&enclousureList.count>0){
            SemCRMEnclosureListViewController *viewViewController=[[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"SemCRMEnclosureListViewController"];
            NSMutableArray *arr =[[NSMutableArray alloc]initWithCapacity:0];
            [arr addObjectsFromArray:enclousureList];
            viewViewController.enclosureArr = arr;
            [self.navigationController pushViewController:viewViewController animated:YES];
        }else{
            [MyUtil showMessage:@"无附件！"];
        }
        
    } failure:^(NSError *err) {
        
    }];
}
-(void)closeCase{
    [MyUtil showMessage:@"已结案！"];
    [self getDetaile];
}
-(void)replyCase{
    [MyUtil showMessage:@"已回复！"];
    [self getDetaile];
}
// pickerView 列数
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

// pickerView 每列个数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    return [teacherArr count];
}


// 返回选中的行
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    TeacherModel *model1 =teacherArr[row];
    teacherATemp = model1;
    
}

//返回当前行的内容,此处是将数组中数值添加到滚动的那个显示栏上
-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    TeacherModel *model1 =teacherArr[row];
    return model1.employee_inf;
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


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    UIViewController * view = segue.destinationViewController;
    if ([view respondsToSelector:@selector(setDelegate:)]) {
        [view setValue:self forKey:@"delegate"];
    }
    if ([view respondsToSelector:@selector(setEnclosureArr:)]) {
        [view setValue:self forKey:@"enclosureArr"];
    }
    
}


@end
