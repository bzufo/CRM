//
//  SemSearchWSNameViewController.h
//  SEMCRM
//
//  Created by Sem on 2017/7/11.
//  Copyright © 2017年 sem. All rights reserved.
//

#import "SemCRMTableViewController.h"
@protocol SemSearchWSDelegate <NSObject>

-(void)chooseWS:(NSDictionary *)dic;

@end
@interface SemSearchWSNameViewController : SemCRMTableViewController
@property (nonatomic, retain) id<SemSearchWSDelegate> delegate;
@end
