//
//  OrderCarViewController.m
//  SEMCRM
//
//  Created by 薛斯岐 on 16/4/1.
//  Copyright © 2016年 sem. All rights reserved.
//

#import "OrderCarViewController.h"
#import "AFHttpTool.h"
@interface OrderCarViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation OrderCarViewController

- (void)viewDidLoad {
        [super viewDidLoad];
    NSString *urtStr=@"";
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    if([_type isEqualToString:@"1"]){
        self.title = @"订交日报表(顾问)";
        urtStr = [NSString stringWithFormat:@"%@get_report_dingjiao.do?token=%@",SEM_TEST_SERVER,app.userModel.token];
    }
    if([_type isEqualToString:@"2"]){
        self.title = @"订交日报表(车系)";
        urtStr = [NSString stringWithFormat:@"%@get_report_djDaySeries.do?token=%@",SEM_TEST_SERVER,app.userModel.token];
    }
    if([_type isEqualToString:@"3"]){
        self.title = @"线索管理日报表";
        urtStr = [NSString stringWithFormat:@"%@get_report_xsgldgw.do?token=%@",SEM_TEST_SERVER,app.userModel.token];
    }
    if([_type isEqualToString:@"4"]){
        self.title = @"线索跟进异常报表";
        urtStr = [NSString stringWithFormat:@"%@get_report_xsgjycgw.do?token=%@",SEM_TEST_SERVER,app.userModel.token];
    }
    if([_type isEqualToString:@"5"]){
        self.title = @"长期跟进未成交表(顾问)";
        urtStr = [NSString stringWithFormat:@"%@get_report_xscsjgjwcjgw.do?token=%@",SEM_TEST_SERVER,app.userModel.token];
    }
    if([_type isEqualToString:@"6"]){
        self.title = @"统计我的线索";
        urtStr = [NSString stringWithFormat:@"%@get_report_total.do?token=%@",SEM_TEST_SERVER,app.userModel.token];
    }
    if([_type isEqualToString:@"7"]){
        self.title = @"统计我的订交业绩";
        urtStr = [NSString stringWithFormat:@"%@get_report_mydingjiao.do?token=%@",SEM_TEST_SERVER,app.userModel.token];
    }
    if([_type isEqualToString:@"8"]){
        self.title = @"线索跟进表";
        urtStr = [NSString stringWithFormat:@"%@get_report_allxxgjb.do?token=%@&from_flag=%@",SEM_TEST_SERVER,app.userModel.token,@"T"];
    }
    if([_type isEqualToString:@"9"]){
        self.title = @"门店线索录入表";
        urtStr = [NSString stringWithFormat:@"%@get_report_two.do?token=%@",SEM_TEST_SERVER,app.userModel.token];
    }
    if([_type isEqualToString:@"10"]){
        self.title = @"网电销线索到店表";
        urtStr = [NSString stringWithFormat:@"%@get_report_three.do?token=%@",SEM_TEST_SERVER,app.userModel.token];
    }
    if([_type isEqualToString:@"11"]){
        self.title = @"厂端线索跟进表(先行者)";
        urtStr = [NSString stringWithFormat:@"%@get_report_four.do?token=%@",SEM_TEST_SERVER,app.userModel.token];
    }
    if([_type isEqualToString:@"13"]){
        self.title = @"厂端线索跟进表";
        urtStr = [NSString stringWithFormat:@"%@get_report_one.do?token=%@",SEM_TEST_SERVER,app.userModel.token];
    }
//    NSString *resourcePath = [ [NSBundle mainBundle] resourcePath];
//    NSString *filePath  = [resourcePath stringByAppendingPathComponent:@"test.html"];
//    NSString *htmlstring =[[NSString alloc] initWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    

    _webView.scrollView.bounces = YES;
    _webView.scalesPageToFit = YES;
    _webView.scrollView.showsHorizontalScrollIndicator = NO;
//    _webView.scrollView.showsHorizontalScrollIndicator = NO;
    _webView.scrollView.scrollEnabled = YES;
    [_webView sizeToFit];
//    [self.webView loadHTMLString:htmlstring  baseURL:[NSURL fileURLWithPath: [[NSBundle mainBundle]  bundlePath]]];
    
   NSURL *url = [[NSURL alloc]initWithString:urtStr];
    
    [_webView loadRequest:[NSURLRequest requestWithURL:url]];

    // Do any additional setup after loading the view.
}
- (IBAction)typeChangeAct:(UISegmentedControl *)sender {
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSString *sStr=@"";
    if(sender.selectedSegmentIndex==0){
        sStr=@"T";
    }else if (sender.selectedSegmentIndex==1){
        sStr=@"Q";
    }else if (sender.selectedSegmentIndex==2){
        sStr=@"P";
    }else if (sender.selectedSegmentIndex==3){
         sStr=@"";
    }
    NSString *urtStr = [NSString stringWithFormat:@"%@get_report_allxxgjb.do?token=%@&from_flag=%@",SEM_TEST_SERVER,app.userModel.token,sStr];
    NSURL *url = [[NSURL alloc]initWithString:urtStr];
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
