//
//  StudentsThreeCell.h
//  MobileProject
//
//  Created by 向蕾 on 2018/8/28.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StudentsThreeCell : UITableViewCell
@property (nonatomic , strong)UILabel *title;
@property (nonatomic , strong)UILabel *typeone;
@property (nonatomic , strong)UILabel *typetwo;
@property (nonatomic , strong)UILabel *typethree;
@property (nonatomic , strong)UILabel *typefour;

@property (nonatomic , strong)UIButton *selelctBut;
@property (nonatomic , strong)FMMainModel *model;
@end
