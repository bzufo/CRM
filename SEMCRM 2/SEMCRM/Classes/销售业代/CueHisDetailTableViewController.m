//
//  CueHisDetailTableViewController.m
//  SEMCRM
//
//  Created by Sem on 2018/3/2.
//  Copyright © 2018年 sem. All rights reserved.
//

#import "CueHisDetailTableViewController.h"
#import "AttenceTimelineCell.h"
#import "SemCRMCueContentViewController.h"
#import "CueInfoCell.h"
#import <MessageUI/MessageUI.h>
#import "MsgTemplateChoiceView.h"
#import "CueList.h"
#import "ConnectModel.h"
#import "SemCRMMaintenanceForConnectViewController.h"
#import <MediaPlayer/MediaPlayer.h>
@interface CueHisDetailTableViewController ()
{
    UIWebView *callWebview;
}
@property (strong, nonatomic)MPVolumeView *volumeView ;
@end

@implementation CueHisDetailTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    callWebview =[[UIWebView alloc] init];
    
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    //callWebview =[[UIWebView alloc] init];
    // Dispose of any resources that can be recreated.
}
#pragma mark - UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _cueModel.data_detail.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    
    return 1;
}
//设置cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
        NSArray *arr = _cueModel.data_detail;
        ConnectModel *connectModel=arr[indexPath.row];
        
        NSString *ss =[NSString stringWithFormat:@"%@(%@%@%@)\n%@",connectModel.CREATE_DATE,[connectModel.CONTACT_TYPE isEqualToString:@"短信"]?@"短信":connectModel.TRACE_TYPE,[MyUtil getOvertime:connectModel.DURATION_R],[MyUtil getOvertime:connectModel.DURATION],connectModel.REMARK];
        return [AttenceTimelineCell cellHeightWithString:ss isContentHeight:NO];
    
    
}
- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
        return  @"联系记录";
    
}

#define TableViewCellID @"TableViewCellID"
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
        AttenceTimelineCell * cell = [tableView dequeueReusableCellWithIdentifier:TableViewCellID];
        NSArray *arr = _cueModel.data_detail;
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
    
    
    //[cell borderColor:[UIColor orangeColor] borderWidth:1 cornerRadius:0];
    
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
    NSArray *arr = _cueModel.data_detail;
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
-(void)clearVedio{
    NSURL *url = [NSURL URLWithString:@""];//创建URL
    NSURLRequest* request = [NSURLRequest requestWithURL:url];//创建
    [callWebview loadRequest:request];
}


@end
