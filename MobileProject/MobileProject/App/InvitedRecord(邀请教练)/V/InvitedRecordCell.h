//
//  InvitedRecordCell.h
//  MobileProject
//
//  Created by 向蕾 on 2018/11/22.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface InvitedRecordCell : UITableViewCell
@property (nonatomic , strong)UILabel *name;
@property (nonatomic , strong)UILabel *pho;
@property (nonatomic , strong)UILabel *time;
@property (nonatomic , strong)FMMainModel *model;
@end

NS_ASSUME_NONNULL_END
