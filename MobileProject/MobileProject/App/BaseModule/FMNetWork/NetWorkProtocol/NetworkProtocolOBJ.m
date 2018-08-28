//
//  CustomMadeOBJ.m
//  MobileProject
//
//  Created by Mingo on 2017/6/7.
//  Copyright © 2017年 ZSGY. All rights reserved.
//


#import "NetworkProtocolOBJ.h"

@interface NetworkProtocolOBJ()
{
    XBApp_Type _type;
}

@property (nonatomic, strong) NSDictionary *customMadeDic;
@end


@implementation NetworkProtocolOBJ

+ (NetworkProtocolOBJ *)sharedNetworkProtocolOBJ{
    static dispatch_once_t onceToken;
    static NetworkProtocolOBJ *sharedInstance = nil;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[NetworkProtocolOBJ alloc] init];
    });
    return sharedInstance;
}

- (NSDictionary *)customMadeDic{
    if (!_customMadeDic) {
//        NSString *path = [[NSBundle mainBundle] pathForResource:@"ReleaseNetworkProtocol" ofType:@"plist"];
        NSString *path = [[NSBundle mainBundle] pathForResource:@"DebugNetworkProtocol" ofType:@"plist"];

        _customMadeDic = [NSDictionary dictionaryWithContentsOfFile:path];
    }
    return _customMadeDic;
}



- (void)setAppType:(XBApp_Type)type{
    NSString *path = nil;
    
    switch (type) {
        case XBApp_Type_Local:
            path =  [[NSBundle mainBundle] pathForResource:@"LocalNetworkProtocol" ofType:@"plist"];
            break;
        case XBApp_Type_Debug:
            path =  [[NSBundle mainBundle] pathForResource:@"DebugNetworkProtocol" ofType:@"plist"];
            break;
        case XBApp_Type_Release:
            path =  [[NSBundle mainBundle] pathForResource:@"ReleaseNetworkProtocol" ofType:@"plist"];
            break;
        default:  NSLog(@"-------- 警告!未选择打包模式 --------------");
            break;
    }
    
    
    self.customMadeDic = [NSDictionary dictionaryWithContentsOfFile:path] ;
}


//选择接口
- (NSString*)XBMyteamBaseURL{
    
    //如果没有设置setAppType 则_customMadeDic懒加载默认为  debug 环境
    NSString *merchantName = [self.customMadeDic objectForKey:NetWorkProtocol_BaseURL];
    return merchantName;
}

- (XBApp_Type)appType{
    return _type;
}

@end