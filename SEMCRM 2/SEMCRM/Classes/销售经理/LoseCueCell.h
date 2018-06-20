//
//  LoseCueCell.h
//  SEMCRM
//
//  Created by Sem on 2017/6/7.
//  Copyright © 2017年 sem. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CueList.h"
@interface LoseCueCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *adviserLal;
@property (weak, nonatomic) IBOutlet UILabel *userLal;
@property (weak, nonatomic) IBOutlet UILabel *carlal;
@property (weak, nonatomic) IBOutlet UILabel *phoneLal;
@property (weak, nonatomic) IBOutlet UILabel *timeLal;
@property (weak, nonatomic) IBOutlet UILabel *typeLal;
@property (weak, nonatomic) IBOutlet UIImageView *sexImageView;
- (void)configureCell:(CueList*)model;
@end
