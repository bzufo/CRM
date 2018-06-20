//
//  FollowTypeCell.h
//  SEMCRM
//
//  Created by 薛斯岐 on 16/3/15.
//  Copyright © 2016年 sem. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FollowTypeCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UISegmentedControl *followSeg;
@property (weak, nonatomic) IBOutlet UITextField *regionTex;

@end
