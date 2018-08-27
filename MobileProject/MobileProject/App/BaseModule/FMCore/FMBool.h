//
//  FMBool.h
//  MobileProject
//
//  Created by Mingo on 2017/7/5.
//  Copyright © 2017年 ZSGY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FMBool : NSObject

/**  @brief 判断手机号码格式是否正确  手机号码  */
+ (BOOL)fm_valiMobile:(NSString *)mobile;

/**  @brief 判断邮箱格式是否正确  */
+ (BOOL)fm_isAvailableEmail:(NSString *)email;

/**  判断字符串是否全部为数字 */
+ (BOOL)fm_isAllNum:(NSString *)string;

/**  @brief  判断字符串中是否含有空格 */
+ (BOOL)fm_isHaveSpaceInString:(NSString *)string;

/**  @brief 判断字符串中是否含有某个字符串 */
+ (BOOL)fm_isHaveString:(NSString *)string1 InString:(NSString *)string2;

/**  @brief 判断字符串中是否含有中文 */
+ (BOOL)fm_isHaveChineseInString:(NSString *)string;

/** 检测字符串是否为空 */ 
+ (BOOL)fm_checkStringIsNull:(NSString *)str;

/** 检测密码合法性 */
+ (BOOL)fm_checkPasswordIsLegal:(NSString *)password;

/** 检测昵称合法性 */ 
+ (BOOL)fm_checkNickNameIsLegal:(NSString *)nickName;

/** 数组判空 */ 
+ (BOOL)fm_checkEmptyArrayIsEmpty:(NSMutableArray *)array;

/** 判断是否为小数 */ 
+ (BOOL)fm_checkValueIsFloat:(NSString *)string;

/** 身份证号码验证 */ 
+ (BOOL)fm_checkIdentityCardNoIsLegal:(NSString *)idNumber;

/// 验证身份证是否合法【这个严谨些】
+ (BOOL)fm_chk18PaperId:(NSString *)sPaperId;

/// 判断一个对象是否包含指定Key 【根据OC的动态特性,利用Runtime去解决这个问题,查找他的ivars中是否存在这个key】
+ (BOOL)fm_key:(NSString *)key existInClass:(Class)metaClass;
@end
