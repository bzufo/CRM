//
//  SupporListCell.h
//  SEMCRM
//
//  Created by Sem on 2017/5/15.
//  Copyright © 2017年 sem. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SupporContentModle.h"
@interface SupporListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *phoneBtn;
@property (weak, nonatomic) IBOutlet UILabel *liNoLal;
@property (weak, nonatomic) IBOutlet UILabel *titleLal;
@property (weak, nonatomic) IBOutlet UILabel *seriesLal;
@property (weak, nonatomic) IBOutlet UILabel *phoneLal;
@property (weak, nonatomic) IBOutlet UILabel *statusLal;
@property (weak, nonatomic) IBOutlet UILabel *teacherLal;
@property (weak, nonatomic) IBOutlet UILabel *sbTimeLal;
- (void)configureCell:(SupporContentModle*)model;
- (void)configureCellTwo:(SupporContentModle*)model;
- (void)configureCellSem:(SupporContentModle*)model;
@end
