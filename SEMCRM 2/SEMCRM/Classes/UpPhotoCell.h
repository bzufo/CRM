//
//  UpPhotoCell.h
//  SEMCRM
//
//  Created by 薛斯岐 on 16/3/14.
//  Copyright © 2016年 sem. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VehicleLicenseModel.h"
@interface UpPhotoCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *LICENSE_NOLal;
@property (weak, nonatomic) IBOutlet UILabel *SERIESLal;
@property (weak, nonatomic) IBOutlet UILabel *UP_CAR_FILELal;
@property (weak, nonatomic) IBOutlet UILabel *CUSTOMER_NAMELal;
- (void)configureCell:(VehicleLicenseModel*)model;
@end
