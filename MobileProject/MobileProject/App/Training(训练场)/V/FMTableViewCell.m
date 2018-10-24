//
//  FMTableViewCell.m
//  MobileProject
//
//  Created by 向蕾 on 2018/10/17.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import "FMTableViewCell.h"

@implementation FMTableViewCell

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
    UIImageView *img = [[UIImageView alloc] init];
    [img setImage:[UIImage imageNamed:@"jiaxiao"]];
    [self.contentView addSubview:img];
    [img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView).mas_offset(KFit_W6S(30));
        make.top.mas_equalTo(self.contentView).mas_offset(KFit_H6S(25));
        make.width.height.mas_equalTo(KFit_W6S(90));
        
    }];
    
    self.title = [[UILabel alloc] init];
    [self.contentView addSubview:self.title];
    self.title.text = @"训练场";
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(img.mas_right).mas_offset(KFit_W6S(20));
        make.top.mas_equalTo(img);
        make.height.mas_equalTo(KFit_H6S(30));
        make.right.mas_equalTo(self.contentView).mas_offset(-KFit_W6S(30));
    }];
    
    UIImageView *imgdz = [[UIImageView alloc] init];
    [imgdz setImage:[UIImage imageNamed:@"map"]];
    [self.contentView addSubview:imgdz];
    [imgdz mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(img.mas_right).mas_offset(KFit_W6S(20));
        make.bottom.mas_equalTo(img);
        make.height.width.mas_equalTo(KFit_H6S(38));
    }];
    
    self.address = [[UILabel alloc] init];
    [self.contentView addSubview:self.address];
    self.address.text = @"训练场";
    self.address.textColor = kColor_N(168, 171, 182);
    self.address.font = [UIFont systemFontOfSize:kFit_Font6(16)];
    [self.address mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(imgdz.mas_right).mas_offset(KFit_W6S(5));
        make.bottom.mas_equalTo(img);
        make.height.mas_equalTo(KFit_H6S(38));
        make.right.mas_equalTo(self.contentView).mas_offset(-KFit_W6S(30));
    }];
    
    
    UILabel *lb = [[UILabel alloc] init];
    [self.contentView addSubview:lb];
    lb.backgroundColor = kColor_N(240, 240, 240);
    [lb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.contentView);
        make.top.mas_equalTo(img.mas_bottom).mas_offset(KFit_H6S(25));
        make.height.mas_equalTo(KFit_H6S(20));
    }];
}

- (void)setModel:(FMMainModel *)model{
    _model = model;
    self.title.text = model.teamTrainingName;
    self.address.text = model.address;
    
}
@end
