//
//  PracticeCarVC.h
//  MobileProject
//
//  Created by 向蕾 on 2018/10/18.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import "FMBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface PracticeCarVC : FMBaseViewController
@property (nonatomic , strong)NSString * groundId;
@property (nonatomic ,strong)FMMainModel *model;
@property (nonatomic , strong)NSString *selectTime;
- (void)loadDataWithTime:(NSString *)time;
@end

NS_ASSUME_NONNULL_END
