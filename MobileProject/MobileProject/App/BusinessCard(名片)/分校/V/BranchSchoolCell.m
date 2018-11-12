//
//  BranchSchoolCell.m
//  MobileProject
//
//  Created by 向蕾 on 2018/11/1.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import "BranchSchoolCell.h"

@implementation BranchSchoolCell

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
    [_img setImage:[UIImage imageNamed:@"nor_fenxiao_photo"]];
    _img.contentMode = UIViewContentModeScaleAspectFit;
    [_img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView).mas_offset(KFit_W6S(30));
        make.centerY.mas_equalTo(self.contentView);
        make.width.mas_equalTo(KFit_W6S(150));
        make.height.mas_equalTo(KFit_W6S(120));
    }];
//    _img.layer.cornerRadius = KFit_W6S(45);
//    _img.layer.masksToBounds = YES;
    
    self.title = [[UILabel alloc] init];
    self.title.font = [UIFont systemFontOfSize:kFit_Font6(17)];
    [self.contentView addSubview:self.title];
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_img);
        make.left.mas_equalTo(_img.mas_right).mas_offset(KFit_W6S(20));
        make.height.mas_equalTo(KFit_H6S(30));
//        make.right.mas_equalTo(self.contentView).mas_offset(-KFit_W6S(200));
        
    }];
    
    self.titleSub = [[UILabel alloc] init];
    self.titleSub.font = [UIFont systemFontOfSize:kFit_Font6(15)];
    self.titleSub.textColor = kColor_N(179, 187, 201);
    [self.contentView addSubview:self.titleSub];
    [self.titleSub mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_img);
        make.left.mas_equalTo(self.title.mas_right).mas_offset(KFit_W6S(20));
        make.height.mas_equalTo(KFit_H6S(30));
//        make.right.mas_equalTo(self.contentView).mas_offset(-KFit_W6S(200));
    }];
    
    self.name = [[UILabel alloc] init];
    [self.contentView addSubview:self.name];
    self.name.font = [UIFont systemFontOfSize:kFit_Font6(15)];
    self.name.textColor = kColor_N(93, 102, 127);
    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.title.mas_bottom).mas_offset(KFit_H6S(20));
        make.left.mas_equalTo(_img.mas_right).mas_offset(KFit_W6S(20));
        make.height.mas_equalTo(KFit_H6S(25));
        
    }];
    
    self.pho = [[UILabel alloc] init];
    self.pho.textColor = kColor_N(93, 102, 127);
    self.pho.font = [UIFont systemFontOfSize:kFit_Font6(15)];
    [self.contentView addSubview:self.pho];
    [self.pho mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.name.mas_bottom).mas_offset(KFit_H6S(20));
        make.left.mas_equalTo(_img.mas_right).mas_offset(KFit_W6S(20));
        make.height.mas_equalTo(KFit_H6S(25));
        make.width.mas_equalTo(KFit_W6S(280));
        
    }];
    
    
    self.typeOne = [[UIImageView alloc] init];
    [self.contentView addSubview:self.typeOne];
    [self.typeOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView).mas_offset(-KFit_W6S(30));
        make.top.mas_equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(KFit_W6S(112), KFit_H6S(96)));
    }];
    
    
    self.typeTwo = [[UIImageView alloc] init];
    [self.contentView addSubview:self.typeTwo];
    [self.typeTwo setImage:[UIImage imageNamed:@"wws_red"]];
    [self.typeTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView).mas_offset(-KFit_W6S(31));
        make.top.mas_equalTo(self.typeOne.mas_bottom).mas_offset(KFit_H6S(20));
        make.size.mas_equalTo(CGSizeMake(KFit_W6S(110), KFit_H6S(36)));
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
    if (_model.headImg.length >0) {
        NSArray  *array = [_model.headImg componentsSeparatedByString:@","];
        KKLog(@"%@",KURLIma([array firstObject]));
        [_img sd_setImageWithURL:[NSURL URLWithString:KURLIma([array firstObject])] placeholderImage:[UIImage imageNamed:@"nor_fenxiao_photo"]];
    }
    if (_model.schoolName.length > 6) {
        self.title.text =  [_model.schoolName substringToIndex:6];
    }else{
        self.title.text = _model.schoolName;
    }
    self.name.text = _model.name;
    self.titleSub.text = [NSString stringWithFormat:@"(%@)",_model.deptName];
    self.pho.text = _model.enrollPhone;
    KKLog(@"%@",_model.isShow);
    if ([_model.isShow intValue] == 1) {
        //        是否展示（2：默认展示 1：不展示）"
        [self.typeOne setImage:[UIImage imageNamed:@"tag_gray"]];

    }else{
        [self.typeOne setImage:[UIImage imageNamed:@"tag_blue"]];

    }
    if (_model.perfectStatus) {
        self.typeTwo.hidden = YES;
        
    }else{
        self.typeTwo.hidden = NO;
    }
}

@end
