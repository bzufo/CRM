//
//  SemCRMMaintenanceForConnectViewController.m
//  SEMCRM
//
//  Created by 薛斯岐 on 16/2/22.
//  Copyright © 2016年 sem. All rights reserved.
//
#import "SVProgressHUD.h"
#import "SemCRMMaintenanceForConnectViewController.h"
#import "TimeChooseCell.h"
#import "ConnectLevelStateCell.h"
#import "ConnectRecordCell.h"
#import "ChooseResonViewController.h"
#import "TimeChooseViewController.h"
#import "LevelModel.h"
#import "FollowTypeCell.h"
#import "XDbrandCell.h"
#import "XDseriesCell.h"
#import "XDseriesDetailsCell.h"
#import "XDclolorCell.h"
#import "MHActionSheet.h"
@interface SemCRMMaintenanceForConnectViewController ()<ChooseResonDelegate,TimeChooseDelegate>
{
    ConnectLevelStateCell *cellTem;
    ConnectRecordCell * connectRecordCell;
    TimeChooseCell *timeCell;
    TimeChooseCell *comeTimeCell;
    UITableViewCell *chooseWhyCell;
    XDbrandCell * brandCell;
    XDseriesCell * seriesCell;
    XDseriesDetailsCell * seriesDetailsCell;
    XDclolorCell * clolorCell;
    FollowTypeCell *followCell;
    NSString *keyStr;
    NSInteger stateTemp;
    BOOL isComeFlag;
    bool isComeTime;
    NSString *nowTimeStr;
}
@property (weak, nonatomic) IBOutlet UISegmentedControl *typeSeg;
@property (weak, nonatomic) IBOutlet UISegmentedControl *followSeg;
@property (weak, nonatomic) IBOutlet UILabel *userNameLal;
@property (weak, nonatomic) IBOutlet UIImageView *sexImageView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *stateSeg;
@end

@implementation SemCRMMaintenanceForConnectViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    UIFont *font = [UIFont boldSystemFontOfSize:12.0f];
    NSDictionary *attributes = [NSDictionary dictionaryWithObject:font
                                                           forKey:UITextAttributeFont];
    [_typeSeg setTitleTextAttributes:attributes
                            forState:UIControlStateNormal];
    if([_isChange isEqualToString:@"0"] ){
        _typeSeg.enabled=false;
    }else{
        _typeSeg.enabled=true;
        
    }
    
    isComeFlag = false;
    colorArr = [[NSMutableArray alloc]init];
    keyStr=@"";
    NSDate *nowDate = [NSDate date];
    NSDateFormatter *dateFormatter =[[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd kk:mm:ss"];
    chooseWhyCell.detailTextLabel.text=@"请选择无效原因";
    nowTimeStr=[dateFormatter stringFromDate:nowDate];;
    [self  setInitData];
    if(_isCall){
        if(_cidStr==nil || _cidStr.length<1){
            [self telCus];
        }else{
            [SVProgressHUD showWithStatus:@"专线电话拨打成功,请等候"];
            [self performSelector:@selector(dissmissSV) withObject:nil/*可传任意类型参数*/ afterDelay:3.0];
        }
        
        _followSeg.selectedSegmentIndex=0;
        _followSeg.enabled=false;
    }else{
        _followSeg.enabled=YES;
        //[_followSeg setEnabled:NO forSegmentAtIndex:0];
    }
    [self.tableView reloadData];
    // Do any additional setup after loading the view.
}
-(void)dissmissSV{
    [SVProgressHUD dismiss];
}
- (IBAction)completAct:(UIBarButtonItem *)sender {
    NSInteger tag = _stateSeg.selectedSegmentIndex;
    NSMutableDictionary *dic =[[NSMutableDictionary alloc]init];
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSInteger state =_stateSeg.selectedSegmentIndex;
    //    1-跟进中
    //    2.战败
    //    3.成交；
    //    5.无效
    //    7.下订
    NSString *stateStr =@"1";
    switch (state) {
        case 1:
            stateStr = @"8";
            break;
        case 2:
            stateStr = @"2";
            break;
        case 3:
            stateStr = @"5";
            break;
        default:
            stateStr =@"1";
            break;
    }
    if(_followSeg.selectedSegmentIndex==-1){
        [MyUtil showMessage:@"请选择跟进类型"];
        return;
    }
    if([connectRecordCell.RecodeText.text isEqualToString:@""]){
        if(![stateStr isEqualToString:@"8"]){
            [MyUtil showMessage:@"请输入商谈内容摘要!"];
            return;
        }
    }
    if(_cidStr){
        [dic setObject:_cidStr forKey:@"cid"];
    }
    NSInteger followtag = _followSeg.selectedSegmentIndex;
    switch (followtag) {
        case 0:
            [dic setObject:@"去电" forKey:@"tracetype"];
            break;
        case 1:
            [dic setObject:@"来电" forKey:@"tracetype"];
            
            
            break;
        case 2:
            [dic setObject:@"到店" forKey:@"tracetype"];
            if(tag==0){
                [dic setObject:comeTimeCell.timeLal.text forKey:@"toShopDate"];
            }
            
            break;
        case 3:
            [dic setObject:@"试驾" forKey:@"tracetype"];
            
            //[dic setObject:comeTimeCell.timeLal.text forKey:@"toShopDate"];
            break;
        case 4:
            [dic setObject:@"上门拜访" forKey:@"tracetype"];
            
            //[dic setObject:comeTimeCell.timeLal.text forKey:@"toShopDate"];
            break;
        default:
            [dic setObject:@"微信" forKey:@"tracetype"];
            break;
    }
    [dic setObject:connectRecordCell.RecodeText.text==nil?@"":connectRecordCell.RecodeText.text forKey:@"rmrk"];
    [dic setObject:stateStr forKey:@"cstate"];
    [dic setObject:_cueModel.TARGET_CUST_ID forKey:@"custid"];
    [dic setObject:@"V" forKey:@"cmd"];
    [dic setObject:@"电话" forKey:@"contacttype"];
    [dic setObject:app.userModel.token forKey:@"token"];
    switch (tag) {
        case 0:
        {
            NSInteger levtag = cellTem.levSeg.selectedSegmentIndex;
            switch (levtag) {
                case 1:
                    [dic setObject:@"H" forKey:@"level"];
                    break;
                case 2:
                    [dic setObject:@"A" forKey:@"level"];
                    break;
                case 3:
                    [dic setObject:@"B" forKey:@"level"];
                    break;
                case 4:
                    [dic setObject:@"C" forKey:@"level"];
                    break;
                default:
                    [dic setObject:@"W" forKey:@"level"];
                    break;
            }
            
            [dic setObject:timeCell.timeLal.text forKey:@"forcastdate"];
            
        }
            
            break;
        case 1:
        {
            if([_isChange isEqualToString:@"0"] ){
                [dic setObject:connectRecordCell.RecodeText.text==nil?@"":connectRecordCell.RecodeText.text forKey:@"order_note"];
            }else{
                if([chooseWhyCell.detailTextLabel.text isEqualToString:@"请选择下订原因"]){
                    [MyUtil showMessage:@"请选择下订原因"];
                    return;
                }
                if([seriesDetailsCell.seriesDetailLal.text isEqualToString:@""]){
                    [MyUtil showMessage:@"请选择车型代码"];
                    return;
                }
                if([clolorCell.clolorLal.text isEqualToString:@""]){
                    [MyUtil showMessage:@"请选择车色"];
                    return;
                }
                [dic setObject:chooseWhyCell.detailTextLabel.text forKey:@"orderReason"];
                if (brandCell.brandSeg.selectedSegmentIndex==0){
                    [dic setObject:@"SEM" forKey:@"brandCode"];
                }else{
                    [dic setObject:@"MMC" forKey:@"brandCode"];
                }
                [dic setObject:seriesCell.seriesLal.text forKey:@"seriesCode"];
                [dic setObject:seriesDetailsCell.seriesDetailLal.text forKey:@"modelCode"];
                [dic setObject:clolorCell.clolorLal.text forKey:@"colorCode"];
            }
            //            [dic setObject:chooseWhyCell.detailTextLabel.text forKey:@"dreason"];
        }
            break;
        case 2:
        {
            if([chooseWhyCell.detailTextLabel.text isEqualToString:@"请选择战败原因"]){
                [MyUtil showMessage:@"请选择战败原因"];
                return;
            }
            if([chooseWhyCell.detailTextLabel.text rangeOfString:@"非本区域客户"].location != NSNotFound){
                //NSString *ssTT=followCell.regionTex.text;
                if(followCell.regionTex.text.length<1){
                    [MyUtil showMessage:@"请填写客户意向区域！"];
                    return;
                }else{
                    [dic setObject:followCell.regionTex.text forKey:@"intent_region"];
                }
            }
            [dic setObject:chooseWhyCell.detailTextLabel.text forKey:@"dreason"];
        }
            break;
        case 3:
        {
            if([chooseWhyCell.detailTextLabel.text isEqualToString:@"请选择无效原因"]){
                [MyUtil showMessage:@"请选择无效原因"];
                return;
            }
            if([chooseWhyCell.detailTextLabel.text isEqualToString:@"非本区域客户"]){
                //NSString *ssTT=followCell.regionTex.text;
                if(followCell.regionTex.text.length<1){
                    [MyUtil showMessage:@"请填写客户意向区域！"];
                    return;
                }else{
                    [dic setObject:followCell.regionTex.text forKey:@"intent_region"];
                }
                
            }
            [dic setObject:chooseWhyCell.detailTextLabel.text forKey:@"noreason"];
            
        }
            break;
        default:
            break;
    }
    [self commit:dic];
}
-(void)commit:(NSDictionary *)dic{
    [HttpManageTool insertNewCueFollow:dic success:^(BOOL isSuccess) {
        if(isSuccess){
            [self.navigationController popViewControllerAnimated:YES];
        }
        
    } failure:^(NSError *err) {
        
    }];
}
- (IBAction)typeChange:(UISegmentedControl *)sender {
    NSInteger tag = _stateSeg.selectedSegmentIndex;
    //stateTemp = _stateSeg.selectedSegmentIndex;
    switch (tag) {
        case 1:
            keyStr=@"okreason";
            stateTemp = _stateSeg.selectedSegmentIndex;
            break;
        case 2:
            if([self.cueModel.TSTATE isEqualToString:@"未联络"]){
                [self.stateSeg setSelectedSegmentIndex:stateTemp];
                [MyUtil showMessage:@"首次跟进不能选战败！"];
            }else{
                stateTemp = _stateSeg.selectedSegmentIndex;
                keyStr=@"dreason";
            }
            chooseWhyCell.detailTextLabel.text=@"请选择战败原因";
            break;
        case 3:
            
            if(![self.cueModel.TSTATE isEqualToString:@"未联络"]){
                [self.stateSeg setSelectedSegmentIndex:stateTemp];
                [MyUtil showMessage:@"非首次跟进不能选无效！"];
            }else{
                stateTemp = _stateSeg.selectedSegmentIndex;
                keyStr=@"noreason";
            }
            chooseWhyCell.detailTextLabel.text=@"请选择无效原因";
            break;
            
        default:
            keyStr=@"";
            stateTemp = _stateSeg.selectedSegmentIndex;
            break;
    }
    
    [self.tableView reloadData];
}
-(void)levChange:(UISegmentedControl *)sender {
    NSString *ss;
    switch (sender.selectedSegmentIndex) {
        case 1:
            ss=@"H";
            break;
        case 2:
            ss=@"A";
            break;
        case 3:
            ss=@"B";
            break;
        case 4:
            ss=@"C";
            break;
        default:
            ss=@"W";
            break;
    }
    timeCell.timeLal.text=[self getTime:ss];
}
- (void)setInitData{
    _userNameLal.text = _cueModel.cname;
    if([_cueModel.sex isEqualToString:@"男"]){
        [_sexImageView setImage:[UIImage imageNamed:@"businessman"]];
    }else{
        [_sexImageView setImage:[UIImage imageNamed:@"businesswoman"]];
    }
    int state =_cueModel.STATE.intValue;
    //    1-跟进中
    //    2.战败
    //    3.成交；
    //    5.无效
    //    8.下订
    switch (state) {
        case 2:
        {
            keyStr= @"dreason";
            [_stateSeg setSelectedSegmentIndex:2];
        }
            break;
            
        case 5:
            keyStr= @"noreason";
            [_stateSeg setSelectedSegmentIndex:3];
            break;
        case 8:
            keyStr=@"okreason";
            [_stateSeg setSelectedSegmentIndex:1];
            break;
        default:
        {
            [_stateSeg setSelectedSegmentIndex:0];
            
        }
            break;
    }
    stateTemp = _stateSeg.selectedSegmentIndex;
}
-(void)telCus{
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",_cueModel.mobile];
    //            NSLog(@"str======%@",str);
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
}
- (IBAction)followTypeChage:(UISegmentedControl *)sender {
    NSString *str=[sender titleForSegmentAtIndex:sender.selectedSegmentIndex];
    if([str isEqualToString:@"到店"]){
        isComeFlag  = true;
    }else{
        isComeFlag = false;
    }
    if([str isEqualToString:@"到店"]||[str isEqualToString:@"试驾"]){
        [_typeSeg setEnabled:NO forSegmentAtIndex:3];
    }else{
        [_typeSeg setEnabled:YES forSegmentAtIndex:3];
    }
    //chooseWhyCell.detailTextLabel.text=@"请选择无效原因";
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger tag = _stateSeg.selectedSegmentIndex;
    switch (tag) {
        case 0:
            if(isComeFlag){
                return 4;
            }else{
                return 3;
            }
            
            break;
        case 1:
            if([_isChange isEqualToString:@"0"] ){
                return 1;
            }else{
                return 5;
            }
            
            break;
        case 2:
            
            if([chooseWhyCell.detailTextLabel.text rangeOfString:@"非本区域客户"].location == NSNotFound||chooseWhyCell.detailTextLabel.text==nil){
                
                return 2;
            }else{
                NSRange ss=[chooseWhyCell.detailTextLabel.text rangeOfString:@"非本区域客户"];
                return 3;
            }
            break;
        case 3:
            if([chooseWhyCell.detailTextLabel.text isEqualToString:@"非本区域客户"]){
                return 3;
            }else{
                return 2;
            }
            
            break;
        default:
            break;
    }
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell=nil;
    NSInteger tag = _stateSeg.selectedSegmentIndex;
    switch (tag) {
            
        case 1:
        {
            if([_isChange isEqualToString:@"0"] ){
                if(indexPath.row==0){
                    cell = [tableView dequeueReusableCellWithIdentifier:@"ConnectRecordCell" forIndexPath:indexPath];
                    connectRecordCell=(ConnectRecordCell *)cell;
                }
                return cell;
            }else{
                if(indexPath.row==0){
                    cell = [tableView dequeueReusableCellWithIdentifier:@"ChooseWhyCell" forIndexPath:indexPath];
                    chooseWhyCell = cell;
                    chooseWhyCell.textLabel.text =@"下订原因";
                    chooseWhyCell.detailTextLabel.text=@"请选择下订原因";
                    
                }
                if(indexPath.row==1){
                    cell = [tableView dequeueReusableCellWithIdentifier:@"XDbrandCell" forIndexPath:indexPath];
                    brandCell=(XDbrandCell *)cell;
                    [brandCell.brandSeg addTarget:self action:@selector(carsChangeAct:) forControlEvents:UIControlEventValueChanged];
                }
                if(indexPath.row==2){
                    cell = [tableView dequeueReusableCellWithIdentifier:@"XDseriesCell" forIndexPath:indexPath];
                    seriesCell=(XDseriesCell *)cell;
                    
                }
                
                if(indexPath.row==3){
                    cell = [tableView dequeueReusableCellWithIdentifier:@"XDseriesDetailsCell" forIndexPath:indexPath];
                    seriesDetailsCell=(XDseriesDetailsCell *)cell;
                    
                }
                if(indexPath.row==4){
                    cell = [tableView dequeueReusableCellWithIdentifier:@"XDclolorCell" forIndexPath:indexPath];
                    clolorCell=(XDclolorCell *)cell;
                    [clolorCell.chooseClolorBtn addTarget:self action:@selector(chooseClolor:) forControlEvents:UIControlEventTouchUpInside];
                }
                return cell;
            }
            
            break;
        }
            
        case 2:
        {
            if([chooseWhyCell.detailTextLabel.text rangeOfString:@"非本区域客户"].location != NSNotFound){
                
                if(indexPath.row==0){
                    cell = [tableView dequeueReusableCellWithIdentifier:@"ChooseWhyCell" forIndexPath:indexPath];
                    chooseWhyCell = cell;
                    chooseWhyCell.textLabel.text =@"战败原因";
                    if(chooseWhyCell.detailTextLabel.text.length<1){
                        chooseWhyCell.detailTextLabel.text=@"请选择战败原因";
                    }
                }else if(indexPath.row==1){
                    cell = [tableView dequeueReusableCellWithIdentifier:@"FollowTypeCell" forIndexPath:indexPath];
                    followCell=(FollowTypeCell *)cell;
                }else{
                    cell = [tableView dequeueReusableCellWithIdentifier:@"ConnectRecordCell" forIndexPath:indexPath];
                    connectRecordCell=(ConnectRecordCell *)cell;
                }
                return cell;
            }else{
                if(indexPath.row==0){
                    cell = [tableView dequeueReusableCellWithIdentifier:@"ChooseWhyCell" forIndexPath:indexPath];
                    chooseWhyCell = cell;
                    chooseWhyCell.textLabel.text =@"战败原因";
                    if(chooseWhyCell.detailTextLabel.text.length<1){
                        chooseWhyCell.detailTextLabel.text=@"请选择战败原因";
                    }
                }else{
                    cell = [tableView dequeueReusableCellWithIdentifier:@"ConnectRecordCell" forIndexPath:indexPath];
                    connectRecordCell=(ConnectRecordCell *)cell;
                }
                return cell;
            }
            
            break;
        }
            
        case 3:
        {
            if([chooseWhyCell.detailTextLabel.text isEqualToString:@"非本区域客户"]){
                if(indexPath.row==0){
                    cell = [tableView dequeueReusableCellWithIdentifier:@"ChooseWhyCell" forIndexPath:indexPath];
                    chooseWhyCell = cell;
                    chooseWhyCell.textLabel.text =@"无效原因";
                    //chooseWhyCell.detailTextLabel.text=@"请选择无效原因";
                }else if(indexPath.row==1){
                    cell = [tableView dequeueReusableCellWithIdentifier:@"FollowTypeCell" forIndexPath:indexPath];
                    followCell=(FollowTypeCell *)cell;
                }else{
                    cell = [tableView dequeueReusableCellWithIdentifier:@"ConnectRecordCell" forIndexPath:indexPath];
                    connectRecordCell=(ConnectRecordCell *)cell;
                }
                return cell;
            }else{
                if(indexPath.row==0){
                    cell = [tableView dequeueReusableCellWithIdentifier:@"ChooseWhyCell" forIndexPath:indexPath];
                    chooseWhyCell = cell;
                    chooseWhyCell.textLabel.text =@"无效原因";
                    if(chooseWhyCell.detailTextLabel.text.length<1){
                        chooseWhyCell.detailTextLabel.text=@"请选择无效原因";
                    }
                    //
                }else{
                    cell = [tableView dequeueReusableCellWithIdentifier:@"ConnectRecordCell" forIndexPath:indexPath];
                    connectRecordCell=(ConnectRecordCell *)cell;
                }
                return cell;
            }
            
            break;
        }
            
        default:
        {
            if(isComeFlag){
                if(indexPath.row==0){
                    cell = [tableView dequeueReusableCellWithIdentifier:@"ComeTimeChooseCell" forIndexPath:indexPath];
                    comeTimeCell =  (TimeChooseCell * )cell;
                    comeTimeCell.timeLal.text=nowTimeStr;
                }
                else if(indexPath.row==1){
                    cell = [tableView dequeueReusableCellWithIdentifier:@"ConnectLevelStateCell" forIndexPath:indexPath];
                    cellTem = (ConnectLevelStateCell *)cell;
                    NSString *lev =_cueModel.level;
                    if([lev isEqualToString:@"H"]){
                        [cellTem.levSeg setSelectedSegmentIndex:1];
                    }else if([lev isEqualToString:@"A"]){
                        [cellTem.levSeg setSelectedSegmentIndex:2];
                    }else if([lev isEqualToString:@"B"]){
                        [cellTem.levSeg setSelectedSegmentIndex:3];
                    }else if([lev isEqualToString:@"C"]){
                        [cellTem.levSeg setSelectedSegmentIndex:4];
                    }else{
                        [cellTem.levSeg setSelectedSegmentIndex:0];
                    }
                    [cellTem.levSeg addTarget:self action:@selector(levChange:) forControlEvents:UIControlEventValueChanged];
                }else if ( indexPath.row==2 ){
                    cell = [tableView dequeueReusableCellWithIdentifier:@"ConnectRecordCell" forIndexPath:indexPath];
                    connectRecordCell=(ConnectRecordCell *)cell;
                    if(_isCall){
                        NSString *rmrk = @"";
                        connectRecordCell.RecodeText.text=rmrk;
                    }
                    
                }else{
                    cell = [tableView dequeueReusableCellWithIdentifier:@"TimeChooseCell" forIndexPath:indexPath];
                    timeCell =  (TimeChooseCell * )cell;
                    NSString *lev =_cueModel.level;
                    timeCell.timeLal.text=[self getTime:lev];
                }
            }else{
                if(indexPath.row==0){
                    cell = [tableView dequeueReusableCellWithIdentifier:@"ConnectLevelStateCell" forIndexPath:indexPath];
                    cellTem = (ConnectLevelStateCell *)cell;
                    NSString *lev =_cueModel.level;
                    if([lev isEqualToString:@"H"]){
                        [cellTem.levSeg setSelectedSegmentIndex:1];
                    }else if([lev isEqualToString:@"A"]){
                        [cellTem.levSeg setSelectedSegmentIndex:2];
                    }else if([lev isEqualToString:@"B"]){
                        [cellTem.levSeg setSelectedSegmentIndex:3];
                    }else if([lev isEqualToString:@"C"]){
                        [cellTem.levSeg setSelectedSegmentIndex:4];
                    }else{
                        [cellTem.levSeg setSelectedSegmentIndex:0];
                    }
                    [cellTem.levSeg addTarget:self action:@selector(levChange:) forControlEvents:UIControlEventValueChanged];
                }else if ( indexPath.row==1 ){
                    cell = [tableView dequeueReusableCellWithIdentifier:@"ConnectRecordCell" forIndexPath:indexPath];
                    connectRecordCell=(ConnectRecordCell *)cell;
                    if(_isCall){
                        NSString *rmrk = @"";
                        connectRecordCell.RecodeText.text=rmrk;
                    }
                    
                }else{
                    cell = [tableView dequeueReusableCellWithIdentifier:@"TimeChooseCell" forIndexPath:indexPath];
                    timeCell =  (TimeChooseCell * )cell;
                    NSString *lev =_cueModel.level;
                    timeCell.timeLal.text=[self getTime:lev];
                }
            }
            
            
            
            return cell;
            break;
        }
            
    }
    
}
-(NSString *)getTime:(NSString *)lev{
    
    
    
    NSDate *nowDate = [NSDate date];
    NSDateFormatter *dateFormatter =[[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd kk:mm:ss"];
    NSTimeInterval  interval1 =1*24*60*60;
    NSDate *date= [nowDate initWithTimeIntervalSinceNow:+interval1];
    NSString *timeStr=[dateFormatter stringFromDate:date];;
    for (LevelModel *model in _cueModel.level_detail) {
        if([model.inteval isEqualToString:lev]){
            NSTimeInterval  interval =model.dealerCode.intValue*24*60*60; //1:天数
            NSDate *date1= [nowDate initWithTimeIntervalSinceNow:+interval];
            timeStr =[dateFormatter stringFromDate:date1];
            break;
        }
    }
    
    
    return timeStr;
}
//设置cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger tag = _stateSeg.selectedSegmentIndex;
    switch (tag) {
        case 1:
            if([_isChange isEqualToString:@"0"] ){
                return 232;
            }else{
                return 44;
            }
            
            break;
            
        case 2:
            
            if([chooseWhyCell.detailTextLabel.text rangeOfString:@"非本区域客户"].location != NSNotFound){
                if(indexPath.row==2){
                    return 232;
                }
                return 44;
            }else{
                if(indexPath.row==1){
                    return 232;
                }
                return 44;
            }
            break;
        case 3:
            if([chooseWhyCell.detailTextLabel.text isEqualToString:@"非本区域客户"]){
                if(indexPath.row==2){
                    return 232;
                }
                return 44;
            }else{
                if(indexPath.row==1){
                    return 232;
                }
                return 44;
            }
            
            break;
        default:
        {
            if(isComeFlag){
                if(indexPath.row==2){
                    return 232;
                }
                else {
                    return 44;
                }
            }else{
                if(indexPath.row==1){
                    return 232;
                }
                else {
                    return 44;
                }
            }
            
        }
            break;
    }
    
    
}
- (IBAction)carsChangeAct:(UISegmentedControl *)sender {
    NSInteger falg = sender.selectedSegmentIndex;
    switch (falg) {
        case 0:
            seriesCell.seriesLal.text = @"DX7";
            seriesDetailsCell.seriesDetailLal.text=@"";
            clolorCell.clolorLal.text =@"";
            break;
        case 1:
            seriesCell.seriesLal.text = @"GS";
            seriesDetailsCell.seriesDetailLal.text=@"";
            clolorCell.clolorLal.text =@"";
            break;
        default:
            break;
    }
}
-(void)chooseReson:(NSString *)reson{
    if(reson.length>0){
        NSInteger state =_stateSeg.selectedSegmentIndex;
        chooseWhyCell.detailTextLabel.text=reson;
        if(state==3||state==2){
            [self.tableView reloadData];
        }
        
    }
    
}
-(void)updataTimeInfo:(NSString *)chooseCars{
    if(isComeTime){
        comeTimeCell.timeLal.text =chooseCars;
    }else{
        timeCell.timeLal.text =chooseCars;
    }
    
}
-(void)chooseClolor:(UIButton *)btn{
    
    if ([seriesDetailsCell.seriesDetailLal.text isEqualToString:@""]){
        [MyUtil showMessage:@"请选择车型代码"];
        return;
    }else{
        NSString *ss;
        if (brandCell.brandSeg.selectedSegmentIndex==0){
            ss=@"SEM";
        }else{
            ss=@"MMC";
        }
        
        AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        NSDictionary *dic =@{@"token":app.userModel.token,@"brandCode":ss,@"seriesCode":seriesCell.seriesLal.text,@"modelCode":seriesDetailsCell.seriesDetailLal.text};
        [colorArr removeAllObjects];
        
        [HttpManageTool selectSeriesColorList:dic success:^(NSArray *colorList) {
            [colorArr addObjectsFromArray:colorList];
            MHActionSheet *actionSheet = [[MHActionSheet alloc] initSheetWithTitle:nil style:MHSheetStyleWeiChat itemTitles:colorArr];
            //            __weak typeof(self) weakSelf = self;
            [actionSheet didFinishSelectIndex:^(NSInteger index, NSString *title) {
                clolorCell.clolorLal.text=title;
                
            }];
            
        } failure:^(NSError *err) {
            
        }];
    }
}
-(void)chooseSeriesCode:(NSString *)seriesCode{
    seriesDetailsCell.seriesDetailLal.text = seriesCode;
    clolorCell.clolorLal.text =@"";
    
}
-(void)updataCarsInfo:(NSString *)chooseCars{
    seriesCell.seriesLal.text = [MyUtil getSeriesCode:chooseCars];
    seriesDetailsCell.seriesDetailLal.text = @"";
    clolorCell.clolorLal.text =@"";
}
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    UIViewController * view = segue.destinationViewController;
    if(comeTimeCell==sender){
        if ([view respondsToSelector:@selector(setTypeStr:)]) {
            [view setValue:@"A" forKey:@"typeStr"];
            isComeTime =true;
        }
        
    }else{
        isComeTime =false;
    }
    if ([view respondsToSelector:@selector(setKeyStr:)]) {
        [view setValue:keyStr forKey:@"keyStr"];
    }
    if ([view respondsToSelector:@selector(setIsSem:)]) {
        [view setValue:self.cueModel.FROM_FLAG forKey:@"isSem"];
    }
    if ([view respondsToSelector:@selector(setDelegate:)]) {
        [view setValue:self forKey:@"delegate"];
    }
    
    if ([view respondsToSelector:@selector(setBrand:)]) {
        if (brandCell.brandSeg.selectedSegmentIndex==0){
            [view setValue:@"SEM" forKey:@"brand"];
        }else{
            [view setValue:@"MMC" forKey:@"brand"];
        }
        
    }
    if ([view respondsToSelector:@selector(setSeries:)]) {
        [view setValue:seriesCell.seriesLal.text forKey:@"series"];
    }
    if ([view respondsToSelector:@selector(setTypeD:)]) {
        [view setValue:@"D" forKey:@"typeD"];
    }
    if ([view respondsToSelector:@selector(setCars:)]) {
        NSInteger falg = brandCell.brandSeg.selectedSegmentIndex;
        switch (falg) {
            case 0:
                [view setValue:@"SEM" forKey:@"cars"];
                break;
            case 1:
                [view setValue:@"MMC" forKey:@"cars"];
                break;
            default:
                break;
        }
        
    }
}


@end
