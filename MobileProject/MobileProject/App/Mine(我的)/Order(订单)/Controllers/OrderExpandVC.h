//
//  OrderExpandVC.h
//  MobileProject
//
//  Created by zsgy on 2018/8/1.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import "FMBaseViewController.h"

@interface OrderExpandVC : FMBaseViewController
@property (nonatomic , strong)FMMainModel *model;
//订单数据
@property (nonatomic , copy)NSString *num;//购电量
@property (nonatomic , copy)NSString *voltage;//电压等级
@property (nonatomic , copy)NSString *max_price;//最高可承受价格
@property (nonatomic , copy)NSString *province;//省份
@property (nonatomic , copy)NSString *start_date;
@property (nonatomic , copy)NSString *end_date;

@end
