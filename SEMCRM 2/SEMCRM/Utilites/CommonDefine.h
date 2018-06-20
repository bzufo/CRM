//
//  RCDCommonDefine.h
//  RCloudMessage
//
//  Created by xsq on 16/2/2.
//  Copyright (c) 2016年 All rights reserved.
//

//NavBar高度
#define NavigationBar_HEIGHT 44
#define http_manager  [AFHTTPRequestOperationManager manager]
//带有RGBA的颜色设置
#define COLOR(R, G, B, A) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]
#define CAR_SERIES @"series.plist"
#define TROUBLE_TYPE @"trouble.plist"
#define SEM_TEACHER @"teacher.plist"
#define SEM_SORTTYPE @"sortType.plist"
#define REGION_NAME @"region.plist"
#define WS_NAME @"wsname.plist"
// 获取RGB颜色
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
//获取屏幕 宽度、高度
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define DEFAULTS [NSUserDefaults standardUserDefaults]
#define ShareApplicationDelegate [[UIApplication sharedApplication] delegate]
#define HEXCOLOR(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
