//
//  Single.h
//  说明：单例模式主要宏文件
//
//  Created by 袁凤鸣 on 16/6/11.
//  Copyright © 2016年 袁凤鸣. All rights reserved.
//

#define singleDot_H(新创建单例类名称) +(instancetype)share##新创建单例类名称;

//ARC-----以下是ARC模式下的单例宏，到//ARC//ARC结束
#if __has_feature(objc_arc)
//带参数的宏，name替换为新创建单例的文件类名。eg：新创建单例（tools.h和tools.m），则参数为tools即可
#define singleDot_M(新创建单例类名称) static id _instance;\
+(instancetype)allocWithZone:(struct _NSZone *)zone\
{\
    static dispatch_once_t onceToken;\
    dispatch_once(&onceToken, ^{\
        _instance = [super allocWithZone:zone];\
    });\
    return _instance;\
}\
\
+(instancetype)share##新创建单例类名称\
{\
    return [[self alloc]init];\
}\
- (id)copyWithZone:(NSZone *)zone\
{\
    return _instance;\
}\
\
- (id)mutableCopyWithZone:(NSZone *)zone\
{\
    return _instance;\
}
//ARC//ARC结束

//MRC-----以下是MRC模式下的单例宏，到//MRC//MRC结束
//不能直接将MRC模式的那部分代码粘贴到ARC下，只能复制ARC所有的后面加上MRC那部分代码再利用条件宏来判断
#else
#define singleM static id _instance;\
+(instancetype)allocWithZone:(struct _NSZone *)zone\
{\
static dispatch_once_t onceToken;\
dispatch_once(&onceToken, ^{\
_instance = [super allocWithZone:zone];\
});\
return _instance;\
}\
\
+(instancetype)shareTools\
{\
return [[self alloc]init];\
}\
- (id)copyWithZone:(NSZone *)zone\
{\
return _instance;\
}\
\
- (id)mutableCopyWithZone:(NSZone *)zone\
{\
return _instance;\
}\
- (oneway void)release\
{\
}\
\
- (instancetype)retain\
{\
    return _instance;\
}\
\
- (NSUInteger)retainCount\
{\
    return MAXFLOAT;\
}
//MRC//MRC结束
#endif
