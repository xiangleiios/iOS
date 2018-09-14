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
- (BOOL)isPureNum:(NSString *)text {
    if (!text) {
        return NO;
    }
    NSScanner *scan = [NSScanner scannerWithString:text];
    int val;
    return [scan scanInt:&val] && [scan isAtEnd];
}
@end
