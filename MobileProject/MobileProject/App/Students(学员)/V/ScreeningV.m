//
//  ScreeningV.m
//  MobileProject
//
//  Created by 向蕾 on 2018/10/11.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import "ScreeningV.h"

@implementation ScreeningV

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
    self.backgroundColor = kRGBAColor(0, 0, 0, 0.8);
}

- (void)setDataArr:(NSArray *)dataArr{
    _dataArr = dataArr;
    NSMutableArray *arr = [NSMutableArray array];
    UIView *back = [[UIView alloc] init];
    [self addSubview:back];
    [back mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(self);
        make.height.mas_equalTo(dataArr.count * KFit_H6S(90));
    }];
    for (int i = 0 ; i < dataArr.count; i++) {
        UIButton *but = [[UIButton alloc] init];
        [but setTitle:arr[i] forState:UIControlStateNormal];
        [but setTitleColor:kColor_N(64, 78, 108) forState:UIControlStateNormal];
        [but setTitleColor:kColor_N(0, 109, 234) forState:UIControlStateSelected];
        but.tag = i;
        [back addSubview:but];
        [arr addObject:but];
    }
    [arr mas_distributeViewsAlongAxis:MASAxisTypeVertical withFixedSpacing:0.1 leadSpacing:0.1 tailSpacing:0.1];
    [arr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(back);
    }];
    
}
@end
