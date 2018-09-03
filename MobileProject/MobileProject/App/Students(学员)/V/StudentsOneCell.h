//
//  StudentsOneCell.h
//  MobileProject
//
//  Created by 向蕾 on 2018/8/24.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StudentsOneCell : UITableViewCell
@property (nonatomic , strong)UIImageView *img;
@property (nonatomic , strong)UILabel *title;
@property (nonatomic , strong)UILabel *typeone;
@property (nonatomic , strong)UILabel *typetwo;
@property (nonatomic , strong)UILabel *typethree;
@property (nonatomic , strong)UILabel *typefour;
@property (nonatomic , strong)FMMainModel *model;
@property (nonatomic , assign)CellType type;
@end
