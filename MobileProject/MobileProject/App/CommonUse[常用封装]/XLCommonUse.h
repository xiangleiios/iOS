//
//  XLCommonUse.h
//  MobileProject
//
//  Created by zsgy on 2017/10/30.
//  Copyright © 2017年 ZSGY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XLCommonUse : NSObject
/// 弹出提示登录框
+ (void)promptingLogin:(UIViewController *)controller;
/// 动态计算高度
+ (float)LaberCalculateHeight:(NSString *)str andWidth:(CGFloat)w andFont:(CGFloat)f;
#pragma mark -时间返回是否为同一天
/// 时间返回是否为同一天
+ (BOOL)isSameDay:(NSString *)timeOne timeTwo:(NSString *)timeTwo;
+ (NSString *)TimeToIntercept:(NSString *)time;
+ (NSString *)TimeToInterceptHHmm:(NSString *)time;
+ (NSString *)TimeToInterceptMMddHHmm:(NSString *)time;
+ (NSString *)TimeToInterceptYYYYMMddHHmm:(NSString *)time;
+ (NSString *)TimeToInterceptYYYYMMddWithStr:(NSString *)time;
+ (NSString *)TimeToInterceptMMdd:(NSDate *)time;
+ (NSString *)TimeToInterceptYYYYMMdd:(NSDate *)time;
+ (NSString *)TimeToInterceptYYYYMMddHHMMSS:(NSDate *)time;
/// 比较2个时间大小
+(BOOL)compareOneDay:(NSString *)oneDay withAnotherDay:(NSString *)anotherDay;
/// 字符串转时间戳
+ (NSString *)dateConversionTimeStamp:(NSString *)date;
/// 时间戳转字符串
+ (NSString *)datetimestampToString:(NSString *)timestamp;
/// 然后今天起让后多少天的数组
+ (NSArray *)dataWhithDay:(NSInteger)index;

/// 根据日期返回星期
+ (NSString*)weekdayStringFromDate:(NSDate*)inputDate;
/// 根据颜色返回图片
+ (UIImage *)imageWithColor:(UIColor *)color;

/// 根据年月返回月头或月尾
+ (NSString *)dateWithArr:(NSArray *)dateArr EachOrFirstMonth:(BOOL)bol;

/// 金额千位分割
+ (NSString *)separatedDigitStringWithStr:(NSString *)digitString;

/// 整形判断(整形返回yes ,否则为no)
+ (BOOL)isPureInt:(NSString *)string;

/// 浮点形判断(整形/浮点型等数字均会返回YES,其他为no):
+ (BOOL)isPureFloat:(NSString *)string;

/// 判断一个字符串是纯数字
+ (BOOL)isPureNum:(NSString *)text;
/// 身份证判断
+(BOOL)checkUserID:(NSString *)userID;
/// 删除小数点后面的0；
+ (NSString*)removeFloatAllZeroByString:(float )num;
@end
