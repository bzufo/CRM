//
//  CueInfoCell.h
//  SEMCRM
//
//  Created by 薛斯岐 on 16/2/22.
//  Copyright © 2016年 sem. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CueList.h"
@interface CueInfoCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *cfrom;
@property (weak, nonatomic) IBOutlet UILabel *ydLal;
@property (weak, nonatomic) IBOutlet UILabel *stateLal;
@property (weak, nonatomic) IBOutlet UILabel *carsLal;
@property (weak, nonatomic) IBOutlet UILabel *levLal;
@property (weak, nonatomic) IBOutlet UILabel *cnameLal;
@property (weak, nonatomic) IBOutlet UILabel *mobileLal;
@property (weak, nonatomic) IBOutlet UILabel *hdmcLal;
@property (weak, nonatomic) IBOutlet UILabel *bzLal;
@property (weak, nonatomic) IBOutlet UILabel *createDateLal;
@property (weak, nonatomic) IBOutlet UILabel *dateLal;
- (void)configureCell:(CueList*)model;
@end
