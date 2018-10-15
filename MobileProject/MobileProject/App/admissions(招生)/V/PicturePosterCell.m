//
//  PicturePosterCell.m
//  MobileProject
//
//  Created by 向蕾 on 2018/9/29.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import "PicturePosterCell.h"

@implementation PicturePosterCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self loadSub];
    }
    return self;
}

- (void)loadSub{
    self.img = [[UIImageView alloc] init];
    [self.contentView addSubview:self.img];
    [self.img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(self.contentView);
        make.height.mas_equalTo(KFit_H6S(400));
    }];
    
    self.title = [[UILabel alloc] init];
    [self.contentView addSubview:self.title];
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.contentView);
        make.top.mas_equalTo(self.img.mas_bottom).mas_offset(KFit_H6S(30));
        make.height.mas_equalTo(KFit_H6S(35));
    }];
    self.title.text = @"        点燃梦想";
    self.title.font = [UIFont systemFontOfSize:kFit_Font6(18) weight:0.5];
    
    self.typeimg = [[UIImageView alloc] init];
    [self.title addSubview:self.typeimg];
    [self.typeimg setImage:[UIImage imageNamed:@"new_red"]];
    [self.typeimg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.left.mas_equalTo(self.title);
        make.size.mas_equalTo(CGSizeMake(KFit_W6S(52), KFit_H6S(30)));
    }];
    
    self.sub = [[UILabel alloc] init];
    [self.contentView addSubview:self.sub];
    [self.sub mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.contentView);
        make.top.mas_equalTo(self.title.mas_bottom).mas_offset(KFit_H6S(20));
        make.height.mas_equalTo(KFit_H6S(35));
    }];
    self.sub.text = @"点燃梦想";
    self.sub.textColor = kColor_N(160, 170, 169);
    self.sub.font = [UIFont systemFontOfSize:kFit_Font6(16)];
    
}


- (void)setModel:(FMMainModel *)model{
    _model = model;
    self.title.text = [NSString stringWithFormat:@"        %@",model.tittle];
    self.sub.text = [NSString stringWithFormat:@"%d人制作",model.useNum];
    [self.img sd_setImageWithURL:[NSURL URLWithString:KURLIma(model.imgUrl)]];
    [self.img sd_setImageWithURL:[NSURL URLWithString:KURLIma(model.imgUrl)] placeholderImage:[UIImage imageNamed:@"photo_nor"]];
}
@end
