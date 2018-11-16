//
//  AddressBookCell.m
//  MobileProject
//
//  Created by 向蕾 on 2018/11/16.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import "AddressBookCell.h"

@implementation AddressBookCell

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
    self.name = [[UILabel alloc] init];
    [self.contentView addSubview:self.name];
    self.name.font = [UIFont systemFontOfSize:kFit_Font6(17)];
    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView).mas_offset(-KFit_H6S(25));
        make.height.mas_equalTo(KFit_H6S(40));
        make.width.mas_equalTo(KFit_W6S(300));
        make.left.mas_equalTo(self.contentView).mas_offset(KFit_W6S(30));
    }];
    
    
    self.pho = [[UILabel alloc] init];
    [self.contentView addSubview:self.pho];
    self.pho.font = [UIFont systemFontOfSize:kFit_Font6(15)];
    self.pho.textColor = ZTColor;
    [self.pho mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView).mas_offset(KFit_H6S(25));
        make.height.mas_equalTo(KFit_H6S(40));
        make.width.mas_equalTo(KFit_W6S(300));
        make.left.mas_equalTo(self.contentView).mas_offset(KFit_W6S(30));
    }];
    
    self.but = [[UIButton alloc] init];
    self.but.userInteractionEnabled = NO;
    [self.contentView addSubview:self.but];
    [self.but setImage:[UIImage imageNamed:@"nor_button"] forState:UIControlStateNormal];
    [self.but setImage:[UIImage imageNamed:@"down_button"] forState:UIControlStateSelected];
    [self.but mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView);
        make.right.mas_equalTo(self.contentView).mas_offset(-KFit_W6S(30));
        make.width.height.mas_equalTo(KFit_W6S(56));
    }];
    
    
}

- (void)setModel:(PPPersonModel *)model{
    _model = model;
    self.name.text = model.name;
    self.pho.text = [model.mobileArray firstObject];
}
@end
