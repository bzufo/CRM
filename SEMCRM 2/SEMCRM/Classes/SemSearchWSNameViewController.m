//
//  SemSearchWSNameViewController.m
//  SEMCRM
//
//  Created by Sem on 2017/7/11.
//  Copyright © 2017年 sem. All rights reserved.
//

#import "SemSearchWSNameViewController.h"

@interface SemSearchWSNameViewController ()
{
    NSMutableArray *wsNameArr;
    NSMutableArray *keyNameArr;
}
@property (weak, nonatomic) IBOutlet UITextField *searchText;

@end

@implementation SemSearchWSNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.tableFooterView= [[UIView alloc] initWithFrame:CGRectZero];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 44;
    keyNameArr =[NSMutableArray arrayWithCapacity:0];
     wsNameArr =[NSMutableArray arrayWithCapacity:0];
    [self getData];
    // Do any additional setup after loading the view.
}

-(void)getData{
    [wsNameArr removeAllObjects];
    NSString *path =[MyUtil getFilePath:WS_NAME];
    NSArray *arr = [NSArray arrayWithContentsOfFile:path];
    if(arr){
        [wsNameArr addObjectsFromArray:arr];
    }
     [keyNameArr addObjectsFromArray:wsNameArr];
    [self.tableView reloadData];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    [keyNameArr removeAllObjects];
    if(![MyUtil isEmptyString:textField.text] ){
        for (NSDictionary  *dic in wsNameArr) {
            NSString *wsNameStr = [dic objectForKey:@"ws_shortname"];
            NSComparisonResult result = [wsNameStr compare:textField.text options:(NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch) range:NSMakeRange(0, [textField.text length])];
            if (result == NSOrderedSame)
            {
                [keyNameArr addObject:dic];
            }
        }
        
    }else{
        [keyNameArr addObjectsFromArray:wsNameArr];
    }
    [self.tableView reloadData];
    return YES;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return keyNameArr.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic =keyNameArr[indexPath.row];
    if ([self.delegate respondsToSelector:@selector(chooseWS:)]) {
        [self.delegate chooseWS:dic];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"wsNameCell" forIndexPath:indexPath];
    NSDictionary *dic =keyNameArr[indexPath.row];
    cell.textLabel.text =[dic objectForKey:@"ws_shortname"];
    return cell;
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
