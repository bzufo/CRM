//
//  CaseChooseCConditionViewDelegate.h
//  SEMCRM
//
//  Created by Sem on 2017/7/4.
//  Copyright © 2017年 sem. All rights reserved.
//

#import "SemCRMTableViewController.h"
@protocol CaseChooseCConditionDelegate <NSObject>

-(void)chooseCCondition:(NSDictionary *)dic;

@end
@interface CaseChooseCConditionViewDelegate : SemCRMTableViewController
@property (nonatomic, retain) id<CaseChooseCConditionDelegate> delegate;
@end
