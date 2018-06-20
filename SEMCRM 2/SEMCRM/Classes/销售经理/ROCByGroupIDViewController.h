//
//  ROCByGroupIDViewController.h
//  SEMCRM
//
//  Created by 薛斯岐 on 16/2/24.
//  Copyright © 2016年 sem. All rights reserved.
//

#import "SemCRMTableViewController.h"
#import "GroupModel.h"
@interface ROCByGroupIDViewController : SemCRMTableViewController
@property (nonatomic,retain)GroupModel *groupModel;
@property (nonatomic,copy)NSString *orderBy;
@end
