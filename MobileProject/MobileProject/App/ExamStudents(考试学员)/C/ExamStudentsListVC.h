//
//  ExamStudentsListVC.h
//  MobileProject
//
//  Created by 向蕾 on 2018/10/18.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import "FMBaseViewController.h"
#import "ExamStudentsVC.h"
NS_ASSUME_NONNULL_BEGIN

@interface ExamStudentsListVC : FMBaseViewController
@property (nonatomic , strong)NSMutableDictionary *dic;
@property (nonatomic , weak)ExamStudentsVC *vc;
@end

NS_ASSUME_NONNULL_END
