//
//  GuideViewCell.m
//  GuideViewDemo
//
//  Created by Jn_Kindle on 16/7/17.
//  Copyright © 2016年 HuaDa. All rights reserved.
//

#import "GuideViewCell.h"
#import "GuideView.h"

@interface GuideViewCell()

@end

@implementation GuideViewCell

- (instancetype)init {
    if (self = [super init]) {
        [self initView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initView];
    }
    return self;
}

- (void)initView {
    self.layer.masksToBounds = YES;
    self.guideImageView = [[UIImageView alloc]initWithFrame:kScreenViewBounds];
    self.guideImageView.center = CGPointMake(kScreenViewBounds.size.width / 2, kScreenViewBounds.size.height / 2);
    
    UIButton *experienceButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    experienceButton.hidden = YES;
    [experienceButton setFrame:CGRectMake(0, 0, KFit_W6S(600), KFit_H6S(300))];
    [experienceButton setImage:[UIImage imageNamed:@"experienceImage"] forState:UIControlStateNormal];
    [experienceButton setImage:[UIImage imageNamed:@"experienceImage"] forState:UIControlStateHighlighted];
    
    
    
    UIButton *skipbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    skipbutton.hidden = YES;
    [skipbutton setFrame:CGRectMake(0, 0, 50, 20)];
    [skipbutton setTitle:@"跳过 >>" forState:UIControlStateNormal];
    skipbutton.titleLabel.font = [UIFont fontWithName:@"Arial" size:14.0];
    [skipbutton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    
    self.experienceButton = experienceButton;
    self.skipButton = skipbutton;
    
    [self.contentView addSubview:self.guideImageView];
    [self.contentView addSubview:self.skipButton];
    [self.contentView addSubview:self.experienceButton];
    
    [self.experienceButton setCenter:CGPointMake(kScreenViewBounds.size.width / 2, kScreenViewBounds.size.height - KFit_H6S(150))];
    [self.skipButton setCenter:CGPointMake(kScreenViewBounds.size.width - 60, 40)];
}

@end
