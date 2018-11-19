//
//  ResultsVC.h
//  MobileProject
//
//  Created by 向蕾 on 2018/11/19.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import "FMBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface ResultsVC : FMBaseViewController
@property (nonatomic , assign)NSInteger seccessCount;
@property (nonatomic , assign)NSInteger errorCount;
@property (nonatomic , strong)NSString *message;

@end

NS_ASSUME_NONNULL_END
