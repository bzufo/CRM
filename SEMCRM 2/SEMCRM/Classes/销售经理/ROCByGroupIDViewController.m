//
//  ROCByGroupIDViewController.m
//  SEMCRM
//
//  Created by 薛斯岐 on 16/2/24.
//  Copyright © 2016年 sem. All rights reserved.
//

#import "ROCByGroupIDViewController.h"
#import "ToBeContactedCell.h"
#import "ChooseYDViewController.h"
@interface ROCByGroupIDViewController ()<ChooseYDDelegate>
{
    NSMutableArray *dataList;
    int pageCount;
    int perCount;
    NSMutableDictionary *nowDic;
    
}
@end

@implementation ROCByGroupIDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    dataList = [[NSMutableArray alloc]init];
    pageCount=1;
    perCount=20;
    NSDictionary *dic=@{@"pageNum":[NSNumber numberWithInt:pageCount],@"pageSize":[NSNumber numberWithInt:perCount]};
    nowDic=[[NSMutableDictionary alloc]initWithDictionary:dic];
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [nowDic setObject:app.userModel.token forKey:@"token"];
    [nowDic setObject:@"1" forKey:@"cstate"];
    [nowDic setObject:_orderBy forKey:@"orderBy"];
    [nowDic setObject:_groupModel.tile_id forKey:@"orderTitle"];
    
    
    [self getData];
    
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self getData:nowDic];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)getData{
    __weak __typeof(self)weakSelf = self;
    
    self.tableView.mj_header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
        pageCount=1;
        
        [nowDic removeObjectForKey:@"pageNum"];
        [nowDic setObject:[NSNumber numberWithInt:pageCount] forKey:@"pageNum"];
        [weakSelf getData:nowDic];
    }];
    MJRefreshGifHeader *header=(MJRefreshGifHeader *)self.tableView.mj_header;
    [self initMJRefeshHeaderForGif:header];
    
    self.tableView.mj_footer = [MJRefreshBackGifFooter footerWithRefreshingBlock:^{
        [nowDic removeObjectForKey:@"pageNum"];
        [nowDic setObject:[NSNumber numberWithInt:pageCount] forKey:@"pageNum"];

        [self getDataWithDicMore:nowDic];
    }];
    MJRefreshBackGifFooter *footer=(MJRefreshBackGifFooter *)self.tableView.mj_footer;
    [self initMJRefeshFooterForGif:footer];
}
#pragma mark 获取数据
-(void)getData:(NSDictionary *)dic{
    __weak __typeof(self)weakSelf = self;
    [HttpManageTool selectCXGroupList:dic success:^(NSArray *fzList) {
        [dataList removeAllObjects];
        
        
        NSMutableArray *arr=[fzList mutableCopy];
        [dataList addObjectsFromArray:arr];
        if(dataList.count>0){
            pageCount++;
            [weakSelf.tableView.mj_footer setHidden:NO];
            //            [weakSelf.tableView.mj_footer resetNoMoreData];
        }
        [weakSelf.tableView reloadData];
        [weakSelf.tableView.mj_header endRefreshing];

    } failure:^(NSError *err) {
        [weakSelf.tableView.mj_header endRefreshing];
    }];
    

    
}
#pragma mark 获取更多一起玩数据
-(void)getDataWithDicMore:(NSDictionary *)dic{
    __weak __typeof(self)weakSelf = self;
    [HttpManageTool selectCXGroupList:dic success:^(NSArray *fzList) {
        if(fzList.count>0){
            [dataList addObjectsFromArray:fzList];
            pageCount ++;
            [weakSelf.tableView reloadData];
            
        }else{
            [weakSelf.tableView.mj_footer setHidden:YES];
            [weakSelf.tableView.mj_footer noticeNoMoreData];
        }
        
        
        [weakSelf.tableView.mj_footer endRefreshing];

        
    } failure:^(NSError *err) {
        [weakSelf.tableView.mj_header endRefreshing];
    }];
    
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return dataList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ToBeContactedCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ToBeContactedCell" forIndexPath:indexPath];
    CueList *cuelist =dataList[indexPath.row];
    [cell configureCell:cuelist];
    [cell.selBtn addTarget:self action:@selector(chooseCue:event:) forControlEvents:UIControlEventTouchUpInside];
    [cell.selBtn setSelected:cuelist.isSel];

    return cell;
}

- (void)chooseCue:(UIButton *)button event:(id)event{
    //    [self.contentView addSubview:self.moreView];
    NSSet *touches = [event allTouches];
    UITouch *touch = [touches anyObject];
    CGPoint currentTouchPosition = [touch locationInView:self.tableView];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint: currentTouchPosition];
    CueList *model = dataList [indexPath.row];
    model.isSel = !model.isSel;
    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
}
-(void)chooseYD:(NSString *)users{
    
    NSMutableString *ss =[[NSMutableString alloc]init];
    for (int i=0;i<dataList.count;i++) {
        CueList *model = dataList[i];
        if(model.isSel){
            [ss appendString:model.TARGET_CUST_ID];
            [ss appendString:@";"];
            
        }
        
    }
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSDictionary *dic=@{@"token":app.userModel.token,@"custids":ss,@"saleids":users,@"sendFlag":@"1"};
    
    [HttpManageTool updataCueForMT:dic success:^(BOOL isSuccess) {
        if(isSuccess){
            
            [self getData:nowDic];
            
        }
    } failure:^(NSError *err) {
        [MyUtil showMessage:@"保存出错！"];
    }];
}

- (IBAction)distributionAct:(UIBarButtonItem *)sender {
    BOOL isflag=false;
    for (CueList *modelTemp in dataList) {
        if(modelTemp.isSel){
            isflag=true;
            break;
        }
    }
    if(isflag){
        ChooseYDViewController *viewController = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]]instantiateViewControllerWithIdentifier:@"chooseYDId"];
        viewController.delegate = self;
        [self.navigationController pushViewController:viewController animated:YES];
    }else{
        [MyUtil showMessage:@"请选择要分配的线索！"];
    }
    
    
}
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    UIViewController * view = segue.destinationViewController;
    if ([view respondsToSelector:@selector(setCustid:)]) {
        
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        CueList *cuelist =dataList[indexPath.row];
        [view setValue:cuelist.TARGET_CUST_ID forKey:@"custid"];
    }
    if([view respondsToSelector:@selector(setSendFlag:)]){
        [view setValue:@"1" forKey:@"sendFlag"];
        
    }
}


@end
