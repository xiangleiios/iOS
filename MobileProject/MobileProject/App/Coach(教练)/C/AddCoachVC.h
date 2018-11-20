//
//  AddCoachVC.h
//  MobileProject
//
//  Created by 向蕾 on 2018/11/16.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import "FMBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface AddCoachVC : FMBaseViewController
@property (nonatomic , strong)FMMainModel *model;
@property (nonatomic , assign)int type; /// 0 添加  1 修改
@end

NS_ASSUME_NONNULL_END
