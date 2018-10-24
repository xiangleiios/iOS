//
//  ChooseStudentsCell.h
//  MobileProject
//
//  Created by 向蕾 on 2018/10/22.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ChooseStudentsCell : UITableViewCell
@property (nonatomic ,strong)FMMainModel *model;

@property (nonatomic , strong)UILabel *name;
@property (nonatomic ,strong)UILabel *xunlianchang;
@property (nonatomic , strong)UIButton *but;
@end

NS_ASSUME_NONNULL_END
