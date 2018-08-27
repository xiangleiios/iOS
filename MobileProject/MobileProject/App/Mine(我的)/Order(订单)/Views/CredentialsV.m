//
//  CredentialsV.m
//  MobileProject
//
//  Created by zsgy on 2018/6/14.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import "CredentialsV.h"

@implementation CredentialsV

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
    self.img = [[UIImageView alloc] init];
    self.img.backgroundColor = [UIColor redColor];
    [self addSubview:self.img];
    [self.img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).mas_offset(KFit_H6S(20));
        make.left.mas_equalTo(self).mas_offset(KFit_W6S(30));
        make.bottom.mas_equalTo(self).mas_offset(-KFit_H6S(20));
        make.width.mas_equalTo(KFit_W6S(160));
    }];
    
    self.time_up = [[UILabel alloc] init];
    self.time_up.text = @"上传时间";
    self.time_up.textColor = kColor_N(105, 105, 105);
    [self addSubview:self.time_up];
    [self.time_up mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.img.mas_right).mas_offset(KFit_H6S(20));
        make.right.mas_equalTo(self);
        make.centerY.mas_equalTo(self).mas_offset(-KFit_H6S(25));
        make.height.mas_equalTo(KFit_W6S(40));
    }];
    
    self.time_confirm = [[UILabel alloc] init];
    self.time_confirm.text = @"确定时间";
    self.time_confirm.textColor = kColor_N(105, 105, 105);
    [self addSubview:self.time_confirm];
    [self.time_confirm mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.img.mas_right).mas_offset(KFit_H6S(20));
        make.right.mas_equalTo(self);
        make.centerY.mas_equalTo(self).mas_offset(KFit_H6S(25));
        make.height.mas_equalTo(KFit_W6S(40));
    }];
    
}
@end
