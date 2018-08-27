//
//  DetailsVC.h
//  MobileProject
//
//  Created by zsgy on 17/8/4.
//  Copyright © 2017年 ZSGY. All rights reserved.
//

#import "FMBaseViewController.h"
#import "FMMainModel.h"
#import "XLInputvc.h"
#import "FMEnums.h"
///FMBaseViewController
@interface DetailsVC : FMBaseViewController
@property (nonatomic, strong) FMMainModel *model;
@property (nonatomic , strong)XLInputvc *inputvc;
@property(nonatomic, assign) BOOL isBannerToHere;
@property (nonatomic , assign)NSInteger filmID;
@property (nonatomic , assign)BOOL slide;  ///是否允许滑动选择
@end
