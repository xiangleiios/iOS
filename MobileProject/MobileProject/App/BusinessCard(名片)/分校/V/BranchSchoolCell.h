//
//  BranchSchoolCell.h
//  MobileProject
//
//  Created by 向蕾 on 2018/11/1.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BranchSchoolCell : UITableViewCell
@property (nonatomic , strong)UIImageView *img;
@property (nonatomic , strong)UILabel *title;
@property (nonatomic , strong)UILabel *pho;
@property (nonatomic , strong)UILabel *titleSub;
@property (nonatomic , strong)UILabel *name;
@property (nonatomic , strong)FMMainModel *model;
@property (nonatomic , strong)UIImageView *typeOne;
@property (nonatomic , strong)UIImageView *typeTwo;
@end

NS_ASSUME_NONNULL_END
