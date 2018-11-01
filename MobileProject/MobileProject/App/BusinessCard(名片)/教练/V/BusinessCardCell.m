//
//  BusinessCardCell.m
//  MobileProject
//
//  Created by 向蕾 on 2018/9/5.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import "BusinessCardCell.h"

@implementation BusinessCardCell

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
    _img = [[UIImageView alloc] init];
    [self.contentView addSubview:_img];
//    [_img setImage:[UIImage imageNamed:@"head_nor"]];
    
    
    [_img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView).mas_offset(KFit_W6S(30));
        make.centerY.mas_equalTo(self.contentView);
        make.width.height.mas_equalTo(KFit_W6S(90));
    }];
    _img.layer.cornerRadius = KFit_W6S(45);
    _img.layer.masksToBounds = YES;
    
    self.title = [[UILabel alloc] init];
    self.title.font = [UIFont systemFontOfSize:kFit_Font6(17)];
    [self.contentView addSubview:self.title];
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_img);
        make.left.mas_equalTo(_img.mas_right).mas_offset(KFit_W6S(20));
        make.height.mas_equalTo(KFit_H6S(30));
        
    }];
    
    self.titleSub = [[UILabel alloc] init];
    self.titleSub.font = [UIFont systemFontOfSize:kFit_Font6(15)];
    self.titleSub.textColor = kColor_N(179, 187, 201);
    [self.contentView addSubview:self.titleSub];
    [self.titleSub mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_img);
        make.left.mas_equalTo(self.title.mas_right).mas_offset(KFit_W6S(20));
        make.height.mas_equalTo(KFit_H6S(30));
        
    }];
    
    self.name = [[UILabel alloc] init];
    [self.contentView addSubview:self.name];
    self.name.font = [UIFont systemFontOfSize:kFit_Font6(15)];
    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.title.mas_bottom).mas_offset(KFit_H6S(20));
        make.left.mas_equalTo(_img.mas_right).mas_offset(KFit_W6S(20));
        make.height.mas_equalTo(KFit_H6S(30));
        
    }];
    
    self.typeone = [[UILabel alloc] init];
    self.typeone.font = [UIFont systemFontOfSize:kFit_Font6(12)];
    self.typeone.text = @"学员端推广中";
    self.typeone.textColor = kColor_N(78, 144, 238);
    self.typeone.backgroundColor = kColor_N(230, 241, 252);
    self.typeone.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.typeone];
    [self.typeone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.name.mas_bottom).mas_offset(KFit_H6S(20));
        make.left.mas_equalTo(_img.mas_right).mas_offset(KFit_W6S(20));
        make.height.mas_equalTo(KFit_H6S(30));
        make.width.mas_equalTo(KFit_W6S(180));
        
    }];
    
    UILabel *lb = [[UILabel alloc] init];
    [self.contentView addSubview:lb];
    lb.backgroundColor = kColor_N(240, 240, 240);
    [lb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.mas_equalTo(self.contentView);
        make.height.mas_equalTo(1);
    }];
    
}

- (void)setModel:(FMMainModel *)model{
    _model = model;
    [_img sd_setImageWithURL:[NSURL URLWithString:_model.headImg] placeholderImage:[UIImage imageNamed:@"head_nor"]];
    self.title.text = _model.schoolName;
    self.name.text = [NSString stringWithFormat:@"%@  %@",_model.name,_model.enrollPhone];
    self.titleSub.text = [NSString stringWithFormat:@"(%@)",_model.deptName];
    if ([_model.isShow intValue] == 1) {
//        是否展示（2：默认展示 1：不展示）"
        self.typeone.hidden = YES;
    }else{
        self.typeone.hidden = NO;
    }
}





@end
