//
//  XLCache.m
//  MobileProject
//
//  Created by 向蕾 on 2018/9/5.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import "XLCache.h"

@implementation XLCache
static XLCache *XLCachesingleton = nil;
+ (XLCache *)singleton
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (XLCachesingleton == nil) {
            XLCachesingleton = [[self alloc] init];
            /// 用户各种字典表
            XLCachesingleton.cache = [YYCache cacheWithName:@"userDic"];
        }
    });
    return XLCachesingleton;
}


- (void)cacheWhitValue:(id)value AndKey:(NSString *)key{
    [self.cache setObject:value forKey:key];
}


- (id)objectForKey:(NSString *)key{
    return [self.cache objectForKey:key];
}

- (NSMutableArray *)ethnicTitleArr{
    if (_ethnicTitleArr == nil) {
        _ethnicTitleArr = [NSMutableArray arrayWithArray:[self loadethnicTitleWithKey:DICTEthnic]];
    }
    return _ethnicTitleArr;
}
- (NSMutableArray *)ethnicValueArr{
    if (_ethnicValueArr == nil) {
        _ethnicValueArr = [NSMutableArray arrayWithArray:[self loadethnicValueWithKey:DICTEthnic]];;
    }
    return _ethnicValueArr;
}


- (NSMutableArray *)student_apply_type_title{
    if (_student_apply_type_title == nil) {
        _student_apply_type_title = [NSMutableArray arrayWithArray:[self loadethnicTitleWithKey:DICTApply_type]];
    }
    return _student_apply_type_title;
}
- (NSMutableArray *)student_apply_type_value{
    if (_student_apply_type_value == nil) {
        _student_apply_type_value = [NSMutableArray arrayWithArray:[self loadethnicValueWithKey:DICTApply_type]];;
    }
    return _student_apply_type_value;
}

- (NSMutableArray *)student_license_type_title{
    if (_student_license_type_title == nil) {
        _student_license_type_title = [NSMutableArray arrayWithArray:[self loadethnicTitleWithKey:DICTLicense_type]];
    }
    return _student_license_type_title;
}
- (NSMutableArray *)student_license_type_value{
    if (_student_license_type_value == nil) {
        _student_license_type_value = [NSMutableArray arrayWithArray:[self loadethnicValueWithKey:DICTLicense_type]];;
    }
    return _student_license_type_value;
}

- (NSMutableArray *)student_is_enter_type_title{
    if (_student_is_enter_type_title == nil) {
        _student_is_enter_type_title = [NSMutableArray arrayWithArray:[self loadethnicTitleWithKey:DICTEnter_type]];
    }
    return _student_is_enter_type_title;
}
- (NSMutableArray *)student_is_enter_type_value{
    if (_student_is_enter_type_value == nil) {
        _student_is_enter_type_value = [NSMutableArray arrayWithArray:[self loadethnicValueWithKey:DICTEnter_type]];;
    }
    return _student_is_enter_type_value;
}

- (NSMutableArray *)sys_user_sex_title{
    if (_sys_user_sex_title == nil) {
        _sys_user_sex_title = [NSMutableArray arrayWithArray:[self loadethnicTitleWithKey:DICTUser_sex]];
    }
    return _sys_user_sex_title;
}
- (NSMutableArray *)sys_user_sex_value{
    if (_sys_user_sex_value == nil) {
        _sys_user_sex_value = [NSMutableArray arrayWithArray:[self loadethnicValueWithKey:DICTUser_sex]];;
    }
    return _sys_user_sex_value;
}

- (NSMutableArray *)teamCode_title{
    if (_teamCode_title == nil) {
        _teamCode_title = [NSMutableArray array];
        NSUserDefaults *defaults  =  [NSUserDefaults standardUserDefaults];
        NSArray *arr = (NSArray *)[defaults objectForKey:SchoolList];
//        [self.cache objectForKey:SchoolList];
        for (NSDictionary *dic in arr) {
            [_teamCode_title addObject:dic[@"schoolName"]];
        }
    }
    return _teamCode_title;
}

- (NSMutableArray *)teamCode_value{
    if (_teamCode_value == nil) {
        _teamCode_value = [NSMutableArray array];
        NSUserDefaults *defaults  =  [NSUserDefaults standardUserDefaults];
        NSArray *arr = (NSArray *)[defaults objectForKey:SchoolList];
//        NSArray *arr = (NSArray *)[self.cache objectForKey:SchoolList];
        for (NSDictionary *dic in arr) {
            [_teamCode_value addObject:[NSString stringWithFormat:@"%@",dic[@"teanSchoolId"]]];
        }
    }
    return _teamCode_value;
}

- (NSMutableArray *)schoolDeptId{
    if (_schoolDeptId == nil) {
        _schoolDeptId = [NSMutableArray array];
        NSUserDefaults *defaults  =  [NSUserDefaults standardUserDefaults];
        NSArray *arr = (NSArray *)[defaults objectForKey:SchoolList];
        //        NSArray *arr = (NSArray *)[self.cache objectForKey:SchoolList];
        for (NSDictionary *dic in arr) {
            [_schoolDeptId addObject:[NSString stringWithFormat:@"%@",dic[@"schoolDeptId"]]];
        }
    }
    return _schoolDeptId;
}








- (NSMutableArray *)loadethnicTitleWithKey:(NSString *)key{
    NSMutableArray *arr = [NSMutableArray array];
    NSUserDefaults *defaults  =  [NSUserDefaults standardUserDefaults];
    NSString *str = (NSString *)[defaults objectForKey:ALLDATA];
    NSDictionary *dic  = [str mj_JSONObject];
//    NSDictionary *dic = (NSDictionary *)[self.cache objectForKey:ALLDATA];
    NSArray *ethnicArr = dic[key];
    for (NSDictionary *dict in ethnicArr) {
        [arr addObject:dict[@"dictLabel"]];
    }
    
    return arr;
}


- (NSMutableArray *)loadethnicValueWithKey:(NSString *)key{
    NSMutableArray *arr = [NSMutableArray array];
    NSUserDefaults *defaults  =  [NSUserDefaults standardUserDefaults];
    NSString *str = (NSString *)[defaults objectForKey:ALLDATA];
    NSDictionary *dic  = [str mj_JSONObject];
    NSArray *ethnicArr = dic[key];
    for (NSDictionary *dict in ethnicArr) {
        [arr addObject:[NSString stringWithFormat:@"%@",dict[@"dictValue"]]];
    }
    return arr;
}

@end
