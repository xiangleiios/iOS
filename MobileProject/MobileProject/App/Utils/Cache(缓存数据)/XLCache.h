//
//  XLCache.h
//  MobileProject
//
//  Created by 向蕾 on 2018/9/5.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <YYCache.h>
@interface XLCache : NSObject
//获取单例对象
+(XLCache *)singleton;
@property (nonatomic , strong)YYCache *cache;
/// 获取名族数组
@property (nonatomic , strong)NSMutableArray *ethnicTitleArr;
/// 获取名族对应的value数组
@property (nonatomic , strong)NSMutableArray *ethnicValueArr;
/// 学员申请类型
@property (nonatomic , strong)NSMutableArray *student_apply_type_title;
/// 学员申请类型value数组
@property (nonatomic , strong)NSMutableArray *student_apply_type_value;
/// 准驾车型
@property (nonatomic , strong)NSMutableArray *student_license_type_title;
/// 准驾车型value数组
@property (nonatomic , strong)NSMutableArray *student_license_type_value;
/// 本外地
@property (nonatomic , strong)NSMutableArray *student_is_enter_type_title;
/// 本外地value数组
@property (nonatomic , strong)NSMutableArray *student_is_enter_type_value;
/// 性别
@property (nonatomic , strong)NSMutableArray *sys_user_sex_title;
/// 性别value数组
@property (nonatomic , strong)NSMutableArray *sys_user_sex_value;
/// 驾校名
@property (nonatomic , strong)NSMutableArray *teamCode_title;
/// 驾校名value数组 学员中使用
@property (nonatomic , strong)NSMutableArray *teamCode_value;

///驾校名value数组 招生名片中使用
@property (nonatomic , strong)NSMutableArray *schoolDeptId;

///将数据存入缓存
- (void)cacheWhitValue:(id)value AndKey:(NSString *)key;
///将缓存数据取出
- (id)objectForKey:(NSString *)key;
/// 通过KEY 取出对应的数组Title
- (NSMutableArray *)loadethnicTitleWithKey:(NSString *)key;
/// 通过KEY 取出对应的数组Value
- (NSMutableArray *)loadethnicValueWithKey:(NSString *)key;
@end
