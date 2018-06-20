//
//  CarsChooseViewController.m
//  SEMCRM
//
//  Created by 薛斯岐 on 16/2/26.
//  Copyright © 2016年 sem. All rights reserved.
//

#import "CarsChooseViewController.h"

@interface CarsChooseViewController ()
{
    NSArray *carsArr;
}
@end

@implementation CarsChooseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if([_cars isEqualToString:@"SEM"]){
        if(_typeD!=nil && [_typeD isEqualToString:@"D"]){
            carsArr=@[@"DX7",@"DX3",@"DX3BEV",@"V5",@"V3",@"V6",@"DE",@"C1"];
        }else{
            carsArr=@[@"DX7",@"DX3",@"DX3EV",@"V5",@"V3",@"V6",@"DE",@"C1"];
        }
        
    }else{
        carsArr=@[@"GS",@"LS",@"PS",@"AS",@"FT"];
    }
    // Do any additional setup after loading the view.
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return carsArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"carsCell" forIndexPath:indexPath];
    cell.textLabel.text=carsArr[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cars =carsArr[indexPath.row];
    if ([self.delegate respondsToSelector:@selector(updataCarsInfo:)]) {
        [self.delegate updataCarsInfo:cars];
    }
    [self.navigationController popViewControllerAnimated:YES];
    
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
