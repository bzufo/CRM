//
//  PhotoCell.h
//  SemOA
//
//  Created by Sem on 2017/5/9.
//  Copyright © 2017年 Sem. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UICollectionView *collView;
- (void)setCollectionViewDataSourceDelegate:(id<UICollectionViewDataSource, UICollectionViewDelegate>)dataSourceDelegate;
@end
