//
//  CoachReplyV.m
//  MobileProject
//
//  Created by 向蕾 on 2018/11/5.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import "CoachReplyV.h"

@implementation CoachReplyV

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
    UILabel *name = [[UILabel alloc] init];
    [self addSubview:name];
    name.text = @"教练回复";
    name.font = [UIFont systemFontOfSize:kFit_Font6(15)];
    name.textColor = ZTColor;
    [name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.left).mas_offset(KFit_W6S(30));
        make.top.mas_equalTo(self);
        make.height.mas_equalTo(KFit_H6S(30));
    }];
    
    self.time = [[UILabel alloc] init];
    [self addSubview:self.time];
    self.time.font = [UIFont systemFontOfSize:kFit_Font6(13)];
    self.time.textAlignment = NSTextAlignmentRight;
    self.time.textColor = kColor_N(189, 196, 208);
    [self.time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.right).mas_offset(-KFit_W6S(30));
        make.top.mas_equalTo(self);
        make.height.mas_equalTo(KFit_H6S(30));
        make.width.mas_equalTo(KFit_W6S(280));
    }];
    
    self.title = [[UILabel alloc] init];
    [self addSubview:self.title];
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).mas_offset(KFit_W6S(30));
        make.right.mas_equalTo(self).mas_offset(-KFit_W6S(30));
        make.top.mas_equalTo(name.mas_bottom).mas_offset(KFit_H6S(30));
    }];
    
}

- (void)setModel:(FMMainModel *)model{
    _model = model;
    NSDictionary *dic = [model.replyList firstObject];
    self.time.text = dic[@"updateTime"];
    self.title.text = dic[@"content"];
    
    
}


@end
