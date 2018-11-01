//
//  SchoolLable.m
//  MobileProject
//
//  Created by 向蕾 on 2018/10/31.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import "SchoolLable.h"

@implementation SchoolLable

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
    self.backgroundColor = [UIColor whiteColor];
    _name = [[XLInformationV alloc] informationWithTitle:@"展示标签" ButTile:@"选择标签" ButImg:nil];
    [self addSubview:_name];
    [_name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(self);
        make.height.mas_equalTo(KFit_H6S(90));
    }];
    
    self.backview = [[UIView alloc] init];
    [self addSubview:self.backview];
    [_backview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self);
        make.top.mas_equalTo(_name.mas_bottom);
    }];
    
    self.tslb = [[UILabel alloc] init];
    [self addSubview:self.tslb];
    self.tslb.text = @"无数据";
    self.tslb.textAlignment = NSTextAlignmentCenter;
    self.tslb.font = [UIFont systemFontOfSize:kFit_Font6(15)];
    self.tslb.textColor = kColor_N(166, 175, 193);
    [self.tslb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.top.mas_equalTo(self.backview);
    }];
}
@end
