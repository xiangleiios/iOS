//
//  OrderInformationV.h
//  MobileProject
//
//  Created by zsgy on 2018/6/14.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import "XLView.h"

@interface OrderInformationV : XLView
@property (nonatomic , strong)UILabel *title;
@property (nonatomic , strong)UILabel *time_up;
@property (nonatomic , strong)UILabel *time_confirm;
@property (nonatomic , strong)FMSubmodel *model;
@end
