//
//  MemoCell.m
//  SEMCRM
//
//  Created by Sem on 2017/6/28.
//  Copyright © 2017年 sem. All rights reserved.
//

#import "MemoCell.h"

@implementation MemoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.memTxt.editable = NO;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
