//
//  MyNewsCell.m
//  MobileProject
//
//  Created by 向蕾 on 2018/8/21.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import "MyNewsCell.h"

@implementation MyNewsCell

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
    self.img = [[UIImageView alloc] init];
    [self.contentView addSubview:self.img];
    [self.img setImage:[UIImage imageNamed:@"news_ask_nor"]];
    [self.img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView).mas_offset(KFit_W6S(30));
        make.top.mas_equalTo(self.contentView).mas_offset(KFit_H6S(40));
        make.width.height.mas_equalTo(KFit_W6S(90));
    }];
    
    self.read = [[UILabel alloc] init];
    [self.img addSubview:self.read];
    self.read.hidden = YES;
    [self.read mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.mas_equalTo(self.img);
        make.width.height.mas_equalTo(KFit_W6S(18));
    }];
    self.read.backgroundColor = [UIColor redColor];
    self.read.layer.cornerRadius = KFit_W6S(9);
    self.read.layer.masksToBounds = YES;
    
    self.title = [[UILabel alloc] init];
    [self.contentView addSubview:self.title];
    self.title.text = @"一条消息";
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.img);
        make.left.mas_equalTo(self.img.mas_right).mas_offset(KFit_W6S(30));
        make.right.mas_equalTo(self.contentView).mas_offset(-KFit_W6S(30));
        make.height.mas_equalTo(KFit_H6S(40));
    }];
    
    
    self.content = [[UILabel alloc] init];
    [self.contentView addSubview:self.content];
    self.content.text = @"一条消息一条消息一条消息一条消息一条消息一条消息一条消息一条消息一条消息一条消息一条消息";
    self.content.numberOfLines = 0;
    self.content.textColor = kColor_N(64, 75, 105);
    self.content.font = [UIFont systemFontOfSize:kFit_Font6(14)];
    [self.content mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.title.mas_bottom).mas_offset(KFit_H6S(30));
        make.left.right.mas_equalTo(self.title);
//        make.height.mas_equalTo(KFit_H6S(40));
    }];
    
    
    self.time = [[UILabel alloc] init];
    [self.contentView addSubview:self.time];
    self.time.text = @"08-12 12:23";
    self.time.textColor = kColor_N(149, 160, 182);
    self.time.font = [UIFont systemFontOfSize:kFit_Font6(12)];
    [self.time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.content.mas_bottom).mas_offset(KFit_H6S(30));
        make.left.right.mas_equalTo(self.title);
        //        make.height.mas_equalTo(KFit_H6S(40));
    }];
    
    UILabel *lb = [[UILabel alloc] init];
    [self.contentView addSubview:lb];
    lb.backgroundColor = kColor_N(240, 240, 240);
    [lb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.time.mas_bottom).mas_offset(KFit_H6S(30));
        make.left.mas_equalTo(self.contentView).mas_offset(KFit_W6S(30));
        make.right.mas_equalTo(self.contentView).mas_offset(-KFit_W6S(30));
        make.height.mas_equalTo(kFit_Font6(1));
    }];
}


- (void)setModel:(FMMainModel *)model{
    _model = model;
    self.title.text = _model.title;
    self.content.text = _model.content;
    self.time.text = [XLCommonUse TimeToInterceptMMddHHmm:_model.createTime];
    if (_model.isRead) {
        self.read.hidden = YES;
    }else{
        self.read.hidden = NO;
    }
}





@end
