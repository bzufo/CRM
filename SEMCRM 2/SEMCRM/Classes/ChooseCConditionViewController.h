//
//  ChooseCConditionViewController.h
//  SEMCRM
//
//  Created by Sem on 2017/5/15.
//  Copyright © 2017年 sem. All rights reserved.
//

#import "SemCRMTableViewController.h"
@protocol ChooseCConditionViewDelegate <NSObject>

-(void)chooseCCondition:(NSDictionary *)dic;

@end
@interface ChooseCConditionViewController : SemCRMTableViewController
@property (nonatomic, retain) id<ChooseCConditionViewDelegate> delegate;
@end
