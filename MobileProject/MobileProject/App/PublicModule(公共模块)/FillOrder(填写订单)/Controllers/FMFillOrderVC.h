//
//  FMFillOrderVC.h
//  MobileProject
//
//  Created by Mingo on 2017/11/2.
//  Copyright © 2017年 ZSGY. All rights reserved.
//

#import "FMBaseViewController.h"

@interface FMFillOrderVC : FMBaseViewController
@property (nonatomic, strong) FMMainModel *model;
/// 门票数据；
@property (nonatomic, strong) NSMutableArray <FMSubmodel *>*dataTable;
/// 购票类型
@property (nonatomic , assign)NSInteger type;   /// 1演出 0 景点
@end
