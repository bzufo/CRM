//
//  SemCRMPreviewViewController.h
//  SEMCRM
//
//  Created by Sem on 2017/5/31.
//  Copyright © 2017年 sem. All rights reserved.
//

#import "SemCRMBaseViewController.h"
@protocol  SemCRMPreviewDelegate <NSObject>

-(void)delImage:(UIImage *)chooseimage;

@end
@interface SemCRMPreviewViewController : SemCRMBaseViewController<UIActionSheetDelegate>
@property (nonatomic,copy)NSString *flag;
@property (nonatomic,copy)UIImage *showImage;
@property (nonatomic, retain) id<SemCRMPreviewDelegate> delegate;
@end
