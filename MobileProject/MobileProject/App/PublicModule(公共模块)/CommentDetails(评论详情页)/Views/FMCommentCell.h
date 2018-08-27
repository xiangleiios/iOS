//
//  FMCommentCell.h
//  MobileProject
//
//  Created by Mingo on 2017/8/8.
//  Copyright © 2017年 ZSGY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FMMainModel.h"
#import "UITableViewCell+LayoutHeight.h"

typedef void (^voteCommentDelete)(BOOL isVoteCommentDeleteOk);

@interface FMCommentCell : UITableViewCell


@property (nonatomic, strong) voteCommentDelete voteCommentDelete;
@property (nonatomic, strong) UIViewController *pushVC;
@property (nonatomic, strong) FMMainModel *model;
/** <#name#> */
@property (nonatomic, strong) UIImageView *yfHeadIcon;
/** <#name#> */
@property (nonatomic, strong) UILabel *yfNikeName;
/** 内容是否含有图片或者视频 */
@property (nonatomic, strong) UIImageView *yfContentType;
/** <#name#> */
@property (nonatomic, strong) UIImageView *yfWenDaIcon;
/** <#name#> */
@property (nonatomic, strong) UILabel *yfText;
/** <#name#> */
@property (nonatomic, strong) UILabel *yfTime;
/** 回复 */
@property (nonatomic, strong) UILabel *yfReply;
/** 点赞 */
@property (nonatomic, strong) UIButton *yfDianZan;
/** 删除评论 */
@property (nonatomic, strong) UIButton *yfDelete;
@end
