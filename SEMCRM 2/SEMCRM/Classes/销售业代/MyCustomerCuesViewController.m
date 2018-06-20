//
//  MyCustomerCuesViewController.m
//  SEMCRM
//
//  Created by sem on 16/2/2.
//  Copyright © 2016年 sem. All rights reserved.
//

#import "MyCustomerCuesViewController.h"
#import "ToBeContactedCell.h"
@interface MyCustomerCuesViewController ()
{
    NSMutableArray *dataList;
    int pageCount;
    int perCount;
    
    NSMutableDictionary *nowDic;
    
}
@property (weak, nonatomic) IBOutlet UISegmentedControl *oneSeg;
@property (weak, nonatomic) IBOutlet UISegmentedControl *twoSeg;
@property (weak, nonatomic) IBOutlet UITextField *searchText;

@end

@implementation MyCustomerCuesViewController
UISegmentedControl *sortSeg;
- (void)viewDidLoad {
    [super viewDidLoad];
    dataList = [[NSMutableArray alloc]init];
    pageCount=1;
    perCount=20;
    sortSeg =[[UISegmentedControl alloc]initWithItems:@[@"下次联系",@"等级查询",@"姓名搜索"]];
    sortSeg.tag = 100;
    [sortSeg addTarget:self action:@selector(segValueChange:) forControlEvents:UIControlEventValueChanged];
    [sortSeg setSelectedSegmentIndex:0];
    UIImageView *img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"search"]];
    _searchText.leftView = img;
    _searchText.leftViewMode = UITextFieldViewModeAlways;
    _searchText.returnKeyType = UIReturnKeySearch;
    NSDictionary *dic=@{@"pageNum":[NSNumber numberWithInt:pageCount],@"pageSize":[NSNumber numberWithInt:perCount]};
    nowDic=[[NSMutableDictionary alloc]initWithDictionary:dic];
    [nowDic setObject:@"1" forKey:@"cstate"];
    [nowDic setObject:@"D" forKey:@"orderBy"];
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [nowDic setObject:app.userModel.token forKey:@"token"];
    [nowDic setObject:@"A" forKey:@"dOrderBy"];
    [nowDic setObject:@"0" forKey:@"sendtype"];
//    [nowDic setObject:[NSNumber numberWithInt:pageCount] forKey:@"pageNum"];
//    [nowDic setObject:[NSNumber numberWithInt:perCount] forKey:@"pageSize"];
    [self getData];
    
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //self.tabBarItem.badgeValue =@"1";
    UILabel *titleView = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 44)];
    titleView.backgroundColor = [UIColor clearColor];
    titleView.font = [UIFont boldSystemFontOfSize:19];
    titleView.textColor = [UIColor blackColor];
    titleView.textAlignment = NSTextAlignmentCenter;
    titleView.text = @"";
    
    
    self.tabBarController.navigationItem.titleView = sortSeg;
    [self getData:nowDic];
//    self.tabBarController.navigationItem.rightBarButtonItem = nil;
}
- (IBAction)segValueChange:(UISegmentedControl *)sender {
    int tag =(int) sender.tag;
    switch (tag) {
            //主选项卡
        case 100:
            [self mainSegChange];
            break;
            //正序倒序
        case 101:
            [self oneSegChange];
            break;
            //级别
        case 102:
            [self twoSegChange];
            break;
        default:
            break;
    }
}
-(void)mainSegChange{
    NSInteger Index = sortSeg.selectedSegmentIndex;
   
    switch (Index) {
            //最近联系
        case 0:
        {
            pageCount=1;
            [nowDic removeAllObjects];
            [nowDic setObject:@"1" forKey:@"cstate"];
            [nowDic setObject:@"D" forKey:@"orderBy"];
            AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
            [nowDic setObject:app.userModel.token forKey:@"token"];
            [nowDic setObject:@"A" forKey:@"dOrderBy"];
            [nowDic setObject:@"0" forKey:@"sendtype"];
            [nowDic setObject:[NSNumber numberWithInt:pageCount] forKey:@"pageNum"];
            [nowDic setObject:[NSNumber numberWithInt:perCount] forKey:@"pageSize"];
            [self getData:nowDic];
            [_oneSeg setHidden:NO];
            [_oneSeg setSelectedSegmentIndex:0];
            [_twoSeg setHidden:YES];
            [_searchText setHidden:YES];
        }
            break;
            //等级排序
        case 1:
        {
            pageCount=1;
            [nowDic removeAllObjects];
            [nowDic setObject:@"1" forKey:@"cstate"];
            [nowDic setObject:@"L" forKey:@"orderBy"];
            [nowDic setObject:@"0" forKey:@"sendtype"];
            AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
            [nowDic setObject:app.userModel.token forKey:@"token"];
            [nowDic setObject:@"H" forKey:@"lOrderBy"];
            [nowDic setObject:[NSNumber numberWithInt:pageCount] forKey:@"pageNum"];
            [nowDic setObject:[NSNumber numberWithInt:perCount] forKey:@"pageSize"];
//            [self getData];
            [self getData:nowDic];
            [_oneSeg setHidden:YES];
            [_twoSeg setHidden:NO];
            [_twoSeg setSelectedSegmentIndex:0];
            [_searchText setHidden:YES];
        }
            break;
            //姓名排序
        case 2:
        {
            pageCount=1;
            [nowDic removeAllObjects];
            [nowDic setObject:@"1" forKey:@"cstate"];
            [nowDic setObject:@"N" forKey:@"orderBy"];
            [nowDic setObject:@"0" forKey:@"sendtype"];
            AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
            [nowDic setObject:app.userModel.token forKey:@"token"];
            [nowDic setObject:[NSNumber numberWithInt:pageCount] forKey:@"pageNum"];
            [nowDic setObject:[NSNumber numberWithInt:perCount] forKey:@"pageSize"];
            [dataList removeAllObjects];
            [self.tableView reloadData];
//            [self getData];
            [_oneSeg setHidden:YES];
            [_twoSeg setHidden:YES];
            [_searchText setHidden:NO];
            _searchText.text=@"";
        }
            break;
  
        default:
            break;
    }
}
-(void)oneSegChange{
    NSInteger Index = _oneSeg.selectedSegmentIndex;
    switch (Index){
        case 0:
            [nowDic setObject:@"A" forKey:@"dOrderBy"];
            
            break;
            //正序
        case 1:
            [nowDic setObject:@"D" forKey:@"dOrderBy"];
            
            break;
            //反序
        
            
        default:
            break;
    }
    [self getData:nowDic];
}
-(void)twoSegChange{
    NSInteger Index = _twoSeg.selectedSegmentIndex;
    switch (Index){
            //H
        case 0:
            [nowDic setObject:@"H" forKey:@"lOrderBy"];
            break;
            //A
        case 1:
            [nowDic setObject:@"A" forKey:@"lOrderBy"];
            break;
            //B
        case 2:
            
            [nowDic setObject:@"B" forKey:@"lOrderBy"];
            break;
            //C
        case 3:
            
            [nowDic setObject:@"C" forKey:@"lOrderBy"];
            break;
            //D
        case 4:
            
            [nowDic setObject:@"W" forKey:@"lOrderBy"];
            break;
            //Exw
        default:
            break;
    }
    [self getData:nowDic];
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
    [HttpManageTool selectMyCueList:dic success:^(NSDictionary *toBCList) {
        [dataList removeAllObjects];
        
        self.tabBarItem.badgeValue = toBCList[@"count"];
        //NSMutableArray *arr=[toBCList mutableCopy];
        [dataList addObjectsFromArray:toBCList[@"data"]];
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
    [HttpManageTool selectMyCueList:dic success:^(NSDictionary *toBCList) {
         self.tabBarItem.badgeValue = toBCList[@"count"];
        if(toBCList.count>0){
            [dataList addObjectsFromArray:toBCList[@"data"]];
             pageCount ++;
            [weakSelf.tableView reloadData];
            
        }else{
            [weakSelf.tableView.mj_footer setHidden:YES];
            [weakSelf.tableView.mj_footer noticeNoMoreData];
        }
        
        
        [weakSelf.tableView.mj_footer endRefreshing];
        
        
    } failure:^(NSError *err) {
        [weakSelf.tableView.mj_footer endRefreshing];
    }];
//    [weakSelf.tableView.mj_header endRefreshing];
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
    CueList *cueModel =dataList[indexPath.row];
    [cell configureCell:cueModel];
    NSLog(@"%zd--%p",indexPath.row,cell);
    return cell;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    if(![MyUtil isEmptyString:textField.text] ){
        [nowDic setObject:textField.text forKey:@"nOrderBy"];
        [self getData:nowDic];
    }
    return YES;
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

-(void)dealloc{
    sortSeg =nil;
    _oneSeg = nil;
    _twoSeg =nil;
    _searchText =nil;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)searchAct:(UITextField *)sender {
    [sender resignFirstResponder];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    UIViewController * view = segue.destinationViewController;
    if ([view respondsToSelector:@selector(setCustid:)]) {
        
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        CueList *cueModel = dataList[indexPath.row];
        [view setValue:cueModel.TARGET_CUST_ID forKey:@"custid"];
    }
}


@end
