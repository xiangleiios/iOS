//
//  MyNewsVC.h
//  MobileProject
//
//  Created by 向蕾 on 2018/8/21.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import "FMBaseViewController.h"

@interface MyNewsVC : FMBaseViewController
@property (nonatomic , strong)NSString *url;
@property (nonatomic , assign)int type; //1 系统 0 通知
- (void)headerRefresh;
@end
