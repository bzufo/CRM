//
//  AddCustomerCuesViewController.h
//  SEMCRM
//
//  Created by sem on 16/2/2.
//  Copyright © 2016年 sem. All rights reserved.
//

#import "SemCRMTableViewController.h"
#import "User.h"
@interface AddCustomerCuesViewController : SemCRMTableViewController{
    NSArray *fromArr;
    NSMutableArray *eArrTitle;
    NSMutableArray *eArr;
    NSString *fromSelStr;
    NSString *actTitle;
    NSString *actID;
}
@property (nonatomic,retain)User *userModel;
@end
