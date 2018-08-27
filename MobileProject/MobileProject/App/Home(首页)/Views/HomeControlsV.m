//
//  HomeControlsV.m
//  MobileProject
//
//  Created by zsgy on 2018/6/7.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import "HomeControlsV.h"

@implementation HomeControlsV

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self loadSubview];
    }
    return self;
}

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
    self.title.font = [UIFont fontWithName:@"ArialHebrew" size:kFit_Font6(30)];
    self.title.textAlignment = NSTextAlignmentCenter;
    self.title.textColor = kColor_N(15, 115, 238);
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(self);
        make.height.mas_equalTo(KFit_H6S(60));
    }];
    
    self.subtitle = [[UILabel alloc] init];
    [self addSubview:self.subtitle];
    self.subtitle.font = [UIFont systemFontOfSize:kFit_Font6(12)];
    self.subtitle.textAlignment = NSTextAlignmentCenter;
    self.subtitle.textColor = [UIColor blackColor];
    [self.subtitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self);
        make.height.mas_equalTo(KFit_H6S(25));
    }];
}


@end
