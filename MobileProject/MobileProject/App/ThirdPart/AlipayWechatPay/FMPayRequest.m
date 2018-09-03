//
//  FMPayRequest.m
//  MobileProject
//
//  Created by Mingo on 2017/11/27.
//  Copyright © 2017年 ZSGY. All rights reserved.
//

#import "FMPayRequest.h"
#import "FLPayManager.h"
#import "FMWechatPayModel.h"
@implementation FMPayRequest
+ (void)fm_payRequestWithOrder:(NSString *)order pushVc:(UIViewController *)pushVc isAlipay:(BOOL)isAlipay{
    if (isAlipay) { //支付宝支付
        NSString *url = [NSString stringWithFormat:GETalipayApppay,order,[User UserOb].token];
        [FMNetworkHelper fm_request_getWithUrlString:url isNeedCache:NO parameters:nil successBlock:^(id responseObject) {
            [MBProgressHUD hideLoadingHUD];
            if (kResponseObjectStatusCodeIsEqual(200)) {
                NSString *payAliStr = responseObject[@"data"];
                KKLog(@">@>>>>>>>>>>>:%@",payAliStr);
                // todo  支付宝调取
                [FLPAYMANAGER fl_payWithOrderMessage:payAliStr callBack:^(FLErrCode errCode, NSString *errStr) {
                    NSLog(@"errCode = %zd,errStr = %@",errCode,errStr);
//                    if (errStr.length) {
//                        [MBProgressHUD showAutoMessage:errStr];
//                    }
                    if (errCode == FLErrCodeSuccess) {
//                        PayComplete *vc = [[PayComplete alloc] init];
//                        vc.title = @"支付宝支付";
//                        vc.success = YES;
//                        [pushVc.navigationController pushViewController:vc animated:YES];
                    }else if (errCode == FLErrCodeFailure){
//                        PayComplete *vc = [[PayComplete alloc] init];
//                        vc.title = @"支付宝支付";
//                        vc.success = NO;
//                        [pushVc.navigationController pushViewController:vc animated:YES];
                    }
                }];
            }else{
                kALERT(kResponseObjectMessage)
            }
        } failureBlock:^(NSError *error) {
        } progress:nil];
    }else{ //微信支付
        if (![WXApi isWXAppInstalled]) {
            kALERT(@"你未安装微信不能使用微信支付哦！")
            return;
        }
        NSString *url = [NSString stringWithFormat:GETwechatApppay,order,[User UserOb].token];
        [FMNetworkHelper fm_request_getWithUrlString:url isNeedCache:NO parameters:nil successBlock:^(id responseObject) {
            [MBProgressHUD hideLoadingHUD];
            KKLog(@">@>>>>>>>>>>>:%@",responseObject);
            if (kResponseObjectStatusCodeIsEqual(200)) {
                NSDictionary *dataArr = responseObject[@"data"];
                FMWechatPayModel *modelWx = [FMWechatPayModel mj_objectWithKeyValues:dataArr];
                PayReq* req = [[PayReq alloc] init];
                req.partnerId = modelWx.partnerid;
                req.prepayId= modelWx.prepayid;
                req.package = modelWx.package;
                req.nonceStr= modelWx.noncestr;
                req.timeStamp= (int)modelWx.timestamp;
                req.sign= modelWx.sign;
                
                [FLPAYMANAGER fl_payWithOrderMessage:req callBack:^(FLErrCode errCode, NSString *errStr) {
                    NSLog(@"errCode = %zd,errStr = %@",errCode,errStr);
//                    if (errStr.length) {
//                        [MBProgressHUD showAutoMessage:errStr];
//                    }
                    if (errCode == FLErrCodeSuccess) {
//                        PayComplete *vc = [[PayComplete alloc] init];
//                        vc.title = @"微信支付";
//                        vc.success = YES;
//                        [pushVc.navigationController pushViewController:vc animated:YES];
                    }else if (errCode == FLErrCodeFailure){
//                        PayComplete *vc = [[PayComplete alloc] init];
//                        vc.title = @"微信支付";
//                        vc.success = NO;
//                        [pushVc.navigationController pushViewController:vc animated:YES];
                    }
                }];
            }else{
                kALERT(kResponseObjectMessage)
            }
        } failureBlock:^(NSError *error) {
        } progress:nil];
        
    }
}




@end
