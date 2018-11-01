//
//  ChangeCardVC.h
//  MobileProject
//
//  Created by 向蕾 on 2018/8/23.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import "FMBaseViewController.h"

@interface ChangeCardVC : FMBaseViewController
@property (nonatomic , strong)FMMainModel *model;
@property (nonatomic , strong)NSString *idid;
@property (nonatomic , strong)UITextView *textView;
- (void)refreshData;
@end
