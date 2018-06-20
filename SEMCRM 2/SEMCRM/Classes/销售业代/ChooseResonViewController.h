//
//  ChooseResonViewController.h
//  SEMCRM
//
//  Created by 薛斯岐 on 16/3/2.
//  Copyright © 2016年 sem. All rights reserved.
//

#import "SemCRMTableViewController.h"
@protocol ChooseResonDelegate <NSObject>

-(void)chooseReson:(NSString *)reson;

@end
@interface ChooseResonViewController : SemCRMTableViewController
@property(nonatomic,retain)NSString *keyStr;
@property (nonatomic, retain) id<ChooseResonDelegate> delegate;
@property(nonatomic,assign)NSString *isSem;
@end
