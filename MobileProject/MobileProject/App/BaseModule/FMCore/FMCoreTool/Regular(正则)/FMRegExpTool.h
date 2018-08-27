//
//  FMRegExpTool.h
//  RegularExpression
//
//  Created by Mingo on 2017/1/13.
//  Copyright © 2017年 袁凤鸣. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FMRegExpTool : NSObject


/**
 *  邮箱验证
 */
+ (BOOL)fm_checkingEmail:(NSString *)email;

/**
 *  手机号验证
 */
+(BOOL)fm_checkingMobile:(NSString *)mobile;

/**
 *  电话号验证
 */
+(BOOL)fm_checkingPhoneNum:(NSString *)phoneNum;

/**
 *  身份证号验证(15位 或 18位)
 */
+(BOOL)fm_checkingIdCard:(NSString *)idCard;

/**
 *  密码验证
 *
 *  @param shortest 最短长度
 *  @param longest  最长长度
 *  @param pwd      密码
 *
 *  @return 结果
 */
+(BOOL)fm_checkingPasswordWithShortest:(NSInteger)shortest
                               longest:(NSInteger)longest
                              password:(NSString *)pwd;


/**
 *  由数字和26个英文字母组成的字符串
 *
 */
+ (BOOL)fm_checkingStrFormNumberAndLetter:(NSString *)data;

/**
 *  校验只能输入由26个小写英文字母组成的字符串
 */
+ (BOOL)fm_checkingStrFormLowerAndUpperLetter:(NSString *)data;


/**
 *  校验只能输入小写字母
 */
+ (BOOL)fm_checkingLowerLetter:(NSString *)lowerCase;

/**
 *  校验只能输入大写字母
 */
+ (BOOL)fm_checkingUpperLetter:(NSString *)upperCase;


/**
 *  是否含有特殊字符(%&’,;=?$\等)
 */
+ (BOOL)fm_checkingSpecialChar:(NSString *)data;


/**
 *  校验只能输入数字
 */
+ (BOOL)fm_checkingNumber:(NSString *)number;

/**
 *  校验只能输入n位的数字
 *
 *  @param length n位
 *  @param number 数字
 */
+ (BOOL)fm_checkingNumberWithLength:(NSString *)length number:(NSString *)number;

/**
 *  校验最少输入n位的数字
 *
 *  @param length n位
 *  @param number 数字
 */
+ (BOOL)fm_checkingNumberWithLeastLength:(NSString *)leastLength number:(NSString *)number;
/*
 *查询当前APP是否允许通知；
 */
+(BOOL)notification;

/*
 *获取缓存文件大小；
 */
+(float)readCacheSize;
+(float)folderSizeAtPath:( NSString *) folderPath;
/*
 *清除缓存
 */
+(void)clearFile;

/*
 传入时间与现在时间差距在60秒以内，输出@“刚刚”
 1个小时以内，输出@“**分钟前”
 差距1-24小时以内，输出@“**小时前”
 差距24小时到48小时，输出昨天
 差距大于48小时，输出@“完整日期”
 */
+ (NSString *)handleDate:(NSString *)dateString;

/*
 *验证码按钮倒计时方法
 */
+(void)startTime:(UIButton *)sender;

/*
 *返回文件大小
 */
+ (unsigned long long) FileSize:(NSString *)path;

@end
