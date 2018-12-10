//
//  SchoolRankingCell.m
//  MobileProject
//
//  Created by 向蕾 on 2018/11/21.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import "SchoolRankingCell.h"

@implementation SchoolRankingCell

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
    self.img = [[UIImageView alloc] init];
    [self.contentView addSubview:self.img];
    [self.img setImage:[UIImage imageNamed:@"nor_fenxiao_photo"]];
    [self.img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView).mas_offset(KFit_H6S(35));
        make.left.mas_equalTo(self.contentView).mas_offset(KFit_H6S(30));
        make.size.mas_equalTo(CGSizeMake(KFit_W6S(150), KFit_H6S(120)));
    }];
    
    self.title = [[UILabel alloc] init];
    [self.contentView addSubview:self.title];
    self.title.font = [UIFont systemFontOfSize:kFit_Font6(17) weight:0.5];
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.img).mas_offset(KFit_H6S(10));
        make.left.mas_equalTo(self.img.mas_right).mas_offset(KFit_W6S(30));
        make.height.mas_equalTo(KFit_H6S(40));
        make.width.mas_equalTo(KFit_W6S(400));
    }];
    
    UILabel *lb = [[UILabel alloc] init];
    [self.contentView addSubview:lb];
    lb.text = @"排名";
    lb.font = [UIFont systemFontOfSize:kFit_Font6(16)];
    [lb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.img).mas_offset(-KFit_H6S(10));
        make.height.mas_equalTo(KFit_H6S(40));
        make.left.mas_equalTo(self.img.mas_right).mas_offset(KFit_W6S(30));
//        make.width.mas_equalTo(KFit_W6S(60));
    }];
    
    self.rank = [[UILabel alloc] init];
    [self.contentView addSubview:self.rank ];
    self.rank.textColor = kColor_N(0, 100, 233);
    self.rank.text = @"15";
    self.rank.font = [UIFont systemFontOfSize:kFit_Font6(20)];
    [self.rank mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(lb);
        make.height.mas_equalTo(KFit_H6S(40));
        make.left.mas_equalTo(lb.mas_right).mas_offset(KFit_W6S(10));
        make.width.mas_equalTo(KFit_W6S(60));
    }];
    
    UILabel *line = [[UILabel alloc] init];
    [self.contentView addSubview:line];
    line.backgroundColor = kColor_N(240, 240, 240);
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.contentView);
        make.height.mas_equalTo(1);
    }];
}

- (void)setModel:(FMMainModel *)model{
    _model = model;
    self.title.text = [NSString stringWithFormat:@"%@ (%@)",model.deptFatherName,model.name];
    self.rank.text = model.schoolrankingCount;
    [self.img sd_setImageWithURL:[NSURL URLWithString:KURLIma(_model.headImg)] placeholderImage:[UIImage imageNamed:@"nor_fenxiao_photo"]];
}
@end
