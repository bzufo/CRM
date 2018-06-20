//
//  JFPostInfoCell.h
//  SEMCRM
//
//  Created by Sem on 2017/8/14.
//  Copyright © 2017年 sem. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserInfo.h"
@interface JFPostInfoCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *netNameLal;
@property (weak, nonatomic) IBOutlet UILabel *dealerNameLal;
@property (weak, nonatomic) IBOutlet UILabel *employeeNameLal;
@property (weak, nonatomic) IBOutlet UILabel *positionLal;
@property (weak, nonatomic) IBOutlet UILabel *positionLevelLal;
@property (weak, nonatomic) IBOutlet UILabel *enterDateLal;
- (void)configureCell:(UserInfo*)model;
@end
