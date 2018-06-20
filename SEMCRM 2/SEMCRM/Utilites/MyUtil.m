//
//  MyUtil.m
//  gatako
//
//  Created by 光速达 on 15-2-3.
//  Copyright (c) 2015年 光速达. All rights reserved.
//

#import "MyUtil.h"
#import "Base64Coder.h"
#import "sys/utsname.h"
#define seriesCode @{@"GS":@"GS",@"DE":@"DE" ,@"V5":@"V5",@"DX3EV":@"DX3EV",@"DX3BEV":@"DX3BEV",@"DX7":@"DX7",@"DX3":@"DX3",@"V3":@"V3",@"V5":@"V5",@"V6":@"V6",@"C1":@"C1",@"LS":@"LS",@"PS":@"PS",@"AS":@"AS",@"FT":@"FT"}
#define countentTypeCode @{@"png":@"image/png",@"jpg":@"image/png",@"doc":@"image/png",@"txt":@"image/png"}
@implementation MyUtil

+(MyUtil *)shareUtil{
    static dispatch_once_t onceToken;
    static MyUtil *singleton;
    dispatch_once(&onceToken, ^{
        singleton=[[MyUtil alloc] init];
    });
    NSLog(@"-------singletonAlipay---------%@",singleton);
    return singleton;
}
#pragma --mark 判断字符串是否为空
+ (BOOL) isEmptyString:(NSString *)string {
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}
#pragma --mark  转化UTF8 的json
+ (NSString *) toJsonUTF8String:(id)obj{
    NSError *error=nil;
    NSData *data=[NSJSONSerialization dataWithJSONObject:obj options:NSJSONWritingPrettyPrinted error:&error];
    
    if (error) {
        NSLog(@"%@",error);
    }
    NSString *json=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return json;
}
#pragma --mark  保存图片到沙盒
+ (void) saveImage:(UIImage *)currentImage withName:(NSString *)imageName andCompressionQuality:(CGFloat) quality {
    NSData *imageDate=UIImageJPEGRepresentation(currentImage, quality);
    NSString *fullPath=[[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]  stringByAppendingPathComponent:imageName];
    
    NSLog(@"%@",fullPath);
    [imageDate writeToFile:fullPath atomically:NO];
    
    

}


#pragma --mark  颜色值转化 ＃ffffff 转化成10进制
+(int)colorStringToInt:(NSString *)colorStrig colorNo:(int)colorNo
{
    const char *cstr;
    int iPosition = 0;
    int nColor = 0;
    cstr = [colorStrig UTF8String];
    
    //判断是否有#号
    if (cstr[0] == '#') iPosition = 1;//有#号，则从第1位开始是颜色值，否则认为第一位就是颜色值
    else iPosition = 0;
    
    //第1位颜色值
    iPosition = iPosition + colorNo*2;
    if (cstr[iPosition] >= '0' && cstr[iPosition] < '9') nColor = (cstr[iPosition] - '0') * 16;
    else  nColor = (cstr[iPosition] - 'A' + 10) * 16;
    
    //第2位颜色值
    iPosition++;
    if (cstr[iPosition] >= '0' && cstr[iPosition] < '9') nColor = nColor + (cstr[iPosition] - '0');
    else nColor = nColor + (cstr[iPosition] - 'A' + 10);
    
    return nColor;
}

#pragma --mark  验证手机号码格式
+ (BOOL)isValidateTelephone:(NSString *)str

{
    
    if (str.length != 11)
    {
        return false;
    }else{
        
        /**
         * 移动号段正则表达式
         */
        //NSString *CM_NUM = @"^((13[4-9])|(147)|(15[0-2,7-9])|(178)|(18[2-4,7-8]))\\d{8}|(1705)\\d{7}$";
        /**
         * 联通号段正则表达式
         */
        //NSString *CU_NUM = @"^((13[0-2])|(145)|(15[5-6])|(176)|(175)|(18[5,6]))\\d{8}|(1709)\\d{7}$";
        /**
         * 电信号段正则表达式
         */
        /*
        NSString *CT_NUM = @"^((133)|(153)|(173)|(177)|(170)|(18[0,1,9]))\\d{8}$";
        NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM_NUM];
        BOOL isMatch1 = [pred1 evaluateWithObject:str];
        NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU_NUM];
        BOOL isMatch2 = [pred2 evaluateWithObject:str];
        NSPredicate *pred3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT_NUM];
        BOOL isMatch3 = [pred3 evaluateWithObject:str];
        
        if (isMatch1 || isMatch2 || isMatch3) {
            return true;
        }else{
            return false;
        }
         */
        NSScanner* scan = [NSScanner scannerWithString:str];
        int val;
        return [scan scanInt:&val] && [scan isAtEnd];
    }
    return true;
    
}
//判断是否为浮点形：
+ (BOOL)isPureFloat:(NSString*)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    float val;
    return[scan scanFloat:&val] && [scan isAtEnd];
}
#pragma --mark  利用正则表达式验证邮箱
+(BOOL)isValidateEmail:(NSString *)email {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

#pragma --mark 获取格式化日期字符串 yyyy-MM-dd HH:mm:ss
+(NSString *)getFormatDate:(NSDate *)date
{
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    //用[NSDate date]可以获取系统当前时间
    NSString *currentDateStr = [dateFormatter stringFromDate:date];
    
    return currentDateStr;
    
}
#pragma --mark 获取格式化日期字符串 yyyyMMddHHmmss
+(NSString *)getNumberFormatDate:(NSDate *)date
{
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"yyyyMMddHHmmss"];
    //用[NSDate date]可以获取系统当前时间
    NSString *currentDateStr = [dateFormatter stringFromDate:date];
    
    return currentDateStr;
    
}

#pragma --mark 字符串转日期 yyyy－MM－dd
+(NSDate *)getDateFromString:(NSString *)dateString
{
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    //用[NSDate date]可以获取系统当前时间
    NSDate *date = [dateFormatter dateFromString:dateString];
    
    return date;
    
}
#pragma --mark 字符串转日期 yyyyMMddHHmmss
+(NSDate *)getFullDateFromString:(NSString *)dateString
{
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    //用[NSDate date]可以获取系统当前时间
    NSDate *date = [dateFormatter dateFromString:dateString];
    
    return date;
    
}

#pragma --mark 字符串去除空串
+(NSString *)trim:(NSString *)string{
    NSString *result = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    return result;

}

#pragma --mark md5 加密

+ (NSString *)md5HexDigest:(NSString*)input
{
    CC_MD5_CTX md5;
    CC_MD5_Init(&md5);
    
    //    const char *src = [[input lowercaseString] UTF8String];
    const char *src = [input  UTF8String];
    const char *salt = "SEMDMS";
    
    CC_MD5_Update(&md5, src, strlen(src));
    CC_MD5_Update(&md5, salt, strlen(salt));
    
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5_Final(digest, &md5);
    
    NSData* data = [NSData dataWithBytes:(const void *)digest length:sizeof(unsigned char)*CC_MD5_DIGEST_LENGTH];
    return [Base64Coder encodeData:data];
}
#pragma --mark 验证身份证号
+ (BOOL) validateIdentityCard: (NSString *)identityCard
{
    BOOL flag;
    if (identityCard.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:identityCard];
}

#pragma --mark 弹出消息框来显示消息
+ (void)showMessage:(NSString* )message
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:message delegate:nil
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
    [alertView show];
}
#pragma --mark 判断是否数字
+ (BOOL)isPureInt:(NSString*)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return[scan scanInt:&val] && [scan isAtEnd];
}
+ (NSDictionary *) getKeyValue:(NSString *)string{
//    name=ligang&phone=13888888888
    NSMutableDictionary *dic=[NSMutableDictionary new];
    if(string){
        NSArray *arr=[string componentsSeparatedByString:@"&"];
        for (NSString *str in arr) {
            NSArray *arr1=[str componentsSeparatedByString:@"="];
            if(arr1.count>=2){
                [dic setObject:arr1[1] forKey:arr1[0]];
            }
        }
    }
    
    
    return dic;
}
+ (NSString *) getMoonValue:(NSString *)string{
    NSDictionary *dic=@{@"1":@"一月",@"2":@"二月",@"3":@"三月",@"4":@"四月",@"5":@"五月",@"6":@"六月",@"7":@"七月",@"8":@"八月",@"9":@"九月",@"10":@"十月",@"11":@"十一月",@"12":@"十二月"};
    return [dic objectForKey:string];
}
#pragma --mark 通过颜色生产纯色图片
+(UIImage *)getImageFromColor:(UIColor *)color{
    
    CGRect rect = CGRectMake(0, 0, 10, 10);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext(); return img;
}

#pragma --mark 生产指定长度随机串
+ (NSString *)randomStringWithLength:(int)len
{
    NSString *letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    NSMutableString *randomString = [NSMutableString stringWithCapacity: len];
    
    for (int i=0; i<len; i++) {
        [randomString appendFormat: @"%C", [letters characterAtIndex: arc4random_uniform((int)[letters length])]];
    }
    
    return randomString;
}


+ (NSString*)deviceString
{
    // 需要#import "sys/utsname.h"
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    if ([deviceString isEqualToString:@"iPhone1,1"])    return @"iPhone 1G";
    if ([deviceString isEqualToString:@"iPhone1,2"])    return @"iPhone 3G";
    if ([deviceString isEqualToString:@"iPhone2,1"])    return @"iPhone 3GS";
    if ([deviceString isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
    if ([deviceString isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([deviceString isEqualToString:@"iPhone5,2"])    return @"iPhone 5";
    if ([deviceString isEqualToString:@"iPhone3,2"])    return @"Verizon iPhone 4";
    if ([deviceString isEqualToString:@"iPod1,1"])      return @"iPod Touch 1G";
    if ([deviceString isEqualToString:@"iPod2,1"])      return @"iPod Touch 2G";
    if ([deviceString isEqualToString:@"iPod3,1"])      return @"iPod Touch 3G";
    if ([deviceString isEqualToString:@"iPod4,1"])      return @"iPod Touch 4G";
    if ([deviceString isEqualToString:@"iPad1,1"])      return @"iPad";
    if ([deviceString isEqualToString:@"iPad2,1"])      return @"iPad 2 (WiFi)";
    if ([deviceString isEqualToString:@"iPad2,2"])      return @"iPad 2 (GSM)";
    if ([deviceString isEqualToString:@"iPad2,3"])      return @"iPad 2 (CDMA)";
    if ([deviceString isEqualToString:@"i386"])         return @"Simulator";
    if ([deviceString isEqualToString:@"x86_64"])       return @"Simulator";
    NSLog(@"NOTE: Unknown device type: %@", deviceString);
    return deviceString;
}
+ (NSString*)toJSONData:(id)theData

{
    
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:theData
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    
    if ([jsonData length] > 0 && error == nil){
        NSString *jsonString = [[NSString alloc] initWithData:jsonData
                                                     encoding:NSUTF8StringEncoding];
        jsonString = [jsonString stringByReplacingOccurrencesOfString:@" " withString:@""];
        jsonString=[jsonString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        jsonString=[jsonString stringByReplacingOccurrencesOfString:@"\"" withString:@"\""];
        
//         NSMutableString *responseString = [NSMutableString stringWithString:jsonString];
//        NSString *character = nil;
//             for (int i = 0; i < responseString.length; i ++) {
//                     character = [responseString substringWithRange:NSMakeRange(i, 1)];
//                 
//                     if ([character isEqualToString:@"\\"])
//                             [responseString deleteCharactersInRange:NSMakeRange(i, 1)];
//                 }
        
        return jsonString;

    }else{
        return @"";
    }
    
}
+ (NSString *) getSeriesCode:(NSString *)string{
    return seriesCode[string];
}
+ (NSString *)getFilePath:(NSString *)fileName{   
        NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES) objectAtIndex:0] stringByAppendingPathComponent:fileName];
        
        if ([[NSFileManager defaultManager] fileExistsAtPath:path] == NO)
            
        {
            
            NSFileManager* fileManager = [NSFileManager defaultManager];
            NSString *version = [UIDevice currentDevice].systemVersion;
            //if(IOS7)
            
            //[fileManager createFileAtPath:@"photo.plist" contents:nil attributes:nil];
            
            //if(IOS8)
            if (version.doubleValue >= 8.0) {
                [fileManager createFileAtPath:path contents:nil attributes:nil];
            }else{
                [fileManager createFileAtPath:@"photo.plist" contents:nil attributes:nil];
            }
            
            
            NSMutableArray *photoPathArray = [NSMutableArray array];
            
            [photoPathArray writeToFile:path atomically:YES];
            
        }
        
        return path;
        
    }
+(NSData *)scaleImage:(UIImage *)image toKb:(NSInteger)kb{
    
    
    kb*=1024;
    
    
    
    CGFloat compression = 0.9f;
    CGFloat maxCompression = 0.1f;
    NSData *imageData = UIImageJPEGRepresentation(image, compression);
    while ([imageData length] > kb && compression > maxCompression) {
        compression -= 0.1;
        imageData = UIImageJPEGRepresentation(image, compression);
    }
    NSLog(@"当前大小:%fkb",(float)[imageData length]/1024.0f);
    
    return imageData;
}
+ (NSString *)getcontenttype:(NSString *)type{
    NSArray *strArr=[type componentsSeparatedByString:@"."];
    if(strArr && strArr.count>1){
        NSString *key =strArr[1];
        NSString *ss= countentTypeCode[key];
        return ss;
    }else{
        return nil;
    }
}
+ (NSString*)dictionaryToJson:(NSDictionary *)dic

{
    
    NSError *parseError = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
}
+(UserInfo *)getUserInfo{
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    return  app.userModel;
}
+ (NSString*)getOvertime:(NSString*)mStr
{
    if(mStr==nil || mStr.length<1 || ![MyUtil isPureInt:mStr]){
        return @"";
    }else{
        long msec = [mStr longLongValue];
        
        if (msec <= 0)
        {
            return @"";
        }
        
        NSInteger d = msec/60/60/24;
        NSInteger h = msec/60/60%24;
        NSInteger  m = msec/60%60;
        NSInteger  s = msec%60;
        
        NSString *_tStr = @"";
        NSString *_dStr = @"";
        NSString *_hStr = @"";
        NSString *_mStr = @"";
        NSString *_sStr = @"";
        
        if (d > 0)
        {
            _dStr = [NSString stringWithFormat:@"%ld天",d];
        }
        
        if (h > 0)
        {
            _hStr = [NSString stringWithFormat:@"%ld小时",h];
        }
        if (m > 0)
        {
            _mStr = [NSString stringWithFormat:@"%ld分",m];
        }
        if (s > 0)
        {
            _sStr = [NSString stringWithFormat:@"%ld秒",s];
        }
        
        
        _tStr = [NSString stringWithFormat:@"%@%@%@%@",_dStr,_hStr,_mStr,_sStr];
        
        return _tStr;
    }
    
}
@end
