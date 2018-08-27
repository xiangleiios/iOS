//
//  FMMediator.h
//  MobileProject
//
//  Created by Mingoy on 16/9/13.
//  Copyright © 2016年 Mingoy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FMMediator : NSObject

+ (instancetype)sharedInstance;

// 远程App调用入口
- (id)performActionWithUrl:(NSURL *)url completion:(void(^)(NSDictionary *info))completion;

// 本地组件调用入口
- (id)performTarget:(NSString *)targetName action:(NSString *)actionName params:(NSDictionary *)params;

@end
