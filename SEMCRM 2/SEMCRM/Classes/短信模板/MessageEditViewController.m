//
//  MessageEditViewController.m
//  SEMCRM
//
//  Created by 薛斯岐 on 16/3/1.
//  Copyright © 2016年 sem. All rights reserved.
//

#import "MessageEditViewController.h"

@interface MessageEditViewController ()
@property (weak, nonatomic) IBOutlet UITextView *msgContentTextView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *commitBtn;

@end

@implementation MessageEditViewController
- (IBAction)commitAct:(UIBarButtonItem *)sender {
    NSMutableArray *msgArr=[[NSMutableArray alloc]init];
    NSArray *arr = [[NSUserDefaults standardUserDefaults]objectForKey:@"msg"];
    
    for (NSDictionary * dic in arr) {
        NSString *title = [dic objectForKey:@"title"];
        NSString *nowtitle = [_msgDic objectForKey:@"title"];
        if([nowtitle isEqualToString:title]){
            NSDictionary *newDic = @{@"title":nowtitle,@"subtitle":self.msgContentTextView.text};
            [msgArr addObject:newDic];
            continue;
        }
        [msgArr addObject:dic];
        
    }
    [[NSUserDefaults standardUserDefaults] setObject:msgArr forKey:@"msg"];
    [MyUtil showMessage:@"保存成功"];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSString *title = [_msgDic objectForKey:@"title"];
//    NSString *subtitle = [_msgDic objectForKey:@"subtitle"];
    return title;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *title = [_msgDic objectForKey:@"title"];
    NSString *subtitle = [_msgDic objectForKey:@"subtitle"];
    _msgContentTextView.text =subtitle;
    if([title isEqualToString:@"默认模板"]){
        [_msgContentTextView setEditable:false];
        [_commitBtn setEnabled:false];
    }
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
