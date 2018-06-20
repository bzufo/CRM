//
//  DistributionOfCluesViewController.m
//  SEMCRM
//
//  Created by 薛斯岐 on 16/2/24.
//  Copyright © 2016年 sem. All rights reserved.
//

#import "DistributionOfCluesViewController.h"
#import "ToBeContactedCell.h"
#import "ChooseYDViewController.h"
@interface DistributionOfCluesViewController ()<ChooseYDDelegate>
{
    NSMutableArray *dataList;
    int pageCount;
    int perCount;
    int chooseCount;
    NSMutableDictionary *nowDic;
    bool isAllchoose;
}
@property (weak, nonatomic) IBOutlet UIButton *chooseBtn;
@property (weak, nonatomic) IBOutlet UILabel *allLal;
@property (weak, nonatomic) IBOutlet UILabel *chooseLal;
@end

@implementation DistributionOfCluesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _chooseBtn.enabled=false;
    chooseCount=0;
    isAllchoose=false;
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
     dataList = [[NSMutableArray alloc]init];
    pageCount=1;
    perCount=20;
    NSDictionary *dic=@{@"pageNum":[NSNumber numberWithInt:pageCount],@"pageSize":[NSNumber numberWithInt:perCount]};
    nowDic=[[NSMutableDictionary alloc]initWithDictionary:dic];
    [nowDic setObject:@"0" forKey:@"csdate"];
    [nowDic setObject:app.userModel.token forKey:@"token"];
    [self getData];
    [self getData:nowDic];
    // Do any additional setup after loading the view.
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
        //        [self.tableView.mj_header endRefreshing];
    }];
    MJRefreshBackGifFooter *footer=(MJRefreshBackGifFooter *)self.tableView.mj_footer;
    [self initMJRefeshFooterForGif:footer];
}
#pragma mark 获取数据
-(void)getData:(NSDictionary *)dic{
    NSLog(@"----------sctj:%@--------------",dic);
     __weak __typeof(self)weakSelf = self;
    [HttpManageTool selectStayCueList:dic success:^(CueStayModel *stayModel) {
        [dataList removeAllObjects];
        
        chooseCount=0;
        _chooseBtn.enabled=false;
        _chooseLal.text=[NSString stringWithFormat:@"%d",chooseCount];
        NSMutableArray *arr=[stayModel.info mutableCopy];
        [dataList addObjectsFromArray:arr];
        NSString *totalCount =stayModel.totalCount;
        if(dataList.count>0){
            pageCount++;
            [weakSelf.tableView.mj_footer setHidden:NO];
            if([MyUtil isPureInt:totalCount]){
                weakSelf.allLal.text=totalCount;
            }
            //            [weakSelf.tableView.mj_footer resetNoMoreData];
        }else{
            
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
    [HttpManageTool selectStayCueList:dic success:^(CueStayModel *stayModel) {
        if(stayModel.info.count>0){
            [dataList addObjectsFromArray:stayModel.info];
            if(isAllchoose){
                for (CueList *cueList in dataList) {
                    cueList.isSel=true;
                }
            }
            pageCount ++;
            [weakSelf.tableView reloadData];
            
        }else{
            [weakSelf.tableView.mj_footer setHidden:YES];
//            [weakSelf.tableView.mj_footer noticeNoMoreData];
        }
        
        
        [weakSelf.tableView.mj_footer endRefreshing];
    } failure:^(NSError *err) {
        [weakSelf.tableView.mj_footer endRefreshing];
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
    CueList *model  = dataList [indexPath.row];
    [cell configureCell:model];
    [cell.selBtn addTarget:self action:@selector(chooseCue:event:) forControlEvents:UIControlEventTouchUpInside];
    [cell.selBtn setSelected:model.isSel];
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
    chooseCount=0;
    for (CueList *modelTemp in dataList) {
        if(modelTemp.isSel){
            
            chooseCount++;
        }
    }
    _chooseLal.text=[NSString stringWithFormat:@"%d",chooseCount];
    if(chooseCount>0){
        _chooseBtn.enabled=true;
    }else{
        _chooseBtn.enabled=false;
    }
    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    UIViewController * view = segue.destinationViewController;
    if ([view respondsToSelector:@selector(setCustid:)]) {
        
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        CueList *cueModel = dataList[indexPath.row];
        [view setValue:cueModel.TARGET_CUST_ID forKey:@"custid"];
    }
    if ([view respondsToSelector:@selector(setDelegate:)]) {
        [view setValue:self forKey:@"delegate"];
    }
    if([view respondsToSelector:@selector(setSendFlag:)]){
        [view setValue:@"0" forKey:@"sendFlag"];
        
    }
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
    NSDictionary *dic;
    if(isAllchoose){
        dic=@{@"token":app.userModel.token,@"flag":@"1",@"saleids":users,@"sendFlag":@"0"};
    }else{
        dic=@{@"token":app.userModel.token,@"custids":ss,@"saleids":users,@"sendFlag":@"0"};
    }
    [HttpManageTool updataCueForMT:dic success:^(BOOL isSuccess) {
        if(isSuccess){
            
            [self getData:nowDic];
            
        }
    } failure:^(NSError *err) {
                [MyUtil showMessage:@"保存出错！"];
    }];
}

- (IBAction)chooseAllAct:(UIButton *)sender {
    isAllchoose =!isAllchoose;
    for (CueList *modelTemp in dataList) {
        modelTemp.isSel = isAllchoose;
    }
    if(isAllchoose){
        chooseCount=_allLal.text.intValue;
         _chooseLal.text=_allLal.text;
        _chooseBtn.enabled=true;
    }else{
        chooseCount=0;
        _chooseLal.text=@"0";
        _chooseBtn.enabled=false;
    }
    [self.tableView reloadData];
}
- (IBAction)distributionAct:(UIButton *)sender {
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

@end
