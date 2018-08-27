//
//  OfflinePayVC.h
//  MobileProject
//
//  Created by zsgy on 2018/6/19.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import "FMBaseViewController.h"

@interface OfflinePayVC : FMBaseViewController
@property (nonatomic , assign)PayType payType;//支付类型
@property (nonatomic ,strong)NSString *num; // 支付金额
@end
