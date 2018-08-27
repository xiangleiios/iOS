//
//  FMPayRequest.h
//  MobileProject
//
//  Created by Mingo on 2017/11/27.
//  Copyright © 2017年 ZSGY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FMPayRequest : NSObject

/**
 支付宝和微信支付请求

 @param model model，需要订单id
 @param pushVc 支付成功跳转vc
 @param isAlipay 是支付宝还是微信支付
 @param needOutTickets 是否需要出票
 */
+ (void)fm_payRequestWithOrder:(NSString *)order pushVc:(UIViewController *)pushVc isAlipay:(BOOL)isAlipay;




@end



