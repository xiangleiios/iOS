//
//  UIWebView+FMSetTonkenToCookie.m
//  MobileProject
//
//  Created by Mingo on 2017/8/28.
//  Copyright © 2017年 ZSGY. All rights reserved.
//

#import "UIWebView+FMSetTonkenToCookie.h"

@implementation UIWebView (FMSetTonkenToCookie)

#pragma mark - 设置token给 UIWebView 的Cookie，返回 NSMutableURLRequest 对象给 UIWebView 加载
// app_token 是键 ，[User UserOb].token是值。可以后期更改自定义设置其他参数
+ (NSMutableURLRequest *)fm_setTokenToUIWebViewCookieWithRequestUrlString:(NSString *)urlString {
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    request.timeoutInterval = 10;
    //获取Cookie管理单例
    NSHTTPCookieStorage *sharedHTTPCookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    //获取Cookie内的字段数组
    NSMutableArray *cookies = (NSMutableArray *)[sharedHTTPCookieStorage cookiesForURL:[NSURL URLWithString:urlString]];
    //获取原Cookie内的字段
    NSString *cookieStr = @"";
    for (NSHTTPCookie *cookie in cookies) {
        NSString *cookieString = [NSString stringWithFormat:@"%@=%@", [cookie name], [cookie value]];
        cookieStr = [cookieStr stringByAppendingString:@"; "];
        cookieStr = [cookieStr stringByAppendingString:cookieString];
    }
    //添加需要增加的Cookie字段
    NSString *addCookie = [NSString stringWithFormat:@"%@=%@",@"app_token",[User UserOb].token];
//    NSString *addCookieAppName = [NSString stringWithFormat:@"%@=%@",@"app_name",@"whnn"];
    
    cookieStr = [NSString stringWithFormat:@"%@%@",cookieStr,addCookie];
    [request setValue:cookieStr forHTTPHeaderField:@"Cookie"];
   
    return request;
}

#pragma mark - 对主域名请求设置token到web的cookie中
+ (void)fm_setTokenToUIWebViewCookie {
    
    NSMutableArray *arrNames = [NSMutableArray arrayWithObjects:@"app_token",nil];
    NSMutableArray *arrValues = [NSMutableArray arrayWithObject:[User UserOb].token.length ? [User UserOb].token : @""];
    for (NSInteger i = 0; i < arrNames.count; i++) {
        // 工厂类中存储cookie的方法
        // 创建一个可变字典存放cookie
        NSMutableDictionary *fromappDict = [NSMutableDictionary dictionary];
        [fromappDict setObject:arrNames[i] forKey:NSHTTPCookieName];
        [fromappDict setObject:arrValues[i] forKey:NSHTTPCookieValue];
        // kDomain是公司app网址
        NSArray *arr = [FMBaseURL componentsSeparatedByString:@"//"];
        [fromappDict setObject:[arr lastObject] forKey:NSHTTPCookieDomain];
        [fromappDict setObject:FMBaseURL forKey:NSHTTPCookieOriginURL];
        [fromappDict setObject:@"/" forKey:NSHTTPCookiePath];
        [fromappDict setObject:@"0" forKey:NSHTTPCookieVersion];
        
        // 将可变字典转化为cookie
        NSHTTPCookie *cookie = [NSHTTPCookie cookieWithProperties:fromappDict];
        // 获取cookieStorage
        NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
        // 存储cookie
        [cookieStorage setCookie:cookie];
    }
   
}

+ (NSMutableURLRequest *)fm_loadRequestWithUrlString:(NSString *)urlString {
    
    // 在此处获取返回的cookie
    NSMutableDictionary *cookieDic = [NSMutableDictionary dictionary];
    
    NSMutableString *cookieValue = [NSMutableString stringWithFormat:@""];
    NSHTTPCookieStorage *cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    
    for (NSHTTPCookie *cookie in [cookieJar cookies]) {
        [cookieDic setObject:cookie.value forKey:cookie.name];
    }
    [cookieDic setObject:[User UserOb].token.length ? [User UserOb].token : @""  forKey:@"app_token"];
//    [cookieDic setObject:@"whnn" forKey:@"app_name"];

    
    // cookie重复，先放到字典进行去重，再进行拼接
    for (NSString *key in cookieDic) {
        NSString *appendString = [NSString stringWithFormat:@"%@=%@;", key, [cookieDic valueForKey:key]];
        [cookieValue appendString:appendString];
    }
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    [request addValue:cookieValue forHTTPHeaderField:@"Cookie"];
    
    return request;
}

@end
