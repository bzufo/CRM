//
//  SemCRMPreviewViewController.m
//  SEMCRM
//
//  Created by Sem on 2017/5/31.
//  Copyright © 2017年 sem. All rights reserved.
//

#import "SemCRMPreviewViewController.h"

@interface SemCRMPreviewViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *previewImageView;
@end

@implementation SemCRMPreviewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if(_flag){
        if([_flag isEqualToString:@"1"]){
            UIBarButtonItem *barButtonItem =[[UIBarButtonItem alloc]initWithTitle:@"删除" style:UIBarButtonItemStylePlain target:self action:@selector(deleteSelectedImage)];
            
            self.navigationItem.rightBarButtonItem=barButtonItem;
        }
        
    }
    _previewImageView.image=_showImage;
    // Do any additional setup after loading the view.
}
- (void)deleteSelectedImage{
    UIActionSheet *action=[[UIActionSheet alloc] initWithTitle:@"要删除这张照片吗？" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"删除" otherButtonTitles: nil];
    [action showInView:self.view];
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex==actionSheet.cancelButtonIndex)
    {
        return;
    }
    else
    {
        [_delegate delImage:_showImage];
        [self.navigationController popViewControllerAnimated:YES];
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
