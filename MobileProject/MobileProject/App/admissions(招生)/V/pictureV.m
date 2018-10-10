//
//  pictureV.m
//  MobileProject
//
//  Created by 向蕾 on 2018/10/9.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import "pictureV.h"

@implementation pictureV

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
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    self.backgroundColor = kRGBAColor(0, 0, 0, 0.8);
    
    self.img = [[UIImageView alloc] init];
    [self addSubview:self.img];
    [self.img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.centerY.mas_equalTo(self).mas_offset(KFit_H6S(80));
        make.size.mas_equalTo(CGSizeMake(KFit_W6S(600), KFit_H6S(900)));
    }];
    
    UIButton *but = [[UIButton alloc] init];
    [self addSubview:but];
    [but setImage:[UIImage imageNamed:@"delete_icon"] forState:UIControlStateNormal];
    [but addTarget:self action:@selector(shutDown) forControlEvents:UIControlEventTouchUpInside];
    [but mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.img);
        make.bottom.mas_equalTo(self.img.mas_top).mas_offset(-KFit_H6S(30));
        make.width.height.mas_equalTo(KFit_H6S(60));
    }];
}
- (void)shutDown{
    [self removeFromSuperview];
}
- (void)show{
    
    UIWindow *rootWindow = [UIApplication sharedApplication].keyWindow;
    [rootWindow addSubview:self];
    
}
@end
