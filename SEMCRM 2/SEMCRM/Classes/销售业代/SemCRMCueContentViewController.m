//
//  SemCRMCueContentViewController.m
//  SEMCRM
//
//  Created by sem on 16/2/21.
//  Copyright © 2016年 sem. All rights reserved.
//
#import "AttenceTimelineCell.h"
#import "SemCRMCueContentViewController.h"
#import "CueInfoCell.h"
#import <MessageUI/MessageUI.h>
#import "MsgTemplateChoiceView.h"
#import "CueList.h"
#import "ConnectModel.h"
#import <MediaPlayer/MediaPlayer.h>
#import "SemCRMMaintenanceForConnectViewController.h"
@interface SemCRMCueContentViewController ()<UITableViewDataSource,UITableViewDelegate,MFMessageComposeViewControllerDelegate,MsgTemplateChoiceDelegate>
{
    CueList *cueModel;
    UIWebView *callWebview;
    bool iszx;
}
@property (weak, nonatomic) IBOutlet UIButton *lxBtn;
@property (strong, nonatomic)MPVolumeView *volumeView ;
@end

@implementation SemCRMCueContentViewController
- (MPVolumeView *)volumeView{
    if(_volumeView==nil){
        MPVolumeView *volumeView   = [[MPVolumeView alloc] init];
        _volumeView=volumeView;
    }
    return _volumeView;
}
-(void)upVodio{
    UISlider *volumeViewSlider = nil;
    for (UIView *view in [self.volumeView subviews]) {
        if ([view.class.description isEqualToString:@"MPVolumeSlider"]) {
            volumeViewSlider = (UISlider *)view;
            break;
        }
    }
    self.volumeView.frame = CGRectMake(-1000, -100, 100, 100);
    volumeViewSlider.frame = CGRectMake(-1000, -100, 100, 100);
    // change system volume, the value is between 0.0f and 1.0f
    if(volumeViewSlider.value<=0.5){
        [volumeViewSlider setValue:1.0f animated:NO];
    }
    
    
    // send UI control event to make the change effect right now. 立即生效
    [volumeViewSlider sendActionsForControlEvents:UIControlEventTouchUpInside];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    callWebview =[[UIWebView alloc] init];
    
    //[self upVodio];
    
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self getData];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self clearVedio];
}
- (void)getData{
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSDictionary *dic = @{@"custid":_custid,@"token":app.userModel.token};
    cueModel=nil;
    [HttpManageTool selectCueInfo:dic success:^(CueList *cueModelTemp) {
        if(cueModelTemp){
            cueModel = cueModelTemp;
            if([cueModel.TSTATE isEqualToString:@"无效"]||[cueModel.TSTATE isEqualToString:@"已战败"]){
                [self.lxBtn setEnabled:false];
            }else{
                [self.lxBtn setEnabled:YES];
            }
            [self.tableView reloadData];
        }else{
            [self.navigationController popViewControllerAnimated:YES];
        }
    } failure:^(NSError *err) {
        
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   
    if(section==1){
        return cueModel.data_detail.count;
    }
    return 1;
    
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    if(cueModel){
        if(cueModel.data_detail){
            if(cueModel.data_detail.count>0){
                return 2;
            }
        }
        
    }
    return 1;
}
//设置cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section==0){
        return 225;
    }else{
        NSArray *arr = cueModel.data_detail;
        ConnectModel *connectModel=arr[indexPath.row];

        NSString *ss =[NSString stringWithFormat:@"%@(%@%@%@)\n%@",connectModel.CREATE_DATE,[connectModel.CONTACT_TYPE isEqualToString:@"短信"]?@"短信":connectModel.TRACE_TYPE,[MyUtil getOvertime:connectModel.DURATION_R],[MyUtil getOvertime:connectModel.DURATION],connectModel.REMARK];
        
        
        return [AttenceTimelineCell cellHeightWithString:ss isContentHeight:NO];
    }
    
}
- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if(section==0){
        return  @"线索信息";
    }else{
        return  @"联系记录";
    }
}

#define TableViewCellID @"TableViewCellID"
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.section==0){
        CueInfoCell * cell = [tableView dequeueReusableCellWithIdentifier:@"CueInfoCell"];
        [cell configureCell:cueModel];
        return cell;
    }else{
        AttenceTimelineCell * cell = [tableView dequeueReusableCellWithIdentifier:TableViewCellID];
        NSArray *arr = cueModel.data_detail;
        ConnectModel *connectModel=arr[indexPath.row];
        bool isFirst=false;
        
        if([connectModel.COLOR isEqualToString:@"1"]){
            isFirst=true;
        }
        //bool isFirst = indexPath.row == 0;
        bool isLast = indexPath.row == arr.count - 1;
        
        NSString *ss =[NSString stringWithFormat:@"%@(%@%@%@)\n%@",connectModel.CREATE_DATE,[connectModel.CONTACT_TYPE isEqualToString:@"短信"]?@"短信":connectModel.TRACE_TYPE,[MyUtil getOvertime:connectModel.DURATION_R],[MyUtil getOvertime:connectModel.DURATION],connectModel.REMARK];
        
        
        if(connectModel.CID && connectModel.CID.length>1 && connectModel.DURATION_R && connectModel.DURATION_R.integerValue>0){
          [cell setDataSource:ss isFirst:isFirst isLast:isLast showL:YES];
          [cell.showLab addTarget:self action:@selector(showSoundRecord:event:) forControlEvents:UIControlEventTouchUpInside];
        }else{
          [cell setDataSource:ss isFirst:isFirst isLast:isLast showL:false];
            
        }
        
        
        return cell;
    }
    
    //[cell borderColor:[UIColor orangeColor] borderWidth:1 cornerRadius:0];
    
}
-(void)clearVedio{
    NSURL *url = [NSURL URLWithString:@""];//创建URL
    NSURLRequest* request = [NSURLRequest requestWithURL:url];//创建
    [callWebview loadRequest:request];
    
}
- (void)showSoundRecord:(UIButton *)button event:(id)event{
    //    [self.contentView addSubview:self.moreView];
    [self clearVedio];
    
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSSet *touches = [event allTouches];
    UITouch *touch = [touches anyObject];
    CGPoint currentTouchPosition = [touch locationInView:self.tableView];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint: currentTouchPosition];
     NSArray *arr = cueModel.data_detail;
    ConnectModel *connectModel=arr[indexPath.row];
    NSString *passwordBase64=[MyUtil getUserInfo].spepwd;
    NSData *data = [[NSData alloc]initWithBase64EncodedString:passwordBase64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
    __weak typeof(self) weakSelf = self;
    NSString *password = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSDictionary *dic =@{@"name":[MyUtil getUserInfo].spename,@"password":password};
    [HttpManageTool get360Token:dic success:^(NSString *token) {
        if(token){
            NSLog(token);
            app.smart360Token = token;
            NSDictionary *dic1 =@{@"cid":connectModel.CID};
            [HttpManageTool getIpInfo:dic1 success:^(NSDictionary *dic) {
                 NSString *urlstr=@"";
                if(dic){
                    if(dic[@"url"]){
                        urlstr=dic[@"url"];
                    }
                }
                [weakSelf upVodio];
                NSURL *url = [NSURL URLWithString:urlstr];//创建URL
                NSURLRequest* request = [NSURLRequest requestWithURL:url];
                //创建
                [callWebview loadRequest:request];
                
            } failure:^(NSError *err) {
                
            }];
        }
    } failure:^(NSError *err) {
        [MyUtil showMessage:@"获取平台电话失败"];
    }];
    
}

- (IBAction)telPhoneAct:(UIButton *)sender {
    if( ![self isTypeRightTwo]){
        [MyUtil showMessage:@"无效，已战败的线索不能继续跟进！"];
        return;
    }
        [self clearVedio];
        if([[MyUtil getUserInfo].is_open isEqualToString:@"1"]){
            iszx =true;
            if([MyUtil isValidateTelephone:cueModel.mobile]){
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:[NSString stringWithFormat:@"%@\n%@",cueModel.mobile,@"是否进行专线拨打?"] delegate:self
                                                          cancelButtonTitle:@"确定"
                                                          otherButtonTitles:@"取消", nil];
                [alertView show];
            }
            
        }else{
            iszx =false;
            if([MyUtil isValidateTelephone:cueModel.mobile]){
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"是否拨打用户电话" delegate:self
                                                          cancelButtonTitle:@"确定"
                                                          otherButtonTitles:@"取消", nil];
                [alertView show];
            }
        }
    
    
    
    
    //lxjlId
    /*
    if([MyUtil isValidateTelephone:cueModel.mobile]){
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"是否拨打用户电话" delegate:self
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:@"取消", nil];
        [alertView show];
    }
    */
}
-(void)callZX{
    NSString *passwordBase64=[MyUtil getUserInfo].spepwd;
    NSData *data = [[NSData alloc]initWithBase64EncodedString:passwordBase64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
    
    NSString *password = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSDictionary *dic =@{@"name":[MyUtil getUserInfo].spename,@"password":password};
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [app startLoading];
    [HttpManageTool get360Token:dic success:^(NSString *token) {
        
        if(token){
            NSLog(token);
            app.smart360Token = token;
            NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
            [formatter setDateFormat:@"yyyyMMddHHmmss"];//自定义时间格式
            NSString *currentDateStr = [formatter stringFromDate:[NSDate date]];
            
            NSString *cidStr=[NSString stringWithFormat:@"%@%@",currentDateStr,app.userModel.s_mobile];
            //app.userModel.s_mobile
            NSDictionary *dic1 =@{@"cid":cidStr,@"dealerId":app.userModel.line_unit,@"caller":app.userModel.s_mobile,@"callee":cueModel.mobile};
            [HttpManageTool callPhone360:dic1 success:^(BOOL issuccess) {
                [app stopLoading];
                if(issuccess){
                    SemCRMMaintenanceForConnectViewController *viewController = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]]instantiateViewControllerWithIdentifier:@"lxjlId"];
                    viewController.isCall = YES;
                    viewController.cueModel=cueModel;
                    viewController.cidStr=cidStr;
                    if(![self isTypeRight]){
                        viewController.isChange=@"0";
                    }
                    [self.navigationController pushViewController:viewController animated:YES];
                }
            } failure:^(NSError *err) {
                [app stopLoading];
            }];
        }
    } failure:^(NSError *err) {
        [app stopLoading];
        [MyUtil showMessage:@"获取平台电话失败"];
    }];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if(buttonIndex==0){
        if(iszx){
            [self callZX];
        }else{
            SemCRMMaintenanceForConnectViewController *viewController = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]]instantiateViewControllerWithIdentifier:@"lxjlId"];;
            viewController.isCall = YES;
            viewController.cueModel=cueModel;
            if(![self isTypeRight]){
                viewController.isChange=@"0";
            }
            //viewController.cidStr=cidStr;
            [self.navigationController pushViewController:viewController animated:YES];
        }
        
    }else{
        //[MyUtil showMessage:@"无效，已战败的线索不能继续跟进！"];
    }
}
- (IBAction)sendMessageAct:(UIButton *)sender {
    if( [self isTypeRightTwo]){
        [self clearVedio];
        if(cueModel){
            MsgTemplateChoiceView *msgView = [[MsgTemplateChoiceView alloc]initWithNibName:@"MsgTemplateChoiceView" bundle:nil];
            msgView.cueModel=cueModel;
            msgView.delegate=self;
            msgView.view.backgroundColor=[UIColor colorWithWhite:0 alpha:0.4];
            msgView.modalPresentationStyle = UIModalPresentationOverFullScreen;
            
            [self presentViewController:msgView animated:YES completion:^(void){
                msgView.view.superview.backgroundColor = [UIColor clearColor];
                
            }];
        }
    }else{
        [MyUtil showMessage:@"无效，已战败的线索不能继续跟进！"];
    }
    
    
    
    /*
         */
}
-(void)chooseMsgTemplate:(NSString *)msg{
    
    
    if( [MFMessageComposeViewController canSendText] )
    {
        if([MyUtil isValidateTelephone:cueModel.mobile]){
        MFMessageComposeViewController * controller = [[MFMessageComposeViewController alloc] init];
        controller.recipients = @[cueModel.mobile];
//        controller.recipients = @[cueModel.mobile];
        controller.navigationBar.tintColor = [UIColor redColor];
        controller.body = msg;
        controller.messageComposeDelegate = self;
        [
         self presentViewController:controller animated:YES completion:nil];
        [[[[controller viewControllers] lastObject] navigationItem] setTitle:@"发送短信"];//修改短信界面标题
        }
    }
    else
    {
         UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示信息"
                                                        message:@"该设备不支持短信功能"
                                                       delegate:nil
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil, nil];
        [alert show];
    }
}
- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result{
    __weak __typeof(self)weakSelf = self;
    [controller dismissViewControllerAnimated:NO completion:^{
        
        if(result==MessageComposeResultSent){
//            [MyUtil showMessage:@"发送成功"];
             [weakSelf upSendMsg:controller.body];
        }else{
//            [weakSelf upSendMsg];
//            [MyUtil showMessage:@"取消"];
            
        }
        
    }];
    
}
-(BOOL)isTypeRight{
    
    if([cueModel.TSTATE isEqualToString:@"待下订"]||[cueModel.TSTATE isEqualToString:@"已转订单"]){
        return false;
    }else{
        return true;
    }
    
}
-(BOOL)isTypeRightTwo{
    
    if([cueModel.TSTATE isEqualToString:@"无效"]||[cueModel.TSTATE isEqualToString:@"已战败"]){
        return false;
    }else{
        return true;
    }
    
}
-(void)upSendMsg:(NSString *)msg{
//    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc]init];
//    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//    NSString *dateStr= [dateFormatter stringFromDate:[NSDate new ]];
     __weak __typeof(self)weakSelf = self;
    NSString *rmrk = msg;
     AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
//    [MyUtil showMessage:cueModel.TARGET_CUST_ID];
    NSDictionary *dic =@{@"custid":weakSelf.custid,@"cmd":@"V",@"cstate":@"1",@"contacttype":@"短信",@"rmrk":rmrk,@"token":app.userModel.token};
    
    [HttpManageTool insertNewCueFollow:dic success:^(BOOL isSuccess) {
        if(isSuccess){
            [weakSelf getData];
        }
        
    } failure:^(NSError *err) {
        
    }];
    
}
#pragma mark - Navigation
- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(nullable id)sender{
    if([self isTypeRightTwo]){
        return YES;
    }else{
        [MyUtil showMessage:@"无效，已战败的线索不能继续跟进！"];
        return false;
    }
}
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    UIViewController * view = segue.destinationViewController;
    if ([view respondsToSelector:@selector(setCueModel:)]) {
        [view setValue:cueModel forKey:@"cueModel"];
    }
    if ([view respondsToSelector:@selector(setDelegate:)]) {
        [view setValue:self forKey:@"delegate"];
    }
    if ([view respondsToSelector:@selector(setIsChange:)]) {
        if( [self isTypeRight]){
             [view setValue:@"1" forKey:@"isChange"];
        }else{
            [view setValue:@"0" forKey:@"isChange"];
        }
       
    }
    
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
