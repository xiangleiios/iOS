//
//  DesignerServiceApi.m
//  MobileProject
//
//  Created by Mingoy on 16/9/21.
//  Copyright © 2016年 Mingoy. All rights reserved.
//

#import "DesignerServiceApi.h"

@implementation DesignerServiceApi

- (NSString *)requestUrl {
    return [NSString stringWithFormat:@"%@%@",FMDesignerConfigManagerInstance.prefixNetWorkUrl,@"message/notice/list/task_type"];
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodGET;
}

@end
