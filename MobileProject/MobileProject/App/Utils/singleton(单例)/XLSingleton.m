//
//  XLSingleton.m
//  MobileProject
//
//  Created by zsgy on 2018/1/31.
//  Copyright © 2018年 ZSGY. All rights reserved.
//
//0 => '订单已取消',
//1 => '订单待确认',
//2 => '押金凭证待确认',
//3 => '订单匹配中',
//4 => '待签订服务合同',
//5 => '待支付服务费首付款',
//6 => '首付款凭证待确认',
//7 => '供电三方合同签订中',
//8 => '待支付服务费余款',
//9 => '服务费余款凭证待确认',
//10 => '订单完成',
//11 => '押金线下支付成功',
//12 => '首付款线下支付成功',
//13 => '尾款线下支付成功',
//14 => '订单匹配成功',
//15 => '订单已确认',
//16 => '服务合同已签订',
//17 => '三方合同签订成功',
//18 => '订单发起',
//19 => '服务费首付款已支付',
#import "XLSingleton.h"

@implementation XLSingleton
static XLSingleton *xlsingleton = nil;
+ (XLSingleton *)singleton
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (xlsingleton == nil) {
            xlsingleton = [[self alloc] init];
            xlsingleton.tagsDic = [NSMutableDictionary dictionary];
            xlsingleton.typeArr = @[@"订单已取消",@"订单待确认",@"押金凭证待确认",@"订单匹配中",@"待签订服务合同",@"待支付服务费首付款",@"首付款凭证待确认",@"供电三方合同签订中",@"待支付服务费余款",@"服务费余款凭证待确认",@"订单完成",@"押金线下支付成功",@"首付款线下支付成功",@"尾款线下支付成功",@"订单匹配成功",@"订单已确认",@"服务合同已签订",@"三方合同签订成功",@"订单发起",@"服务费首付款已支付"];
            xlsingleton.dateArr = @[@[@"2018",@"2019",@"2020"],@[@"01",@"02",@"03",@"04",@"05",@"06",@"07",@"08",@"09",@"10",@"11",@"12"]];
        }
    });
    return xlsingleton;
}
@end
