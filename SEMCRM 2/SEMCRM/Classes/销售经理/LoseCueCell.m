//
//  LoseCueCell.m
//  SEMCRM
//
//  Created by Sem on 2017/6/7.
//  Copyright © 2017年 sem. All rights reserved.
//

#import "LoseCueCell.h"

@implementation LoseCueCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)configureCell:(CueList*)model{
    if([model.sex isEqualToString:@"男"]){
        [_sexImageView setImage:[UIImage imageNamed:@"businessman"]];
    }else{
        [_sexImageView setImage:[UIImage imageNamed:@"businesswoman"]];
    }

    _adviserLal.text = model.EMPLOYEE_NAME;
    _userLal.text =model.cname ;
    _carlal.text = model.series;
    _phoneLal.text = model.mobile;
    _timeLal.text = model.CREATE_DATE;
    _typeLal.text = model.level;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
