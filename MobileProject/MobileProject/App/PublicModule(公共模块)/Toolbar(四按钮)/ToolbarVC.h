//
//  ToolbarVC.h
//  MobileProject
//
//  Created by zsgy on 17/8/4.
//  Copyright © 2017年 ZSGY. All rights reserved.
//

//#import "FMBaseViewController.h"
#import <UIKit/UIKit.h>
#import "FMMainModel.h"
#import "DetailsVC.h"
@interface ToolbarVC : UIViewController
@property (nonatomic, strong) FMMainModel *model;
@property (nonatomic ,strong) FMBaseViewController *viewcontroller;
@property (nonatomic ,strong) UIColor *color;
@end
