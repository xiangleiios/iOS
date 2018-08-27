//
//  XLMyNewsFunction.m
//  MobileProject
//
//  Created by zsgy on 2017/10/30.
//  Copyright © 2017年 ZSGY. All rights reserved.
//

#import "XLMyNewsFunction.h"

@implementation XLMyNewsFunction

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
    UIImageView *imagenCommon=[[UIImageView alloc]init];
    [self addSubview:imagenCommon];
    [imagenCommon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self).mas_offset(-KFit_W6S(50));
        make.centerY.mas_equalTo(self);
        make.height.width.mas_equalTo(KFit_W6S(40));
    }];
    
    
    self.img=[[UIImageView alloc]init];
    [self addSubview:self.img];
    [self.img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(imagenCommon.mas_left).mas_offset(-KFit_W6S(25));
        make.centerY.mas_equalTo(self);
        make.height.width.mas_equalTo(KFit_W6S(70));
    }];
    self.img.layer.cornerRadius=KFit_W6S(35);
    self.img.clipsToBounds=YES;
    [self.img sd_setImageWithURL:[NSURL URLWithString:[User UserOb].avatar_url]];
    self.img.hidden = YES;
    
    self.title=[[UILabel alloc]init];
    self.title.font=[UIFont systemFontOfSize:kFit_Font6(15)];
    [self addSubview:self.title];
    self.title.textAlignment=NSTextAlignmentLeft;
    self.title.textColor=[UIColor lightGrayColor];
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self);
        make.left.mas_equalTo(self).mas_equalTo(KFit_W6S(50));
        make.height.mas_equalTo(KFit_H6S(60));
        make.width.mas_equalTo(KFit_W6S(150));
    }];
    
    self.subtitle=[[UILabel alloc]init];
    self.subtitle.font=[UIFont systemFontOfSize:kFit_Font6(15)];
    [self addSubview:self.subtitle];
    self.subtitle.textAlignment=NSTextAlignmentLeft;
    self.subtitle.textColor=[UIColor lightGrayColor];
    [self.subtitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self);
        make.left.mas_equalTo(self.title.mas_right).mas_offset(KFit_W6S(30));
        make.height.mas_equalTo(KFit_H6S(60));
        make.width.mas_equalTo(KFit_W6S(300));
    }];
    
    self.describe=[[UILabel alloc]init];
    [self addSubview:self.describe];
    [self.describe mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(imagenCommon.mas_left).mas_offset(-KFit_W6S(25));
        make.centerY.mas_equalTo(self);
        make.height.mas_equalTo(KFit_W6S(60));
        make.width.mas_equalTo(KFit_W6S(150));
    }];
    self.describe.textAlignment=NSTextAlignmentRight;
    self.describe.textColor=[UIColor lightGrayColor];
    
    UILabel *lb=[[UILabel alloc]init];
    [self addSubview:lb];
    [lb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self);
        make.left.mas_equalTo(self).mas_offset(KFit_W6S(50));
        make.right.mas_equalTo(self).mas_offset(-KFit_W6S(50));
        make.height.mas_equalTo(1);
    }];
    lb.backgroundColor=[UIColor colorWithWhite:240/255.0 alpha:1];
    
}
- (void)setType:(MyNewsType)type{
    _type=type;
    if (type==MyNewsTypeCommon) {
        
    }else if (type == MyNewsTypeHead){
        self.img.hidden = NO;
    }else if (type == MyNewsTypeNum){
        
    }
}
- (void)addGestures{
    UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    [self addGestureRecognizer:tap];
}

- (void)tapAction:(UITapGestureRecognizer *)tap{
    [self.delegate XLMyNewsFunctionclickOnTheIndex:self.tag];
}
@end
