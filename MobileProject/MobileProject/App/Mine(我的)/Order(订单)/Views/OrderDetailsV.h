//
//  OrderDetailsV.h
//  MobileProject
//
//  Created by zsgy on 2018/6/13.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderDetailsV : UIView
@property (nonatomic , strong)NSArray <FMSubmodel *>*data;
@property (nonatomic , strong)FMMainModel *model;
@property (nonatomic , strong)UIButton *LookContract;
@property (nonatomic , strong)FMBaseViewController *vc;
@end
