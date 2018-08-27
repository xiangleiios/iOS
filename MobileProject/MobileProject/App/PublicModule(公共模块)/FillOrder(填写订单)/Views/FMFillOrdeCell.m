//
//  FMFillOrdeCell.m
//  MobileProject
//
//  Created by Mingo on 2017/11/2.
//  Copyright © 2017年 ZSGY. All rights reserved.
//

#import "FMFillOrdeCell.h"
#define padding KFit_W6S(20)

@implementation FMFillOrdeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    
    self.back = [[UIView alloc] init];
    [self.contentView addSubview:_back];
    _back.layer.cornerRadius = kFit_Font6(4);
    _back.clipsToBounds = YES;
    
    self.yfTitle = [UILabel fm_initUIlabelWithTextColor:kMainTitleColor backColor:nil textAlignment_Left0_Center1_Right2:0 font:16 cornerRadius:0 addToSuperView:_back title:@" "];
    
    self.yfMoney = [UILabel fm_initUIlabelWithTextColor:kMianRed backColor:nil textAlignment_Left0_Center1_Right2:2 font:22 cornerRadius:0 addToSuperView:_back title:@"￥10"];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [_back mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.with.offset(padding);
        make.right.with.offset(-padding);
        make.bottom.with.offset(-padding/2);
        make.top.with.offset(padding/2);
    }];
    
    [_yfMoney mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(_back);
        make.right.with.offset(-kFit_Font6(10));
        make.width.mas_equalTo(KFit_W6S(220));
    }];
    
    [_yfTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.top.mas_equalTo(_back);
        make.left.with.offset(padding);
        make.right.mas_equalTo(_yfMoney.mas_left).with.offset(-kFit_Font6(10));
    }];
}

-(void)setModel:(FMSubmodel *)model {
    _model = model;
    [_yfTitle setText:model.name];
    if (model.price == 0) {
        [_yfMoney setText:[NSString stringWithFormat:@"免费"]];
    }else{
        [_yfMoney setText:[NSString stringWithFormat:@"￥%.2lf",model.price]];
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    if (selected) {
        self.back.backgroundColor = kRGBColor(253, 208, 86);
        [self.yfTitle setTextColor:kMianRed];
    }else{
        self.back.backgroundColor = kRGBColor(242, 243, 244);
        [self.yfTitle setTextColor:kMainTitleColor];
    }

}


-(void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    [super setHighlighted:highlighted animated:animated];
    
    if (highlighted) {
        _back.backgroundColor = kRGBColor(253, 208, 86);
        [_yfTitle setTextColor:kMianRed];
    }else{
        _back.backgroundColor = kRGBColor(242, 243, 244);
        [_yfTitle setTextColor:kMainTitleColor];
    }
}

@end
