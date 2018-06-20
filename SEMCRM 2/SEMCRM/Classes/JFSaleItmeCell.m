//
//  JFSaleItmeCell.m
//  SEMCRM
//
//  Created by Sem on 2017/8/14.
//  Copyright © 2017年 sem. All rights reserved.
//

#import "JFSaleItmeCell.h"

@implementation JFSaleItmeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)configureCell:(JFPointSaleItemModle*)model{
    _seriesLal.text =model.series;
    _vinLal.text=model.vin;
    _pcarLal.text=model.pcar;
    _pointLal.text=model.point;
    _delivery_dateLal.text=model.delivery_date;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
