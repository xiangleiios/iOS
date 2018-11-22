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
    UIImageView *imgone = [[UIImageView alloc] init];
    self.img = imgone;
    [self addSubview:imgone];
//    [imgone setImage:[UIImage imageNamed:img]];
    [imgone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).mas_offset(KFit_W6S(50));
        make.centerY.mas_equalTo(self);
        make.height.width.mas_equalTo(KFit_H6S(100));
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
    
    UILabel *titleLable = [[UILabel alloc] init];
    [self addSubview:titleLable];
    self.title = titleLable;
//    titleLable.text = title;
    titleLable.font = [UIFont systemFontOfSize:kFit_Font6(16)];
    [titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(imgone.mas_right).mas_offset(KFit_W6S(30));
        make.centerY.mas_equalTo(self);
        make.height.mas_equalTo(KFit_H6S(40));
        make.right.mas_equalTo(imgtwo.mas_left).mas_offset(-KFit_W6S(20));
    }];
    
    UILabel *subtitleLable = [[UILabel alloc] init];
    [self addSubview:subtitleLable];
    self.subtitle = subtitleLable;
    self.subtitle.textColor = ZTColor;
//    subtitleLable.text = subtitle;
    subtitleLable.font = [UIFont systemFontOfSize:kFit_Font6(16)];
    //        subtitleLable.textColor = kColor_N(183, 190, 205);
    subtitleLable.textAlignment = NSTextAlignmentRight;
    [subtitleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(imgtwo.mas_left).mas_offset(-KFit_W6S(20));
        make.centerY.mas_equalTo(self);
        make.height.mas_equalTo(KFit_H6S(40));
        make.right.mas_equalTo(imgtwo.mas_left).mas_offset(-KFit_W6S(20));
    }];
}


////该方法视图加载的时候调用
//- (void)layoutSubviews{
//    [_img mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(self.contentView).mas_offset(KFit_W6S(30));
//        make.centerY.mas_equalTo(self.contentView);
//        make.size.mas_equalTo(CGSizeMake(KFit_W6S(36), KFit_W6S(36)));
//    }];
//
//    [_subtitle mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.mas_equalTo(self.contentView).mas_offset(-KFit_W6S(35));
//        make.centerY.mas_equalTo(self.contentView);
//        make.size.mas_equalTo(CGSizeMake(KFit_W6S(150), KFit_W6S(39)));
//    }];
//
//    [_title mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(_img.mas_right).mas_offset(KFit_W6S(30));
//        make.right.mas_equalTo(_subtitle.mas_left).mas_offset(-KFit_W6S(20));
//        make.centerY.mas_equalTo(self.contentView);
//        make.height.mas_equalTo(self.contentView);
//    }];
//}
//
//- (void)setModel:(MineModel *)model{
//    _model = model;
//    _subtitle.text = model.subtitle;
//    _title.text = model.title;
//    [_img setImage:[UIImage imageNamed:model.img]];
//}
@end
