//
//  PhotoCell.m
//  SemOA
//
//  Created by Sem on 2017/5/9.
//  Copyright © 2017年 Sem. All rights reserved.
//

#import "PhotoCell.h"

@implementation PhotoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setCollectionViewDataSourceDelegate:(id<UICollectionViewDataSource, UICollectionViewDelegate>)dataSourceDelegate
{
    self.collView.dataSource = dataSourceDelegate;
    self.collView.delegate = dataSourceDelegate;
    [self.collView reloadData];
}

@end
