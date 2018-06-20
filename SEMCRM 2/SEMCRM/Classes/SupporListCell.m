//
//  SupporListCell.m
//  SEMCRM
//
//  Created by Sem on 2017/5/15.
//  Copyright © 2017年 sem. All rights reserved.
//

#import "SupporListCell.h"

@implementation SupporListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)configureCell:(SupporContentModle*)model{
    _liNoLal.text=model.license_no;
    _titleLal.text=model.trouble_title;
    _seriesLal.text=model.series;
    _statusLal.text=model.help_status;
    _teacherLal.text=model.help_teacher;
    _sbTimeLal.text = [NSString stringWithFormat:@"上报时间:%@",model.ws_submit_date];
    _phoneLal.text=model.help_teacher_mobile;
}
- (void)configureCellTwo:(SupporContentModle*)model{
    _liNoLal.text=model.sort_code;
    _titleLal.text=model.trouble_title;
    _seriesLal.text=model.series;
    _statusLal.text=model.trouble_type;
    _teacherLal.text=model.create_by_name;
    _sbTimeLal.text = [NSString stringWithFormat:@"分享时间:%@    公里数:%@",model.create_date,model.mileage];
    _phoneLal.text=model.share_mobile;
}
- (void)configureCellSem:(SupporContentModle*)model{
    _liNoLal.text=model.ws_shortname;
    _titleLal.text=model.trouble_title;
    _seriesLal.text=model.series;
    _statusLal.text=model.help_status;
    _teacherLal.text=model.help_teacher;
    _sbTimeLal.text = [NSString stringWithFormat:@"上报时间:%@",model.ws_submit_date];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
