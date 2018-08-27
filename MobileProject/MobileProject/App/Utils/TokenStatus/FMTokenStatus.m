//
//  FMTokenStatus.m
//  MobileProject
//
//  Created by Mingo on 2017/8/5.
//  Copyright © 2017年 ZSGY. All rights reserved.
//

#import "FMTokenStatus.h"

@implementation FMTokenStatus
+ (void)fm_tokenStatus:(tokenStatus)membersTokenStatus {
    User *bend=[User UserOb];
    NSString *url=[NSString stringWithFormat:GETmembersTokenStatus,bend.token];
    
    [FMNetworkHelper fm_request_getWithUrlString:url isNeedCache:NO parameters:nil successBlock:^(id responseObject) {
        if ([responseObject[@"status_code"] isEqual:@200]) {
            membersTokenStatus(YES) ;
        }else{
            membersTokenStatus(NO) ;
        }
    } failureBlock:^(NSError *error) {
         membersTokenStatus(NO) ;
    } progress:nil];
 
}
@end
