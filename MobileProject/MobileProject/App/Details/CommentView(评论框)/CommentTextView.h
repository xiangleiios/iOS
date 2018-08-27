//
//  CommentTextView.h
//  SmallDemo
//
//  Created by 菜鸟 on 15/7/9.
//  Copyright (c) 2015年 菜鸟. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CommentTextViewDelegate <NSObject>

- (void)commentTextViewDidFinishWithText:(NSString *)text;

@end

@interface MainTextView : UIView
@property (nonatomic, strong) UIButton * button;
@property (nonatomic, strong) UITextView * textView;
@end


@interface CommentTextView : UIView
@property (nonatomic, strong) NSString * text;
@property (nonatomic, strong) MainTextView * mainTextView;
@property (nonatomic, assign) id<CommentTextViewDelegate> delegate;
@end
