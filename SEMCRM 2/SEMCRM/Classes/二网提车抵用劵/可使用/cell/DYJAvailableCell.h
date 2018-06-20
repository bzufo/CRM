//
//  DYJAvailableCell.h
//  SEMCRM
//
//  Created by Sem on 2017/11/23.
//  Copyright © 2017年 sem. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VoucherModel.h"
@interface DYJAvailableCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *engineNolal;
@property (weak, nonatomic) IBOutlet UILabel *serieslal;
@property (weak, nonatomic) IBOutlet UILabel *applyDatelal;
@property (weak, nonatomic) IBOutlet UILabel *sendDateLal;
@property (weak, nonatomic) IBOutlet UILabel *amountLal;
@property (weak, nonatomic) IBOutlet UILabel *noLal;
@property (weak, nonatomic) IBOutlet UILabel *overDateLal;
@property (weak, nonatomic) IBOutlet UILabel *titleLal;
@property (weak, nonatomic) IBOutlet UIButton *accBtn;
- (void)configureCell:(VoucherModel*)model;
@end
