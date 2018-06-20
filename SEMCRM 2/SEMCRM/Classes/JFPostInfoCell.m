//
//  JFPostInfoCell.m
//  SEMCRM
//
//  Created by Sem on 2017/8/14.
//  Copyright © 2017年 sem. All rights reserved.
//

#import "JFPostInfoCell.h"

@implementation JFPostInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)configureCell:(UserInfo*)model{
    _netNameLal.text = model.netname;
    _dealerNameLal.text =model.dealername;
    _employeeNameLal.text = model.employee_name;
    _positionLal.text =model.position;
    _positionLevelLal.text = model.position_level;
    _enterDateLal.text =model.enter_date;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
