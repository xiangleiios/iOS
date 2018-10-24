//
//  ChooseTimeCell.h
//  MobileProject
//
//  Created by 向蕾 on 2018/10/22.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ChooseTimeCell : UITableViewCell
@property (nonatomic ,strong)FMMainModel *model;
@property (nonatomic , strong)UILabel *time;
@property (nonatomic , strong)UILabel *typeOne;
@property (nonatomic , strong)UILabel *typeTwo;
@property (nonatomic , strong)UILabel *num;
@property (nonatomic , strong)UIButton *but;
@end

NS_ASSUME_NONNULL_END
