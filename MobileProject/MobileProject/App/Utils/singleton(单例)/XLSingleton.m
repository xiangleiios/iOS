//
//  XLSingleton.m
//  MobileProject
//
//  Created by zsgy on 2018/1/31.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import "XLSingleton.h"

@implementation XLSingleton
static XLSingleton *xlsingleton = nil;
+ (XLSingleton *)singleton
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (xlsingleton == nil) {
            xlsingleton = [[self alloc] init];
            xlsingleton.dateArr = [NSMutableArray array];
            xlsingleton.courseArr = [NSMutableArray array];
            xlsingleton.practiceArr = [NSMutableArray array];
            xlsingleton.timeArr = [NSMutableArray array];
        }
    });
    return xlsingleton;
}
@end
