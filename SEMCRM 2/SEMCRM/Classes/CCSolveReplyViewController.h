//
//  CCSolveReplyViewController.h
//  SemCC
//
//  Created by SEM on 15/6/1.
//  Copyright (c) 2015年 SEM. All rights reserved.
//

#import "SemCRMBaseViewController.h"
#import "CustomerInfo.h"
@protocol SolveReplyDelegate <NSObject>

-(void)rePly;

@end
@interface CCSolveReplyViewController : SemCRMBaseViewController
@property (weak, nonatomic) IBOutlet UISegmentedControl *typeSeg;
@property (weak, nonatomic) IBOutlet UITextView *replyTex;
@property (nonatomic, nonatomic)CustomerInfo *customerInfo;
@property (nonatomic, copy)NSString *isYeDai;
@property (nonatomic, nonatomic) id<SolveReplyDelegate> delegate ;
@end
