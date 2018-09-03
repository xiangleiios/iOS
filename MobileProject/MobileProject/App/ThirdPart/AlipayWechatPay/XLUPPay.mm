//
//  XLUPPay.m
//  MobileProject
//
//  Created by zsgy on 2018/7/12.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import "XLUPPay.h"
#import "UPPaymentControl.h"
#import "PDSlideViewController.h"
@implementation XLUPPay
+ (void)upPayRequestWithOrder:(NSString *)order pushVc:(UIViewController *)pushVc;{
    NSString *url=[NSString stringWithFormat:GETUnionPay,[User UserOb].token,order];
    [FMNetworkHelper fm_request_getWithUrlString:url isNeedCache:NO parameters:nil successBlock:^(id responseObject) {
        [MBProgressHUD hideLoadingHUD];
        NSLog(@"成功返货=============%@",responseObject);
        if (kResponseObjectStatusCodeIsEqual(200)) {
            NSString* tn = responseObject[@"data"];
            if (tn != nil && tn.length > 0)
            {
                NSLog(@"tn=%@",tn);
                [[UPPaymentControl defaultControl] startPay:tn fromScheme:@"tdb" mode:@"00" viewController:pushVc];
                
            }
        }else{
            [MBProgressHUD showAutoMessage:responseObject[@"message"]];
        }
    } failureBlock:^(NSError *error) {
        
    } progress:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];
    
}

+ (void)uppay_handleUrl:(NSURL *)url{
    [[UPPaymentControl defaultControl] handlePaymentResult:url completeBlock:^(NSString *code, NSDictionary *data) {
        
        if([code isEqualToString:@"success"]) {
            
            //如果想对结果数据验签，可使用下面这段代码，但建议不验签，直接去商户后台查询交易结果
            if(data != nil){
                //数据从NSDictionary转换为NSString
                NSData *signData = [NSJSONSerialization dataWithJSONObject:data
                                                                   options:0
                                                                     error:nil];
                NSString *sign = [[NSString alloc] initWithData:signData encoding:NSUTF8StringEncoding];
                
//                PayComplete *vc = [[PayComplete alloc] init];
//                vc.title = @"银联支付";
//                vc.success = YES;
//                AppDelegate *delegete = (AppDelegate *)[UIApplication sharedApplication].delegate;
//                PDSlideViewController *currentVc = (PDSlideViewController *)delegete.window.rootViewController;
//                [currentVc.leftVC.homeVc.navigationController pushViewController:vc animated:YES];
                //此处的verify建议送去商户后台做验签，如要放在手机端验，则代码必须支持更新证书
                /// 目前没有验签
//                if([self verify:sign]) {
//                    //验签成功
//                }
//                else {
//                    //验签失败
//                }
            }
            
            //结果code为成功时，去商户后台查询一下确保交易是成功的再展示成功
        }
        else if([code isEqualToString:@"fail"]) {
//            PayComplete *vc = [[PayComplete alloc] init];
//            vc.title = @"银联支付";
//            vc.success = NO;
//            AppDelegate *delegete = (AppDelegate *)[UIApplication sharedApplication].delegate;
//            PDSlideViewController *currentVc = (PDSlideViewController *)delegete.window.rootViewController;
//            [currentVc.leftVC.homeVc.navigationController pushViewController:vc animated:YES];
            //交易失败
        }
        else if([code isEqualToString:@"cancel"]) {
            //交易取消
        }
    }];

}
@end
