//
//  PracticeCarDetailsCell.h
//  MobileProject
//
//  Created by 向蕾 on 2018/10/19.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PracticeCarDetailsVC.h"
NS_ASSUME_NONNULL_BEGIN

@interface PracticeCarDetailsCell : UITableViewCell
@property (nonatomic ,strong)FMMainModel *model;
@property (nonatomic , strong)UILabel *name;
@property (nonatomic , strong)UIButton *but;
@property (nonatomic , strong)NSDictionary *dic;
@property (nonatomic , weak)PracticeCarDetailsVC *vc;
@property (nonatomic ,strong)UIImageView *tx;
@end

NS_ASSUME_NONNULL_END
