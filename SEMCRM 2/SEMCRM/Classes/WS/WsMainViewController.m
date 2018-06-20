//
//  WsMainViewController.m
//  SEMCRM
//
//  Created by 薛斯岐 on 16/3/10.
//  Copyright © 2016年 sem. All rights reserved.
//

#import "WsMainViewController.h"
#import "MainCCell.h"
#import "VehicleLicenseUploadViewController.h"
#import "SemCRMCComplaintListViewController.h"
#import "SemCRMSupportListviewController.h"
#import "SemCRMCaseShareListViewController.h"
#import "SemCRMSupportListSemViewController.h"
#import "SemVehicleLossValuationMainViewController.h"
@interface WsMainViewController ()
{
    BOOL isflag;
    NSArray *mainArr;
    BOOL isWS;
}
@end

@implementation WsMainViewController
static NSString * const reuseIdentifier = @"MainCCell";
- (void)viewDidLoad {
    
    [super viewDidLoad];
    isflag =false;
    isWS = false;
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    if(app.userModel.isteach){
        if([app.userModel.isteach isEqualToString:@"1"]){
            isflag =true;
            isWS =true;
        }else if ([app.userModel.isteach isEqualToString:@"2"]){
            isflag=true;
            isWS =false;
        }
        
    }
    //yiche_price.png
    if(isflag==false){
        mainArr=@[@{@"title":@"上传行驶证",@"image":[UIImage imageNamed:@"Upload_WS"]},@{@"title":@"客诉管理",@"image":[UIImage imageNamed:@"customer_service_new"]}];
    }else{
        if([[MyUtil getUserInfo].cxgj isEqualToString:@"1"]){
        mainArr=@[@{@"title":@"上传行驶证",@"image":[UIImage imageNamed:@"Upload_WS"]},@{@"title":@"客诉管理",@"image":[UIImage imageNamed:@"customer_service_new"]},@{@"title":@"支援查询",@"image":[UIImage imageNamed:@"Car_Repair_Blue"]},@{@"title":@"案例分享",@"image":[UIImage imageNamed:@"share1"]},@{@"title":@"车损估价",@"image":[UIImage imageNamed:@"yiche_price"]}];
        }else{
            mainArr=@[@{@"title":@"上传行驶证",@"image":[UIImage imageNamed:@"Upload_WS"]},@{@"title":@"客诉管理",@"image":[UIImage imageNamed:@"customer_service_new"]},@{@"title":@"支援查询",@"image":[UIImage imageNamed:@"Car_Repair_Blue"]},@{@"title":@"案例分享",@"image":[UIImage imageNamed:@"share1"]}];
        }
    }
    [self initData];
    // Do any additional setup after loading the view.
}
-(void)initData{
    if(isflag){
        if(isWS){
            AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
            NSDictionary *dic =@{@"token":app.userModel.token};
            [HttpManageTool getHelpInitList:dic success:^(NSDictionary *dic1) {
                NSArray *arr = [dic1 objectForKey:@"car_series"];
                NSArray *arr1 = [dic1 objectForKey:@"trouble_type"];
                NSArray *arr2 = [dic1 objectForKey:@"sem_teacher"];
                NSArray *arr3 = [dic1 objectForKey:@"sort_type"];
                if(arr!=nil&&arr.count>0){
                    NSString *filePath = [MyUtil getFilePath:CAR_SERIES];
                    [arr writeToFile:filePath atomically:YES];
                }
                if(arr1!=nil&&arr.count>0){
                    NSString *filePath = [MyUtil getFilePath:TROUBLE_TYPE];
                    [arr1 writeToFile:filePath atomically:YES];
                }
                if(arr2!=nil&&arr.count>0){
                    NSString *filePath = [MyUtil getFilePath:SEM_TEACHER];
                    [arr2 writeToFile:filePath atomically:YES];
                }
                if(arr3!=nil&&arr.count>0){
                    NSString *filePath = [MyUtil getFilePath:SEM_SORTTYPE];
                    [arr3 writeToFile:filePath atomically:YES];
                }
                
            } failure:^(NSError *err) {
                
            }];
        }else{
            AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
            NSDictionary *dic =@{@"token":app.userModel.token};
            [HttpManageTool getHelpInitList:dic success:^(NSDictionary *dic1) {
                NSArray *arr = [dic1 objectForKey:@"car_series"];
                NSArray *arr1 = [dic1 objectForKey:@"trouble_type"];
                NSArray *arr2 = [dic1 objectForKey:@"sem_teacher"];
                NSArray *arr3 = [dic1 objectForKey:@"sort_type"];
                if(arr!=nil&&arr.count>0){
                    NSString *filePath = [MyUtil getFilePath:CAR_SERIES];
                    [arr writeToFile:filePath atomically:YES];
                }
                if(arr1!=nil&&arr1.count>0){
                    NSString *filePath = [MyUtil getFilePath:TROUBLE_TYPE];
                    [arr1 writeToFile:filePath atomically:YES];
                }
                if(arr2!=nil&&arr2.count>0){
                    NSString *filePath = [MyUtil getFilePath:SEM_TEACHER];
                    [arr2 writeToFile:filePath atomically:YES];
                }
                if(arr3!=nil&&arr3.count>0){
                    NSString *filePath = [MyUtil getFilePath:SEM_SORTTYPE];
                    [arr3 writeToFile:filePath atomically:YES];
                }
                
            } failure:^(NSError *err) {
                
            }];
            [HttpManageTool getHelpInitListForSem:dic success:^(NSDictionary *dic1) {
                NSArray *arr = [dic1 objectForKey:@"region"];
                NSArray *arr1 = [dic1 objectForKey:@"ws"];
                if(arr!=nil&&arr.count>0){
                    NSString *filePath = [MyUtil getFilePath:REGION_NAME];
                    [arr writeToFile:filePath atomically:YES];
                }
                if(arr1!=nil&&arr.count>0){
                    NSString *filePath = [MyUtil getFilePath:WS_NAME];
                    [arr1 writeToFile:filePath atomically:YES];
                }
                
                
            } failure:^(NSError *err) {
                
            }];
        
        }
    }
    
}
#pragma mark - Table view data source
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    UILabel *titleView = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 44)];
    titleView.backgroundColor = [UIColor clearColor];
    titleView.font = [UIFont boldSystemFontOfSize:19];
    titleView.textColor = [UIColor blackColor];
    titleView.textAlignment = NSTextAlignmentCenter;
    titleView.text = @"常用功能";
    self.tabBarController.navigationItem.titleView = titleView;
    //    self.tabBarController.navigationItem.rightBarButtonItem = nil;
}
#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return mainArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MainCCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    NSDictionary *dic =mainArr[indexPath.row];
    [cell.imageView setImage:[dic objectForKey:@"image"]];
    cell.titleLal.text=[dic objectForKey:@"title"];
    // Configure the cell
    
    return cell;
}
- (CGSize)collectionview:(UICollectionView *)collectionview layout:(UICollectionViewLayout*)collectionviewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(94, 134);
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:
        {
            AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
            NSString *jueSeTag = app.userModel.flag;
            NSArray *arr =@[@"7",@"8",@"9",@"10",@"11",@"12",@"13"];
            if([arr indexOfObject:jueSeTag] == NSNotFound){
                [MyUtil showMessage:@"您没有权限操作此项业务"];
                return;
            }
            VehicleLicenseUploadViewController *viewController = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]]instantiateViewControllerWithIdentifier:@"VehicleLicenseUpload"];
            viewController.title=@"行驶证上传";
            [self.navigationController pushViewController:viewController animated:YES];
        }
            break;
        case 1:{
            SemCRMCComplaintListViewController *viewController = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]]instantiateViewControllerWithIdentifier:@"CCManageID"];
            [self.navigationController pushViewController:viewController animated:YES];
        }
            break;
        case 2:
        {
            if(isWS){
                SemCRMSupportListviewController *viewController = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]]instantiateViewControllerWithIdentifier:@"SupportListviewController"];
                [self.navigationController pushViewController:viewController animated:YES];
            }else{
                SemCRMSupportListSemViewController *viewController = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]]instantiateViewControllerWithIdentifier:@"SemCRMSupportListSemViewController"];
                [self.navigationController pushViewController:viewController animated:YES];
            }
            
        }
            break;
        case 3:
        {
            
            SemCRMCaseShareListViewController *viewController = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]]instantiateViewControllerWithIdentifier:@"SemCRMCaseShareListViewController"];
            [self.navigationController pushViewController:viewController animated:YES];
        }
            break;
        case 4:
        {
            
            SemVehicleLossValuationMainViewController *viewController = [[UIStoryboard storyboardWithName:@"Main2" bundle:[NSBundle mainBundle]]instantiateViewControllerWithIdentifier:@"SemVehicleLossValuationMainViewController"];
            [self.navigationController pushViewController:viewController animated:YES];
        }
            break;
        default:
            break;
    }
}
#pragma mark <UICollectionViewDelegate>

/*
 // Uncomment this method to specify if the specified item should be highlighted during tracking
 - (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
 }
 */

/*
 // Uncomment this method to specify if the specified item should be selected
 - (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
 return YES;
 }
 */

/*
 // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
 - (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
 }
 
 - (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
 }
 
 - (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
 }
 */
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
