//
//  FMWechatPayModel.h
//  MobileProject
//
//  Created by Mingo on 2017/11/15.
//  Copyright © 2017年 ZSGY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FMWechatPayModel : NSObject

@property (nonatomic, copy) NSString *sign;
@property (nonatomic, copy) NSString *partnerid;
@property (nonatomic, copy) NSString *package;
@property (nonatomic, copy) NSString *noncestr;
@property (nonatomic, assign) NSInteger timestamp;
@property (nonatomic, copy) NSString *appid;
@property (nonatomic, copy) NSString *prepayid;
@end
