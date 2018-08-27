//
//  FMNavSegmentVC.h
//  MobileProject
//
//  Created by zsgy on 17/6/23.
//  Copyright © 2017年 Mingoy. All rights reserved.
//
#import "FMBaseViewController.h"

@interface FMNavSegmentVC : FMBaseViewController
@property (nonatomic , strong)UIButton *yfButton1th;
@property (nonatomic , strong)UIButton *yfButton2th;

//切换导航栏按钮时会调用此方法
- (void)navigationMethod:(UIButton *)sender;
@end
