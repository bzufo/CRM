//
//  SemChooseCConditionViewDelegate.h
//  SEMCRM
//
//  Created by Sem on 2017/7/10.
//  Copyright © 2017年 sem. All rights reserved.
//

#import "SemCRMTableViewController.h"
@protocol SemChooseCConditionDelegate <NSObject>

-(void)chooseCCondition:(NSDictionary *)dic;

@end
@interface SemChooseCConditionViewDelegate : SemCRMTableViewController
@property (nonatomic, retain) id<SemChooseCConditionDelegate> delegate;
@end
