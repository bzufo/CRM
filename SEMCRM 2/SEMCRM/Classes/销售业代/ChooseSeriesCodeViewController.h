//
//  ChooseSeriesCodeViewController.h
//  SEMCRM
//
//  Created by 薛斯岐 on 16/5/13.
//  Copyright © 2016年 sem. All rights reserved.
//

#import "SemCRMTableViewController.h"
@protocol ChooseSeriesCodeDelegate <NSObject>

-(void)chooseSeriesCode:(NSString *)seriesCode;

@end
@interface ChooseSeriesCodeViewController : SemCRMTableViewController
@property (nonatomic, retain) IBOutlet UISearchBar *searchBar;
@property (nonatomic, copy)NSString *brand;
@property (nonatomic, copy)NSString *series;
@property (nonatomic, retain) id<ChooseSeriesCodeDelegate> delegate;
@end
