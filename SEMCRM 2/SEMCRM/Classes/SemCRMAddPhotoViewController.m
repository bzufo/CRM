//
//  SemCRMAddPhotoViewController.m
//  SEMCRM
//
//  Created by Sem on 2017/5/31.
//  Copyright © 2017年 sem. All rights reserved.
//

#import "SemCRMAddPhotoViewController.h"
#import "SemCRMPreviewViewController.h"
@interface SemCRMAddPhotoViewController ()
@property (weak, nonatomic) IBOutlet UIBarButtonItem *commitBTN;
@end

@implementation SemCRMAddPhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.tableFooterView= [[UIView alloc] initWithFrame:CGRectZero];
    if(_currentImages==nil){
        _currentImages=[[NSMutableArray alloc]initWithCapacity:0];
    }
    // Do any additional setup after loading the view.
}
- (IBAction)savePhoto:(UIBarButtonItem *)sender {
    if(_currentImages.count < 1){
        [MyUtil showMessage:@"请选择图片！"];
        return;
    }
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    //app.userModel.tokenaction=list
     NSDictionary *dic = @{@"action":@"list",@"token":app.userModel.token};
    
   
    [HttpManageTool upEnclousure:dic block:^(id<AFMultipartFormData> formData) {
        
        //[formData appendPartWithFileData:UIImagePNGRepresentation(_currentImages[0]) name:@"importFile1" fileName:@"Vehicle_license.png" mimeType:@"image/png"];
        
        if(_currentImages.count>0){
            int i = 1;
            //根据当前系统时间生成图片名称
            NSDate *date = [NSDate date];
            NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
            [formatter setDateFormat:@"yyyyMMddHHmmss"];
            NSString *dateString = [formatter stringFromDate:date];
            for (UIImage *image in _currentImages) {
                NSString *fileName = [NSString stringWithFormat:@"%@%d.png",dateString,i];
                NSString *parameter = [NSString stringWithFormat:@"importFile%d",i];
                NSLog(@"%@:%@",parameter,fileName);
                NSData *imageData;
                
                imageData = [MyUtil scaleImage:image toKb:500];
                
                [formData appendPartWithFileData:imageData name:parameter fileName:fileName mimeType:@"image/png"];
                i++;
            }
            
        }
        
    } success:^(NSArray *resultArr) {
        if(resultArr){
            
            if ([self.delegate respondsToSelector:@selector(addPhoto:)]) {
                [self.delegate addPhoto:resultArr];
                [self.navigationController popViewControllerAnimated:YES];
            }
        }
        
    } failure:^(NSError *err) {
       // [MyUtil showMessage:@"上传失败!"];
    }];

}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row==_currentImages.count)
    {
        if(_currentImages.count == 5-[_countStr intValue]){
            [MyUtil showMessage:@"已达到上传上限！"];
            return;
        }
        UIActionSheet *action=[[UIActionSheet alloc] initWithTitle:@"选取照片" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"从摄像头选取", @"从图片库选择",nil];
        [action showInView:self.view];
    }
    else
    {
        
        SemCRMPreviewViewController *viewViewController=[[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"PreviewVC"];
        viewViewController.delegate =self;
        viewViewController.showImage=_currentImages[indexPath.row];
        viewViewController.flag =@"1";
        [self.navigationController pushViewController:viewViewController animated:YES];
    }
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _currentImages.count==0?1:_currentImages.count+1;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"collectionCell" forIndexPath:indexPath];
    UIImageView *imageView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    if(_currentImages.count==0||indexPath.row==_currentImages.count)
    {
        while ([cell.contentView.subviews lastObject] != nil) {
            [(UIView*)[cell.contentView.subviews lastObject] removeFromSuperview];
        }
        
        imageView.image=[UIImage imageNamed:@"add_pic"];
    }
    else{
        while ([cell.contentView.subviews lastObject] != nil) {
            [(UIView*)[cell.contentView.subviews lastObject] removeFromSuperview];
        }
        imageView.image=_currentImages[indexPath.row];
    }
    imageView.contentMode=UIViewContentModeScaleAspectFill;
    [cell.contentView addSubview:imageView];
    return  cell;
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 0:
            [self openCamera];
            break;
        case 1:
            [self openLibary];
            break;
        default:
            break;
    }
}
-(void)openCamera{
    //UIImagePickerControllerSourceType *type=UIImagePickerControllerSourceTypeCamera;
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
	   {
           UIImagePickerController *picker=[[UIImagePickerController alloc] init];
           picker.delegate=self;
           picker.sourceType=UIImagePickerControllerSourceTypeCamera;
           picker.allowsEditing=YES;
           [self presentViewController:picker animated:YES completion:nil];
       }
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *image=[info objectForKey:UIImagePickerControllerOriginalImage];
//    NSData * imageData = UIImageJPEGRepresentation(image, 0.3);
//    UIImage * newImage1 = [UIImage imageWithData:imageData];
    
    //UIImage *newimage=[self imageWithImage:image scaledToSize:CGSizeMake(500, 500)];
    if(_currentImages ==nil)
    {
        _currentImages=[[NSMutableArray alloc] init];
    }
    [_currentImages addObject:image];
    [_photosCollectionView reloadData];
    //    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:1 inSection:0];
    //    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    // [self saveImage:image withName:@""]
}
//手动实现图片压缩，可以写到分类里，封装成常用方法。按照大小进行比例压缩，改变了图片的size。

- (UIImage *)makeThumbnailFromImage:(UIImage *)srcImage scale:(double)imageScale {
    
    UIImage *thumbnail = nil;
    
    CGSize imageSize = CGSizeMake(srcImage.size.width * imageScale, srcImage.size.height * imageScale);
    
    if (srcImage.size.width != imageSize.width || srcImage.size.height != imageSize.height)
        
    {
        
        UIGraphicsBeginImageContext(imageSize);
        
        CGRect imageRect = CGRectMake(0.0, 0.0, imageSize.width, imageSize.height);
        
        [srcImage drawInRect:imageRect];
        
        thumbnail = UIGraphicsGetImageFromCurrentImageContext();
        
        UIGraphicsEndImageContext();
        
    }
    
    else
        
    {
        
        thumbnail = srcImage;
        
    }
    
    return thumbnail;
    
}
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}
-(void)openLibary{
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
    {
        UIImagePickerController *picker=[[UIImagePickerController alloc] init];
        picker.delegate=self;
        picker.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
        picker.allowsEditing=YES;
        [self presentViewController:picker animated:YES completion:nil];
    }
}
-(void)deleteSelectedImage:(NSInteger)index
{
    if(_currentImages!=nil)
        [_currentImages removeObjectAtIndex:index];
    
     [_photosCollectionView reloadData];
}
-(void)deleteSelectedImageWithImage:(UIImage *)image{
    if(_currentImages!=nil)
        [_currentImages removeObject:image];
    
     [_photosCollectionView reloadData];
}
-(void)delImage:(UIImage *)chooseimage{
    [self deleteSelectedImageWithImage:chooseimage];
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
