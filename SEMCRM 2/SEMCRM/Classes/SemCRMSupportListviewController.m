//
//  SemCRMSupportListviewController.m
//  SEMCRM
//
//  Created by Sem on 2017/5/11.
//  Copyright © 2017年 sem. All rights reserved.
//

#import "SemCRMSupportListviewController.h"
#import "SnailFullView.h"
#import "SnailSheetViewConfig.h"
#import "SnailCurtainView.h"
#import "SnailPopupController.h"
#import "SupporListCell.h"
#import "ChooseCConditionViewController.h"
#import "NewSupporViewController.h"
#import "SupporContentModle.h"
#import "SemCRMSupporDetailViewControllerTableViewController.h"
#import "NewSupporViewController.h"
@interface SemCRMSupportListviewController ()<ChooseCConditionViewDelegate>
{
    NSMutableDictionary *keyDic;
    NSMutableArray *dataArr;
}
@end

@implementation SemCRMSupportListviewController
- (IBAction)moreAct:(id)sender {
    SnailCurtainView *curtainView = [self curtainView];
    curtainView.closeClicked = ^(UIButton *closeButton) {
        [self.sl_popupController dismissWithDuration:0.25 elasticAnimated:NO];
    };
    @weakify(self);
    curtainView.didClickItems = ^(SnailCurtainView *curtainView, NSInteger index) {
        [weak_self.sl_popupController dismissWithDuration:0 elasticAnimated:NO];
        if(index==0){
            ChooseCConditionViewController *viewController = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]]instantiateViewControllerWithIdentifier:@"ChooseCConditionViewController"];
            viewController.delegate=self;
            [self.navigationController pushViewController:viewController animated:YES];
        }else if (index==1){
            NewSupporViewController *viewController = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]]instantiateViewControllerWithIdentifier:@"NewSupporViewController"];
            [self.navigationController pushViewController:viewController animated:YES];
        }
    };
    
    self.sl_popupController = [SnailPopupController new];
    self.sl_popupController.layoutType = PopupLayoutTypeTop;
    self.sl_popupController.allowPan = YES;
    //@weakify(self);
    self.sl_popupController.maskTouched = ^(SnailPopupController * _Nonnull popupController) {
        [weak_self.sl_popupController dismissWithDuration:0 elasticAnimated:NO];
    };
    [self.sl_popupController presentContentView:curtainView duration:0.75 elasticAnimated:YES];

}
- (SnailCurtainView *)curtainView {
    
    SnailCurtainView *curtainView = [[SnailCurtainView alloc] init];
    curtainView.width = [UIScreen width];
    [curtainView.closeButton setImage:[UIImage imageNamed:@"qzone_close"] forState:UIControlStateNormal];
    NSArray *imageNames = @[@"筛选", @"新建"];
    NSMutableArray *models = [NSMutableArray arrayWithCapacity:imageNames.count];
    for (NSString *imageName in imageNames) {
        UIImage *image = [UIImage imageNamed:[@"sina_" stringByAppendingString:imageName]];
        [models addObject:[SnailIconLabelModel modelWithTitle:imageName image:image]];
    }
    curtainView.models = models;
    return curtainView;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return dataArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SupporListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SupporListCell" forIndexPath:indexPath];
    SupporContentModle *model =dataArr[indexPath.row];
    [cell.phoneBtn addTarget:self action:@selector(telPhone:event:) forControlEvents:UIControlEventTouchUpInside];

    [cell configureCell:model];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SupporContentModle *model =dataArr[indexPath.row];
    if([model.help_status isEqualToString:@"新增"]){
        NewSupporViewController *viewViewController=[[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"NewSupporViewController"];
        viewViewController.rhNo = model.rh_no;
        [self.navigationController pushViewController:viewViewController animated:YES];
    }else{
        SemCRMSupporDetailViewControllerTableViewController *viewViewController=[[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"SemCRMSupporDetailViewControllerTableViewController"];
        viewViewController.rhNo = model.rh_no;
        [self.navigationController pushViewController:viewViewController animated:YES];
    }
    
}
//
- (void)viewDidLoad {
    [super viewDidLoad];
    keyDic =[[NSMutableDictionary alloc]init];
    dataArr=[[NSMutableArray alloc]initWithCapacity:0];
    
     __weak __typeof(self)weakSelf = self;
    self.tableView.mj_header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
       
        [weakSelf ininData];
    }];
   
    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:false];
     [self ininData];
}
-(void)ininData{
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    //app.userModel.token
    // NSDictionary *dic = @{@"token":app.userModel.token};
    [keyDic setObject:app.userModel.token forKey:@"token"];
    
    [HttpManageTool selectSupporListForWs:keyDic success:^(NSArray *dataList) {
        [dataArr removeAllObjects];
        [dataArr addObjectsFromArray:dataList];
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
    } failure:^(NSError *err) {
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
    }];

}
-(void)chooseCCondition:(NSDictionary *)dic{
    [keyDic removeAllObjects];
    [keyDic setDictionary:dic];
    //[self ininData];
}
- (void)telPhone:(UIButton *)button event:(id)event{
    //    [self.contentView addSubview:self.moreView];
    NSSet *touches = [event allTouches];
    UITouch *touch = [touches anyObject];
    CGPoint currentTouchPosition = [touch locationInView:self.tableView];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint: currentTouchPosition];
    SupporContentModle *model =dataArr[indexPath.row];
    if([MyUtil isValidateTelephone:model.help_teacher_mobile]){
        NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",model.help_teacher_mobile];
        //            NSLog(@"str======%@",str);
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
        
    }
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
