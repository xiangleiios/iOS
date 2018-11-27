//
//  MyPicturePosterCell.m
//  MobileProject
//
//  Created by 向蕾 on 2018/10/9.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import "MyPicturePosterCell.h"
#import "CodeShareV.h"

@implementation MyPicturePosterCell
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
    self.title.font = [UIFont systemFontOfSize:kFit_Font6(18) weight:0.5];
    
    
    self.sub = [[UILabel alloc] init];
    [self.contentView addSubview:self.sub];
    [self.sub mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.contentView);
        make.top.mas_equalTo(self.title.mas_bottom).mas_offset(KFit_H6S(20));
        make.height.mas_equalTo(KFit_H6S(35));
    }];
    self.sub.textColor = kColor_N(160, 170, 169);
    self.sub.font = [UIFont systemFontOfSize:kFit_Font6(16)];
    
//    self.share = [[UIButton alloc] init];
//    [self.contentView addSubview:self.share];
//    [self.share setImage:[UIImage imageNamed:@"share_icon"] forState:UIControlStateNormal];
//    [self.share addTarget:self action:@selector(toShare) forControlEvents:UIControlEventTouchUpInside];
//    [self.share mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.mas_equalTo(self.sub);
//        make.right.mas_equalTo(self.contentView);
//        make.width.height.mas_equalTo(KFit_H6S(48));
//    }];
    
}


- (void)setModel:(FMMainModel *)model{
    _model = model;
    self.title.text = [NSString stringWithFormat:@"%@",model.tittle];
    self.sub.text = [XLCommonUse TimeToIntercept:_model.createTime];
//    [self.img sd_setImageWithURL:[NSURL URLWithString:KURLIma(model.memo)]];
    [self.img sd_setImageWithURL:[NSURL URLWithString:KURLIma(model.memo)] placeholderImage:[UIImage imageNamed:@"photo_nor"]];
}


- (void)toShare{
    XLSingleton *sing = [XLSingleton singleton];
    sing.type = 1;
    sing.shareId = self.model.idid;
    CodeShareV *v = [[CodeShareV alloc] init];
    v.type = ShareTypeImage;
    XLshare *share = [[XLshare alloc]init];
    share.shareImgUrl = KURLIma(_model.memo);
    v.share = share;
    [v show];
}
@end
