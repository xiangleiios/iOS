//
//  SchoolRankingCell.h
//  MobileProject
//
//  Created by 向蕾 on 2018/11/21.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SchoolRankingCell : UITableViewCell
@property (nonatomic ,strong)FMMainModel *model;
@property (nonatomic , strong)UIImageView *img;
@property (nonatomic , strong)UILabel *title;
@property (nonatomic , strong)UILabel *rank;

@end

NS_ASSUME_NONNULL_END
