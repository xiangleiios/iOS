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
    
    self.selelctBut = [[UIButton alloc] init];
    [self.contentView addSubview:self.selelctBut];
    [self.selelctBut setImage:[UIImage imageNamed:@"nor_button"] forState:UIControlStateNormal];
    [self.selelctBut setImage:[UIImage imageNamed:@"down_button"] forState:UIControlStateSelected];
    [self.selelctBut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView).mas_offset(KFit_W6S(27));
        make.centerY.mas_equalTo(self.contentView);
        make.width.height.mas_equalTo(KFit_W6S(56));
    }];
    
    UIImageView * img = [[UIImageView alloc] init];
    [self.contentView addSubview:img];
    [img setImage:[UIImage imageNamed:@"head_nor"]];
    [img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.selelctBut.mas_right).mas_offset(KFit_W6S(30));
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
    
    self.typeone.layer.cornerRadius = 3;
    
    self.typeone.font = [UIFont systemFontOfSize:kFit_Font6(13)];
    self.typeone.textAlignment = NSTextAlignmentCenter;
    
    [self.typeone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(img.mas_right).mas_offset(KFit_W6S(30));
        make.centerY.mas_equalTo(self.contentView).mas_offset(KFit_H6S(25));
        make.size.mas_equalTo(CGSizeMake(KFit_W6S(160), KFit_H6S(40)));
    }];
    
    self.typetwo = [[UILabel alloc] init];
    [self.contentView addSubview:self.typetwo];
    self.typetwo.layer.borderWidth = 0.3;
    
    self.typetwo.layer.cornerRadius = 3;
    self.typetwo.textColor = kColor_N(77, 213, 185);
    self.typetwo.font = [UIFont systemFontOfSize:kFit_Font6(13)];
    self.typetwo.textAlignment = NSTextAlignmentCenter;
    
    [self.typetwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.typeone.mas_right).mas_offset(KFit_W6S(10));
        make.centerY.mas_equalTo(self.contentView).mas_offset(KFit_H6S(25));
        make.size.mas_equalTo(CGSizeMake(KFit_W6S(160), KFit_H6S(40)));
    }];
    
    
    self.dial = [[UIButton alloc] init];
    [self.contentView addSubview:self.dial];
    [self.dial setImage:[UIImage imageNamed:@"phone_icon"] forState:UIControlStateNormal];
    [self.dial addTarget:self action:@selector(dianhua) forControlEvents:UIControlEventTouchUpInside];
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

- (void)setModel:(FMMainModel *)model{
    _model = model;
    self.selelctBut.tag = [_model.idid integerValue];
//    XLSingleton *single = [XLSingleton singleton];
    NSMutableArray *arr = [NSMutableArray array];
    for (NSDictionary *dic in [XLSingleton singleton].dateArr) {
        [arr addObject:dic[@"idid"]];
    }
    if ([arr containsObject:_model.idid]) {
        self.selelctBut.selected = YES;
    }else{
        self.selelctBut.selected = NO;
    }
    
    self.title.text = [NSString stringWithFormat:@"%@  %@",model.studentName,model.studentPhone?model.studentPhone:@""];
    if ([model.isComplete  isEqual: @"1"]) {
        self.typeone.text = @"信息未完善";
        self.typeone.layer.borderColor = [UIColor redColor].CGColor;
        self.typeone.textColor = [UIColor redColor];
    }else{
        self.typeone.text = @"信息已完善";
        self.typeone.layer.borderColor = kColor_N(77, 213, 185).CGColor;
        self.typeone.textColor = kColor_N(77, 213, 185);
    }
    
    if (_model.coachName) {
        self.typetwo.text = _model.coachName;
        if (model.coachStatus) {
            self.typetwo.textColor = kColor_N(204, 209, 218);
            self.typetwo.layer.borderColor = kColor_N(204, 209, 218).CGColor;
        }else{
            self.typetwo.textColor = kColor_N(255, 132, 30);
            self.typetwo.layer.borderColor = kColor_N(255, 132, 30).CGColor;
        }
        
    }else{
        self.typetwo.text = @"分校";
        self.typetwo.textColor = kColor_N(255, 132, 30);
        self.typetwo.layer.borderColor = kColor_N(255, 132, 30).CGColor;
        
    }
    //1:未缴费 2：已缴费
//    if ([model.isPay intValue] == 1) {
//        self.typetwo.text = @"未收费";
//        self.typetwo.layer.borderColor = [UIColor redColor].CGColor;
//        self.typetwo.textColor = [UIColor redColor];
//
//    }else{
//        self.typetwo.text = @"已收费";
//        self.typetwo.layer.borderColor = kColor_N(77, 213, 185).CGColor;
//        self.typetwo.textColor = kColor_N(77, 213, 185);
//    }
    if (USERFZR) {
    if ([model.isComplete  isEqual: @"1"]) {
        self.selelctBut.hidden = YES;
    }else{
        self.selelctBut.hidden = NO;
    }
    }else{
        self.selelctBut.hidden = YES;
    }
}



- (void)dianhua{
    if (_model.studentPhone) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"telprompt:%@",_model.studentPhone]]];
    }
}

@end
