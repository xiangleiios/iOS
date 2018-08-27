//
//  XLUPPay.h
//  MobileProject
//
//  Created by zsgy on 2018/7/12.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XLUPPay : NSObject
/// 银联支付
+ (void)upPayRequestWithOrder:(NSString *)order pushVc:(UIViewController *)pushVc;
/// 银联支付回调
+ (void)uppay_handleUrl:(NSURL *)url;
@end
