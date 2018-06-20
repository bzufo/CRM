//
//  ToBeContactedCell.h
//  SEMCRM
//
//  Created by sem on 16/2/21.
//  Copyright © 2016年 sem. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CueList.h"
@interface ToBeContactedCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *selBtn;
@property (weak, nonatomic) IBOutlet UILabel *timeLal;
@property (weak, nonatomic) IBOutlet UILabel *levLal;
@property (weak, nonatomic) IBOutlet UILabel *cnamelal;
@property (weak, nonatomic) IBOutlet UILabel *phoneLal;
@property (weak, nonatomic) IBOutlet UILabel *carsLal;
@property (weak, nonatomic) IBOutlet UIButton *showBtn;
@property (weak, nonatomic) IBOutlet UIImageView *userImageView;
- (void)configureCell:(CueList*)model;
@end
