//
//  PayInforV.m
//  MobileProject
//
//  Created by zsgy on 2018/7/2.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import "PayInforV.h"

@implementation PayInforV

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
    [self addSubview:_title];
    [_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(self).mas_offset(KFit_W6S(25));
        make.width.mas_equalTo(KFit_W6S(450));
        make.height.mas_equalTo(KFit_H6S(30));
    }];
    
    self.time = [[UILabel alloc] init];
    self.time.textColor = kColor_N(105, 105, 105);
    [self addSubview:_time];
    [_time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).mas_offset(KFit_W6S(25));
        make.top.mas_equalTo(self.title.mas_bottom).mas_offset(KFit_H6S(20));
        make.right.mas_equalTo(self).mas_offset(-KFit_W6S(25));
        make.height.mas_equalTo(KFit_H6S(30));
    }];
    
    self.money = [[UILabel alloc] init];
    self.money.textAlignment = NSTextAlignmentRight;
    self.money.textColor = kColor_N(247, 142, 50);
    [self addSubview:_money];
    [_money mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).mas_offset(KFit_W6S(25));
        make.right.mas_equalTo(self).mas_offset(-KFit_W6S(85));
        make.left.mas_equalTo(self.title.mas_right);
        make.height.mas_equalTo(KFit_H6S(30));
    }];
    
}
- (void)setModel:(FMSubmodel *)model{
    self.title.text = [NSString stringWithFormat:@"%@支付信息:",model.title];
    self.time.text = [NSString stringWithFormat:@"付款时间:%@",model.payed_at];
    self.money.text = [NSString stringWithFormat:@"%ld",model.amount];
}
@end
