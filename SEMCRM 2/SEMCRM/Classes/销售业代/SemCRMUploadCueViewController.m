//
//  SemCRMUploadCueViewController.m
//  SEMCRM
//
//  Created by sem on 16/2/21.
//  Copyright © 2016年 sem. All rights reserved.
//

#import "SemCRMUploadCueViewController.h"
#import "CueChooseUpLoadCell.h"
#import "User.h"
static NSString *CueChooseUploadCellStr=@"CueChooseUploadCell";
@interface SemCRMUploadCueViewController ()
{
    NSMutableArray *userArr;
}
@end

@implementation SemCRMUploadCueViewController
- (IBAction)chooseAll:(UIButton *)sender {
    if(sender.selected){
        for (User *user in userArr) {
            user.isSel =false;
        }
    }else{
        for (User *user in userArr) {
            user.isSel =true;
        }
    }
    [sender setSelected: !sender.selected];
    [self.tableView reloadData];
}
- (IBAction)uploadAct:(UIBarButtonItem *)sender {
    NSMutableArray *newArr=[[NSMutableArray alloc]init];
    for (User *user in userArr) {
        if(user.isSel){
            [newArr addObject:user];
        }
    }
    NSArray *arr = [User mj_keyValuesArrayWithObjectArray:newArr];
    if(arr.count>0){
        NSString *mobileJson = [MyUtil toJSONData:arr];
        
        NSMutableDictionary *dicparam = [[NSMutableDictionary alloc]init];
        AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        [dicparam setObject:app.userModel.token forKey:@"token"];
        [dicparam setObject:mobileJson forKey:@"destr"];
        [HttpManageTool insertNewCueList:dicparam success:^(NSString *mobiles) {
            if(mobiles&&mobiles.length>0){
                
                NSArray *mobileArr=[mobiles componentsSeparatedByString:@";"];
                if(mobileArr.count>0){
                    [self clearDataCoreS:mobileArr];
                    NSString *megStr = [NSString stringWithFormat:@"上传成功%ld个",mobileArr.count];
                    [MyUtil showMessage:megStr];
                    [self getDataFromCore];
                }
                
            }else{
                [MyUtil showMessage:@"上传失败"];
            }
        } failure:^(NSError *err) {
            [MyUtil showMessage:@"很抱歉，因网络连接不畅或服务器异常，线索无法上传服务器，请在Wifi连接下再试"];
        }];
    }else{
        [MyUtil showMessage:@"请选择要上传的数据"];
    }
}
-(void)clearDataCoreS:(NSArray *)arr{
    for (NSString *ss in arr) {
        if(ss){
            // 1. 实例化查询请求
            AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
            
            NSManagedObjectContext *context = [app managedObjectContext];
            NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:@"User"];
            // 2. 设置谓词条件
            NSPredicate *pred = [NSPredicate predicateWithFormat:@"%K=%@",@"mobile",ss];
            request.predicate = pred;
            
            // 3. 由上下文查询数据
            NSArray *result = [context executeFetchRequest:request error:nil];
            
            // 4. 输出结果
            NSManagedObject *newObject = nil;
            if([result count]>0){
                newObject = [result objectAtIndex:0];
                [context deleteObject:newObject];
            }
            // 5. 通知_context保存数据
            if ([context save:nil]) {
                NSLog(@"删除成功");
            } else {
                NSLog(@"删除失败");
            }

        }
        
    }
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self getDataFromCore];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    userArr = [[NSMutableArray alloc]init];
//    [self getDataFromCore];
    
    // Do any additional setup after loading the view.
}
-(void)getDataFromCore{
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSError *error;
    NSManagedObjectContext *context = [app managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:@"User"];
    userArr = [NSMutableArray arrayWithArray:[context executeFetchRequest:request error:&error]];
    if(userArr==nil){
        return;
    }
    
    [self.tableView reloadData];
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

    return userArr.count;
}


 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
     CueChooseUpLoadCell *cell = [tableView dequeueReusableCellWithIdentifier:CueChooseUploadCellStr forIndexPath:indexPath];
     User *user = (User *)userArr [indexPath.row];
     [cell.chooseBtn setSelected:user.isSel];
     cell.userNameLal.text = user.cname;
     cell.phoneNameLal.text = user.mobile;
     cell.creadDataLal.text = user.series;
     [cell.chooseBtn addTarget:self action:@selector(chooseUser:event:) forControlEvents:UIControlEventTouchUpInside];
     return cell;
 }
- (void)chooseUser:(UIButton *)button event:(id)event{
    //    [self.contentView addSubview:self.moreView];
    NSSet *touches = [event allTouches];
    UITouch *touch = [touches anyObject];
    CGPoint currentTouchPosition = [touch locationInView:self.tableView];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint: currentTouchPosition];
    User *user = userArr [indexPath.row];
    user.isSel = !user.isSel;
    
    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
}
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除";
}
//- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return UITableViewCellEditingStyleDelete;
//}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return YES;
    
    
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self clearDataCore:indexPath];
        
    }
    
}
-(void)clearDataCore:(NSIndexPath *)indexPath{
    
    // 1. 实例化查询请求
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext *context = [app managedObjectContext];
    
    
    
    
    User *user = userArr [indexPath.row];
    [context deleteObject:user];
    [userArr removeObject:user];
        // 2. 通知_context保存数据
    if ([context save:nil]) {
        NSLog(@"删除成功");
    } else {
        NSLog(@"删除失败");
    }
    [self.tableView reloadData];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    //showUpInfo
    UIViewController * view = segue.destinationViewController;
    NSString *iden=segue.identifier;
    
    if([iden isEqualToString:@"showUpInfo"]){
        view.title=@"修改信息";
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        User *user=userArr [indexPath.row];
        [view setValue:user forKey:@"userModel"];
    }
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
