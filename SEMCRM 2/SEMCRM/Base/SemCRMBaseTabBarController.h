//
//  SemCRMBaseTabBarController.h
//  SEMCRM
//
//  Created by sem on 16/2/2.
//  Copyright © 2016年 sem. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SemCRMBaseTabBarController : UITabBarController
-(void)chooseStoryBoardWithStoryBoardName:(NSString *)boardName
                               identifier:(NSString *)identifier
                                otherRole:(NSString *)otherRole;
@end
