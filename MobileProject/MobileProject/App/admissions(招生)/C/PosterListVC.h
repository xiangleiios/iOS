//
//  PosterListVC.h
//  MobileProject
//
//  Created by 向蕾 on 2018/9/29.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PosterListVC : UIViewController
@property (nonatomic , strong)NSMutableDictionary *dic;
@property (nonatomic , strong)NSString *url;
@property (nonatomic , assign)PostersListType type;
@end

NS_ASSUME_NONNULL_END
