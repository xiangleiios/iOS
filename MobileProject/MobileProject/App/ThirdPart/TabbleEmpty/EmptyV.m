//
//  EmptyV.m
//  MobileProject
//
//  Created by 向蕾 on 2018/10/24.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import "EmptyV.h"

@implementation EmptyV

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
        [self loadsub];
    }
    return self;
}
- (void)loadsub{
    self.backgroundColor = kColor_N(240, 240, 240);
    UIImage* image = [UIImage imageNamed:@"placeholder"];
    UIImageView *carImageView = [[UIImageView alloc] init];
    [carImageView setImage:image];
    [self addSubview:carImageView];
    [carImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.width.mas_equalTo(image.size.width);
        make.height.mas_equalTo(image.size.height);
        make.centerY.mas_equalTo(self).mas_offset(-KFit_H6S(200));
    }];
    
    UILabel *noInfoLabel = [[UILabel alloc] init];
    self.title = noInfoLabel;
    self.title.numberOfLines = 0;
    noInfoLabel.textAlignment = NSTextAlignmentCenter;
    noInfoLabel.textColor = ZTColor;
    noInfoLabel.backgroundColor = [UIColor clearColor];
    noInfoLabel.font = [UIFont systemFontOfSize:kFit_Font6(17)];
    [self addSubview:noInfoLabel];
    [noInfoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self);
        make.top.mas_equalTo(carImageView.mas_bottom).mas_offset(KFit_H6S(40));
//        make.height.mas_equalTo(KFit_H6S(40));
    }];

    self.but = [[UIButton alloc] init];
    [_but setBackgroundImage:[UIImage imageWithColor:kColor_N(0, 112, 234)] forState:UIControlStateNormal];
    _but.layer.cornerRadius = 3;
    _but.layer.masksToBounds = YES;
    [_but setTitle:@"立即添加" forState:UIControlStateNormal];
    [self addSubview:_but];
    [_but mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.top.mas_equalTo(noInfoLabel.mas_bottom).mas_offset(KFit_H6S(50));
        make.height.mas_equalTo(KFit_H6S(90));
        make.width.mas_equalTo(KFit_H6S(330));
    }];
}
@end
