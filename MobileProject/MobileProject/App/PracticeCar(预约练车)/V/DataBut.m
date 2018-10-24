//
//  DataBut.m
//  MobileProject
//
//  Created by 向蕾 on 2018/10/18.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import "DataBut.h"

@implementation DataBut

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
//- (instancetype)init
//{
//    self = [super init];
//    if (self) {
//        
//        
//    }
//    return self;
//}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.cornerRadius = 5;
        self.layer.masksToBounds = YES;
        
        self.data = [[UILabel alloc] init];
        [self addSubview:self.data];
        self.data.textAlignment = NSTextAlignmentCenter;
        self.data.font = [UIFont systemFontOfSize:kFit_Font6(14)];
        [self.data mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self).mas_offset(KFit_H6S(25));
            make.left.right.mas_equalTo(self);
            make.height.mas_equalTo(KFit_H6S(25));
        }];
        
        self.week = [[UILabel alloc] init];
        [self addSubview:self.week];
        self.week.textAlignment = NSTextAlignmentCenter;
        self.week.font = [UIFont systemFontOfSize:kFit_Font6(14)];
        [self.week mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.data.mas_bottom).mas_offset(KFit_H6S(10));
            make.left.right.mas_equalTo(self);
            make.height.mas_equalTo(KFit_H6S(25));
        }];
        
        self.num = [[UILabel alloc] init];
        [self addSubview:self.num];
        self.num.textAlignment = NSTextAlignmentCenter;
        self.num.font = [UIFont systemFontOfSize:kFit_Font6(17)];
        [self.num mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self).mas_offset(-KFit_H6S(25));
            make.left.right.mas_equalTo(self);
            make.height.mas_equalTo(KFit_H6S(25));
        }];
        
        self.but = [[UIButton alloc] init];
        [self addSubview:self.but];
        [self.but addTarget:self action:@selector(Click:) forControlEvents:UIControlEventTouchUpInside];
        [self.but mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.mas_equalTo(self);
        }];
        
    }
    return self;
}


- (void)setTextColor:(UIColor *)textColor{
    _textColor = textColor;
    self.data.textColor = _textColor;
    self.num.textColor = _textColor;
    self.week.textColor = _textColor;
}

- (void)setBKColor:(UIColor *)BKColor{
    _BKColor = BKColor;
    self.backgroundColor = BKColor;
}

- (void)Click:(UIButton *)senter{
    senter.selected = !senter.selected;
    if (senter.selected) {
        self.data.textColor = [UIColor whiteColor];
        self.num.textColor = [UIColor whiteColor];
        self.week.textColor = [UIColor whiteColor];
        self.backgroundColor = kColor_N(0, 112, 234);
    }else{
        self.data.textColor = _textColor;
        self.num.textColor = _textColor;
        self.week.textColor = _textColor;
        self.backgroundColor = _BKColor;
    }
    [self.deleget DataButTouchUpInset:self];
}

- (void)change:(UIButton *)senter{
    senter.selected = !senter.selected;
    if (senter.selected) {
        self.data.textColor = [UIColor whiteColor];
        self.num.textColor = [UIColor whiteColor];
        self.week.textColor = [UIColor whiteColor];
        self.backgroundColor = kColor_N(0, 112, 234);
    }else{
        self.data.textColor = _textColor;
        self.num.textColor = _textColor;
        self.week.textColor = _textColor;
        self.backgroundColor = _BKColor;
    }
}
@end
