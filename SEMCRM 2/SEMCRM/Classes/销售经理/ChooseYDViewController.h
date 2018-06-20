//
//  ChooseYDViewController.h
//  SEMCRM
//
//  Created by 薛斯岐 on 16/3/4.
//  Copyright © 2016年 sem. All rights reserved.
//

#import "SemCRMTableViewController.h"
@protocol ChooseYDDelegate <NSObject>

-(void)chooseYD:(NSString *)users;

@end

@interface ChooseYDViewController : SemCRMTableViewController
@property (nonatomic,assign)BOOL isOnly;
@property (nonatomic,copy)NSString *employee_no;
@property (nonatomic, retain) id<ChooseYDDelegate> delegate;
@end
