//
//  SQLfmdb.h
//  NNTT
//
//  Created by zsgy on 16/8/3.
//  Copyright © 2016年 王文辉. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "FMMainModel.h"
typedef void (^sqlSelect) (NSMutableArray *arry);
@interface SQLfmdb : NSObject


@property(nonatomic ,strong)FMDatabase *db;

/// 创建数据库文件
- (void)createsqlitedb;

/// 创建表
- (void)createTableName:(NSString *)table;

/// 插入数据
- (void)sqlinsertintoModel:(NSString *)userid COMID:(int)comid;

- (void)sqlinsertintoLBModel:(NSString *)userid COMID:(int)comid;

/// 删除数据
- (void)sqldeleteModel:(NSString *)userid COMID:(int)comid;
- (void)sqldeleteLBModel:(NSString *)userid COMID:(int)comid;

///修改数据
- (void)changeDataWithModel:(FMMainModel *)model TAG:(NSInteger )tag;

/// 修改我的ID
- (void)changeDataWithid:(NSInteger )tag;

/// 查询我的最新ID 数据
- (void)sqlselectueserWDBlock:(sqlSelect)block;

/// 查询
- (void)sqlselectueser:(NSString *)uerid COMID:(int)comid Block:(sqlSelect)block;

- (void)sqlselectueserLB:(NSString *)uerid COMID:(int)comid Block:(sqlSelect)block;

/// 通过tag查询
- (void)sqlselectfrom:(NSInteger)Tag Block:(sqlSelect)block;

///////////////////////// 推送本地储存

/// 插入推送数据
- (void)sqlinsertintoDictionJson:(NSString *)DictionJson;
@end
