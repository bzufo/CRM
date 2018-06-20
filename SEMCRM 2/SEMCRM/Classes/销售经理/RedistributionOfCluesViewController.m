//
//  RedistributionOfCluesViewController.m
//  SEMCRM
//
//  Created by 薛斯岐 on 16/2/24.
//  Copyright © 2016年 sem. All rights reserved.
//

#import "RedistributionOfCluesViewController.h"
#import "CueGourpCell.h"
#import "GroupModel.h"
#import "ToBeContactedCell.h"
#import "ChooseYDViewController.h"
@interface RedistributionOfCluesViewController ()<ChooseYDDelegate>
{
    NSMutableArray *cueGroupList;
    NSMutableDictionary *nowDic;
    BOOL isNameSel;
}
@property (weak, nonatomic) IBOutlet UISegmentedControl *typeSeg;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *completeBtn;
@property (weak, nonatomic) IBOutlet UITextField *searchText;
@end

@implementation RedistributionOfCluesViewController
-(void)chooseYD:(NSString *)users{
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
    NSInteger tag = _typeSeg.selectedSegmentIndex;
    NSString *titleId = @"";
    for (GroupModel *model in cueGroupList) {
        if (model.isSel) {
            titleId = model.tile_id;
            break;
        }
    }
    switch (tag) {
        case 0:
            
            [dic setObject:titleId forKey:@"dOrderBy"];
            
            break;
        case 1:
            [dic setObject:titleId forKey:@"nOrderBy"];
            
            break;
        case 2:
            [dic setObject:titleId forKey:@"lOrderBy"];
            
            break;
        default:
            break;
    }
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [dic setObject:app.userModel.token forKey:@"token"];
    [dic setObject:@"1" forKey:@"sendFlag"];
    [dic setObject:users forKey:@"saleids"];
    
    [HttpManageTool updataCueForMT:dic success:^(BOOL isSuccess) {
        if(isSuccess){
            [MyUtil showMessage:@"添加成功!"];
            [self getData:nowDic];
            
        }
    } failure:^(NSError *err) {
        [MyUtil showMessage:@"保存出错！"];
    }];
}
- (IBAction)completeAct:(UIBarButtonItem *)sender {
    if(!isNameSel){
        BOOL flag=false;
        for (GroupModel *model in cueGroupList) {
            if (model.isSel) {
                flag=true;
                break;
            }
        }
        if (flag) {
            ChooseYDViewController *viewController = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]]instantiateViewControllerWithIdentifier:@"chooseYDId"];
            viewController.delegate = self;
            [self.navigationController pushViewController:viewController animated:YES];
        }else{
            [MyUtil showMessage:@"请选择要分配的分组！"];
        }
    }
}
- (IBAction)typeChange:(UISegmentedControl *)sender {
    if(sender.selectedSegmentIndex ==1){
        _completeBtn.enabled=YES;
    }else{
        _completeBtn.enabled=false;
    }
    [_searchText resignFirstResponder];
    _searchText.text=0;
    isNameSel=false;
    [self getData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    isNameSel=false;
    cueGroupList=[[NSMutableArray alloc]init];
    _completeBtn.enabled=false;
    nowDic=[[NSMutableDictionary alloc]init];
    UIImageView *img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"search"]];
    _searchText.leftView = img;
    _searchText.leftViewMode = UITextFieldViewModeAlways;
    _searchText.returnKeyType = UIReturnKeySearch;
    [self getData];
    self.tableView.mj_header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
        
        [self getData:nowDic];
    }];
    // Do any additional setup after loading the view.
}
-(void)getData{
    NSInteger tag = _typeSeg.selectedSegmentIndex;
    [nowDic removeAllObjects];
    [nowDic setObject:@"1" forKey:@"cstate"];
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [nowDic setObject:app.userModel.token forKey:@"token"];
    
    switch (tag) {
        case 0:
            
            [nowDic setObject:@"D" forKey:@"orderBy"];
            //_completeBtn.enabled=YES;
            break;
        case 1:
            [nowDic setObject:@"N" forKey:@"orderBy"];
            //_completeBtn.enabled=YES;
            break;
        case 2:
            [nowDic setObject:@"L" forKey:@"orderBy"];
            //_completeBtn.enabled=YES;
            break;
        default:
            break;
    }
    [self getData:nowDic];
}
#pragma mark 获取数据
-(void)getData:(NSDictionary *)dic{
    NSLog(@"----------sctj:%@--------------",dic);
    __weak __typeof(self)weakSelf = self;
    if (isNameSel) {
        [HttpManageTool selectMyCueList:dic success:^(NSDictionary *toBCList) {
            [cueGroupList removeAllObjects];
            
            
            NSMutableArray *arr=[toBCList[@"data"] mutableCopy];
            [cueGroupList addObjectsFromArray:arr];
            
            [weakSelf.tableView reloadData];
            [weakSelf.tableView.mj_header endRefreshing];
        } failure:^(NSError *err) {
            [weakSelf.tableView.mj_header endRefreshing];
        }];
    }else{
        [HttpManageTool selectCXCueByGroupList:dic success:^(NSArray *cxList) {
            [cueGroupList removeAllObjects];
            
            
            NSMutableArray *arr=[cxList mutableCopy];
            [cueGroupList addObjectsFromArray:arr];
            [weakSelf.tableView reloadData];
            [weakSelf.tableView.mj_header endRefreshing];
        } failure:^(NSError *err) {
            [weakSelf.tableView.mj_header endRefreshing];
        }];
    }
    
    
    
    
    
    
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
    
    
        return cueGroupList.count;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(isNameSel){
        ToBeContactedCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ToBeContactedCell" forIndexPath:indexPath];
        CueList *cueModel =cueGroupList[indexPath.row];
        [cell configureCell:cueModel];
        return cell;
    }else{
        CueGourpCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CueGroupCell" forIndexPath:indexPath];
        GroupModel *model = cueGroupList[indexPath.row];
        cell.gourpNameLal.text=model.title;
        cell.countLal.text =[NSString stringWithFormat:@"共%@条线索",model.count];
        [cell.selBtn addTarget:self action:@selector(chooseGroup:event:) forControlEvents:UIControlEventTouchUpInside];
        [cell.selBtn setSelected:model.isSel];
        return cell;
    }
}
//设置cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(isNameSel){
        return 68;
    }
    return 44;
}
- (void)chooseGroup:(UIButton *)button event:(id)event{
    //    [self.contentView addSubview:self.moreView];
    NSSet *touches = [event allTouches];
    UITouch *touch = [touches anyObject];
    CGPoint currentTouchPosition = [touch locationInView:self.tableView];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint: currentTouchPosition];
    GroupModel *model = cueGroupList[indexPath.row];
    model.isSel = !model.isSel;
    if(model.isSel){
        for (GroupModel *modelTemp in cueGroupList) {
            if (model!=modelTemp) {
                modelTemp.isSel=false;
            }
        }
    }
    
    [self.tableView reloadData];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    if(![MyUtil isEmptyString:textField.text] ){
        isNameSel = true;
        _typeSeg.selectedSegmentIndex = -1;
        [nowDic removeAllObjects];
        [nowDic setObject:@"1" forKey:@"cstate"];
        [nowDic setObject:@"N" forKey:@"orderBy"];
        [nowDic setObject:@"1" forKey:@"sendtype"];
        AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        [nowDic setObject:app.userModel.token forKey:@"token"];
        [nowDic setObject:[NSNumber numberWithInt:1] forKey:@"pageNum"];
        [nowDic setObject:[NSNumber numberWithInt:50] forKey:@"pageSize"];

        [nowDic setObject:textField.text forKey:@"nOrderBy"];
        [self getData:nowDic];
    }
    return YES;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    UIViewController * view = segue.destinationViewController;
    if ([view respondsToSelector:@selector(setCustid:)]) {
        
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        CueList *cueModel = cueGroupList[indexPath.row];
        [view setValue:cueModel.TARGET_CUST_ID forKey:@"custid"];
    }
    if([view respondsToSelector:@selector(setSendFlag:)]){
        [view setValue:@"1" forKey:@"sendFlag"];
        
    }
    if ([view respondsToSelector:@selector(setGroupModel:)]) {
        
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        GroupModel *model = cueGroupList[indexPath.row];
        [view setValue:model forKey:@"groupModel"];
        view.title =model.title;
    }
    if ([view respondsToSelector:@selector(setOrderBy:)]) {
        NSInteger tag = _typeSeg.selectedSegmentIndex;
        NSString *ss=@"";
        switch (tag) {
            case 0:
                
                ss=@"D";
                //_completeBtn.enabled=YES;
                break;
            case 1:
                ss=@"N";
                
                //_completeBtn.enabled=YES;
                break;
            case 2:
                ss=@"L";
                
                //_completeBtn.enabled=YES;
                break;
            default:
                break;
        }

        [view setValue:ss forKey:@"orderBy"];
        
    }
}


@end
