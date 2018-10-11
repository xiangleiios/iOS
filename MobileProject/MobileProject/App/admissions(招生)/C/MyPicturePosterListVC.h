//
//  MyPicturePosterListVC.h
//  MobileProject
//
//  Created by 向蕾 on 2018/10/9.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyPicturePosterListVC : UIViewController
@property (nonatomic , strong)UICollectionView *table;
@property (nonatomic , strong)NSMutableDictionary *dic;
@property (nonatomic , strong)NSString *url;
@property (nonatomic , assign)PostersListType type;
- (void)headerRefresh;
@end

NS_ASSUME_NONNULL_END
