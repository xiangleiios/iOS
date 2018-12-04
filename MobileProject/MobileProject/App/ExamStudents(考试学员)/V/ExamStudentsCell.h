//
//  ExamStudentsCell.h
//  MobileProject
//
//  Created by 向蕾 on 2018/10/18.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ExamStudentsCell : UITableViewCell
@property (nonatomic , strong)FMMainModel *model;
@property (nonatomic , strong)UILabel *title;
@property (nonatomic , strong)UILabel *typeOne;
@property (nonatomic , strong)UILabel *typeTwo;
@property (nonatomic , strong)UILabel *typeThree;
@property (nonatomic , strong)UILabel *typeFour;
@property (nonatomic , strong)UILabel *type;
@property (nonatomic , strong)UIButton *state;
@end

NS_ASSUME_NONNULL_END
