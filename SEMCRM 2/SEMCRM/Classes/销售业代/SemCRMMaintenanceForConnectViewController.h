//
//  SemCRMMaintenanceForConnectViewController.h
//  SEMCRM
//
//  Created by 薛斯岐 on 16/2/22.
//  Copyright © 2016年 sem. All rights reserved.
//

#import "SemCRMTableViewController.h"

@interface SemCRMMaintenanceForConnectViewController : SemCRMTableViewController
{
    NSMutableArray *colorArr;
}
@property(nonatomic,retain)CueList *cueModel;
@property(nonatomic,retain)NSString *cidStr;
@property(nonatomic,assign)BOOL isCall;
@property (nonatomic,retain)NSString *callType;
@property (nonatomic,retain)NSString *isChange;
@end
