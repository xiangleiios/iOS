//
//  ChooseStudentsCell.m
//  MobileProject
//
//  Created by 向蕾 on 2018/10/22.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import "ChooseStudentsCell.h"

@implementation ChooseStudentsCell

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
    [self.contentView addSubview:img];
    [img setImage:[UIImage imageNamed:@"head_nor"]];
    [img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView);
        make.left.mas_equalTo(self.contentView).mas_offset(KFit_W6S(30));
        make.width.height.mas_equalTo(KFit_W6S(80));
    }];
    
    self.name = [[UILabel alloc] init];
    [self.contentView addSubview:self.name];
    self.name.text = @"向蕾";
    self.name.font = [UIFont systemFontOfSize:kFit_Font6(16)];
    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView);
        make.left.mas_equalTo(img.mas_right).mas_offset(KFit_W6S(25));
        make.height.mas_equalTo(KFit_H6S(40));
        make.width.mas_equalTo(KFit_W6S(150));
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
    

    self.xunlianchang = [[UILabel alloc] init];
    [self.contentView addSubview:self.xunlianchang];
    self.xunlianchang.font = [UIFont systemFontOfSize:kFit_Font6(16)];
    self.xunlianchang.text = @"上次预约：2号训练场";
    self.xunlianchang.textAlignment = NSTextAlignmentRight;
    [self.xunlianchang mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView);
        make.right.mas_equalTo(self.but.mas_left).mas_offset(-KFit_W6S(30));
        make.left.mas_equalTo(self.name.mas_right).mas_offset(KFit_W6S(30));
        make.height.mas_equalTo(KFit_H6S(40));
    }];
    // 创建Attributed
    NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:self.xunlianchang.text];
    // 需要改变的第一个文字的位置
    NSUInteger firstLoc = [[noteStr string] rangeOfString:@"上"].location ;
    // 需要改变的最后一个文字的位置
    NSUInteger secondLoc = [[noteStr string] rangeOfString:@"："].location;
    // 需要改变的区间
    NSRange range = NSMakeRange(firstLoc, secondLoc - firstLoc);
    // 改变颜色
    [noteStr addAttribute:NSForegroundColorAttributeName value:ZTColor range:range];
    // 改变字体大小及类型
//    [noteStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica-BoldOblique" size:27] range:range];
    // 为label添加Attributed
    [self.xunlianchang setAttributedText:noteStr];
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
    self.but.tag = [_model.idid integerValue];
    //    XLSingleton *single = [XLSingleton singleton];
    NSMutableArray *arr = [NSMutableArray array];
    for (NSDictionary *dic in [XLSingleton singleton].practiceArr) {
        [arr addObject:dic[@"idid"]];
    }
    if ([arr containsObject:_model.idid]) {
        self.but.selected = YES;
    }else{
        self.but.selected = NO;
    }
    self.name.text = model.studentName;
    if (model.trainingName) {
        self.xunlianchang.text = [NSString stringWithFormat:@"上次预约：%@",model.trainingName];
        self.xunlianchang.hidden = NO;
    }else{
        self.xunlianchang.hidden = YES;
    }
    
}
@end
