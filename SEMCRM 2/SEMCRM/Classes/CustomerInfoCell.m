//
//  CustomerInfoCell.m
//  SEMCRM
//
//  Created by 薛斯岐 on 16/2/23.
//  Copyright © 2016年 sem. All rights reserved.
//

#import "CustomerInfoCell.h"

@implementation CustomerInfoCell

- (void)awakeFromNib {
    // Initialization code
}
- (IBAction)telAct:(UIButton *)sender {
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",phone];
    //            NSLog(@"str======%@",str);
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)configureCell:(CustomerInfo*)model{
    _userNameLal.text=model.car_owner;
    _phoneLal.text=model.tel_cstm_tel;
    _carsLal.text = model.series;
    _lcLal.text=[NSString stringWithFormat:@"%@公里",model.miles];
    _xsDateLal.text=model.sale_date;
    _levLal.text=model.license_no;
    phone = model.tel_cstm_tel;
}
@end
