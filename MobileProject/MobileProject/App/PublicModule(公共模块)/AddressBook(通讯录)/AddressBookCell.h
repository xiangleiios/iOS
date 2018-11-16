//
//  AddressBookCell.h
//  MobileProject
//
//  Created by 向蕾 on 2018/11/16.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PPPersonModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface AddressBookCell : UITableViewCell
@property (nonatomic , strong)PPPersonModel *model;
@property (nonatomic , strong)UILabel *name;
@property (nonatomic , strong)UILabel *pho;
@property (nonatomic , strong)UIButton *but;
@end

NS_ASSUME_NONNULL_END
