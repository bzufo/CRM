//
//  User+CoreDataProperties.h
//  SEMCRM
//
//  Created by 薛斯岐 on 16/2/27.
//  Copyright © 2016年 sem. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "User.h"

NS_ASSUME_NONNULL_BEGIN

@interface User (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *leadbatch;
@property (nullable, nonatomic, retain) NSString *cfrom;
@property (nullable, nonatomic, retain) NSString *forcast_date;
@property (nullable, nonatomic, retain) NSString *level;
@property (nullable, nonatomic, retain) NSString *cname;
@property (nullable, nonatomic, retain) NSString *sex;
@property (nullable, nonatomic, retain) NSString *mobile;
@property (nullable, nonatomic, retain) NSString *brand;
@property (nullable, nonatomic, retain) NSString *series;
@property (nullable, nonatomic, retain) NSString *remark;
@end

NS_ASSUME_NONNULL_END
