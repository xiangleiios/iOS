//
//  AFNRequest.h
//  MobileProject
//
//  Created by zsgy on 17/2/23.
//  Copyright © 2017年 Mingoy. All rights reserved.
//

#import <Foundation/Foundation.h>
@class AFNetworking;
@interface AFNRequest : NSObject
+ (AFNRequest *)sharedInstance;

- (void)GET:(NSString *)URLString dict:(id)dict succeed:(void (^)(id responseObject))succeed failure:(void (^)(NSError *error))failure;

- (void)POST:(NSString *)URLString dict:(id)dict succeed:(void (^)(id responseObject))succeed failure:(void (^)(NSError *error))failure;
@end
