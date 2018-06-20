//
//  AppDelegate.h
//  SEMCRM
//
//  Created by sem on 16/2/2.
//  Copyright © 2016年 sem. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "UMessage.h"
#import "UserInfo.h"
#define UMSYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define _IPHONE80_ 80000
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property(retain,nonatomic) UserInfo *userModel;
@property(copy,nonatomic) NSString *deviceToken;
@property(copy,nonatomic) NSString *smart360Token;
- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;
-(void)doHeart;
- (void)startLoading;
- (void)stopLoading;

@end

