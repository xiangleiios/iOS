//
//  CoachCell.m
//  MobileProject
//
//  Created by 向蕾 on 2018/11/13.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import "CoachCell.h"

@implementation CoachCell

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
    self.head = [[UIImageView alloc] init];
    [self.contentView addSubview:self.head];
    [self.head mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(self.contentView).mas_offset(KFit_W6S(30));
        make.width.height.mas_equalTo(KFit_W6S(80));
    }];
    self.head.layer.cornerRadius = KFit_W6S(40);
    self.head.layer.masksToBounds = YES;
    self.head.contentMode = UIViewContentModeScaleAspectFill;
    self.name = [[UILabel alloc] init];
    [self.contentView addSubview:self.name];
    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.head);
        make.left.mas_equalTo(self.head.mas_right).mas_offset(KFit_W6S(30));
        make.height.mas_equalTo(KFit_H6S(40));
    }];
    
    self.pho = [[UILabel alloc] init];
    self.pho.textColor = ZTColor;
    [self.contentView addSubview:self.pho];
    [self.pho mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.head);
        make.left.mas_equalTo(self.name.mas_right).mas_offset(KFit_W6S(30));
        make.height.mas_equalTo(KFit_H6S(40));
    }];
    
    UIImageView *img = [[UIImageView alloc] init];
    [self.contentView addSubview:img];
    img.contentMode = UIViewContentModeLeft;
    [img setImage:[UIImage imageNamed:@"star_o_k"]];
    [img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.name);
        make.top.mas_equalTo(self.name.mas_bottom).mas_offset(KFit_H6S(15));
        make.size.mas_equalTo(CGSizeMake(KFit_W6S(120), KFit_H6S(20)));
    }];
    
    self.rank = [[UILabel alloc] init];
    self.rank.textColor = ZTColor;
    self.rank.font = [UIFont systemFontOfSize:kFit_Font6(13)];
    [self.contentView addSubview:self.rank];
    [self.rank mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(img);
        make.left.mas_equalTo(img.mas_right).mas_offset(KFit_W6S(30));
    }];
    
    self.xinImg = [[UIImageView alloc] init];
    [self.contentView addSubview:self.xinImg];
    [self.xinImg setImage:[UIImage imageNamed:@"star_o_"]];
    self.xinImg.contentMode = UIViewContentModeLeft;
    self.xinImg.clipsToBounds = YES;
    [self.xinImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.mas_equalTo(img);
        make.width.mas_equalTo(KFit_W6S(120));
    }];
    
    self.typeOne = [[UILabel alloc] init];
    [self.contentView addSubview:self.typeOne];
    self.typeOne.layer.borderColor = kColor_N(55, 208, 177).CGColor;
    self.typeOne.layer.borderWidth = 0.5;
    self.typeOne.font = [UIFont systemFontOfSize:kFit_Font6(12)];
    self.typeOne.text = @"学员20";
    self.typeOne.textColor = kColor_N(55, 208, 177);
    self.typeOne.textAlignment = NSTextAlignmentCenter;
    [self.typeOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.name);
        make.top.mas_equalTo(img.mas_bottom).mas_offset(KFit_H6S(15));
        make.size.mas_equalTo(CGSizeMake(KFit_W6S(120), KFit_H6S(40)));
    }];
    
    self.typeTwo = [[UILabel alloc] init];
    [self.contentView addSubview:self.typeTwo];
    self.typeTwo.layer.borderColor = kColor_N(105, 170, 243).CGColor;
    self.typeTwo.textAlignment = NSTextAlignmentCenter;
    self.typeTwo.layer.borderWidth = 0.5;
    self.typeTwo.text = @"c1";
    self.typeTwo.font = [UIFont systemFontOfSize:kFit_Font6(12)];
    self.typeTwo.textColor = kColor_N(105, 170, 243);
    [self.typeTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.typeOne.mas_right).mas_offset(KFit_W6S(15));
        make.top.mas_equalTo(img.mas_bottom).mas_offset(KFit_H6S(15));
        make.size.mas_equalTo(CGSizeMake(KFit_W6S(60), KFit_H6S(40)));
    }];
    
    self.typeThree = [[UILabel alloc] init];
    [self.contentView addSubview:self.typeThree];
    self.typeThree.layer.borderColor = kColor_N(105, 170, 243).CGColor;
    self.typeThree.textAlignment = NSTextAlignmentCenter;
    self.typeThree.layer.borderWidth = 0.5;
    self.typeThree.text = @"c2";
    self.typeThree.font = [UIFont systemFontOfSize:kFit_Font6(12)];
    self.typeThree.textColor = kColor_N(105, 170, 243);
    [self.typeThree mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.typeTwo.mas_right).mas_offset(KFit_W6S(15));
        make.top.mas_equalTo(img.mas_bottom).mas_offset(KFit_H6S(15));
        make.size.mas_equalTo(CGSizeMake(KFit_W6S(60), KFit_H6S(40)));
    }];
    
    self.typeFour = [[UIImageView alloc] init];
    [self.contentView addSubview:self.typeFour];
    [self.typeFour setImage:[UIImage imageNamed:@"leave"]];
    [self.typeFour mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView).mas_offset(-KFit_W6S(30));
        make.top.mas_equalTo(self.name);
        make.size.mas_equalTo(CGSizeMake(KFit_W6S(112), KFit_H6S(40)));
    }];
    self.typeOne.hidden = YES;
    self.typeTwo.hidden = YES;
    self.typeThree.hidden = YES;
    
    UILabel *line = [[UILabel alloc] init];
    [self.contentView addSubview:line];
    line.backgroundColor = kColor_N(240, 240, 240);
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.contentView);
        make.height.mas_equalTo(kFit_Font6(1));
    }];
    
}

- (void)setModel:(FMMainModel *)model{
    _model = model;
    self.name.text = model.name;
    self.pho.text = model.enrollPhone;
    self.rank.text = [NSString stringWithFormat:@"%@分",[XLCommonUse removeFloatAllZeroByString:model.averageScore]];
//    if (model.headPic.length > 1) {
        [self.head sd_setImageWithURL:[NSURL URLWithString:KURLIma(model.headPic)] placeholderImage:[UIImage imageNamed:@"head_nor"]];
//    }
    [self.xinImg mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(KFit_W6S(120) * (model.averageScore/5.0));
    }];
    if (model.enrollStudentCount == 0) {
        self.typeOne.hidden = YES;
        [self.typeTwo mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.name);
        }];
    }else{
        self.typeOne.hidden = NO;
        self.typeOne.text = [NSString stringWithFormat:@"学员%d",model.enrollStudentCount];
        [self.typeTwo mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.typeOne.mas_right).mas_offset(KFit_W6S(15));
        }];
    }
    if (model.isDimission) {
        self.typeFour.hidden = NO;
    }else{
        self.typeFour.hidden = YES;
    }
    if (model.licenses && model.licenses.length > 1) {
        NSArray  *array = [model.licenses componentsSeparatedByString:@","];
        if (array.count == 1) {
            self.typeTwo.hidden = NO;
            self.typeTwo.text = [array firstObject];
            self.typeThree.hidden = YES;
        }else if(array.count >=2){
            self.typeTwo.hidden = NO;
            self.typeTwo.text = [array firstObject];
            self.typeThree.hidden = NO;
            self.typeThree.text = array[1];
        }
        
    }else{
        self.typeTwo.hidden = YES;
        self.typeThree.hidden = YES;
    }
}
@end
