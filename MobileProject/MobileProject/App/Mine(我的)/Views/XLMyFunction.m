//
//  XLMyFunction.m
//  MobileProject
//
//  Created by zsgy on 17/7/31.
//  Copyright © 2017年 ZSGY. All rights reserved.
//

#import "XLMyFunction.h"

@implementation XLMyFunction

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
        self.backgroundColor=[UIColor whiteColor];
        [self loadsubview];
        [self addGestures];
    }
    return self;
}


- (void)loadsubview{
    self.img=[[UIImageView alloc]init];
    [self addSubview:self.img];
    [self.img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).mas_offset(KFit_W6S(25));
        make.centerY.mas_equalTo(self);
        make.height.width.mas_equalTo(KFit_W6S(40));
    }];
    
    self.title=[[UILabel alloc]init];
    self.title.font=[UIFont systemFontOfSize:kFit_Font6(17)];
    [self addSubview:self.title];
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self);
        make.left.mas_equalTo(self).mas_equalTo(KFit_W6S(80));
        make.right.mas_equalTo(self).mas_offset(-KFit_W6S(150));
        make.height.mas_equalTo(KFit_H6S(30));
    }];
    
    self.subtitle=[[UILabel alloc]init];
    self.subtitle.font=[UIFont systemFontOfSize:kFit_Font6(15)];
    [self addSubview:self.subtitle];
    self.subtitle.textAlignment=NSTextAlignmentRight;
    [self.subtitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self);
        make.right.mas_equalTo(self).mas_offset(-KFit_W6S(30));
        make.height.mas_equalTo(KFit_H6S(65));
        make.width.mas_equalTo(KFit_W6S(300));
    }];
    
    self.imgT=[[UIImageView alloc]init];
    [self addSubview:self.imgT];
    [self.imgT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self);
        make.right.mas_equalTo(self).mas_offset(-KFit_W6S(30));
        make.height.width.mas_equalTo(KFit_W6S(35));
    }];
    
    
    UILabel *lb=[[UILabel alloc]init];
    [self addSubview:lb];
    [lb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self);
        make.left.mas_equalTo(self).mas_offset(KFit_W6S(25));
        make.right.mas_equalTo(self).mas_offset(-KFit_W6S(25));
        make.height.mas_equalTo(1);
    }];
    lb.backgroundColor=[UIColor colorWithWhite:240/255.0 alpha:1];
    
}

- (void)addGestures{
    UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    [self addGestureRecognizer:tap];
}

- (void)tapAction:(UITapGestureRecognizer *)tap{
    if (self.delegate && [self.delegate respondsToSelector:@selector(xlMyFunctionView:clickOnTheIndex:)]) {
        [self.delegate xlMyFunctionView:self clickOnTheIndex:self.num];
    }
}


@end
