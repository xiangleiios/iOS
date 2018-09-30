//
//  HomeControlsV.m
//  MobileProject
//
//  Created by zsgy on 2018/6/7.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import "HomeControlsV.h"

@implementation HomeControlsV

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self loadSubview];
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self loadSubview];
    }
    return self;
}


- (void)loadSubview{
    UIImageView *img = [[UIImageView alloc] init];
    [self addSubview:img];
    img.userInteractionEnabled = YES;
    [img setImage:[UIImage imageNamed:@"white_block"]];
    [img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.mas_equalTo(self);
    }];
    
    self.title = [[UILabel alloc] init];
    [self addSubview:self.title];
    self.title.font = [UIFont fontWithName:@"DIN-Medium" size:kFit_Font6(40)];
    self.title.textAlignment = NSTextAlignmentCenter;
    self.title.textColor = kColor_N(15, 115, 238);
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self);
        make.height.mas_equalTo(KFit_H6S(80));
        make.bottom.mas_equalTo(self).mas_offset(-KFit_H6S(70));
    }];
    
    self.subtitle = [[UILabel alloc] init];
    [self addSubview:self.subtitle];
    self.subtitle.font = [UIFont systemFontOfSize:kFit_Font6(14)];
    self.subtitle.textAlignment = NSTextAlignmentCenter;
    self.subtitle.textColor = [UIColor blackColor];
    [self.subtitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self);
        make.top.mas_equalTo(self).mas_offset(KFit_H6S(30));
        make.height.mas_equalTo(KFit_H6S(25));
    }];
    
    self.but = [[UIButton alloc] init];
    [self addSubview:self.but];
    [self.but mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.mas_equalTo(self);
    }];
}


@end
