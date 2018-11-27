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
@property (nonatomic , strong)NSMutableArray *dateArr; /// 学员选择数组
@property (nonatomic , strong)NSMutableArray *practiceArr; /// 练习学员数组
@property (nonatomic , strong)NSMutableArray *timeArr;   ///预约时段
@property (nonatomic , strong)NSMutableArray *courseArr;
@property (nonatomic , strong)NSString *scanPhotoIp;
@property (nonatomic , strong)NSString *shareId;
/// 分享类型  1：海报  2：名片
@property (nonatomic , assign)NSInteger type;
@end
