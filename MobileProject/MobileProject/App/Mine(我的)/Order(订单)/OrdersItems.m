//
//  OrdersItems.m
//  MobileProject
//
//  Created by zsgy on 2018/6/20.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import "OrdersItems.h"

@implementation OrdersItems
+(void)ordersItemsCreateWithType:(OrdersItemsType)ordersItemsType Title:(NSString *)title Discount:(NSInteger)discount ID:(NSInteger)ID{
    NSString *url=[NSString stringWithFormat:GETOrdersItemsCreate,ordersItemsType,title,ID,discount,[User UserOb].token];
    NSString *url2 = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    KKLog(@"url = %@",url2);
    [FMNetworkHelper fm_request_postWithUrlString:url2 isNeedCache:NO parameters:nil successBlock:^(id responseObject) {
        KKLog(@"%@-------%@",responseObject[@"message"],responseObject[@"data"]);
    } failureBlock:^(NSError *error) {
        KKLog(@"%@", error);
    } progress:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];
}





@end
