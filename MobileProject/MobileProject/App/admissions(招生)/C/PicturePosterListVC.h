//
//  PicturePosterListVC.h
//  MobileProject
//
//  Created by 向蕾 on 2018/9/29.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import "FMBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface PicturePosterListVC : FMBaseViewController
@property (nonatomic , strong)UICollectionView *table;
@property (nonatomic , strong)NSMutableDictionary *dic;
@property (nonatomic , strong)NSString *url;
@property (nonatomic , assign)PostersListType type;
@end

NS_ASSUME_NONNULL_END
