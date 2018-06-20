//
//  GroupModel.h
//  SEMCRM
//
//  Created by 薛斯岐 on 16/3/7.
//  Copyright © 2016年 sem. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GroupModel : NSObject
@property(nonatomic,copy)NSString * tile_id;
@property(nonatomic,copy)NSString * title;
@property(nonatomic,copy)NSString * count;
@property(nonatomic,assign)BOOL isSel;
@end
