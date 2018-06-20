//
//  ToBeContactedViewController.m
//  SEMCRM
//
//  Created by sem on 16/2/2.
//  Copyright © 2016年 sem. All rights reserved.
//

#import "ToBeContactedViewController.h"
#import "ToBeContactedCell.h"
#import "CueList.h"
@interface ToBeContactedViewController ()
{
    NSMutableArray *toBCArr;
    int pageCount;
    int perCount;
    NSMutableDictionary *nowDic;
    UILabel *titleView;
}
@end

@implementation ToBeContactedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    toBCArr=[[NSMutableArray alloc]init];
    pageCount=1;
    perCount=20;
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];

    NSDictionary *dic = @{@"cstate":@"0",@"ordby":@"C",@"token":app.userModel.token,@"pageNum":[NSNumber numberWithInt:pageCount],@"pageSize":[NSNumber numberWithInt:perCount]};
     nowDic=[[NSMutableDictionary alloc]initWithDictionary:dic];
    [self getData];
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    titleView = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 44)];
    titleView.backgroundColor = [UIColor clearColor];
    titleView.font = [UIFont boldSystemFontOfSize:19];
    titleView.textColor = [UIColor blackColor];
    titleView.textAlignment = NSTextAlignmentCenter;
    titleView.text = @"待联络";
    self.tabBarController.navigationItem.titleView = titleView;
    [self getData:nowDic];
//    self.tabBarController.navigationItem.rightBarButtonItem = nil;
}
-(void)getData{
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
    
    
    [HttpManageTool selectToBeConTactList:dic success:^(NSDictionary *toBCList) {
        [toBCArr removeAllObjects];
        titleView.text=[NSString stringWithFormat:@"%@(%@)",@"待联络",toBCList[@"count"]];
        [toBCArr addObjectsFromArray:toBCList[@"data"]];
        if(toBCArr.count>0){
            pageCount++;
            [weakSelf.tableView.mj_footer setHidden:NO];
            //            [weakSelf.tableView.mj_footer resetNoMoreData];
        }
        [self.tableView reloadData];
        [weakSelf.tableView.mj_header endRefreshing];
    } failure:^(NSError *err) {
        //[self.tableView reloadData];
        [weakSelf.tableView.mj_header endRefreshing];
    }];
    
    
    
    
    
}
#pragma mark 获取更多一起玩数据
-(void)getDataWithDicMore:(NSDictionary *)dic{
    __weak __typeof(self)weakSelf = self;
    [HttpManageTool selectToBeConTactList:dic success:^(NSDictionary *toBCList) {
        titleView.text=[NSString stringWithFormat:@"%@(%@)",@"待联络",toBCList[@"count"]];
        if(toBCList.count>0){
            [toBCArr addObjectsFromArray:toBCList[@"data"]];
            pageCount ++;
            [weakSelf.tableView reloadData];
        }else{
            [weakSelf.tableView.mj_footer setHidden:YES];
            [weakSelf.tableView.mj_footer noticeNoMoreData];
        }
        [weakSelf.tableView.mj_footer endRefreshing];
    } failure:^(NSError *err) {
        //[self.tableView reloadData];
        [weakSelf.tableView.mj_footer endRefreshing];
    }];
    
    //    [weakSelf.tableView.mj_header endRefreshing];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return toBCArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ToBeContactedCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ToBeContactedCell" forIndexPath:indexPath];
    CueList *cueModel = toBCArr[indexPath.row];
    [cell configureCell:cueModel];
    return cell;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    UIViewController * view = segue.destinationViewController;
    if ([view respondsToSelector:@selector(setCustid:)]) {
        
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        CueList *cueModel = toBCArr[indexPath.row];
        [view setValue:cueModel.TARGET_CUST_ID forKey:@"custid"];
    }
}


@end
