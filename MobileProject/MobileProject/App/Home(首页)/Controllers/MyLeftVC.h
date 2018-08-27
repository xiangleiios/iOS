//
//  MyLeftVC.h
//  MobileProject
//
//  Created by zsgy on 2018/5/23.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import "FMBaseViewController.h"
#import "HomeVC.h"
typedef void(^CallBackBlcok) (FMBaseViewController *vc);
@interface MyLeftVC : FMBaseViewController
@property (nonatomic , strong)UIButton *loginBut;
@property (nonatomic , strong)UIButton *outBut;
@property (nonatomic , copy)CallBackBlcok back;
@property (nonatomic , strong)HomeVC *homeVc;
- (void)loaddata;
@end
