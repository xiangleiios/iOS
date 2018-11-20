//
//  User.h
//  MobileProject
//
//  Created by zsgy on 17/2/24.
//  Copyright © 2017年 Mingoy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject
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
@property (nonatomic , strong)NSString *idid;
@property (nonatomic , strong)NSString *userId;
@property (nonatomic , strong)NSString *name;
@property (nonatomic , strong)NSString *password;
@property (nonatomic , strong)NSString *nick_name;
@property (nonatomic , strong)NSString *mobile;
@property (nonatomic , strong)NSString *avatar_url;
@property (nonatomic , strong)NSString *salt;
@property (nonatomic , strong)NSString *points;
@property (nonatomic , strong)NSString *ip;
@property (nonatomic , strong)NSString *token;
@property (nonatomic , strong)NSString *type;
@property (nonatomic , strong)NSString *source;
@property (nonatomic , strong)NSString *uid;

@property (nonatomic , strong)NSString *state;

@property (nonatomic , strong)NSNumber *accounttype;
@property (nonatomic , strong)NSString *teamUserHead;
// accountType


//获取单例对象
+(User *)UserOb;
//保存登录信息
- (void)UserSave:(NSDictionary *)dic;
//判断是否登录
- (BOOL)UserLogin;
//退出登录
- (void)UserQuit;


@end
