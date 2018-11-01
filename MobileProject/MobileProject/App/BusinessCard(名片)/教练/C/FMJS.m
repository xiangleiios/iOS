//
//  FMJS.m
//  MobileProject
//
//  Created by 向蕾 on 2018/9/14.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import "FMJS.h"
#import <JavaScriptCore/JavaScriptCore.h>
@implementation FMJS
-(void)submit:(NSString *)message ID:(NSString *)idid{
    [self.delegate submit:message ID:idid];
}
@end
