//
//  SemVehicleLossApplyViewController.m
//  SEMCRM
//
//  Created by Sem on 2018/4/17.
//  Copyright © 2018年 sem. All rights reserved.
//

#import "SemVehicleLossApplyViewController.h"

@interface SemVehicleLossApplyViewController ()
@property (weak, nonatomic) IBOutlet UITextField *amountTex;
@property (weak, nonatomic) IBOutlet UITextField *dateTex;
@property (weak, nonatomic) IBOutlet UITextView *contentTex;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveBtn;

@end

@implementation SemVehicleLossApplyViewController
- (IBAction)exitEdit:(UITextField *)sender {
    [sender resignFirstResponder];
}
- (IBAction)saveAct:(UIBarButtonItem *)sender {
    
    if(!([MyUtil isPureInt:_amountTex.text] || [MyUtil isPureFloat:_amountTex.text])){
        [MyUtil showMessage:@"估计金额必须为数字！"];
        return;
    }
    if(!([MyUtil isPureInt:_dateTex.text] || [MyUtil isPureFloat:_dateTex.text])){
        [MyUtil showMessage:@"预估维修时间必须为数字！"];
        return;
    }
    if(_contentTex.text.length<1){
        [MyUtil showMessage:@"请填写估计说明！"];
        return;
    }
    NSDictionary *dic=@{@"token":[MyUtil getUserInfo].token,@"state":@"hui",@"eval_id":_evalId,@"amount":_amountTex.text,@"time":_dateTex.text,@"remark":_contentTex.text};
    [HttpManageTool getEvaluationList:dic success:^(NSArray *dyzArr) {
        [MyUtil showMessage:@"回复成功！"];
        
    } failure:^(NSError *err) {
        
    }
     ];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





@end
