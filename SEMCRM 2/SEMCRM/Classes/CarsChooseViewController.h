//
//  CarsChooseViewController.h
//  SEMCRM
//
//  Created by 薛斯岐 on 16/2/26.
//  Copyright © 2016年 sem. All rights reserved.
//

#import "SemCRMTableViewController.h"
@protocol CarsChooseDelegate <NSObject>

-(void)updataCarsInfo:(NSString *)chooseCars;

@end
@interface CarsChooseViewController : SemCRMTableViewController
@property (nonatomic,strong)NSString *cars;
@property (nonatomic,strong)NSString *typeD;
@property (nonatomic, retain) id<CarsChooseDelegate> delegate;
@end
