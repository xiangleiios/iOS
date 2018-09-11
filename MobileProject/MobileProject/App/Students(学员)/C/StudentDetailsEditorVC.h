//
//  StudentDetailsEditorVC.h
//  MobileProject
//
//  Created by 向蕾 on 2018/8/27.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import "FMBaseViewController.h"

@interface StudentDetailsEditorVC : FMBaseViewController
@property (nonatomic , strong)FMMainModel *model;
@property (nonatomic , strong)NSString *url;
@property (nonatomic , assign)BOOL PayCost;
@end
