//
//  CommentsCell.h
//  MobileProject
//
//  Created by 向蕾 on 2018/11/5.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoachReplyV.h"
NS_ASSUME_NONNULL_BEGIN

@interface CommentsCell : UITableViewCell
@property (nonatomic , strong)FMMainModel *model;
@property (nonatomic , strong)UIImageView *head;
@property (nonatomic , strong)UILabel *name;
@property (nonatomic , strong)UILabel *title;
@property (nonatomic , strong)UILabel *time;

@property (nonatomic , strong)UILabel *num;
@property (nonatomic , strong)UIButton *like;
@property (nonatomic , strong)UIButton *reply;
@property (nonatomic , strong)CoachReplyV *coachReply;

@property (nonatomic , strong)UIImageView *imgOne;
@property (nonatomic , strong)UIImageView *imgTwo;
@property (nonatomic , strong)UIImageView *imgThree;
@property (nonatomic , assign)NSInteger type;
@property (nonatomic , strong)UILabel *fen;
@property (nonatomic , strong)UIImageView *xinImg;
@property (nonatomic , strong)FMBaseViewController *vc;
@end

NS_ASSUME_NONNULL_END
