//
//  CoachCell.h
//  MobileProject
//
//  Created by 向蕾 on 2018/11/13.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CoachCell : UITableViewCell
@property (nonatomic ,strong)FMMainModel *model;
@property (nonatomic , strong)UIImageView *head;
@property (nonatomic , strong)UIImageView *xinImg;
@property (nonatomic , strong)UILabel *name;
@property (nonatomic , strong)UILabel *pho;
@property (nonatomic , strong)UILabel *rank;
@property (nonatomic , strong)UILabel *typeOne;
@property (nonatomic , strong)UILabel *typeTwo;
@property (nonatomic , strong)UILabel *typeThree;

@property (nonatomic , strong)UIImageView *typeFour;

@end

NS_ASSUME_NONNULL_END
