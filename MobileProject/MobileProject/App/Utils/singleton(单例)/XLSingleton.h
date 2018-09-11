//
//  XLSingleton.h
//  MobileProject
//
//  Created by zsgy on 2018/1/31.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XLSingleton : NSObject
//获取单例对象
+(XLSingleton *)singleton;
@property (nonatomic , strong)NSMutableArray *dateArr;
@property (nonatomic , strong)NSMutableArray *courseArr;
@end
