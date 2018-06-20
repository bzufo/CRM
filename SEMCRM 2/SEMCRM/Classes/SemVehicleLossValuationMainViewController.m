//
//  SemVehicleLossValuationMainViewController.m
//  SEMCRM
//
//  Created by Sem on 2018/4/17.
//  Copyright © 2018年 sem. All rights reserved.
//

#import "SemVehicleLossValuationMainViewController.h"
#import "VehicleLossCell.h"
#import "EvaluationInfoModle.h"
@interface SemVehicleLossValuationMainViewController ()
{
    NSMutableArray *dataArr;
}
@end

@implementation SemVehicleLossValuationMainViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self getData];
}
-(void)getData{
    
    //[MyUtil getUserInfo].employee_no BB010102&STATUS=0
    NSDictionary *dic=@{@"token":[MyUtil getUserInfo].token,@"state":@"list"};
    [HttpManageTool getEvaluationList:dic success:^(NSArray *dyzArr) {
        [dataArr removeAllObjects];
        [dataArr addObjectsFromArray:dyzArr];
        [self.tableView reloadData];
    } failure:^(NSError *err) {
        
    }
     ];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    dataArr=[[NSMutableArray alloc]initWithCapacity:0];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return dataArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    VehicleLossCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VehicleLossCell" forIndexPath:indexPath];
    EvaluationInfoModle *model =dataArr[indexPath.row];
    cell.VNOLal.text=model.licenseNO;
    cell.VLNOLbl.text = model.eva_id;
    cell.nameLal.text = model.name;
    if(![model.status isEqualToString:@"40"]){
        cell.VNOLal.textColor =[UIColor redColor];
        cell.VLNOLbl.textColor =[UIColor redColor];
        cell.nameLal.textColor =[UIColor redColor];
    }else{
        cell.VNOLal.textColor =[UIColor blackColor];
        cell.VLNOLbl.textColor =[UIColor blackColor];
        cell.nameLal.textColor =[UIColor blackColor];
    }
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    UIViewController * view = segue.destinationViewController;
    if ([view respondsToSelector:@selector(setDelegate:)]) {
        [view setValue:self forKey:@"delegate"];
    }
    if ([view respondsToSelector:@selector(setEvalId:)]) {
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        EvaluationInfoModle *model =dataArr[indexPath.row];
        [view setValue:model.eva_id forKey:@"evalId"];
    }
}
@end
