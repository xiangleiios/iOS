//
//  AddStudentCell.m
//  MobileProject
//
//  Created by 向蕾 on 2018/9/3.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import "AddStudentCell.h"

@implementation AddStudentCell

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
    UIImageView *imgone = [[UIImageView alloc] init];
    self.img = imgone;
    [self addSubview:imgone];
//    [imgone setImage:[UIImage imageNamed:img]];
    [imgone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).mas_offset(KFit_W6S(20));
        make.centerY.mas_equalTo(self);
        make.height.width.mas_equalTo(KFit_H6S(90));
    }];
    
    UIImageView *imgtwo = [[UIImageView alloc] init];
    [self addSubview:imgtwo];
    [imgtwo setImage:[UIImage imageNamed:@"arrows_right_icon"]];
    [imgtwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self).mas_offset(-KFit_W6S(20));
        make.centerY.mas_equalTo(self);
        make.width.mas_equalTo(KFit_H6S(40));
        make.height.mas_equalTo(KFit_H6S(40));
    }];
    
    self.titleLable = [[UILabel alloc] init];
    [self addSubview:_titleLable];
//    titleLable.text = title;
    [_titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(imgone.mas_right).mas_offset(KFit_W6S(30));
        make.centerY.mas_equalTo(self).mas_offset(-KFit_H6S(25));
        make.height.mas_equalTo(KFit_H6S(40));
        make.right.mas_equalTo(imgtwo.mas_left).mas_offset(-KFit_W6S(20));
    }];
    
    self.SubLable = [[UILabel alloc] init];
    [self addSubview:_SubLable];
//    subtitleLable.text = subtitle;
    _SubLable.font = [UIFont systemFontOfSize:kFit_Font6(14)];
    _SubLable.textColor = kColor_N(183, 190, 205);
    [_SubLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(imgone.mas_right).mas_offset(KFit_W6S(30));
        make.centerY.mas_equalTo(self).mas_offset(KFit_H6S(25));;
        make.height.mas_equalTo(KFit_H6S(40));
        make.right.mas_equalTo(imgtwo.mas_left).mas_offset(-KFit_W6S(20));
    }];
    
    UILabel *lb = [[UILabel alloc] init];
    [self addSubview:lb];
    lb.backgroundColor = kColor_N(240, 240, 240);
    [lb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self);
        make.left.mas_equalTo(self).mas_offset(KFit_W6S(20));
        make.right.mas_equalTo(self).mas_offset(-KFit_W6S(20));
        make.height.mas_equalTo(1);
    }];
}


@end
