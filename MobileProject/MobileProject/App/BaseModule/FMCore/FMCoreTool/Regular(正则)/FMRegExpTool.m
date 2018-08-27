//
//  FMRegExpTool.m
//  RegularExpression
//
//  Created by LiCheng on 2017/1/13.
//  Copyright © 2017年 Li_Cheng. All rights reserved.
//

#import "FMRegExpTool.h"

@implementation FMRegExpTool

/**
 *

 4 m-n位的数字：^\\d{m,n}$
 5 零和非零开头的数字：^(0|[1-9][0-9]*)$
 6 非零开头的最多带两位小数的数字：^([1-9][0-9]*)+(.[0-9]{1,2})?$
 7 带1-2位小数的正数或负数：^(\-)?\d+(\.\d{1,2})?$
 8 正数、负数、和小数：^(\-|\+)?\d+(\.\d+)?$
 9 有两位小数的正实数：^[0-9]+(.[0-9]{2})?$
 10 有1~3位小数的正实数：^[0-9]+(.[0-9]{1,3})?$
 11 非零的正整数：^[1-9]\d*$ 或 ^([1-9][0-9]*){1,3}$ 或 ^\+?[1-9][0-9]*$
 12 非零的负整数：^\-[1-9][]0-9"*$ 或 ^-[1-9]\d*$
 13 非负整数：^\d+$ 或 ^[1-9]\d*|0$
 14 非正整数：^-[1-9]\d*|0$ 或 ^((-\d+)|(0+))$
 15 非负浮点数：^\d+(\.\d+)?$ 或 ^[1-9]\d*\.\d*|0\.\d*[1-9]\d*|0?\.0+|0$
 16 非正浮点数：^((-\d+(\.\d+)?)|(0+(\.0+)?))$ 或 ^(- ([1-9]\d*\.\d*|0\.\d*[1-9]\d*))|0?\.0+|0$
 17 正浮点数：^[1-9]\d*\.\d*|0\.\d*[1-9]\d*$ 或 ^(([0-9]+\.[0-9]*[1-9][0-9]*)|([0-9]*[1-9][0-9]*\.[0-9]+)|([0-9]*[1-9][0-9]*))$
 18 负浮点数：^- ([1-9]\d*\.\d*|0\.\d*[1-9]\d*)$ 或 ^(- (([0-9]+\.[0-9]*[1-9][0-9]*)|([0-9]*[1-9][0-9]*\.[0-9]+)|([0-9]*[1-9][0-9]*)))$
 19 浮点数：^(-?\d+)(\.\d+)?$ 或 ^-?([1-9]\d*\.\d*|0\.\d*[1-9]\d*|0?\.0+|0)$

 1 汉字：^[\u4e00-\u9fa5]{0,}$


 9 中文、英文、数字包括下划线：^[\u4E00-\u9FA5A-Za-z0-9_]+$
 10 中文、英文、数字但不包括下划线等符号：^[\u4E00-\u9FA5A-Za-z0-9]+$ 或 ^[\u4E00-\u9FA5A-Za-z0-9]{2,20}$



 2 域名：[a-zA-Z0-9][-a-zA-Z0-9]{0,62}(/.[a-zA-Z0-9][-a-zA-Z0-9]{0,62})+/.?


 7 身份证号(15位、18位数字)：^\d{15}|\d{18}$
 8 短身份证号码(数字、字母x结尾)：^([0-9]){7,18}(x|X)?$ 或 ^\d{8,18}|[0-9x]{8,18}|[0-9X]{8,18}?$
 9 帐号是否合法(字母开头，允许5-16字节，允许字母数字下划线)：^[a-zA-Z][a-zA-Z0-9_]{4,15}$
 10 密码(以字母开头，长度在6~18之间，只能包含字母、数字和下划线)：^[a-zA-Z]\w{5,17}$
 11 强密码(必须包含大小写字母和数字的组合，不能使用特殊字符，长度在8-10之间)：^(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,10}$
 12 日期格式：^\d{4}-\d{1,2}-\d{1,2}
 13 一年的12个月(01～09和1～12)：^(0?[1-9]|1[0-2])$
 14 一个月的31天(01～09和1～31)：^((0?[1-9])|((1|2)[0-9])|30|31)$
 15 钱的输入格式：
 16    1.有四种钱的表示形式我们可以接受:"10000.00" 和 "10,000.00", 和没有 "分" 的 "10000" 和 "10,000"：^[1-9][0-9]*$
 17    2.这表示任意一个不以0开头的数字,但是,这也意味着一个字符"0"不通过,所以我们采用下面的形式：^(0|[1-9][0-9]*)$
 18    3.一个0或者一个不以0开头的数字.我们还可以允许开头有一个负号：^(0|-?[1-9][0-9]*)$
 19    4.这表示一个0或者一个可能为负的开头不为0的数字.让用户以0开头好了.把负号的也去掉,因为钱总不能是负的吧.下面我们要加的是说明可能的小数部分：^[0-9]+(.[0-9]+)?$
 20    5.必须说明的是,小数点后面至少应该有1位数,所以"10."是不通过的,但是 "10" 和 "10.2" 是通过的：^[0-9]+(.[0-9]{2})?$
 21    6.这样我们规定小数点后面必须有两位,如果你认为太苛刻了,可以这样：^[0-9]+(.[0-9]{1,2})?$
 22    7.这样就允许用户只写一位小数.下面我们该考虑数字中的逗号了,我们可以这样：^[0-9]{1,3}(,[0-9]{3})*(.[0-9]{1,2})?$
 23    8.1到3个数字,后面跟着任意个 逗号+3个数字,逗号成为可选,而不是必须：^([0-9]+|[0-9]{1,3}(,[0-9]{3})*)(.[0-9]{1,2})?$
 24    备注：这就是最终结果了,别忘了"+"可以用"*"替代如果你觉得空字符串也可以接受的话(奇怪,为什么?)最后,别忘了在用函数时去掉去掉那个反斜杠,一般的错误都在这里
 25 xml文件：^([a-zA-Z]+-?)+[a-zA-Z0-9]+\\.[x|X][m|M][l|L]$
 26 中文字符的正则表达式：[\u4e00-\u9fa5]
 27 双字节字符：[^\x00-\xff]    (包括汉字在内，可以用来计算字符串的长度(一个双字节字符长度计2，ASCII字符计1))
 28 空白行的正则表达式：\n\s*\r    (可以用来删除空白行)
 29 HTML标记的正则表达式：<(\S*?)[^>]*>.*?</\1>|<.*? />    (网上流传的版本太糟糕，上面这个也仅仅能部分，对于复杂的嵌套标记依旧无能为力)
 30 首尾空白字符的正则表达式：^\s*|\s*$或(^\s*)|(\s*$)    (可以用来删除行首行尾的空白字符(包括空格、制表符、换页符等等)，非常有用的表达式)
 31 腾讯QQ号：[1-9][0-9]{4,}    (腾讯QQ号从10000开始)
 32 中国邮政编码：[1-9]\d{5}(?!\d)    (中国邮政编码为6位数字)
 33 IP地址：\d+\.\d+\.\d+\.\d+    (提取IP地址时有用)
 34 IP地址：((?:(?:25[0-5]|2[0-4]\\d|[01]?\\d?\\d)\\.){3}(?:25[0-5]|2[0-4]\\d|[01]?\\d?\\d))
 

 */

#pragma mark - 私有方法
/**
 *  基本的验证方法
 *
 *  @param regEx 校验格式
 *  @param data  要校验的数据
 *
 *  @return YES:成功 NO:失败
 */
+(BOOL)baseCheckForRegEx:(NSString *)regEx data:(NSString *)data{

    NSPredicate *card = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regEx];

    if (([card evaluateWithObject:data])) {
        return YES;
    }
    return NO;
}


#pragma mark - 邮箱校验
+(BOOL)fm_checkingEmail:(NSString *)email{

    NSString *regEx = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    return [self baseCheckForRegEx:regEx data:email];
}

#pragma mark - 验证手机号
+(BOOL)fm_checkingMobile:(NSString *)mobile{

    NSString *regEx = @"^1[3|4|5|7|8][0-9]\\d{8}$";
    return [self baseCheckForRegEx:regEx data:mobile];
}
#pragma mark - 验证电话号
+(BOOL)fm_checkingPhoneNum:(NSString *)phone{
    NSString *regEx = @"^(\\d{3,4}-)\\d{7,8}$";
    return [self baseCheckForRegEx:regEx data:phone];
}

#pragma mark - 身份证号验证
+ (BOOL)fm_checkingIdCard:(NSString *)idCard{

    NSString *regEx = @"(^[0-9]{15}$)|([0-9]{17}([0-9]|X)$)";
    return [self baseCheckForRegEx:regEx data:idCard];
}
#pragma mark - 密码校验
+(BOOL)fm_checkingPasswordWithShortest:(NSInteger)shortest
                               longest:(NSInteger)longest
                              password:(NSString *)pwd
{
    NSString *regEx =[NSString stringWithFormat:@"^[a-zA-Z0-9]{%ld,%ld}+$", shortest, longest];
    return [self baseCheckForRegEx:regEx data:pwd];
}


#pragma mark - 由数字和26个英文字母组成的字符串
+ (BOOL)fm_checkingStrFormNumberAndLetter:(NSString *)data{
    NSString *regEx = @"^[A-Za-z0-9]+$";
    return [self baseCheckForRegEx:regEx data:data];
}
#pragma mark - 26位英文大小写字母组成的字符
+(BOOL) fm_checkingStrFormLowerAndUpperLetter:(NSString *)data{
    NSString *regEx = @"^[A-Za-z]+$";
    return [self baseCheckForRegEx:regEx data:data];
}

#pragma mark - 小写字母
+(BOOL)fm_checkingLowerLetter:(NSString *)lowerCase{
    NSString *regEx = @"^[a-z]+$";
    return [self baseCheckForRegEx:regEx data:lowerCase];
}

#pragma mark - 大写字母
+(BOOL)fm_checkingUpperLetter:(NSString *)upperCase{
    NSString *regEx = @"^[A-Z]+$";
    return [self baseCheckForRegEx:regEx data:upperCase];
}

#pragma mark - 特殊字符
+ (BOOL)fm_checkingSpecialChar:(NSString *)data{
    NSString *regEx = @"[^%&',;=?$\x22]+";
    return [self baseCheckForRegEx:regEx data:data];
}

#pragma mark - 只能输入数字
+ (BOOL)fm_checkingNumber:(NSString *)number{
    NSString *regEx = @"^[0-9]*$";
    return [self baseCheckForRegEx:regEx data:number];
}

#pragma mark - 校验只能输入n位的数字
+ (BOOL)fm_checkingNumberWithLength:(NSString *)length number:(NSString *)number{
    NSString *regEx = [NSString stringWithFormat:@"^\\d{%@}$", length];
    return [self baseCheckForRegEx:regEx data:number];
}
#pragma mark - 校验最少输入n位的数字
+ (BOOL)fm_checkingNumberWithLeastLength:(NSString *)leastLength number:(NSString *)number{
    NSString *regEx = [NSString stringWithFormat:@"^\\d{%@,}$", leastLength];
    return [self baseCheckForRegEx:regEx data:number];
}

+(BOOL)notification{
    if(NSClassFromString(@"UIAlertController")){
        BOOL isRemoteNotify = [UIApplication sharedApplication].isRegisteredForRemoteNotifications;
        
        return isRemoteNotify;
        
    }else{
        UIRemoteNotificationType type = [[UIApplication sharedApplication] enabledRemoteNotificationTypes];
        int typeBadge = (type & UIRemoteNotificationTypeBadge);
        int typeSound = (type & UIRemoteNotificationTypeSound);
        int typeAlert = (type & UIRemoteNotificationTypeAlert);
        BOOL ret =  !typeBadge || !typeSound || !typeAlert;
        
        return ret;
    }
}
+(float)readCacheSize
{
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains (NSCachesDirectory , NSUserDomainMask , YES) firstObject];
//    return [FMRegExpTool folderSizeAtPath :cachePath];
    return [FMRegExpTool fileSizeAtPath:cachePath];
}
//获取文件大小
+ (long long)fileSizeAtPath:(NSString *)filePath
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:filePath])
    {
        return 0;
    }
    else
    {
        return [[fileManager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
}
+(float)folderSizeAtPath:( NSString *) folderPath{
    
    NSFileManager * manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath :folderPath]) return 0 ;
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath :folderPath] objectEnumerator];
    NSString * fileName;
    long long folderSize = 0 ;
    while ((fileName = [childFilesEnumerator nextObject]) != nil ){
        //获取文件全路径
        NSString * fileAbsolutePath = [folderPath stringByAppendingPathComponent :fileName];
        folderSize += [FMRegExpTool folderSizeAtPath:fileAbsolutePath];
    }
    return folderSize/( 1024.0 * 1024.0);
}



+(void)clearFile
{
    NSString * cachePath = [NSSearchPathForDirectoriesInDomains (NSCachesDirectory , NSUserDomainMask , YES ) firstObject];
    NSArray * files = [[NSFileManager defaultManager ] subpathsAtPath :cachePath];
    //NSLog ( @"cachpath = %@" , cachePath);
    for ( NSString * p in files) {
        
        NSError * error = nil ;
        //获取文件全路径
        NSString * fileAbsolutePath = [cachePath stringByAppendingPathComponent :p];
        
        if ([[NSFileManager defaultManager ] fileExistsAtPath :fileAbsolutePath]) {
            [[NSFileManager defaultManager ] removeItemAtPath :fileAbsolutePath error :&error];
        }
    }
    
    //读取缓存大小
//    float cacheSize = [self readCacheSize] *1024;
//    self.cacheSize.text = [NSString stringWithFormat:@"%.2fKB",cacheSize];
    
}

+ (NSString *)handleDate:(NSString *)dateString {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    
    NSDate *date = [dateFormatter dateFromString:dateString];
    
    NSTimeInterval timeInterval = date.timeIntervalSinceNow;
    double time = - (timeInterval - 28800);
    NSString *backString;
    if (time < 60 && time > 0) {
        backString = @"刚刚";
    } else if (time > 60 && time < 3600 ) {
        int Minute = time / 60;
        backString = [NSString stringWithFormat:@"%d 分钟前",Minute];
        
    } else if (time > 3600 && time < 86400) {
        int Hour = time / 3600;
        backString = [NSString stringWithFormat:@"%d 小时前",Hour];
        
    } else if (time > 86400 && time < 172800) {
        
        backString = [NSString stringWithFormat:@"昨天"];
        
    } else if (time > 172800) {
        dateFormatter.dateFormat = @"MM月dd日";
        backString = [dateFormatter stringFromDate:date];
    }
    
    
    return backString;
}
/*
 *验证码按钮倒计时方法
 */
+(void)startTime:(UIButton *)sender{
    __block int timeout = 59;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), 1.0*NSEC_PER_SEC, 0);//每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if (timeout <= 0) {
            //倒计时结束,关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示,根据自己的要求设置
                [sender setTitle:@"获取验证码" forState:UIControlStateNormal];
                sender.userInteractionEnabled = YES;
            });
        }else{
            int seconds = timeout % 60;
            NSString *strTime = [NSString stringWithFormat:@"%.2d",seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [sender setTitle:[NSString stringWithFormat:@"%@秒后重新获取",strTime] forState:UIControlStateNormal];
                sender.userInteractionEnabled = NO;
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
}


+ (unsigned long long) FileSize:(NSString *)path
{
    NSDictionary *fileDictionary = [[NSFileManager defaultManager] attributesOfItemAtPath:path error:nil];
    return [[fileDictionary objectForKey:NSFileSize] unsignedLongLongValue];
}


@end
