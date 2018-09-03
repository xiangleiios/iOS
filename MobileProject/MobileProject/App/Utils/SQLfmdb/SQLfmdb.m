//
//  SQLfmdb.m
//  NNTT
//
//  Created by zsgy on 16/8/3.
//  Copyright © 2016年 王文辉. All rights reserved.
//

#import "SQLfmdb.h"

@implementation SQLfmdb
/*
 *创建数据库文件
 */
- (void)createsqlitedb{
    NSString * path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
    path = [path stringByAppendingPathComponent:@"Found.db"];
    KKLog(@"数据库:%@",path);
    self.db = [FMDatabase databaseWithPath:path];
}

/*
 *创建表
 */
- (void)createTableName:(NSString *)table{
    [self.db open];
    NSString * tablename = [NSString stringWithFormat:@"create table if not exists Thumbup(idid integer not null primary key,user text,comid text)"];
    
    BOOL b = [self.db executeUpdate:tablename];
    NSString * tablenametwo = [NSString stringWithFormat:@"create table if not exists ThumbupLB(idid integer not null primary key,user text,comid text)"];
    [self.db executeUpdate:tablenametwo];
    
    //创建我的问答 ID里面的表
    NSString * tablenamethree = [NSString stringWithFormat:@"create table if not exists WD(idid integer not null primary key,WDID integer)"];
    BOOL c = [self.db executeUpdate:tablenamethree];
    
    //创建推送消息表
    NSString * tablenameFore = [NSString stringWithFormat:@"create table if not exists Push(idid integer not null primary key,dic text)"];
    [self.db executeUpdate:tablenameFore];
    
    
    if (c) {
        KKLog(@"创建表成功");
        //成功的时候插入一条默认数据
        NSString *sql=[NSString stringWithFormat:@"insert into WD(idid,WDID)values(0,0)"];
        [self.db executeUpdate:sql];
    }
    
    
    if (!b) {
        KKLog(@"创建表失败");
    }
    [self.db close];
}

/*
 *插入数据
 */
- (void)sqlinsertintoModel:(NSString *)userid COMID:(int)comid{
    [self.db open];

    NSString *sql=[NSString stringWithFormat:@"insert into Thumbup(comid,user)values(%d,'%@')",comid,userid];
    KKLog(@"%@",sql);
    BOOL b = [self.db executeUpdate:sql];
//              @"insert into collection(tagnum,title,image_url)values(?,?,?)",model.tagnum,model.title,model.image_url];
    if (!b) {
        KKLog(@"插入数据失败");
    }else{
        KKLog(@"插入数据成功");
    }
    [self.db close];
}

- (void)sqlinsertintoLBModel:(NSString *)userid COMID:(int)comid{
    [self.db open];
    
    NSString *sql=[NSString stringWithFormat:@"insert into ThumbupLB(comid,user)values(%d,'%@')",comid,userid];
    KKLog(@"%@",sql);
    BOOL b = [self.db executeUpdate:sql];
    //              @"insert into collection(tagnum,title,image_url)values(?,?,?)",model.tagnum,model.title,model.image_url];
    if (!b) {
        KKLog(@"插入数据失败");
    }else{
        KKLog(@"插入数据成功");
    }
    [self.db close];
}
/*
 *插入推送数据
 */
- (void)sqlinsertintoDictionJson:(NSString *)DictionJson{
    [self.db open];
    NSString *sql=[NSString stringWithFormat:@"insert into Push(dic)values('%@')",DictionJson];
    KKLog(@"%@",sql);
    BOOL b = [self.db executeUpdate:sql];
    if (!b) {
        KKLog(@"插入数据失败");
    }else{
        KKLog(@"插入数据成功");
    }
    [self.db close];

}
/*
 *删除数据
 */
- (void)sqldeleteModel:(NSString *)userid COMID:(int)comid{
    [self.db open];
    NSString * sql = [NSString stringWithFormat:@"delete from Thumbup where user = '%@' and comid = '%d'",userid,comid];
    KKLog(@"%@",sql);
    BOOL b = [self.db executeUpdate:sql];
    
    if (!b) {
        KKLog(@"插入数据失败");
    }else{
        KKLog(@"插入数据成功");
    }
    [self.db close];

}
- (void)sqldeleteLBModel:(NSString *)userid COMID:(int)comid{
    [self.db open];
    NSString * sql = [NSString stringWithFormat:@"delete from ThumbupLB where user = '%@' and comid = '%d'",userid,comid];
    KKLog(@"%@",sql);
    BOOL b = [self.db executeUpdate:sql];
    
    if (!b) {
        KKLog(@"插入数据失败");
    }else{
        KKLog(@"插入数据成功");
    }
    [self.db close];
}
/*
 *改数据
 */
- (void)changeDataWithModel:(FMMainModel *)model TAG:(NSInteger )Tag{
      [self.db open];
//    NSString *sql=[NSString stringWithFormat:@"update collection set tagnum = %ld,title = '%@',image_url = '%@' where num = %ld",model.idid,model.title,model.image_url,Tag];
//    BOOL b=[self.db executeUpdate:sql];
//    if (!b) {
//        KKLog(@"修改数据失败");
//    }else{
//        KKLog(@"修改数据成功");
//    }
//    [self.db close];
    
}

/*
 *改我的问答ID
 */
- (void)changeDataWithid:(NSInteger )tag{
    [self.db open];
    NSString *sql=[NSString stringWithFormat:@"update WD set WDID = %ld where idid = 0",tag];
    BOOL b=[self.db executeUpdate:sql];
    if (!b) {
        KKLog(@"修改数据失败");
    }else{
        KKLog(@"修改数据成功");
    }
    [self.db close];
}
/*
 *查询我的最新ID 数据
 */
- (void)sqlselectueserWDBlock:(sqlSelect)block{
    [self.db open];
    NSMutableArray * mutable = [NSMutableArray array];
    NSString * select = [NSString stringWithFormat:@"select * from WD where idid = 0"];
    FMResultSet * result = [self.db executeQuery:select];
    while ([result next]) {
        int idid=[result intForColumn:@"WDID"];
        [mutable addObject:[NSNumber numberWithInteger:idid]];
    }
    block(mutable);
    [self.db close];
}

/*
 *查询
 */
- (void)sqlselectueser:(NSString *)uerid COMID:(int)comid Block:(sqlSelect)block
{
    [self.db open];
    NSMutableArray * mutable = [NSMutableArray array];
    NSString * select = [NSString stringWithFormat:@"select * from Thumbup where user = '%@' and comid = '%d'",uerid,comid];
//    KKLog(@"sql  %@",select);
    FMResultSet * result = [self.db executeQuery:select];
    while ([result next]) {

        NSString *userid=[result stringForColumn:@"user"];
        [mutable addObject:userid];
    }
    block(mutable);
    [self.db close];
}

- (void)sqlselectueserLB:(NSString *)uerid COMID:(int)comid Block:(sqlSelect)block
{
    [self.db open];
    NSMutableArray * mutable = [NSMutableArray array];
    NSString * select = [NSString stringWithFormat:@"select * from ThumbupLB where user = '%@' and comid = '%d'",uerid,comid];
    FMResultSet * result = [self.db executeQuery:select];
    while ([result next]) {
        NSString *userid=[result stringForColumn:@"user"];
        [mutable addObject:userid];
    }
    block(mutable);
    [self.db close];
}

- (void)sqlselectfrom:(NSInteger)Tag Block:(sqlSelect)block{
    [self.db open];
   
    [self.db close];

}

@end
