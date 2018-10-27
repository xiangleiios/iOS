//
//  PracticeCarDetailsVC.h
//  MobileProject
//
//  Created by 向蕾 on 2018/10/19.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import "FMBaseViewController.h"
#import "PracticeCarVC.h"
NS_ASSUME_NONNULL_BEGIN

@interface PracticeCarDetailsVC : FMBaseViewController
@property (nonatomic , strong)NSString *groundId;
@property (nonatomic , strong)NSArray *dataArr;
@property (nonatomic , strong)UITableView *table;
@property (nonatomic , strong)NSString *selectTime;
@property (nonatomic , weak)PracticeCarVC *vc;

@end

NS_ASSUME_NONNULL_END
