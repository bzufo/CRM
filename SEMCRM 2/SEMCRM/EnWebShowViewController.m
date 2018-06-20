//
//  EnWebShowViewController.m
//  SEMCRM
//
//  Created by Sem on 2017/7/19.
//  Copyright © 2017年 sem. All rights reserved.
//
#import "AFHttpTool.h"
#import "EnWebShowViewController.h"

@interface EnWebShowViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@end

@implementation EnWebShowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    _webView.backgroundColor = [UIColor whiteColor];
    _webView.opaque = NO;
    [self initData];
    // Do any additional setup after loading the view.
}
-(void)initData{
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSString *urlStr;
    if(_urlShow!=nil&&_urlShow.length>0){
        urlStr = _urlShow;
    }else{
        urlStr=[NSString stringWithFormat:@"%@ttYearPartyVoteAction.do?action=delete&token=%@&contenttype=%@&showtype=inline&id=%@",SEM_SERVER_UP,app.userModel.token,_contenttype,_fileId];
    }
    
    NSURL *url = [[NSURL alloc]initWithString:urlStr];
    
    [_webView loadRequest:[NSURLRequest requestWithURL:url]];
   
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
