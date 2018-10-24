//
//  EditTimeVC.h
//  MobileProject
//
//  Created by 向蕾 on 2018/10/19.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import "FMBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface EditTimeVC : FMBaseViewController
@property (nonatomic , strong)NSString * groundId;
@property (nonatomic , assign)int editorType;/// 1:新增  0：编辑
@property (nonatomic , strong)FMMainModel *model;
@end

NS_ASSUME_NONNULL_END
