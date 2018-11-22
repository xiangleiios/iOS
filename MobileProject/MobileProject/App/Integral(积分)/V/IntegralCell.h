//
//  IntegralCell.h
//  MobileProject
//
//  Created by 向蕾 on 2018/11/21.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FMIntegralModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface IntegralCell : UITableViewCell
@property (nonatomic ,strong)FMIntegralModel *model;
@property (nonatomic , strong)UILabel *title;
@property (nonatomic , strong)UILabel *time;
@property (nonatomic , strong)UILabel *fen;
@end

NS_ASSUME_NONNULL_END
