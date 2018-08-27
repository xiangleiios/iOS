//
//  ControllersListVC.h
//  MobileProject
//
//  Created by zsgy on 2017/11/10.
//  Copyright © 2017年 ZSGY. All rights reserved.
//

#import "FMBaseViewController.h"

@interface ControllersListVC : FMBaseViewController
@property (nonatomic, copy) NSString *module_type;//列表内形

- (void)enterTheEdit;
- (void)ExittheEditor;
@end
