//
//  PosterVC.h
//  MobileProject
//
//  Created by 向蕾 on 2018/10/8.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import "FMBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface PosterVC : FMBaseViewController
@property (nonatomic , strong)FMMainModel *model;
@property (nonatomic , strong)NSString *url;
@property (nonatomic , assign)NSInteger type;
@end

NS_ASSUME_NONNULL_END
