//
//  MyUtil.h
//  gatako
//
//  Created by 光速达 on 15-2-3.
//  Copyright (c) 2015年 光速达. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CommonCrypto/CommonDigest.h>
#import "UserInfo.h"
@interface MyUtil : NSObject

+(MyUtil *)shareUtil;

//判断字符串是否为空
+ (BOOL) isEmptyString:(NSString *)string;
//对象转换成utf8json
+ (NSString *) toJsonUTF8String:(id)obj;

//将图片压缩 保存至本地沙盒
+ (void) saveImage:(UIImage *)currentImage withName:(NSString *)imageName andCompressionQuality:(CGFloat) quality ;

//颜色值转化 ＃ffffff 转化成10进制
+(int)colorStringToInt:(NSString *)colorStrig colorNo:(int)colorNo;

//验证手机号码格式
+ (BOOL)isValidateTelephone:(NSString *)str;

//利用正则表达式验证邮箱
+(BOOL)isValidateEmail:(NSString *)email;

+(NSString *)getFormatDate:(NSDate *)date;

+(NSString *)getNumberFormatDate:(NSDate *)date;

+(NSDate *)getDateFromString:(NSString *)dateString;

+(NSDate *)getFullDateFromString:(NSString *)dateString;

+(NSString *)trim:(NSString *)string;

+ (NSString *)md5HexDigest:(NSString*)input;

+ (BOOL) validateIdentityCard: (NSString *)identityCard;
//判断是否数字
+ (BOOL)isPureInt:(NSString*)string;
+(BOOL)isPureFloat:(NSString*)string;
//弹出消息框来显示消息
+ (void)showMessage:(NSString* )message;
//获取键值参数
+ (NSDictionary *) getKeyValue:(NSString *)string;
//获取月份中文
+ (NSString *) getMoonValue:(NSString *)string;
//获取纯色块图片
+(UIImage *)getImageFromColor:(UIColor *)color;
//获取随机数
+ (NSString *)randomStringWithLength:(int)len;
//获取json字符串
+ (NSString*)toJSONData:(id )theData;

+ (NSString*)deviceString;
//获取车系代码
+ (NSString *) getSeriesCode:(NSString *)string;
+ (NSString *)getFilePath:(NSString *)fileName;
+(NSData *)scaleImage:(UIImage *)image toKb:(NSInteger)kb;
+ (NSString *)getcontenttype:(NSString *)type;
+ (NSString*)dictionaryToJson:(NSDictionary *)dic;
+(UserInfo *)getUserInfo;
//获取时分秒
+ (NSString*)getOvertime:(NSString*)mStr;

@end
