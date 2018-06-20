//
//  MsgTemplateChoiceView.h
//  SEMCRM
//
//  Created by 薛斯岐 on 16/2/23.
//  Copyright © 2016年 sem. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CueList.h"
@protocol MsgTemplateChoiceDelegate <NSObject>

-(void)chooseMsgTemplate:(NSString *)msg;

@end
@interface MsgTemplateChoiceView : UIViewController
@property(nonatomic,retain)CueList *cueModel;
@property (nonatomic, retain) id<MsgTemplateChoiceDelegate> delegate;
@end
