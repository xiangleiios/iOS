//
//  MyPicturePosterVC.h
//  MobileProject
//
//  Created by 向蕾 on 2018/10/9.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import "FMBaseViewController.h"
#import "MyPicturePosterListVC.h"
NS_ASSUME_NONNULL_BEGIN

@interface MyPicturePosterVC : FMBaseViewController
@property (nonatomic , strong)FMMainModel *model;
@property (nonatomic , strong)MyPicturePosterListVC *vc;
@end

NS_ASSUME_NONNULL_END
