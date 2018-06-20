//
//  ChooseSeriesCodeViewController.m
//  SEMCRM
//
//  Created by 薛斯岐 on 16/5/13.
//  Copyright © 2016年 sem. All rights reserved.
//

#import "ChooseSeriesCodeViewController.h"

@interface ChooseSeriesCodeViewController ()
{
    NSMutableArray *seriesCodeArr;
    NSMutableArray *searchArr;
}
@end

@implementation ChooseSeriesCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    searchArr =[[NSMutableArray alloc]init];
    seriesCodeArr =[[NSMutableArray alloc]init];
    [self getData];
    // Do any additional setup after loading the view.
}
-(void) getData{
    __weak __typeof(self)weakSelf = self;
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
     NSDictionary *dic =@{@"token":app.userModel.token,@"brandCode":_brand,@"seriesCode":_series};
    [HttpManageTool selectSeriesCodeList:dic success:^(NSArray *seriesCodeList) {
        [seriesCodeArr removeAllObjects];
        [seriesCodeArr addObjectsFromArray:seriesCodeList]  ;
        [weakSelf.tableView reloadData];
    } failure:^(NSError *err) {
        
    }];
    
}
#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return searchArr.count;
    }
    return seriesCodeArr.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *kCustomCellID = @"QBPeoplePickerControllerCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCustomCellID];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCustomCellID] ;
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    NSString *ss =@"";
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        ss = searchArr[indexPath.row];
    }else{
        ss = seriesCodeArr[indexPath.row];
    }
    cell.textLabel.text=ss;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44.f;
}
#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *ss =@"";
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        ss = searchArr[indexPath.row];
    }else{
        ss = seriesCodeArr[indexPath.row];
    }
    if ([self.delegate respondsToSelector:@selector(chooseSeriesCode:)]) {
        [self.delegate chooseSeriesCode:ss];
    }
    [self.navigationController popViewControllerAnimated:YES];
//
//
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
#pragma mark -
#pragma mark UISearchBarDelegate

- (void)searchBarTextDidBeginEditing:(UISearchBar *)_searchBar
{
    //[self.searchDisplayController.searchBar setShowsCancelButton:NO];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)_searchBar
{
    [self.searchDisplayController setActive:NO animated:YES];
    //[self.tableView reloadData];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)_searchBar
{
    
    //[self.tableView reloadData];
}

#pragma mark -
#pragma mark UISearchDisplayControllerDelegate

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [searchArr removeAllObjects];
   NSString *studentUp         = [searchString uppercaseString];
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF CONTAINS %@",studentUp];
    [searchArr addObjectsFromArray:[seriesCodeArr filteredArrayUsingPredicate:pred]];
//    NSLog(@"%@",[seriesCodeArr filteredArrayUsingPredicate:pred]);
    return YES;
}


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
