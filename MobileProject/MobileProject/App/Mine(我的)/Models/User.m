//
//  User.m
//  MobileProject
//
//  Created by zsgy on 17/2/24.
//  Copyright © 2017年 Mingoy. All rights reserved.
//

#import "User.h"
#import "UIWebView+FMSetTonkenToCookie.h"
#import "JPUSHService.h"
/*
 *    "id": 3,
 "name": "13720187713",
 "password": "",
 "nick_name": "13720187713",
 "mobile": "13720187713",
 "avatar_url": "http://zsnc.nctv.net.cn/images/avatar_default.png",
 "salt": "",
 "points": 0,
 "ip": "101.226.221.47",
 "token": "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjMsImlzcyI6Imh0dHA6XC9cL3pzbmMubmN0di5uZXQuY25cL2FwaVwvbWVtYmVyc1wvbG9naW4iLCJpYXQiOjE0ODc5MDczOTcsImV4cCI6MTgwMzI2NzM5NywibmJmIjoxNDg3OTA3Mzk3LCJqdGkiOiI1ZDkwNDZkMjRmMGQwZGI0MGFkODJhODEwZmVlNDE5NSJ9.qqGIltkwDXMvsJAcBCqMYHXlEXIjjU6R-ezZUWy3SCw",
 "type": 1,
 "source": "",
 "uid": 0,
 "vip_start": "0000-00-00 00:00:00",
 "vip_end": "0000-00-00 00:00:00",
 "state": 1,
 "signed_at": null,
 "created_at": "2017-02-24 11:33:24",
 "updated_at": "2017-02-24 11:36:37"
 */
@implementation User
static User *user  =  nil;
+ (User *)UserOb
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (user  ==  nil) {
            user  =  [[self alloc] init];
            
            NSUserDefaults *defaults  =  [NSUserDefaults standardUserDefaults];
            BOOL log=[defaults boolForKey:@"log"];
            if (log) {
                user.name = [defaults objectForKey:@"name"];
                user.password = [defaults objectForKey:@"password"];
                user.idid = [defaults objectForKey:@"idid"];
                user.nick_name = [defaults objectForKey:@"nick_name"];
                user.mobile = [defaults objectForKey:@"mobile"];
                user.avatar_url = [defaults objectForKey:@"avatar_url"];
                user.salt = [defaults objectForKey:@"salt"];
                user.points = [defaults objectForKey:@"points"];
                user.token = [defaults objectForKey:@"token"];
                user.uid = [defaults objectForKey:@"uid"];
                user.accounttype = [defaults objectForKey:@"accounttype"];
            }
        }
        
    });
    return user;
}

- (void)UserSave:(NSDictionary *)dic{
    self.name = dic[@"name"];
    self.password = dic[@"password"];
    self.idid = dic[@"id"];
    self.nick_name = dic[@"nick_name"];
    self.mobile = dic[@"mobile"];
    self.avatar_url = dic[@"avatar_url"];
    self.salt = dic[@"salt"];
    self.points = dic[@"points"];
    self.token = dic[@"token"];
    self.uid = dic[@"uid"];
    self.userId = dic[@"userId"];
    //把信息存起来
    NSUserDefaults *defaults  =  [NSUserDefaults standardUserDefaults];
    [defaults setObject:self.name forKey:@"name"];
    [defaults setObject:self.password forKey:@"password"];
    [defaults setObject:self.idid forKey:@"idid"];
    [defaults setObject:self.nick_name forKey:@"nick_name"];
    [defaults setObject:self.mobile forKey:@"mobile"];
    [defaults setObject:self.avatar_url forKey:@"avatar_url"];
    [defaults setObject:self.salt forKey:@"salt"];
    [defaults setObject:self.points forKey:@"points"];
    [defaults setObject:self.token forKey:@"token"];
    [defaults setObject:self.uid forKey:@"uid"];
    [defaults setObject:self.accounttype forKey:@"accounttype"];
    [defaults setObject:self.userId forKey:@"userId"];
    //登录状态
    [defaults setBool:YES forKey:@"log"];
    [defaults synchronize];
    [self setalis];
}

- (BOOL)UserLogin{
    NSUserDefaults *defaults  =  [NSUserDefaults standardUserDefaults];
    return [defaults boolForKey:@"log"];
}
- (void)UserQuit{
    KKLog(@"退出登录");
    self.name = @"";
    self.password = @"";
    self.idid = @"";
    self.nick_name = @"";
    self.mobile = @"";
    self.avatar_url = @"";
    self.salt = @"";
    self.points = @"";
    self.token = @"";
    self.uid = @"";
    self.userId = @"";
    self.accounttype = nil;
    //把信息存起来
    NSUserDefaults *defaults  =  [NSUserDefaults standardUserDefaults];
    [defaults setObject:self.name forKey:@"name"];
    [defaults setObject:self.password forKey:@"password"];
    [defaults setObject:self.idid forKey:@"idid"];
    [defaults setObject:self.nick_name forKey:@"nick_name"];
    [defaults setObject:self.mobile forKey:@"mobile"];
    [defaults setObject:self.avatar_url forKey:@"avatar_url"];
    [defaults setObject:self.salt forKey:@"salt"];
    [defaults setObject:self.points forKey:@"points"];
    [defaults setObject:self.token forKey:@"token"];
    [defaults setObject:self.uid forKey:@"uid"];
    [defaults setObject:self.accounttype forKey:@"accounttype"];
    [defaults setObject:self.userId forKey:@"userId"];
    //登录状态
    [defaults setBool:NO forKey:@"log"];
    [defaults synchronize];
    
    //清除cookies
    NSHTTPCookie *cookie;
    NSHTTPCookieStorage *storage   =   [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (cookie in [storage cookies]){
        [storage deleteCookie:cookie];
    }
    [UIWebView fm_setTokenToUIWebViewCookie];
    [FMSingle shareSingle].needReloadWeb = YES;
    [JPUSHService deleteAlias:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
        KKLog(@"清除别名");
    } seq:1];
    
}
- (void)setalis{
    
    User* bean = [User UserOb];
    if (bean.UserLogin) {
        NSSet *set=[[NSSet alloc] initWithObjects:[NSString stringWithFormat:@"%@",bean.type], nil];
        NSString *str=[NSString stringWithFormat:@"%@%@%@",bean.idid,bean.idid,bean.idid];
        NSString *str1=[NSString stringWithFormat:@"%@",bean.idid];
        [JPUSHService setAlias:str1 completion:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
            KKLog(@"rescode: %d,  \nalias: %@\n  seq:%d", iResCode, iAlias ,seq);
        } seq:1];
    }
    
}
@end
