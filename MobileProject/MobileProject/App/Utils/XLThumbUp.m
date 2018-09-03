//
//  XLThumbUp.m
//  MobileProject
//
//  Created by Mingo on 2017/8/30.
//  Copyright © 2017年 ZSGY. All rights reserved.
//

#import "XLThumbUp.h"

@implementation XLThumbUp

+(void)thumbUpButton:(UIButton *)sender thumbUpType:(ThumbUpType)type idid:(NSInteger)idid model:(FMMainModel *)model{
    sender.enabled = NO;
    AppDelegate *app = [UIApplication sharedApplication].delegate;
    int dian;
    if (sender.selected) {
        dian = 0;
    }else{
        dian = 1;
    }
    NSString *url;
# warning 根据不同type拼接不同url进行 点赞和取消点赞
    switch (type) {
        case ThumbUpComments:
            break;
        case ThumbUpAskZheng:
            break;
        default:
            break;
    }
    if (sender.selected) { //取消点赞
        [app.fmdb sqldeleteModel:[User UserOb].uid COMID:(int)idid];
        [FMNetworkHelper fm_request_getWithUrlString:url isNeedCache:NO parameters:nil successBlock:^(id responseObject) {
            sender.enabled = YES;
            if (kResponseObjectStatusCodeIsEqual(200)) {
                [MBProgressHUD showAutoMessage:@"点赞取消!"];
               
            }
        } failureBlock:^(NSError *error) {
            sender.enabled = YES;
            [MBProgressHUD showAutoMessage:@"取消点赞失败!"];
        } progress:nil];
  
        
    }else {//点赞
        [app.fmdb sqlinsertintoModel:[User UserOb].uid COMID:(int)idid];
        [FMNetworkHelper fm_request_getWithUrlString:url isNeedCache:NO parameters:nil successBlock:^(id responseObject) {
            sender.enabled = YES;
            if (kResponseObjectStatusCodeIsEqual(200)) {
                [MBProgressHUD showAutoMessage:@"点赞成功!"];
                
            }
        } failureBlock:^(NSError *error) {
            sender.enabled = YES;
            [MBProgressHUD showAutoMessage:@"点赞失败!"];
        } progress:nil];
    }
}

+(void)thumbUpButton:(UIButton *)sender idid:(NSInteger)idid{
    User *uer=[User UserOb];
    if (![uer UserLogin]) {
        return;
    }
    AppDelegate   *app = [UIApplication sharedApplication].delegate;
    [app.fmdb sqlselectueser:uer.uid COMID:(int)idid Block:^(NSMutableArray *arry) {
        if (arry.count) {
            sender.selected=YES;
        }
    }];
}

@end
