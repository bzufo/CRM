//
//  SemCRMAddPhotoViewController.h
//  SEMCRM
//
//  Created by Sem on 2017/5/31.
//  Copyright © 2017年 sem. All rights reserved.
//
@protocol AddPhotoDelegate <NSObject>

-(void)addPhoto:(NSArray *)arrNew;

@end
#import "SemCRMTableViewController.h"
#import "SemCRMPreviewViewController.h"
@interface SemCRMAddPhotoViewController : SemCRMTableViewController<UITextViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,SemCRMPreviewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *photosCollectionView;
@property (nonatomic,copy)NSString *type;
@property (nonatomic,copy)NSString *countStr;
@property (nonatomic,copy)NSMutableArray *currentImages;
-(void) deleteSelectedImage:(NSInteger) index;
-(void) deleteSelectedImageWithImage:(UIImage*)image;
@property (nonatomic, retain) id<AddPhotoDelegate> delegate;

@end
