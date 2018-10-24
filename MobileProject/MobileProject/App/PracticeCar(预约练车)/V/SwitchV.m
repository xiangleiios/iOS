//
//  SwitchV.m
//  MobileProject
//
//  Created by 向蕾 on 2018/10/22.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import "SwitchV.h"

@implementation SwitchV

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
        [self loadSub];
    }
    return self;
}

- (void)loadSub{
    UILabel *lineone = [[UILabel alloc] init];
    [self addSubview:lineone];
    lineone.backgroundColor = kColor_N(240, 240, 240);
    [lineone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(self);
        make.height.mas_equalTo(KFit_H6S(20));
    }];
    
    UILabel *linetwo = [[UILabel alloc] init];
    [self addSubview:linetwo];
    linetwo.backgroundColor = kColor_N(240, 240, 240);
    [linetwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self);
        make.height.mas_equalTo(KFit_H6S(20));
    }];
    
    _title = [[UILabel alloc] init];
    [self addSubview:_title];
    _title.text = @"开启预约";
    [_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).mas_offset(KFit_W6S(30));
        make.centerY.mas_equalTo(self).mas_offset(-KFit_H6S(30));
        make.height.mas_equalTo(KFit_H6S(40));
    }];
    _subtitle = [[UILabel alloc] init];
    [self addSubview:_subtitle];
    _subtitle.textColor = kColor_N(166, 175, 193);
    _subtitle.font = [UIFont systemFontOfSize:kFit_Font6(14)];
    _subtitle.text = @"预约练车开启中，关闭后为休息日";
    [_subtitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).mas_offset(KFit_W6S(30));
        make.centerY.mas_equalTo(self).mas_offset(KFit_H6S(30));
        make.height.mas_equalTo(KFit_H6S(40));
    }];
    
    self.opne = [[UISwitch alloc] init];
    [self addSubview:self.opne];
    [_opne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self);
        make.right.mas_equalTo(self).mas_offset(-KFit_W6S(30));
        make.size.mas_equalTo(CGSizeMake(KFit_W6S(100), KFit_H6S(60)));
    }];
}
@end
