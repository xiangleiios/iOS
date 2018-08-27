//
//  XLPartyLoginV.h
//  MobileProject
//
//  Created by zsgy on 17/7/24.
//  Copyright © 2017年 ZSGY. All rights reserved.



//第三方登录封装

#import <UIKit/UIKit.h>
#import "LoginVC.h"
@interface XLPartyLoginV : UIView
@property (nonatomic , strong)UIButton *logBttQQ;
@property (nonatomic , strong)UIButton *logBttWX;
@property (nonatomic , strong)UIButton *logBttWB;
@property (nonatomic , strong)LoginVC *vc;
@end
