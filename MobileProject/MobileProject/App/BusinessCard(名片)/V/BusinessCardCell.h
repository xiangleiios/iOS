//
//  BusinessCardCell.h
//  MobileProject
//
//  Created by 向蕾 on 2018/9/5.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BusinessCardCell : UITableViewCell
@property (nonatomic , strong)UIImageView *img;
@property (nonatomic , strong)UILabel *title;
@property (nonatomic , strong)UILabel *typeone;
@property (nonatomic , strong)UILabel *titleSub;
@property (nonatomic , strong)UILabel *name;
@property (nonatomic , strong)FMMainModel *model;
@end
