//
//  SemCRMLoseCueListViewController.m
//  SEMCRM
//
//  Created by Sem on 2017/6/7.
//  Copyright © 2017年 sem. All rights reserved.
//

#import "SemCRMLoseCueListViewController.h"
#import "LoseCueCell.h"
@interface SemCRMLoseCueListViewController ()
{
    NSMutableArray *dataArr;
    
}
@property (weak, nonatomic) IBOutlet UILabel *countLal;
@end

@implementation SemCRMLoseCueListViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self getData];
}
-(void)getData{
    
    [dataArr removeAllObjects];
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    //app.userModel.token
    NSDictionary *dic = @{@"token":app.userModel.token};
    [HttpManageTool selectLostCueList:dic success:^(NSDictionary *dataListDic) {
        NSArray *dataArrTemp =dataListDic[@"data"];
        
        NSArray *resultArr = [CueList mj_objectArrayWithKeyValuesArray:dataArrTemp];
        [dataArr addObjectsFromArray:resultArr];
        NSString *countStr =dataListDic[@"count"];
        if(countStr){
            _countLal.text = countStr;
        }
        [self.tableView reloadData];
    } failure:^(NSError *err) {
        [self.tableView reloadData];
    }];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return dataArr.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 78;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LoseCueCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LoseCueCell" forIndexPath:indexPath];
    CueList *modle = dataArr[indexPath.row];
    
    [cell configureCell:modle];
    return cell;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    dataArr =[[NSMutableArray alloc]init];

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    UIViewController * view = segue.destinationViewController;
    if ([view respondsToSelector:@selector(setCustid:)]) {
        
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        CueList *cuelist =dataArr[indexPath.row];
        [view setValue:cuelist.TARGET_CUST_ID forKey:@"custid"];
    }
    if ([view respondsToSelector:@selector(setIndexNext:)]) {
        
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        
        [view setValue:[NSString stringWithFormat:@"%ld",indexPath.row] forKey:@"indexNext"];
    }
    if([view respondsToSelector:@selector(setSendFlag:)]){
        [view setValue:@"1" forKey:@"sendFlag"];
        
    }
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
