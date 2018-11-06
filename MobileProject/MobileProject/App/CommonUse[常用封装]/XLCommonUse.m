//
//  XLCommonUse.m
//  MobileProject
//
//  Created by zsgy on 2017/10/30.
//  Copyright © 2017年 ZSGY. All rights reserved.
//

#import "XLCommonUse.h"

@implementation XLCommonUse
+ (void)promptingLogin:(UIViewController *)controller{
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"请登录后再操作哦！" preferredStyle: UIAlertControllerStyleAlert];
        UIAlertAction *cancelButton = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        UIAlertAction *logButton = [UIAlertAction actionWithTitle:@"登录" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            LoginVC *vc=[[LoginVC alloc]init];
            vc.hidesBottomBarWhenPushed=YES;
            [controller.navigationController pushViewController:vc animated:YES];
        }];
        [alert addAction:cancelButton];
        [alert addAction:logButton];
        [controller presentViewController:alert animated:YES completion:nil];
}

+ (float)LaberCalculateHeight:(NSString *)str andWidth:(CGFloat)w andFont:(CGFloat)f{
    CGSize maxSize = CGSizeMake(w, MAXFLOAT);
    CGFloat textH = [str boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:f]} context:nil].size.height;
    return textH;
}


+ (BOOL)isSameDay:(NSString *)timeOne timeTwo:(NSString *)timeTwo
{
    NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSDate* date1 = [formatter dateFromString:timeOne];
    NSDate* date2 = [formatter dateFromString:timeTwo];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    unsigned unitFlag = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit;
    NSDateComponents *comp1 = [calendar components:unitFlag fromDate:date1];
    
    NSDateComponents *comp2 = [calendar components:unitFlag fromDate:date2];
    
    return (([comp1 day] == [comp2 day]) && ([comp1 month] == [comp2 month]) && ([comp1 year] == [comp2 year]));
    
}

+ (NSString *)TimeToIntercept:(NSString *)time{
    NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSDate* date = [formatter dateFromString:time];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    NSString *time1 = [formatter stringFromDate:date];
    return time1;
}

+ (NSString *)TimeToInterceptHHmm:(NSString *)time{
    NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSDate* date = [formatter dateFromString:time];
    [formatter setDateFormat:@"HH:mm"];
    NSString *time1 = [formatter stringFromDate:date];
    return time1;
}
+ (NSString *)TimeToInterceptMMddHHmm:(NSString *)time{
    NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSDate* date = [formatter dateFromString:time];
    [formatter setDateFormat:@"MM-dd HH:mm"];
    NSString *time1 = [formatter stringFromDate:date];
    return time1;
}
+ (NSString *)TimeToInterceptYYYYMMddHHmm:(NSString *)time{
    NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSDate* date = [formatter dateFromString:time];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm"];
    NSString *time1 = [formatter stringFromDate:date];
    return time1;
}
+ (NSString *)TimeToInterceptYYYYMMddWithStr:(NSString *)time{
    NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSDate* date = [formatter dateFromString:time];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    NSString *time1 = [formatter stringFromDate:date];
    return time1;
}
+ (NSString *)TimeToInterceptMMdd:(NSDate *)time{
    NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"MM-dd"];
    return [formatter stringFromDate:time];
}
+ (NSString *)TimeToInterceptYYYYMMdd:(NSDate *)time{
    NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    return [formatter stringFromDate:time];
}
+ (NSString *)TimeToInterceptYYYYMMddHHMMSS:(NSDate *)time{
    NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    return [formatter stringFromDate:time];
}
+ (UIImage *)imageWithColor:(UIColor *)color{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f); //宽高 1.0只要有值就够了
    UIGraphicsBeginImageContext(rect.size); //在这个范围内开启一段上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);//在这段上下文中获取到颜色UIColor
    CGContextFillRect(context, rect);//用这个颜色填充这个上下文
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();//从这段上下文中获取Image属性,,,结束
    UIGraphicsEndImageContext();
    return image;
}

+ (NSString *)dateWithArr:(NSArray *)dateArr EachOrFirstMonth:(BOOL)bol{
    if (dateArr.count <2) {
        return @"数据错误";
    }
    if (bol) {
        return [NSString stringWithFormat:@"%@-%@-01",dateArr[0],dateArr[1]];
    }else{
        NSString *day;
        switch ([dateArr[1] intValue]) {
            case 1:
                day = @"31";
                break;
            case 2:
                day = @"28";
                break;
            case 3:
                day = @"31";
                break;
            case 4:
                day = @"30";
                break;
            case 5:
                day = @"31";
                break;
            case 6:
                day = @"30";
                break;
            case 7:
                day = @"31";
                break;
            case 8:
                day = @"31";
                break;
            case 9:
                day = @"30";
                break;
            case 10:
                day = @"31";
                break;
            case 11:
                day = @"30";
                break;
            case 12:
                day = @"31";
                break;
                
            default:
                break;
        }
        
        
        return [NSString stringWithFormat:@"%@-%@-%@",dateArr[0],dateArr[1],day];
    }
    
}

+ (NSString *)separatedDigitStringWithStr:(NSString *)digitString{
    NSString *xiaoshu;
    if([digitString rangeOfString:@"."].location !=NSNotFound)//_roaldSearchText
    {
        NSLog(@"yes");
        NSArray  *array = [digitString componentsSeparatedByString:@"."];
        digitString = array[0];
        xiaoshu = array[1];
    }
    if (digitString.length <= 3) {
        if (xiaoshu != nil) {
            digitString = [NSString stringWithFormat:@"%@.%@",digitString,xiaoshu];
        }
        return digitString;
    } else {
        NSMutableString *processString = [NSMutableString stringWithString:digitString];
        NSInteger location = processString.length - 3;
        NSMutableArray *processArray = [NSMutableArray array];
        while (location >= 0) {
            NSString *temp = [processString substringWithRange:NSMakeRange(location, 3)];
            [processArray addObject:temp];
            if (location < 3 && location > 0){
                NSString *t = [processString substringWithRange:NSMakeRange(0, location)];
                [processArray addObject:t];
            }
            location -= 3;
        }
        NSMutableArray *resultsArray = [NSMutableArray array];
        int k = 0;
        for (NSString *str in processArray)
        {
            k++;
            NSMutableString *tmp = [NSMutableString stringWithString:str];
            if (str.length > 2 && k < processArray.count )
            {
                [tmp insertString:@"," atIndex:0];
                [resultsArray addObject:tmp];
            } else {
                [resultsArray addObject:tmp];
            }
        }
        NSMutableString *resultString = [NSMutableString string];
        for (NSInteger i = resultsArray.count - 1 ; i >= 0; i--)
        {
            NSString *tmp = [resultsArray objectAtIndex:i];
            [resultString appendString:tmp];
        }
        if (xiaoshu != nil) {
            resultString = [NSMutableString stringWithFormat:@"%@.%@",resultString,xiaoshu];
        }
        return resultString;
    }
}


+ (BOOL)isPureFloat:(NSString *)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    float val;
    return [scan scanFloat:&val] && [scan isAtEnd];
}
+ (BOOL)isPureInt:(NSString *)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return [scan scanInt:&val] && [scan isAtEnd];
}



+ (NSString *)dateConversionTimeStamp:(NSString *)date{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init]; //指定时间显示样式: HH表示24小时制 hh表示12小时制
    [formatter setDateFormat:@"YYYY-MM-dd"];
//    NSString *lastTime = @"2017-01-23 17:22:00";
    NSDate *lastDate = [formatter dateFromString:date]; //以 1970/01/01 GMT为基准，得到lastDate的时间戳
    long firstStamp = [lastDate timeIntervalSince1970];
    NSLog(@"firstStamp:%ld",firstStamp);
    /// 转时间戳
    NSString *timeSp = [NSString stringWithFormat:@"%ld", firstStamp*1000];
    return timeSp;
}

+ (NSString *)datetimestampToString:(NSString *)timestamp{
    
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[timestamp longLongValue]/1000];
    
    NSDateFormatter *dateFormat=[[NSDateFormatter alloc]init];
    
    [dateFormat setDateFormat:@"YYYY-MM-dd"];
    
    NSString* string=[dateFormat stringFromDate:confromTimesp];
    
    return string;
    
}


+(BOOL)compareOneDay:(NSString *)oneDay withAnotherDay:(NSString *)anotherDay
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
//    NSString *oneDayStr = [dateFormatter stringFromDate:oneDay];
//    NSString *anotherDayStr = [dateFormatter stringFromDate:anotherDay];
    NSDate *dateA = [dateFormatter dateFromString:oneDay];
    NSDate *dateB = [dateFormatter dateFromString:anotherDay];
    NSComparisonResult result = [dateA compare:dateB];
    NSLog(@"date1 : %@, date2 : %@", oneDay, anotherDay);
    if (result == NSOrderedDescending) {
        //NSLog(@"Date1  is in the future");
        return NO;
    }
    else if (result == NSOrderedAscending){
        //NSLog(@"Date1 is in the past");
        return YES;
    }
    //NSLog(@"Both dates are the same");
    return NO;
    
}
/** 判断一个字符串是纯数字 */
+ (BOOL)isPureNum:(NSString *)text{
    if (text.length == 0) {
        return YES;
    }
    text = [text stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]];
    if(text.length > 0) {
        return NO;
        
    }
    return YES;
    
    
   
}


+(BOOL)checkUserID:(NSString *)userID{
    //长度不为18的都排除掉
    if (userID.length!=18) { return NO; }
    //校验格式
    NSString *regex2 = @"^(^[1-9]\\d{7}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}$)|(^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])((\\d{4})|\\d{3}[Xx])$)$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2]; BOOL flag = [identityCardPredicate evaluateWithObject:userID];
    if (!flag) { return flag;
        //格式错误
        
    }else {
        //格式正确在判断是否合法 //将前17位加权因子保存在数组里
        NSArray * idCardWiArray = @[@"7", @"9", @"10", @"5", @"8", @"4", @"2", @"1", @"6", @"3", @"7", @"9", @"10", @"5", @"8", @"4", @"2"];
        //这是除以11后，可能产生的11位余数、验证码，也保存成数组
        NSArray * idCardYArray = @[@"1", @"0", @"10", @"9", @"8", @"7", @"6", @"5", @"4", @"3", @"2"]; //用来保存前17位各自乖以加权因子后的总和
        NSInteger idCardWiSum = 0; for(int i = 0;i < 17;i++) { NSInteger subStrIndex = [[userID substringWithRange:NSMakeRange(i, 1)] integerValue]; NSInteger idCardWiIndex = [[idCardWiArray objectAtIndex:i] integerValue]; idCardWiSum+= subStrIndex * idCardWiIndex; }
        //计算出校验码所在数组的位置
        NSInteger idCardMod=idCardWiSum%11;
        //得到最后一位身份证号码
        NSString * idCardLast= [userID substringWithRange:NSMakeRange(17, 1)];
        //如果等于2，则说明校验码是10，身份证号码最后一位应该是X
        if(idCardMod==2) {
            if([idCardLast isEqualToString:@"X"]||[idCardLast isEqualToString:@"x"]){
                return YES;
                
            }else {
                return NO;
                
            }
            
        }else{
            //用计算出的验证码与最后一位身份证号码匹配，如果一致，说明通过，否则是无效的身份证号码
            if([idCardLast isEqualToString: [idCardYArray objectAtIndex:idCardMod]]) {
                return YES;
                
            } else {
                return NO;
                
            }
            
        }
        
    }
    
}
    
+ (NSArray *)dataWhithDay:(NSInteger)index{
    NSMutableArray *arr = [NSMutableArray array];
    NSDate*nowDate = [NSDate date];
    [arr addObject:nowDate];
    NSTimeInterval  oneDay = 24*60*60*1;  //1天的长度
    for (int i = 1; i < index; i ++) {
        NSDate* theDate = [nowDate initWithTimeIntervalSinceNow: oneDay * i ];
        [arr addObject:theDate];
    }
    return arr;
}

+ (NSString*)weekdayStringFromDate:(NSDate*)inputDate{
    NSArray *weekdays = [NSArray arrayWithObjects: [NSNull null], @"周日", @"周一", @"周二", @"周三", @"周四", @"周五", @"周六", nil];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierChinese];
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
    [calendar setTimeZone: timeZone];
    NSCalendarUnit calendarUnit = NSCalendarUnitWeekday;
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:inputDate];
    return [weekdays objectAtIndex:theComponents.weekday];
    
    
}

+ (NSString*)removeFloatAllZeroByString:(float )num{
    NSString *testNumber = [NSString stringWithFormat:@"%.4f",num];
    NSString * outNumber = [NSString stringWithFormat:@"%@",@(testNumber.floatValue)];
    return outNumber;
}

@end
