//
//  FMTokenStatus.h
//  MobileProject
//
//  Created by Mingo on 2017/8/5.
//  Copyright © 2017年 ZSGY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FMTokenStatus : NSObject
typedef void (^tokenStatus)(BOOL isTokenStatusOk);
+ (void)fm_tokenStatus:(tokenStatus)membersTokenStatus;
@end
