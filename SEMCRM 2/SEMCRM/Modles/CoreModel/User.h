//
//  User.h
//  SEMCRM
//
//  Created by 薛斯岐 on 16/2/27.
//  Copyright © 2016年 sem. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

@interface User : NSManagedObject
@property (nonatomic,assign)BOOL isSel;
// Insert code here to declare functionality of your managed object subclass

@end

NS_ASSUME_NONNULL_END

#import "User+CoreDataProperties.h"
