//
//  SemCRMWsClosedCaseViewController.h
//  SEMCRM
//
//  Created by Sem on 2017/6/30.
//  Copyright © 2017年 sem. All rights reserved.
//

#import "SemCRMTableViewController.h"
@protocol ClosedCaseDelegate <NSObject>

-(void)closeCase;

@end
@interface SemCRMWsClosedCaseViewController : SemCRMTableViewController
@property (nonatomic,copy)NSString *rhNo;
@property (nonatomic, retain) id<ClosedCaseDelegate> delegate;
@end
