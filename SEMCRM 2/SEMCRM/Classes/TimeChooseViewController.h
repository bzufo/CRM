//
//  TimeChooseViewController.h
//  SEMCRM
//
//  Created by 薛斯岐 on 16/2/26.
//  Copyright © 2016年 sem. All rights reserved.
//

#import "SemCRMBaseViewController.h"
@protocol TimeChooseDelegate <NSObject>

-(void)updataTimeInfo:(NSString *)chooseCars;

@end
@interface TimeChooseViewController : SemCRMBaseViewController
@property (nonatomic,retain)NSString *timeValue;
@property (nonatomic,retain)NSString *typeStr;
@property (nonatomic, retain) id<TimeChooseDelegate> delegate;
@end
