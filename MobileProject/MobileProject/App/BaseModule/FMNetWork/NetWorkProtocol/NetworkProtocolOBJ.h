//
//  CustomMadeOBJ.h
//  MobileProject
//
//  Created by Mingo on 2017/6/7.
//  Copyright © 2017年 ZSGY. All rights reserved.
//

#import <Foundation/Foundation.h>

//测试服务器
#define NetWorkProtocol_BaseURL  @"NetWorkProtocol_BaseURL"//plist文件里字典对应的key

typedef enum{
 XBApp_Type_Release = 0,  //打包版本
 XBApp_Type_Debug,      //测试版本
 XBApp_Type_Local,     //本地版本
}XBApp_Type;

@interface NetworkProtocolOBJ : NSObject

+ (NetworkProtocolOBJ*)sharedNetworkProtocolOBJ;

//选择网络环境
- (void)setAppType:(XBApp_Type)type;


//接口前缀
- (NSString*)XBMyteamBaseURL;

//查看当前环境
- (XBApp_Type)appType;

@end
