//
//  ReservationRecordCell.h
//  MobileProject
//
//  Created by 向蕾 on 2018/10/22.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ReservationRecordCell : UITableViewCell
@property (nonatomic ,strong)FMMainModel *model;
@property (nonatomic , strong)UILabel *time;
@property (nonatomic , strong)UILabel *name;
@property (nonatomic , strong)UILabel *pho;
@property (nonatomic , strong)UILabel *timeCar;
@property (nonatomic , strong)UILabel *typeOne;
@property (nonatomic , strong)UILabel *typeTwo;
@property (nonatomic , strong)UILabel *typeThree;
@property (nonatomic , strong)UIButton *butOne;
@property (nonatomic , strong)UIButton *butTwo;
@property (nonatomic , strong)UIButton *butThree;
@property (nonatomic , strong)UILabel *redlb;
@property (nonatomic ,strong)UIImageView *tx;
@end

NS_ASSUME_NONNULL_END
