//
//  SemCRMEnclosureListViewController.h
//  SEMCRM
//
//  Created by Sem on 2017/7/19.
//  Copyright © 2017年 sem. All rights reserved.
//

#import "SemCRMTableViewController.h"
@protocol AddEnclosureDelegate <NSObject>

-(void)addEnclosure:(NSMutableArray *)arrNew;

@end
@interface SemCRMEnclosureListViewController : SemCRMTableViewController
@property (nonatomic,retain)NSMutableArray *enclosureArr;
@property (nonatomic, retain) id<AddEnclosureDelegate> delegate;
@property (nonatomic,copy)NSString *isAdd;
@end
