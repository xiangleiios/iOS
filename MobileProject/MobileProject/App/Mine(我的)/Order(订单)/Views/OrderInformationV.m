//
//  OrderInformationV.m
//  MobileProject
//
//  Created by zsgy on 2018/6/14.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import "OrderInformationV.h"

@implementation OrderInformationV

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
    self.title.textColor = kColor_N(105, 105, 105);
//    self.title.text = @"交易号";
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).mas_offset(KFit_H6S(20));
        make.left.mas_equalTo(self).mas_offset(KFit_W6S(10));
        make.right.mas_equalTo(self);
        make.height.mas_equalTo(KFit_H6S(30));
    }];
    
    self.time_up = [[UILabel alloc] init];
//    self.time_up.text = @"创建时间";
    self.time_up.textColor = kColor_N(105, 105, 105);
    [self addSubview:self.time_up];
    [self.time_up mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.title.mas_bottom).mas_offset(KFit_H6S(20));
        make.left.mas_equalTo(self).mas_offset(KFit_W6S(10));
        make.right.mas_equalTo(self);
        make.height.mas_equalTo(KFit_H6S(30));
    }];
    
    self.time_confirm = [[UILabel alloc] init];
//    self.time_confirm.text = @"付款时间";
    self.time_confirm.textColor = kColor_N(105, 105, 105);
    [self addSubview:self.time_confirm];
    [self.time_confirm mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.time_up.mas_bottom).mas_offset(KFit_H6S(20));
        make.left.mas_equalTo(self).mas_offset(KFit_W6S(10));
        make.right.mas_equalTo(self);
        make.height.mas_equalTo(KFit_H6S(30));
    }];
    
}


-(void)setModel:(FMSubmodel *)model{
    _model = model;
    _title.text = [NSString stringWithFormat:@"付款时间：%@",model.payed_at];
}
@end
