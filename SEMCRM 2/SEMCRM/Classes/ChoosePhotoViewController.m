//
//  ChoosePhotoViewController.m
//  SEMCRM
//
//  Created by 薛斯岐 on 16/3/15.
//  Copyright © 2016年 sem. All rights reserved.
//

#import "ChoosePhotoViewController.h"
#import "UzysAssetsPickerController.h"
@interface ChoosePhotoViewController ()<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UzysAssetsPickerControllerDelegate>
{
    
}
@property (weak, nonatomic) IBOutlet UIBarButtonItem *commitBTN;
@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;

@end

@implementation ChoosePhotoViewController
- (IBAction)chooseAct:(UIButton *)sender {
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:@"图片选择"
                                  delegate:self
                                  cancelButtonTitle:@"取消"
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:@"相册", @"相机",nil];
    actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    [actionSheet showInView:self.view];
}
- (void)actionSheet:(UIActionSheet *)actionSheet    clickedButtonAtIndex:(NSInteger)buttonIndex {
    switch (buttonIndex) {
        case 0:
            //相册
            [self xiangceAct:nil];
            break;
        case 1:
            //相机
            [self paizhaoAct:nil];
            break;
        default:
            break;
    }
}
#pragma mark - 相册
-(void)xiangceAct:(id)sender{
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera])
    {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        //设置拍照后的图片可被编辑
        picker.allowsEditing = YES;
        picker.sourceType = sourceType;
        [self presentViewController:picker animated:YES completion:^{
            
        }];
        
    }else
    {
        NSLog(@"模拟其中无法打开照相机,请在真机中使用");
    }
    UIImagePickerController *imagePicker=[[UIImagePickerController alloc] init];
    
    imagePicker.delegate=self;
    
    imagePicker.allowsEditing=YES;
    
    imagePicker.sourceType=sourceType;
    
    [self presentViewController:imagePicker animated:YES completion:^{
        
    }];

}
#pragma mark - 拍照
-(void)paizhaoAct:(id)sender{
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera])
    {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        //设置拍照后的图片可被编辑
        picker.allowsEditing = YES;
        picker.sourceType = sourceType;
        [self presentViewController:picker animated:YES completion:^{
            
        }];
        
    }else
    {
        NSLog(@"模拟其中无法打开照相机,请在真机中使用");
    }
    
}
//imagepicker 的delegate事件
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
    
    // UIImage *image=[info objectForKey:UIImagePickerControllerOriginalImage];//原始图
    UIImage *image=[info objectForKey:UIImagePickerControllerEditedImage];
    [_photoImageView setImage:[[UIImage alloc] initWithData:UIImageJPEGRepresentation(image, 0.3)]];
    
    
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
     self.commitBTN.enabled=true;
    // Do any additional setup after loading the view.
}
- (IBAction)completeAct:(UIBarButtonItem *)sender {
    if(!_photoImageView.image){
        [MyUtil showMessage:@"请上传图片"];
        return;
    }
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    //app.userModel.token
    //
    NSDictionary *dic = @{@"action":@"add",@"token":app.userModel.token,@"vin":_vin};
    
    [HttpManageTool upVehicleLicen:dic block:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileData:UIImagePNGRepresentation(_photoImageView.image) name:@"importFile" fileName:@"Vehicle_license.png" mimeType:@"image/png"];
    } success:^(BOOL result) {
        if(result){
            [MyUtil showMessage:@"上传成功!"];
            self.commitBTN.enabled=false;
        }
    } failure:^(NSError *err) {
        
    }];
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
