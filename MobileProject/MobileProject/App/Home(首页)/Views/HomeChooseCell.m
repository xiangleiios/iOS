//
//  HomeChooseCell.m
//  MobileProject
//
//  Created by zsgy on 2018/6/6.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import "HomeChooseCell.h"

@implementation HomeChooseCell

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
    _title.font = [UIFont systemFontOfSize:kFit_Font6(16)];
    [self.contentView addSubview:_title];
    
    _subtitle = [[UILabel alloc] init];
    _subtitle.textAlignment = NSTextAlignmentRight;
    _subtitle.font = [UIFont systemFontOfSize:kFit_Font6(14)];
    [self.contentView addSubview:_subtitle];
    
    _img_arrow = [[UIImageView alloc] init];
    [_img_arrow setImage:[UIImage imageNamed:@"ret"]];
    [self.contentView addSubview:_img_arrow];
    
    UILabel *lb = [[UILabel alloc] init];
    lb.backgroundColor = [UIColor colorWithWhite:240/255.0 alpha:1];
    [self.contentView addSubview:lb];
    [lb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.contentView);
        make.height.mas_equalTo(kFit_Font6(1));
    }];
}


//该方法视图加载的时候调用
- (void)layoutSubviews{
    [_img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView).mas_offset(KFit_W6S(20));
        make.centerY.mas_equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(KFit_W6S(40), KFit_W6S(40)));
    }];
    
    [_img_arrow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView).mas_offset(-KFit_W6S(20));
        make.centerY.mas_equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(KFit_W6S(14), KFit_W6S(26)));
    }];
    
    [_subtitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(_img_arrow.mas_left).mas_offset(-KFit_W6S(20));
        make.centerY.mas_equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(KFit_W6S(250), KFit_W6S(39)));
    }];
    
    [_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_img.mas_right).mas_offset(KFit_W6S(20));
        make.right.mas_equalTo(_subtitle.mas_left).mas_offset(-KFit_W6S(20));
        make.centerY.mas_equalTo(self.contentView);
        make.height.mas_equalTo(KFit_H6S(80));
    }];
}

- (void)setModel:(MineModel *)model{
    _model = model;
    _subtitle.text = model.subtitle;
    _title.text = model.title;
    [_img setImage:[UIImage imageNamed:model.img]];
}

@end
