//
//  InvitedRecordCell.m
//  MobileProject
//
//  Created by 向蕾 on 2018/11/22.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import "InvitedRecordCell.h"

@implementation InvitedRecordCell

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
    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView).mas_offset(KFit_W6S(30));
        make.centerY.mas_equalTo(self.contentView);
        make.height.mas_equalTo(KFit_H6S(50));
    }];
    
    self.pho = [[UILabel alloc] init];
    [self.contentView addSubview:self.pho];
    [self.pho mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.name.mas_right).mas_offset(KFit_W6S(30));
        make.centerY.mas_equalTo(self.contentView);
        make.height.mas_equalTo(KFit_H6S(50));
    }];
    
    self.time = [[UILabel alloc] init];
    self.time.textAlignment = NSTextAlignmentRight;
    self.time.textColor = ZTColor;
    [self.contentView addSubview:self.time];
    self.time.font = [UIFont systemFontOfSize:kFit_Font6(15)];
    [self.time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView).mas_offset(-KFit_W6S(30));
        make.centerY.mas_equalTo(self.contentView);
        make.height.mas_equalTo(KFit_H6S(50));
    }];
    
    UILabel *line = [[UILabel alloc] init];
    [self.contentView addSubview:line];
    line.backgroundColor = kColor_N(240, 240, 240);
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.contentView);
        make.height.mas_equalTo(kFit_Font6(1));
    }];
}

- (void)setModel:(FMMainModel *)model{
    self.pho.text = [NSString fm_hiddenMiddleNumOfPhoneNum:model.coachPhone];
    self.name.text = [NSString stringWithFormat:@"%@**",[model.coachName substringToIndex:1]];
    self.time.text = [NSString stringWithFormat:@"提交时间:%@",model.createTime];
}
@end
