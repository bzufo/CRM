//
//  SemCRMBaseViewController.h
//  SEMCRM
//
//  Created by sem on 16/2/21.
//  Copyright © 2016年 sem. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SemCRMBaseViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *tableView;
-(void)initMJRefeshHeaderForGif:(MJRefreshGifHeader *) header;
-(void)initMJRefeshFooterForGif:(MJRefreshBackGifFooter *) footer;
@end
