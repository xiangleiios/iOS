//
//  SelectSchoolCell.h
//  MobileProject
//
//  Created by 向蕾 on 2018/11/13.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FMSchoolModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface SelectSchoolCell : UITableViewCell
@property (nonatomic , strong)FMSchoolModel *model;
@property (nonatomic , strong)UILabel *title;
@end

NS_ASSUME_NONNULL_END
