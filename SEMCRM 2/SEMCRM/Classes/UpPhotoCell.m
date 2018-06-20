//
//  UpPhotoCell.m
//  SEMCRM
//
//  Created by 薛斯岐 on 16/3/14.
//  Copyright © 2016年 sem. All rights reserved.
//

#import "UpPhotoCell.h"

@implementation UpPhotoCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)configureCell:(VehicleLicenseModel*)model{
    _LICENSE_NOLal.text=model.LICENSE_NO;
    _SERIESLal.text =model.SERIES;
    if([model.UP_CAR_FILE isEqualToString:@"1"]){
        _UP_CAR_FILELal.text = @"已上传";
    }else{
        _UP_CAR_FILELal.text = @"未上传";
    }
   
    _CUSTOMER_NAMELal.text = model.CUSTOMER_NAME;
}
@end
