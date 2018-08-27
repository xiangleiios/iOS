//
//  XLMineCell.h
//  MobileProject
//
//  Created by zsgy on 2018/6/5.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XLMineCell : UITableViewCell
@property (nonatomic , strong)UIImageView *img;
@property (nonatomic , strong)UILabel *title;
@property (nonatomic , strong)UILabel *subtitle;

@property (nonatomic , strong)MineModel *model;
@end
