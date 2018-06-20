//
//  SemCRMTableViewController.h
//  SEMCRM
//
//  Created by sem on 16/2/2.
//  Copyright © 2016年 sem. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SemCRMTableViewController : UITableViewController
-(void)initMJRefeshHeaderForGif:(MJRefreshGifHeader *) header;
-(void)initMJRefeshFooterForGif:(MJRefreshBackGifFooter *) footer;
@end
