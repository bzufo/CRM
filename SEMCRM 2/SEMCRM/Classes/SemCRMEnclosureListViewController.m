//
//  SemCRMEnclosureListViewController.m
//  SEMCRM
//
//  Created by Sem on 2017/7/19.
//  Copyright © 2017年 sem. All rights reserved.
//

#import "SemCRMEnclosureListViewController.h"
#import "FileModle.h"
#import "SemCRMAddPhotoViewController.h"
#import "EnWebShowViewController.h"
@interface SemCRMEnclosureListViewController ()<AddPhotoDelegate>
@property (weak, nonatomic) IBOutlet UIBarButtonItem *moreBtn;
@property (weak, nonatomic) IBOutlet UIButton *addBtn;

@end

@implementation SemCRMEnclosureListViewController
-(void)addPhoto:(NSArray *)arrNew{
    //[MyUtil showMessage:@"添加成功！"];
    [_enclosureArr addObjectsFromArray:arrNew];
    [self.tableView reloadData];
}
- (IBAction)moreAct:(id)sender {
    if ([self.delegate respondsToSelector:@selector(addEnclosure:)]) {
        [self.delegate addEnclosure:_enclosureArr];
        [self.navigationController popViewControllerAnimated:YES];
    }
}
- (IBAction)addAct:(id)sender {
    if(_enclosureArr.count>5){
        [MyUtil showMessage:@"最多不能超过5个!"];
    }
    SemCRMAddPhotoViewController *viewViewController=[[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"SemCRMAddPhotoViewController"];
    viewViewController.countStr = [NSString stringWithFormat:@"%ld",_enclosureArr.count];
    viewViewController.delegate=self;
    [self.navigationController pushViewController:viewViewController animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if(_isAdd==nil){
        self.navigationItem.rightBarButtonItem = nil;
        
        [self.addBtn setTitle:[NSString stringWithFormat:@"有%ld个附件",_enclosureArr.count] forState:UIControlStateNormal];
        self.addBtn.enabled =false;
    }
    if(_enclosureArr==nil){
        _enclosureArr =[[NSMutableArray alloc]initWithCapacity:0];
    }
    // Do any additional setup after loading the view.
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _enclosureArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"photoTitleCell" forIndexPath:indexPath];
    FileModle *model =_enclosureArr[indexPath.row];
    cell.textLabel.text=model.file_name;
    return cell;
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_enclosureArr removeObjectAtIndex:indexPath.row];
        // Delete the row from the data source.
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
    }
    
}
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除";
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
     FileModle *model =_enclosureArr[indexPath.row];
    EnWebShowViewController *viewController = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]]instantiateViewControllerWithIdentifier:@"EnWebShowViewController"];
    viewController.contenttype=[MyUtil getcontenttype:model.file_name];
    viewController.fileId=model.file_id;
    [self.navigationController pushViewController:viewController animated:YES];
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
