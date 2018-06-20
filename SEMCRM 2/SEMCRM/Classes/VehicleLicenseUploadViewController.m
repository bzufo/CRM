//
//  VehicleLicenseUploadViewController.m
//  SEMCRM
//
//  Created by 薛斯岐 on 16/2/25.
//  Copyright © 2016年 sem. All rights reserved.
//

#import "VehicleLicenseUploadViewController.h"
#import "UpPhotoCell.h"
#import "VehicleLicenseModel.h"
@interface VehicleLicenseUploadViewController ()
{
    NSMutableArray *vcList;
    NSMutableDictionary *nowDic;
}
@property (weak, nonatomic) IBOutlet UISegmentedControl *typaSeg;
@property (weak, nonatomic) IBOutlet UITextField *searchTex;

@end

@implementation VehicleLicenseUploadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    nowDic=[[NSMutableDictionary alloc]init];
    vcList=[[NSMutableArray alloc]init];
    _searchTex.returnKeyType = UIReturnKeySearch;
    self.navigationController.title =@"行驶证上传";
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    //1456101228854zl62uqujl60wc9d259yc9zz5
    //app.userModel.token
    [nowDic setObject:app.userModel.token forKey:@"token"];
    [nowDic setObject:@"0" forKey:@"upCarFile"];
    [self getData:nowDic];
    self.tableView.mj_header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
        
        [self getData:nowDic];
    }];

    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self getData:nowDic];
}
#pragma mark 获取数据
-(void)getData:(NSDictionary *)dic{
    __weak __typeof(self)weakSelf = self;
    [HttpManageTool selectVehicleLicenseList:dic success:^(NSArray *vehicleLicenseList) {
        [vcList removeAllObjects];
        
        
        NSMutableArray *arr=[vehicleLicenseList mutableCopy];
        [vcList addObjectsFromArray:arr];
        
        [weakSelf.tableView reloadData];
        [weakSelf.tableView.mj_header endRefreshing];
    } failure:^(NSError *err) {
        [weakSelf.tableView.mj_header endRefreshing];
    }];
}
- (IBAction)typeChangeAct:(UISegmentedControl *)sender {
    _searchTex.text=@"";
    
    [_searchTex resignFirstResponder];
    switch (sender.selectedSegmentIndex) {
        case 0:
            [nowDic setObject:@"0" forKey:@"upCarFile"];
            [nowDic removeObjectForKey:@"licenseNo"];
            _searchTex.enabled=NO;
            [self getData:nowDic];
            break;
        case 1:
            [nowDic setObject:@"1" forKey:@"upCarFile"];
            [vcList removeAllObjects];
            [self.tableView reloadData];
            _searchTex.enabled=YES;
            break;
        default:
            break;
    }
}
- (IBAction)endEdit:(id)sender {
    [sender resignFirstResponder];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return vcList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UpPhotoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UpPhotoCell" forIndexPath:indexPath];
    VehicleLicenseModel *model = vcList[indexPath.row];
    [cell configureCell:model];
    return cell;
}
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    
//}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [_searchTex resignFirstResponder];
    if(![MyUtil isEmptyString:textField.text] ){
        [nowDic setObject:textField.text forKey:@"licenseNo"];
        [self getData:nowDic];
    }
    return YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    UIViewController * view = segue.destinationViewController;
    //    if ([view respondsToSelector:@selector(setManageDic:)]) {
    //        [view setValue:manageDic forKey:@"manageDic"];
    //    }
    
    if([view respondsToSelector:@selector(setVin:)]){
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        VehicleLicenseModel *model = vcList[indexPath.row];
        [view setValue:model.VIN forKey:@"vin"];
    }
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
