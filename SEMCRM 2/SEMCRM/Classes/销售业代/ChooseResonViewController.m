//
//  ChooseResonViewController.m
//  SEMCRM
//
//  Created by 薛斯岐 on 16/3/2.
//  Copyright © 2016年 sem. All rights reserved.
//

#import "ChooseResonViewController.h"
#import "ResonModel.h"
@interface ChooseResonViewController ()
{
    NSMutableArray *reasonArr;
    BOOL isOnly;
}
@property (weak, nonatomic) IBOutlet UIBarButtonItem *completeBtn;
@end

@implementation ChooseResonViewController
- (IBAction)completeAct:(id)sender {
    NSMutableString *ss =[[NSMutableString alloc]init];
    
    for (int i=0;i<reasonArr.count;i++) {
        NSDictionary *dic =reasonArr[i];
        NSString *key = [dic allKeys][0];
        NSArray *arr = [dic objectForKey:key];
        for (ResonModel *model in arr) {
            if(model.isSel){
                [ss appendString:model.title];
                [ss appendString:@";"];
                
            }
        }
        
        
        
    }
    if ([self.delegate respondsToSelector:@selector(chooseReson:)]) {
        [self.delegate chooseReson:ss];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *arrTemp=[[NSArray alloc]init];
    reasonArr=[[NSMutableArray alloc]init];
    
    if([_keyStr isEqualToString:@"okreason"]){
        _completeBtn.enabled =YES;
        isOnly=false;
        arrTemp=@[@"质量好",@"价格实惠",@"安全性高",@"性能好",@"油耗经济",@"外观好看",@"内饰好看",@"空间大",@"经销商服务好",@"其他"];
    }else if ([_keyStr isEqualToString:@"noreason"]){
        _completeBtn.enabled =false;
        isOnly=true;
        if(_isSem!=NULL&&[_isSem isEqualToString:@"T"]){
            arrTemp=@[@"非本区域客户",@"客户已购车",@"未购车，无进一步购车意愿"];
        }else{
            arrTemp=@[@"多次联系无人接听",@"非本区域客户",@"客户已购车",@"未购车，无进一步购车意愿",@"空号",@"电话号码录入错误"];
        }
        
    }
    if([_keyStr isEqualToString:@"dreason"]){
//    —— 品牌力——不喜欢本品牌口碑差/知名度低—— 产品力——外观不好内饰不好配置不足动力不足操控不好空间不足安全性不好油耗高噪音大—— 价格因素——价格偏高—— 其他——贷款条件不符资金不足车型无法及时供应暂缓购车客户失联已在其它店购买本/其他品牌车型
        NSMutableArray *arrNew1 = [[NSMutableArray alloc]init];
        NSArray *arrTemp1=@[@"不喜欢本品牌",@"口碑差/知名度低"];
        
        NSArray *arrTemp2=@[@"外观不好",@"内饰不好",@"配置不足",@"动力不足",@"操控不好",@"空间不足",@"安全性不好",@"油耗高",@"噪音大"];
        
        NSArray *arrTemp3=@[@"价格偏高"];
        
        NSArray *arrTemp4=@[@"贷款条件不符",@"资金不足",@"车型无法及时供应",@"暂缓购车",@"客户失联",@"非本区域客户",@"已在其它店购买本/其他品牌车型"];
        NSArray *arrTitle1=@[@"——品牌力——",@"——产品力——",@"——价格因素——",@"——其他——"];
        [arrNew1 addObject:arrTemp1];
        [arrNew1 addObject:arrTemp2];
        [arrNew1 addObject:arrTemp3];
        [arrNew1 addObject:arrTemp4];
        
        for (int i =0 ;i<arrNew1.count;i++) {
            NSMutableArray *tempArr = [[NSMutableArray alloc]init];
            NSArray *arrTemp1 =arrNew1[i];
            for (NSString *value in arrTemp1) {
                ResonModel *resonModel =[[ResonModel alloc]init];
                resonModel.title = value;
                resonModel.isSel =false;
                [tempArr addObject:resonModel];
            }
            NSMutableDictionary *dic =[[NSMutableDictionary alloc]init];
            [dic setObject:tempArr forKey:arrTitle1[i]];
            [reasonArr addObject:dic];
        }
        
    }else{
        NSMutableArray *tempArr = [[NSMutableArray alloc]init];
        
        for (NSString *value in arrTemp) {
            ResonModel *resonModel =[[ResonModel alloc]init];
            resonModel.title = value;
            resonModel.isSel =false;
            [tempArr addObject:resonModel];
            
            
        }
        NSDictionary *dic =@{@"请选择原因：":tempArr};
        [reasonArr addObject:dic];
    }
    
   
    // Do any additional setup after loading the view.
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return reasonArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSDictionary *dic =reasonArr[section];
    NSString *key =[dic allKeys][0];
    NSArray *arr = [dic objectForKey:key];
    return arr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ResonCell" forIndexPath:indexPath];
    NSDictionary *dic =reasonArr[indexPath.section];
    NSString *key =[dic allKeys][0];
    NSArray *arr = [dic objectForKey:key];
    ResonModel *resonModel = arr[indexPath.row];
    cell.textLabel.text = resonModel.title;
    if(!isOnly){
        if(resonModel.isSel){
            cell.accessoryType= UITableViewCellAccessoryCheckmark;
        }else{
            cell.accessoryType= UITableViewCellAccessoryNone;
        }
        
    }
    return cell;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSDictionary *dic =reasonArr[section];
    NSString *key =[dic allKeys][0];
    return key;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dic =reasonArr[indexPath.section];
    NSString *key =[dic allKeys][0];
    NSArray *arr = [dic objectForKey:key];
    ResonModel *resonModel = arr[indexPath.row];
    NSIndexSet *sexStr = [NSIndexSet indexSetWithIndex:indexPath.section];
    if(isOnly){
        if ([self.delegate respondsToSelector:@selector(chooseReson:)]) {
            [self.delegate chooseReson:resonModel.title];
        }
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        resonModel.isSel=!resonModel.isSel;
        [tableView reloadSections:sexStr withRowAnimation:UITableViewRowAnimationNone];
    }
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
