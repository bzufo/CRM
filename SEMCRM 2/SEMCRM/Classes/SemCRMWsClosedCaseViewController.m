//
//  SemCRMWsClosedCaseViewController.m
//  SEMCRM
//
//  Created by Sem on 2017/6/30.
//  Copyright © 2017年 sem. All rights reserved.
//

#import "SemCRMWsClosedCaseViewController.h"

@interface SemCRMWsClosedCaseViewController ()
@property (weak, nonatomic) IBOutlet UIBarButtonItem *commitBtn;
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation SemCRMWsClosedCaseViewController
- (IBAction)commitAct:(UIBarButtonItem *)sender {
    if(_textView.text.length<1){
        [MyUtil showMessage:@"请填写结论！"];
        return;
    }
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSDictionary *dic=@{@"rh_no":_rhNo,@"ws_endcase_memo":_textView.text,@"token":app.userModel.token};
    [HttpManageTool updataSupporEndForWs:dic success:^(NSString *rhNO) {
        if ([self.delegate respondsToSelector:@selector(closeCase)]) {
            [self.delegate closeCase];
            [self.navigationController popViewControllerAnimated:YES];
        }
    } failure:^(NSError *err) {
        
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
