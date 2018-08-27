//
//  HomeChooseCell.h
//  MobileProject
//
//  Created by zsgy on 2018/6/6.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeChooseCell : UITableViewCell
@property (nonatomic , strong)UIImageView *img;
@property (nonatomic , strong)UILabel *title;
@property (nonatomic , strong)UILabel *subtitle;

@property (nonatomic , strong)UIImageView *img_arrow;

@property (nonatomic , strong)MineModel *model;
@end
