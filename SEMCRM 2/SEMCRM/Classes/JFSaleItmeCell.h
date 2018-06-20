//
//  JFSaleItmeCell.h
//  SEMCRM
//
//  Created by Sem on 2017/8/14.
//  Copyright © 2017年 sem. All rights reserved.
//
#import "JFPointSaleItemModle.h"
#import <UIKit/UIKit.h>

@interface JFSaleItmeCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *seriesLal;
@property (weak, nonatomic) IBOutlet UILabel *vinLal;
@property (weak, nonatomic) IBOutlet UILabel *pcarLal;
@property (weak, nonatomic) IBOutlet UILabel *pointLal;
@property (weak, nonatomic) IBOutlet UILabel *delivery_dateLal;
- (void)configureCell:(JFPointSaleItemModle*)model;
@end
