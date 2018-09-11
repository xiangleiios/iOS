//
//  MyNewsCell.h
//  MobileProject
//
//  Created by 向蕾 on 2018/8/21.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyNewsCell : UITableViewCell
@property (nonatomic , strong)UIImageView *img;
@property (nonatomic , strong)UILabel *title;
@property (nonatomic , strong)UILabel *content;
@property (nonatomic , strong)UILabel *time;
@property (nonatomic , strong)FMMainModel *model;
@property (nonatomic , strong)UILabel *read;
@end
