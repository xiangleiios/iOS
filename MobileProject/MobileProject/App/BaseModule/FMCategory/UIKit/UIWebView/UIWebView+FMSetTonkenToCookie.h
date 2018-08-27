//
//  UIWebView+FMSetTonkenToCookie.h
//  MobileProject
//
//  Created by Mingo on 2017/8/28.
//  Copyright © 2017年 ZSGY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIWebView (FMSetTonkenToCookie)
/** 设置token给 UIWebView 的Cookie，返回 NSMutableURLRequest 对象给 UIWebView 加载 */
+ (NSMutableURLRequest *)fm_setTokenToUIWebViewCookieWithRequestUrlString:(NSString *)urlString;
/// 对主域名请求设置token到web的cookie中
+ (void)fm_setTokenToUIWebViewCookie;
+ (NSMutableURLRequest *)fm_loadRequestWithUrlString:(NSString *)urlString;
@end
