//
//  ChooseTimeCell.m
//  MobileProject
//
//  Created by 向蕾 on 2018/10/22.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import "ChooseTimeCell.h"

@implementation ChooseTimeCell

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
    self.time = [[UILabel alloc] init];
    [self.contentView addSubview:self.time];
    self.time.text = @"08:00-20:00";
    self.time.font = [UIFont systemFontOfSize:kFit_Font6(16)];
    [self.time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView).mas_offset(KFit_W6S(30));
        make.centerY.mas_equalTo(self.contentView).mas_offset(-KFit_H6S(30));
        make.height.mas_equalTo(KFit_H6S(40));
        make.width.mas_equalTo(KFit_W6S(200));
    }];
    self.typeOne = [[UILabel alloc] init];
    [self.contentView addSubview:self.typeOne];
    self.typeOne.text = @"科二";
    self.typeOne.textAlignment = NSTextAlignmentCenter;
    self.typeOne.layer.borderWidth = 0.5;
    self.typeOne.textColor = kColor_N(0, 121, 236);
    self.typeOne.font = [UIFont systemFontOfSize:kFit_Font6(13)];
    self.typeOne.layer.borderColor = kColor_N(0, 121, 236).CGColor;
    [self.typeOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.time.mas_right).mas_offset(KFit_W6S(20));
        make.centerY.mas_equalTo(self.time);
        make.width.mas_equalTo(KFit_W6S(100));
        make.height.mas_equalTo(KFit_W6S(40));
    }];
    
    self.typeTwo = [[UILabel alloc] init];
    [self.contentView addSubview:self.typeTwo];
    self.typeTwo.text = @"C1";
    self.typeTwo.textAlignment = NSTextAlignmentCenter;
    self.typeTwo.layer.borderWidth = 0.5;
    self.typeTwo.textColor = kColor_N(255, 134, 7);
    self.typeTwo.font = [UIFont systemFontOfSize:kFit_Font6(13)];
    self.typeTwo.layer.borderColor = kColor_N(255, 134, 7).CGColor;
    [self.typeTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.typeOne.mas_right).mas_offset(KFit_W6S(20));
        make.centerY.mas_equalTo(self.time);
        make.width.mas_equalTo(KFit_W6S(100));
        make.height.mas_equalTo(KFit_W6S(40));
    }];
    
    self.num = [[UILabel alloc] init];
    [self.contentView addSubview:self.num];
    self.num.text = @"已约2";
    self.num.font = [UIFont systemFontOfSize:kFit_Font6(14)];
    self.num.textColor = kColor_N(117, 127, 149);
    [self.num mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView).mas_offset(KFit_W6S(30));
        make.centerY.mas_equalTo(self.contentView).mas_offset(KFit_H6S(30));
        make.height.mas_equalTo(KFit_H6S(40));
        make.width.mas_equalTo(KFit_W6S(200));
    }];
    
    self.but = [[UIButton alloc] init];
    [self.contentView addSubview:self.but];
    [self.but setImage:[UIImage imageNamed:@"nor_button"] forState:UIControlStateNormal];
    [self.but setImage:[UIImage imageNamed:@"down_button"] forState:UIControlStateSelected];
    [self.but mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView);
        make.right.mas_equalTo(self.contentView).mas_offset(-KFit_W6S(30));
        make.width.height.mas_equalTo(KFit_W6S(56));
    }];
    
    UILabel *lb = [[UILabel alloc] init];
    [self.contentView addSubview:lb];
    lb.backgroundColor = kColor_N(240, 240, 240);
    [lb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.contentView);
        make.height.mas_equalTo(1);
    }];
}


- (void)setModel:(FMMainModel *)model{
    _model = model;
    self.but.tag = [_model.idid integerValue];
    //    XLSingleton *single = [XLSingleton singleton];
    NSMutableArray *arr = [NSMutableArray array];
    for (NSDictionary *dic in [XLSingleton singleton].timeArr) {
        [arr addObject:dic[@"idid"]];
    }
    if ([arr containsObject:_model.idid]) {
        self.but.selected = YES;
    }else{
        self.but.selected = NO;
    }
    
    XLCache *cache = [XLCache singleton];
    self.time.text = [NSString stringWithFormat:@"%@-%@",model.startDay,model.endDay];
    self.typeOne.text = model.keMu;
    self.typeTwo.text = [NSString stringWithFormat:@"%@",cache.student_license_type_title[[cache.student_license_type_value indexOfObject:[NSString stringWithFormat:@"%@",model.licenseType]]]];
    self.num.text = [NSString stringWithFormat:@"已约%lu",model.trainingRecords.count];
}
@end
