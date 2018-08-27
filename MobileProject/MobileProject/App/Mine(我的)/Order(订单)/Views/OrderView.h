//
//  OrderView.h
//  MobileProject
//
//  Created by zsgy on 2018/6/8.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderView : UIView
@property (nonatomic , strong)FMMainModel *model;
@property (nonatomic , strong)UILabel *orderNo;
@property (nonatomic , strong)UILabel *address;
@property (nonatomic , strong)UILabel *voltage;//电压
@property (nonatomic , strong)UILabel *dosage; //用量，度
@property (nonatomic , strong)UILabel *price; //单价
@property (nonatomic , strong)UILabel *start_time;
@property (nonatomic , strong)UILabel *end_time;

- (instancetype)initWithstyle:(BOOL)Default;
@end
