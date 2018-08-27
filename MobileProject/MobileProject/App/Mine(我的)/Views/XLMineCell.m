//
//  XLMineCell.m
//  MobileProject
//
//  Created by zsgy on 2018/6/5.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import "XLMineCell.h"

@implementation XLMineCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
     if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
         
         [self loadsubview];
    }
    return self;
}

- (void)loadsubview{
    _img = [[UIImageView alloc] init];
    [self.contentView addSubview:_img];
    
    _title = [[UILabel alloc] init];
    [self.contentView addSubview:_title];
    
    _subtitle = [[UILabel alloc] init];
    _subtitle.textAlignment = NSTextAlignmentRight;
    _subtitle.textColor = kColor_N(175, 175, 175);
    _subtitle.font = [UIFont systemFontOfSize:kFit_Font6(15)];
    [self.contentView addSubview:_subtitle];
}


//该方法视图加载的时候调用
- (void)layoutSubviews{
    [_img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView).mas_offset(KFit_W6S(30));
        make.centerY.mas_equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(KFit_W6S(36), KFit_W6S(36)));
    }];
    
    [_subtitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView).mas_offset(-KFit_W6S(35));
        make.centerY.mas_equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(KFit_W6S(150), KFit_W6S(39)));
    }];
    
    [_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_img.mas_right).mas_offset(KFit_W6S(30));
        make.right.mas_equalTo(_subtitle.mas_left).mas_offset(-KFit_W6S(20));
        make.centerY.mas_equalTo(self.contentView);
        make.height.mas_equalTo(self.contentView);
    }];
}

- (void)setModel:(MineModel *)model{
    _model = model;
    _subtitle.text = model.subtitle;
    _title.text = model.title;
    [_img setImage:[UIImage imageNamed:model.img]];
}
@end
