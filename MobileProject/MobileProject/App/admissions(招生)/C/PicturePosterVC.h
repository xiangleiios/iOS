//
//  PicturePosterVC.h
//  MobileProject
//
//  Created by 向蕾 on 2018/9/30.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import "FMBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface PicturePosterVC : FMBaseViewController
@property (nonatomic , strong)FMMainModel *model;
@property (nonatomic , strong)NSString *url;
@property (nonatomic , assign)PostersListType type;
@end

NS_ASSUME_NONNULL_END
