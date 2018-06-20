//
//  FollowTypeCell.m
//  SEMCRM
//
//  Created by 薛斯岐 on 16/3/15.
//  Copyright © 2016年 sem. All rights reserved.
//

#import "FollowTypeCell.h"

@implementation FollowTypeCell

- (void)awakeFromNib {
    // Initialization code
}
- (IBAction)exitBtn:(UITextField *)sender {
    [sender resignFirstResponder];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
