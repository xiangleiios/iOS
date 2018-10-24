//
//  FMTableViewCell.h
//  MobileProject
//
//  Created by 向蕾 on 2018/10/17.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FMTableViewCell : UITableViewCell
@property (nonatomic ,strong)FMMainModel *model;
@property (nonatomic , strong)UILabel *title;
@property (nonatomic , strong)UILabel *address;
@end

NS_ASSUME_NONNULL_END
