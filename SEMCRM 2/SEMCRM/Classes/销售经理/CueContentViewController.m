//
//  CueContentViewController.m
//  SEMCRM
//
//  Created by 薛斯岐 on 16/2/24.
//  Copyright © 2016年 sem. All rights reserved.
//

#import "CueContentViewController.h"
#import "CueInfoCell.h"
#import "AttenceTimelineCell.h"
#import "CueList.h"
#import "ConnectModel.h"
#import "ChooseYDViewController.h"
#import <MediaPlayer/MediaPlayer.h>
@interface CueContentViewController ()<ChooseYDDelegate>

{
    CueList *cueModel;
    UIWebView *callWebview;
}
@property (strong, nonatomic)MPVolumeView *volumeView ;
@end

@implementation CueContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     callWebview =[[UIWebView alloc] init];
    
    // Do any additional setup after loading the view.
}
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
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self clearVedio];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self getData];
}
- (void)getData{
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSDictionary *dic = @{@"custid":_custid,@"token":app.userModel.token};
    [HttpManageTool selectCueInfo:dic success:^(CueList *cueModelTemp) {
        if(cueModelTemp){
            cueModel = cueModelTemp;
            [self.tableView reloadData];
        }else{
            
        }
    } failure:^(NSError *err) {
        
    }];
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
        return 239;
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
        bool isLast = indexPath.row == arr.count - 1;
        if([connectModel.COLOR isEqualToString:@"1"]){
            isFirst=true;
        }
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
    __weak typeof(self) weakSelf = self;
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSSet *touches = [event allTouches];
    UITouch *touch = [touches anyObject];
    CGPoint currentTouchPosition = [touch locationInView:self.tableView];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint: currentTouchPosition];
    NSArray *arr = cueModel.data_detail;
    ConnectModel *connectModel=arr[indexPath.row];
    NSString *passwordBase64=[MyUtil getUserInfo].spepwd;
    NSData *data = [[NSData alloc]initWithBase64EncodedString:passwordBase64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
    
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
                NSURLRequest* request = [NSURLRequest requestWithURL:url];//创建
                [callWebview loadRequest:request];
            } failure:^(NSError *err) {
                
            }];
        }
    } failure:^(NSError *err) {
        [MyUtil showMessage:@"获取平台电话失败"];
    }];
    
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
-(void)chooseYD:(NSString *)users{
    
   
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSDictionary *dic=@{@"token":app.userModel.token,@"custids":cueModel.TARGET_CUST_ID,@"saleids":users,@"sendFlag":_sendFlag};
    [HttpManageTool updataCueForMT:dic success:^(BOOL isSuccess) {
        if(isSuccess){
            
            [self getData];
            
        }
    } failure:^(NSError *err) {
        [MyUtil showMessage:@"保存出错！"];
    }];
}

- (IBAction)againDisAct:(UIButton *)sender {
    [self clearVedio];
    ChooseYDViewController *viewController = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]]instantiateViewControllerWithIdentifier:@"chooseYDId"];
    viewController.delegate = self;
    [self.navigationController pushViewController:viewController animated:YES];
}

- (IBAction)telAct:(UIButton *)sender {
    [self clearVedio];
    if([MyUtil isValidateTelephone:cueModel.mobile]){
        NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",cueModel.mobile];
        //            NSLog(@"str======%@",str);
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];

    }
    
}
@end
