//
//  XLThumbUp.h
//  MobileProject
//
//  Created by Mingo on 2017/8/30.
//  Copyright © 2017年 ZSGY. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ThumbUpType) {
    /** 评论点赞 */
    ThumbUpComments = 1,
    /** 问政点赞 */
    ThumbUpAskZheng = 2,
    /** 投票点赞 */
    ThumbUpVote = 3
};

typedef void (^contentLikes)(BOOL isContentLikesOk ,NSInteger index);

@interface XLThumbUp : UIView

@property(nonatomic, strong) contentLikes contentLikes;
//点赞，取消点赞方法
+(void)thumbUpButton:(UIButton *)sender thumbUpType:(ThumbUpType)type idid:(NSInteger)idid model:(FMMainModel *)model;
//判断是否点赞
+(void)thumbUpButton:(UIButton *)sender idid:(NSInteger)idid;

@end
