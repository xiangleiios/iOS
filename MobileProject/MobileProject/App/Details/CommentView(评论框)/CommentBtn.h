//
//  CommentBtn.h
//  AllTest
//
//  Created by 菜鸟 on 15/7/4.
//  Copyright (c) 2015年 菜鸟. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommentTextView.h"
@protocol CommentBtnDelegate <NSObject>

- (void)pushCommentViewController;

@end

@interface CommentBtn : UIView<CommentTextViewDelegate>
@property (nonatomic, strong) UIButton * textbut;
@property (nonatomic, assign) id<CommentBtnDelegate> delegate;
@property (nonatomic, strong) UIButton * btn;
@property (nonatomic, strong) UIButton * butcollection;
@property (nonatomic, strong) UIButton * butshare;
@property (nonatomic, strong) UILabel *comment;
@end
