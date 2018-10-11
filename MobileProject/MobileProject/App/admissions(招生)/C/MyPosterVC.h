//
//  MyPosterVC.h
//  MobileProject
//
//  Created by 向蕾 on 2018/10/9.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import "FMBaseViewController.h"
#import "MyPosterListVC.h"
NS_ASSUME_NONNULL_BEGIN

@interface MyPosterVC : FMBaseViewController
@property (nonatomic , strong)FMMainModel *model;
@property (nonatomic , strong)NSString *idid;
@property (nonatomic , strong)NSString *shareTitle;
@property (nonatomic , strong)NSString *shareContent;
@property (nonatomic , strong)MyPosterListVC *vc;
@end

NS_ASSUME_NONNULL_END
