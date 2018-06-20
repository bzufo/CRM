//
//  ContactTimeSettingViewController.m
//  SEMCRM
//
//  Created by 薛斯岐 on 16/2/24.
//  Copyright © 2016年 sem. All rights reserved.
//

#import "ContactTimeSettingViewController.h"
#import "TimeModle.h"
@interface ContactTimeSettingViewController (){
    NSMutableArray *timeList;

}
@property (weak, nonatomic) IBOutlet UISegmentedControl *HSeg;
@property (weak, nonatomic) IBOutlet UISegmentedControl *ASeg;
@property (weak, nonatomic) IBOutlet UISegmentedControl *BSeg;
@property (weak, nonatomic) IBOutlet UISegmentedControl *CSeg;

@end

@implementation ContactTimeSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    timeList =[[NSMutableArray alloc]init];
    [self getData];
    // Do any additional setup after loading the view.
}
-(void)getData{
    [timeList removeAllObjects];
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSDictionary *dic = @{@"token":app.userModel.token};
    [HttpManageTool selectTimeList:dic success:^(NSArray *list) {
        [timeList addObjectsFromArray:list];
        [self setData];
        
    } failure:^(NSError *err) {
//        [self.tableView reloadData];
    }];
    
}
-(void)setData{
    for (TimeModle *timeModel in timeList) {
        NSString *inteval =timeModel.inteval;
        if([timeModel.level isEqualToString:@"H"]){
            if([inteval isEqualToString:@"2"]){
                [_HSeg setSelectedSegmentIndex:1];
            }else{
                [_HSeg setSelectedSegmentIndex:0];
            }
        }else if([timeModel.level isEqualToString:@"A"]){
            if([inteval isEqualToString:@"3"]){
                [_ASeg setSelectedSegmentIndex:0];
            }else if([inteval isEqualToString:@"5"]){
                [_ASeg setSelectedSegmentIndex:1];
            }else{
                [_ASeg setSelectedSegmentIndex:2];
            }
        }else if([timeModel.level isEqualToString:@"B"]){
            if([inteval isEqualToString:@"3"]){
                [_BSeg setSelectedSegmentIndex:0];
            }else if([inteval isEqualToString:@"7"]){
                [_BSeg setSelectedSegmentIndex:1];
            }else{
                [_BSeg setSelectedSegmentIndex:2];
            }
        }else if([timeModel.level isEqualToString:@"C"]){
            if([inteval isEqualToString:@"7"]){
                [_CSeg setSelectedSegmentIndex:0];
            }else if([inteval isEqualToString:@"14"]){
                [_CSeg setSelectedSegmentIndex:1];
            }else{
                [_CSeg setSelectedSegmentIndex:2];
            }
        }
    }
    
}
- (IBAction)completAct:(UIBarButtonItem *)sender {
    NSMutableString *ss=[[NSMutableString alloc]init];
    
    if(_HSeg.selectedSegmentIndex == 0){
        [ss appendString:@"1"];
    }else{
        [ss appendString:@"2"];
    }
    [ss appendString:@";"];
    if(_ASeg.selectedSegmentIndex == 0){
        [ss appendString:@"3"];
    }else if(_ASeg.selectedSegmentIndex == 1){
        [ss appendString:@"5"];
    }else{
        [ss appendString:@"7"];
    }
    [ss appendString:@";"];
    if(_BSeg.selectedSegmentIndex == 0){
        [ss appendString:@"3"];
    }else if(_BSeg.selectedSegmentIndex == 1){
        [ss appendString:@"7"];
    }else{
        [ss appendString:@"14"];
    }
    [ss appendString:@";"];
    if(_CSeg.selectedSegmentIndex == 0){
        [ss appendString:@"7"];
    }else if(_CSeg.selectedSegmentIndex == 1){
        [ss appendString:@"14"];
    }else{
        [ss appendString:@"30"];
    }
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSDictionary *dic = @{@"level":@"H;A;B;C",@"inteval":ss,@"token":app.userModel.token};
    [HttpManageTool updataTimeSet:dic success:^(BOOL isSuccess) {
        if(isSuccess){
            [MyUtil showMessage:@"保存成功"];
            [self getData];
        }
    } failure:^(NSError *err) {
        
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

@end
