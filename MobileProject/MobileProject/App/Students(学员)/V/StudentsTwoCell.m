//
//  StudentsTwoCell.m
//  MobileProject
//
//  Created by 向蕾 on 2018/8/25.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import "StudentsTwoCell.h"

@implementation StudentsTwoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self loadSubview];
    }
    return self;
}


- (void)loadSubview{
    UIImageView * img = [[UIImageView alloc] init];
    [self.contentView addSubview:img];
    [img setImage:[UIImage imageNamed:@"head_nor"]];
    [img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView).mas_offset(KFit_W6S(30));
        make.centerY.mas_equalTo(self.contentView);
        make.width.height.mas_equalTo(KFit_W6S(80));
    }];
    
    self.title = [[UILabel alloc] init];
    self.title.text = @"丽丽  13333333333";
    [self.contentView addSubview:self.title];
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(img.mas_right).mas_offset(KFit_W6S(30));
        make.centerY.mas_equalTo(self.contentView).mas_offset(-KFit_H6S(25));
        make.size.mas_equalTo(CGSizeMake(KFit_W6S(350), KFit_H6S(40)));
    }];
    
    self.typeone = [[UILabel alloc] init];
    [self.contentView addSubview:self.typeone];
    self.typeone.layer.borderWidth = 0.3;
    self.typeone.layer.borderColor = kColor_N(77, 213, 185).CGColor;
    self.typeone.layer.cornerRadius = 3;
    self.typeone.textColor = kColor_N(77, 213, 185);
    self.typeone.font = [UIFont systemFontOfSize:kFit_Font6(13)];
    self.typeone.textAlignment = NSTextAlignmentCenter;
    self.typeone.text = @"信息已完善";
    [self.typeone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(img.mas_right).mas_offset(KFit_W6S(30));
        make.centerY.mas_equalTo(self.contentView).mas_offset(KFit_H6S(25));
        make.size.mas_equalTo(CGSizeMake(KFit_W6S(160), KFit_H6S(40)));
    }];
    
    self.dial = [[UIButton alloc] init];
    [self.contentView addSubview:self.dial];
    [self.dial setImage:[UIImage imageNamed:@"phone_icon"] forState:UIControlStateNormal];
    [self.dial mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView).mas_offset(-KFit_W6S(30));
        make.centerY.mas_equalTo(self.contentView);
        make.width.height.mas_equalTo(KFit_W6S(70));
    }];
    
    UILabel *lb = [[UILabel alloc] init];
    [self.contentView addSubview:lb];
    lb.backgroundColor = kColor_N(240, 240, 240);
    [lb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.mas_equalTo(self.contentView);
        make.height.mas_equalTo(1);
    }];
}
@end
