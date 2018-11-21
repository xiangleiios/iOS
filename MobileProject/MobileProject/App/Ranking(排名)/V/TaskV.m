//
//  TaskV.m
//  MobileProject
//
//  Created by 向蕾 on 2018/11/21.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import "TaskV.h"

@implementation TaskV

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self loadSubview];
    }
    return self;
}
- (void)loadSubview{
    self.title = [[UILabel alloc] init];
    [self addSubview:self.title];
    self.title.font = [UIFont systemFontOfSize:kFit_Font6(16)];
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self);
        make.centerY.mas_equalTo(self).mas_offset(-KFit_H6S(25));
        make.height.mas_equalTo(KFit_H6S(30));
        make.width.mas_equalTo(KFit_W6S(210));
    }];
    
    self.subtitle = [[UILabel alloc] init];
    [self addSubview:self.subtitle];
    self.subtitle.font = [UIFont systemFontOfSize:kFit_Font6(13)];
    self.subtitle.textColor = ZTColor;
    [self.subtitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self);
        make.centerY.mas_equalTo(self).mas_offset(KFit_H6S(25));
        make.height.mas_equalTo(KFit_H6S(30));
    }];
    
    self.fen = [[UILabel alloc] init];
    [self addSubview:self.fen];
    self.fen.textColor = kColor_N(95, 196, 107);
    self.fen.font = [UIFont systemFontOfSize:kFit_Font6(13)];
    [self.fen mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.title.mas_right).mas_offset(KFit_W6S(30));
        make.centerY.mas_equalTo(self.title);
        make.height.mas_equalTo(KFit_H6S(30));
        make.width.mas_equalTo(KFit_W6S(100));
    }];
    
    self.but = [[UIButton alloc] init];
    [self addSubview:self.but];
    [self.but mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self);
        make.centerY.mas_equalTo(self.title);
        make.height.mas_equalTo(KFit_H6S(52));
        make.width.mas_equalTo(KFit_W6S(120));
    }];
    
    self.line = [[UILabel alloc] init];
    [self addSubview:self.line];
    self.line.backgroundColor = kColor_N(240, 240, 240);
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self);
        make.height.mas_equalTo(kFit_Font6(1));
    }];
}
@end
