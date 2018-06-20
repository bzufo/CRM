//
//  DYJAvailableCell.m
//  SEMCRM
//
//  Created by Sem on 2017/11/23.
//  Copyright © 2017年 sem. All rights reserved.
//

#import "DYJAvailableCell.h"

@implementation DYJAvailableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)configureCell:(VoucherModel*)model{
    _engineNolal.text=model.engine_no;
    _serieslal.text=model.series;
    _applyDatelal.text=model.apply_date;
    _sendDateLal.text=model.send_date;
    _amountLal.text=[NSString stringWithFormat:@"￥%@",model.amount];;
    _noLal.text=model.voucher_no;
    _overDateLal.text=model.over_date;
    _titleLal.text=[NSString stringWithFormat:@"仅限于向%@提车时抵扣车款",model.dealer_shortname];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
