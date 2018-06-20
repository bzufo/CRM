//
//  SemCRMWSReplyViewController.h
//  SEMCRM
//
//  Created by Sem on 2017/6/30.
//  Copyright © 2017年 sem. All rights reserved.
//

#import "SemCRMTableViewController.h"
@protocol ReplyCaseDelegate <NSObject>

-(void)replyCase;

@end
@interface SemCRMWSReplyViewController : SemCRMTableViewController
@property (nonatomic,copy)NSString *rhNo;
@property (nonatomic, retain) id<ReplyCaseDelegate> delegate;
@property (nonatomic,copy)NSString *isSem;
@end
