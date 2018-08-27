//
//  OrdersItems.h
//  MobileProject
//
//  Created by zsgy on 2018/6/20.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrdersItems : NSObject
+ (void)ordersItemsCreateWithType:(OrdersItemsType)ordersItemsType Title:(NSString *)title Discount:(NSInteger)discount ID:(NSInteger)ID;


//+ (NSString *)orderDescribeWithState:(NSInteger)state;
@end
