//
//  ChangeCardHeadVC.h
//  MobileProject
//
//  Created by 向蕾 on 2018/10/31.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import "FMBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface ChangeCardHeadVC : FMBaseViewController
@property (nonatomic , strong)FMMainModel *model;
@property (nonatomic , strong)NSString *idid;
@property (nonatomic , strong)UITextView *textView;
- (void)refreshData;
@end

NS_ASSUME_NONNULL_END
