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
#import "XLCache.h"

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
                user.userId = [defaults objectForKey:@"userId"];
                user.accounttype = [defaults objectForKey:@"accounttype"];
                user.teamUserHead = [defaults objectForKey:@"teamUserHead"];
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
    self.teamUserHead = dic[@"teamUserHead"];
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
    NSString *str = [NSString stringWithFormat:@"%@",self.teamUserHead?self.teamUserHead:@""];
    
    [defaults setObject:KURLIma(str) forKey:@"teamUserHead"];
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
    self.teamUserHead = @"";
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
    [defaults setObject:self.teamUserHead forKey:@"teamUserHead"];
    //登录状态
    [defaults setBool:NO forKey:@"log"];
    [defaults synchronize];
    XLCache *sinle = [XLCache singleton];
    sinle.ethnicTitleArr = nil;
    sinle.ethnicValueArr = nil;
    sinle.student_apply_type_title = nil;
    sinle.student_apply_type_value = nil;
    sinle.student_license_type_title = nil;
    sinle.student_license_type_value = nil;
    sinle.student_is_enter_type_title = nil;
    sinle.student_is_enter_type_value = nil;
    sinle.sys_user_sex_title = nil;
    sinle.sys_user_sex_value = nil;
    sinle.teamCode_title = nil;
    sinle.teamCode_value = nil;
    sinle.schoolDeptId = nil;
//    sinle.sys_user_sex_value = nil;
    
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

#pragma mark -用户类型区分
@synthesize type = _type;
- (void)setType:(NSString *)type{
    NSUserDefaults *defaults  =  [NSUserDefaults standardUserDefaults];
    [defaults setObject:type forKey:@"userType"];
    [defaults synchronize];
}
- (NSString *)type{
    NSUserDefaults *defaults  =  [NSUserDefaults standardUserDefaults];
    _type = [defaults objectForKey:@"userType"];
    return _type;
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
