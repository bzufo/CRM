//
//  ToBeContactedCell.m
//  SEMCRM
//
//  Created by sem on 16/2/21.
//  Copyright © 2016年 sem. All rights reserved.
//

#import "ToBeContactedCell.h"

@implementation ToBeContactedCell

- (void)awakeFromNib {
    [self.levLal bringSubviewToFront:self];
    _showBtn.backgroundColor=[UIColor clearColor];
    // Initialization code
}
- (void)configureCell:(CueList*)model{
    if([model.sex isEqualToString:@"男"]){
        [_userImageView setImage:[UIImage imageNamed:@"businessman"]];
    }else{
        [_userImageView setImage:[UIImage imageNamed:@"businesswoman"]];
    }
    _levLal.text=model.level;
    if(_levLal.text.length<1){
        [_levLal setHidden:YES];
    }
    _cnamelal.text = model.cname;
    _phoneLal.text = model.mobile;
    _carsLal.text = model.series;
    _timeLal.text =model.forcast_date;
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
