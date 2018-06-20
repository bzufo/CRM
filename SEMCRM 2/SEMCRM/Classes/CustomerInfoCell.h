//
//  CustomerInfoCell.h
//  SEMCRM
//
//  Created by 薛斯岐 on 16/2/23.
//  Copyright © 2016年 sem. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomerInfo.h"
@interface CustomerInfoCell : UITableViewCell
{
    NSString *phone;
}
@property (weak, nonatomic) IBOutlet UILabel *userNameLal;
@property (weak, nonatomic) IBOutlet UILabel *phoneLal;
@property (weak, nonatomic) IBOutlet UILabel *levLal;
@property (weak, nonatomic) IBOutlet UILabel *carsLal;
@property (weak, nonatomic) IBOutlet UILabel *lcLal;
@property (weak, nonatomic) IBOutlet UILabel *xsDateLal;
- (void)configureCell:(CustomerInfo*)model;

@end
