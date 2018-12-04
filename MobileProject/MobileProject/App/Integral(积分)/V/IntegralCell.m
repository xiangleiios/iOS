//
//  IntegralCell.m
//  MobileProject
//
//  Created by 向蕾 on 2018/11/21.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import "IntegralCell.h"

@implementation IntegralCell

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
    self.title = [[UILabel alloc] init];
    [self.contentView addSubview:self.title];
    self.title.font = [UIFont systemFontOfSize:kFit_Font6(16)];
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView).mas_offset(KFit_W6S(30));
        make.centerY.mas_equalTo(self.contentView).mas_offset(-KFit_H6S(25));
        make.height.mas_equalTo(KFit_H6S(30));
        make.width.mas_equalTo(KFit_W6S(410));
    }];
    
    self.time = [[UILabel alloc] init];
    [self.contentView addSubview:self.time];
    self.time.font = [UIFont systemFontOfSize:kFit_Font6(13)];
    self.time.textColor = ZTColor;
    [self.time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.title);
        make.centerY.mas_equalTo(self.contentView).mas_offset(KFit_H6S(25));
        make.height.mas_equalTo(KFit_H6S(30));
    }];
    
    self.fen = [[UILabel alloc] init];
    [self.contentView addSubview:self.fen];
    self.fen.font = [UIFont systemFontOfSize:kFit_Font6(13)];
    self.fen.textAlignment = NSTextAlignmentRight;
    [self.fen mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView).mas_offset(-KFit_W6S(30));
        make.centerY.mas_equalTo(self.contentView).mas_offset(-KFit_H6S(25));
        make.height.mas_equalTo(KFit_H6S(30));
        make.width.mas_equalTo(KFit_W6S(110));
    }];
    UILabel *line = [[UILabel alloc] init];
    [self.contentView addSubview:line];
    line.backgroundColor = kColor_N(240, 240, 240);
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.title);
        make.right.mas_equalTo(self.fen);
        make.bottom.mas_equalTo(self.contentView);
        make.height.mas_equalTo(kFit_Font6(1));
    }];
    
}

- (void)setModel:(FMIntegralModel *)model{
    self.title.text = model.scoreName;
    self.time.text = model.dateTime;
    if ([model.score intValue] > 0) {
        self.fen.text = [NSString stringWithFormat:@"+%@",model.score];
        self.fen.textColor = kColor_N(49, 187, 75);
    }else{
        
        self.fen.text = model.score;
        self.fen.textColor = [UIColor redColor];
    }
}
@end
