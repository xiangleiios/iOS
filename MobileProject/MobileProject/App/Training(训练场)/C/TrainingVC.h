//
//  TrainingVC.h
//  MobileProject
//
//  Created by 向蕾 on 2018/10/17.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import "FMBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface TrainingVC : FMBaseViewController
@property (nonatomic , strong) FMMainModel *model;
@property (nonatomic , strong)NSDictionary *province;
@property (nonatomic , strong)NSDictionary *city;
@property (nonatomic , strong)NSDictionary *areadic;
@property (nonatomic , assign)int type;/// 1:新增  0：编辑
@property (nonatomic , strong)NSArray *coachArr;
@property (nonatomic , strong)NSMutableArray *selectArr;
@end

NS_ASSUME_NONNULL_END
