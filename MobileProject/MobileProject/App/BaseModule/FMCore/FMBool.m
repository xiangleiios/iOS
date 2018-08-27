//
//  FMBool.m
//  MobileProject
//
//  Created by Mingo on 2017/7/5.
//  Copyright © 2017年 ZSGY. All rights reserved.
//

#import "FMBool.h"

@implementation FMBool

#pragma mark - ===== 数字判断 =====
#pragma mark  判断手机号码格式是否正确
+ (BOOL)fm_valiMobile:(NSString *)mobile{
    mobile = [mobile stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (mobile.length != 11)
    {
        return NO;
    }
    /**
     * 手机号码:
     * 13[0-9], 14[5,7], 15[0, 1, 2, 3, 5, 6, 7, 8, 9], 17[0, 1, 6, 7, 8], 18[0-9]
     * 移动号段: 134,135,136,137,138,139,147,150,151,152,157,158,159,178,182,183,184,187,188
     * 联通号段: 130,131,132,145,152,155,156,170,171,176,185,186
     * 电信号段: 133,134,153,177,180,181,189
     */
    NSString *MOBILE = @"(13\\d|14[57]|15[0-35-9]|17[01678]|18\\d)\\d{8}";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    
    return [regextestmobile evaluateWithObject:mobile];
}

#pragma mark - 判断是否为小数
+ (BOOL)fm_checkValueIsFloat:(NSString *)string
{
    //    NSScanner *scan = [NSScanner scannerWithString:string];
    //    float val;
    //    return [scan scanFloat:&val] && [scan isAtEnd];
    NSString *regex = @"^[1-9]\\d*\\.\\d+|0\\.\\d+$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pred evaluateWithObject:string];
    
}

#pragma mark --- 身份证号码验证
+ (BOOL)fm_checkIdentityCardNoIsLegal:(NSString *)idNumber{
    if (idNumber.length == 15 || idNumber.length == 18) {
        NSString *emailRegex = @"^[0-9]*$";
        NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
        bool sfzNo = [emailTest evaluateWithObject:[idNumber stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
        
        if (idNumber.length == 15) {
            if (!sfzNo) {
                return NO;
            }
        }
        else if (idNumber.length == 18) {
            bool sfz18NO = [self fm_check18IdentityCardNo:idNumber];
            if (!sfz18NO) {
                return NO;
            }
        }
        return YES;
    }else{
        return NO;
    }
}

+ (BOOL)fm_check18IdentityCardNo:(NSString*)cardNo
{
    if (cardNo.length != 18) {
        return  NO;
    }
    NSArray* codeArray = [NSArray arrayWithObjects:@"7",@"9",@"10",@"5",@"8",@"4",@"2",@"1",@"6",@"3",@"7",@"9",@"10",@"5",@"8",@"4",@"2", nil];
    NSDictionary* checkCodeDic = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"1",@"0",@"X",@"9",@"8",@"7",@"6",@"5",@"4",@"3",@"2", nil]  forKeys:[NSArray arrayWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10", nil]];
    
    NSScanner* scan = [NSScanner scannerWithString:[cardNo substringToIndex:17]];
    
    int val;
    BOOL isNum = [scan scanInt:&val] && [scan isAtEnd];
    if (!isNum) {
        return NO;
    }
    int sumValue = 0;
    
    for (int i =0; i<17; i++) {
        sumValue+=[[cardNo substringWithRange:NSMakeRange(i , 1) ] intValue]* [[codeArray objectAtIndex:i] intValue];
    }
    
    NSString* strlast = [checkCodeDic objectForKey:[NSString stringWithFormat:@"%d",sumValue%11]];
    
    if ([strlast isEqualToString: [[cardNo substringWithRange:NSMakeRange(17, 1)]uppercaseString]]) {
        return YES;
    }
    return  NO;
}

#pragma mark - 验证身份证是否合法【这个严谨些】
+ (BOOL)fm_chk18PaperId:(NSString *)sPaperId {
    //判断位数
    if ([sPaperId length] != 15 && [sPaperId length] != 18) {
        return NO;
    }
    NSString *carid = sPaperId;
    long lSumQT =0;
    //加权因子
    int R[] ={7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2 };
    //校验码
    unsigned char sChecker[11]={'1','0','X', '9', '8', '7', '6', '5', '4', '3', '2'};
    //将15位身份证号转换成18位
    NSMutableString *mString = [NSMutableString stringWithString:sPaperId];
    
    if ([sPaperId length] == 15) {
        [mString insertString:@"19" atIndex:6];
        long p = 0;
        const char *pid = [mString UTF8String];
        for (int i=0; i<=16; i++)
        {
            p += (pid[i]-48) * R[i];
        }
        int o = p%11;
        NSString *string_content = [NSString stringWithFormat:@"%c",sChecker[o]];
        [mString insertString:string_content atIndex:[mString length]];
        carid = mString;
    }
    //判断地区码
    NSString * sProvince = [carid substringToIndex:2];
    if (![self fm_areaCode:sProvince]) {
        return NO;
    }
    //判断年月日是否有效
    int strYear = [[carid substringWithRange:NSMakeRange(6,4)] intValue];//年份
    int strMonth = [[carid substringWithRange:NSMakeRange(10,2)] intValue];//月份
    int strDay = [[carid substringWithRange:NSMakeRange(12,2)] intValue];//日
    
    NSTimeZone *localZone = [NSTimeZone localTimeZone];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    [dateFormatter setTimeZone:localZone];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date=[dateFormatter dateFromString:[NSString stringWithFormat:@"%d-%d-%d 12:01:01",strYear,strMonth,strDay]];
    if (date == nil) {
        return NO;
    }
    const char *PaperId  = [carid UTF8String];
    //检验长度
    if( 18 != strlen(PaperId)) return -1;
    //校验数字
    for (int i=0; i<18; i++) {
        if ( !isdigit(PaperId[i]) && !(('X' == PaperId[i] || 'x' == PaperId[i]) && 17 == i) ) {
            return NO;
        }
    }
    //验证最末的校验码
    for (int i=0; i<=16; i++) {
        lSumQT += (PaperId[i]-48) * R[i];
    }
    
    if (sChecker[lSumQT%11] != PaperId[17] ) {
        return NO;
    }
    return YES;
}

/**
 * 功能:判断是否在地区码内
 * 参数:地区码
 */
+ (BOOL)fm_areaCode:(NSString *)code {
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    
    [dic setObject:@"北京" forKey:@"11"];
    [dic setObject:@"天津" forKey:@"12"];
    [dic setObject:@"河北" forKey:@"13"];
    [dic setObject:@"山西" forKey:@"14"];
    [dic setObject:@"内蒙古" forKey:@"15"];
    [dic setObject:@"辽宁" forKey:@"21"];
    [dic setObject:@"吉林" forKey:@"22"];
    [dic setObject:@"黑龙江" forKey:@"23"];
    [dic setObject:@"上海" forKey:@"31"];
    [dic setObject:@"江苏" forKey:@"32"];
    [dic setObject:@"浙江" forKey:@"33"];
    [dic setObject:@"安徽" forKey:@"34"];
    [dic setObject:@"福建" forKey:@"35"];
    [dic setObject:@"江西" forKey:@"36"];
    [dic setObject:@"山东" forKey:@"37"];
    [dic setObject:@"河南" forKey:@"41"];
    [dic setObject:@"湖北" forKey:@"42"];
    [dic setObject:@"湖南" forKey:@"43"];
    [dic setObject:@"广东" forKey:@"44"];
    [dic setObject:@"广西" forKey:@"45"];
    [dic setObject:@"海南" forKey:@"46"];
    [dic setObject:@"重庆" forKey:@"50"];
    [dic setObject:@"四川" forKey:@"51"];
    [dic setObject:@"贵州" forKey:@"52"];
    [dic setObject:@"云南" forKey:@"53"];
    [dic setObject:@"西藏" forKey:@"54"];
    [dic setObject:@"陕西" forKey:@"61"];
    [dic setObject:@"甘肃" forKey:@"62"];
    [dic setObject:@"青海" forKey:@"63"];
    [dic setObject:@"宁夏" forKey:@"64"];
    [dic setObject:@"新疆" forKey:@"65"];
    [dic setObject:@"台湾" forKey:@"71"];
    [dic setObject:@"香港" forKey:@"81"];
    [dic setObject:@"澳门" forKey:@"82"];
    [dic setObject:@"国外" forKey:@"91"];
    if ([dic objectForKey:code] == nil) {
        return NO;
    }
    return YES;
}

#pragma mark   判断字符串是否全部为数字
+ (BOOL)fm_isAllNum:(NSString *)string{
    NSScanner *scan = [NSScanner scannerWithString:string];
    int val;
    return [scan scanInt:&val] && [scan isAtEnd];
}

#pragma mark - ===== 邮箱判断 =====
#pragma mark  利用正则表达式判断邮箱格式是否正确
+ (BOOL)fm_isAvailableEmail:(NSString *)email {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}


#pragma mark - ===== 字符判断 =====
#pragma mark  判断字符串中是否含有空格
+ (BOOL)fm_isHaveSpaceInString:(NSString *)string{
    NSRange _range = [string rangeOfString:@" "];
    if (_range.location != NSNotFound) {
        return YES;
    }else {
        return NO;
    }
}

#pragma mark  判断字符串中是否含有某个字符串
+ (BOOL)fm_isHaveString:(NSString *)string1 InString:(NSString *)string2{
    NSRange _range = [string2 rangeOfString:string1];
    if (_range.location != NSNotFound) {
        return YES;
    }else {
        return NO;
    }
}

#pragma mark 判断字符串中是否含有中文
+ (BOOL)fm_isHaveChineseInString:(NSString *)string{
    for(NSInteger i = 0; i < [string length]; i++){
        int a = [string characterAtIndex:i];
        if (a > 0x4e00 && a < 0x9fff) {
            return YES;
        }
    }
    return NO;
}

#pragma mark 检测字符串是否为空
+ (BOOL)fm_checkStringIsNull:(NSString *)str
{
    if (str == nil || str == NULL || [str isEqualToString:@""]) {
        return YES;
    }
    if ([str isKindOfClass:[NSNull class]]) {
        return YES;
    }
    
    if ([str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length == 0) {
        return YES;
    }
    return NO;
}


#pragma mark - ===== 昵称密码 =====
#pragma mark 检测密码合法性
+ (BOOL)fm_checkPasswordIsLegal:(NSString *)password
{
    NSString *passWordRegex = @"^[a-zA-Z0-9]{6,18}+$";;
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", passWordRegex];
    
    return [passWordPredicate evaluateWithObject:password];
}

#pragma mark 检测昵称合法性
+ (BOOL)fm_checkNickNameIsLegal:(NSString *)nickName
{
    NSString *regex = @"[A-Za-z0-9_\\-\u4e00-\u9fa5]+";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pred evaluateWithObject:nickName];
}

#pragma mark - ===== 数组判空 =====
#pragma mark  数组判空
+ (BOOL)fm_checkEmptyArrayIsEmpty:(NSMutableArray *)array{
    if ([array isEqual:[NSNull class]]) {
        return YES;
    }else if ([array isKindOfClass:[NSNull class]]){
        return YES;
    }else if (array == nil){
        return YES;
    }else if (array.count <= 0){
        return YES;
    }
    return NO;
}

#pragma mark - 判断一个对象是否包含指定Key 【根据OC的动态特性,利用Runtime去解决这个问题,查找他的ivars中是否存在这个key】
+ (BOOL)fm_key:(NSString *)key existInClass:(Class)metaClass{
    unsigned int count = 0;
    BOOL exist = NO;
    Ivar *ivars = class_copyIvarList(metaClass, &count);
    for (int i = 0; i < count; i++) {
        Ivar ivar = ivars[i];
        NSString *keyName = [NSString stringWithCString:ivar_getName(ivar) encoding:NSUTF8StringEncoding];
        if ([keyName rangeOfString:key].length>0) {
            exist = YES;
        }
    }
    return exist;
}




@end
