//
//  TimeSetCell.m
//  MobileProject
//
//  Created by 向蕾 on 2018/10/19.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import "TimeSetCell.h"

@implementation TimeSetCell

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
    self.time = [[UILabel alloc] init];
    [self.contentView addSubview:self.time];
    self.time.text = @"08:00-20:00";
    [self.time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView).mas_offset(KFit_W6S(30));
        make.top.bottom.mas_equalTo(self.contentView);
        make.width.mas_equalTo(KFit_W6S(200));
    }];
    self.typeOne = [[UILabel alloc] init];
    [self.contentView addSubview:self.typeOne];
    self.typeOne.text = @"科二";
    self.typeOne.textAlignment = NSTextAlignmentCenter;
    self.typeOne.layer.borderWidth = 0.5;
    self.typeOne.textColor = kColor_N(0, 121, 236);
    self.typeOne.font = [UIFont systemFontOfSize:kFit_Font6(13)];
    self.typeOne.layer.borderColor = kColor_N(0, 121, 236).CGColor;
    [self.typeOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.time.mas_right).mas_offset(KFit_W6S(20));
        make.centerY.mas_equalTo(self.contentView);
        make.width.mas_equalTo(KFit_W6S(100));
        make.height.mas_equalTo(KFit_W6S(40));
    }];
    
    self.typeTwo = [[UILabel alloc] init];
    [self.contentView addSubview:self.typeTwo];
    self.typeTwo.text = @"C1";
    self.typeTwo.textAlignment = NSTextAlignmentCenter;
    self.typeTwo.layer.borderWidth = 0.5;
    self.typeTwo.textColor = kColor_N(255, 134, 7);
    self.typeTwo.font = [UIFont systemFontOfSize:kFit_Font6(13)];
    self.typeTwo.layer.borderColor = kColor_N(255, 134, 7).CGColor;
    [self.typeTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.typeOne.mas_right).mas_offset(KFit_W6S(20));
        make.centerY.mas_equalTo(self.contentView);
        make.width.mas_equalTo(KFit_W6S(100));
        make.height.mas_equalTo(KFit_W6S(40));
    }];
    
    self.deleteBut = [[UIButton alloc] init];
    [self.contentView addSubview:self.deleteBut];
    [self.deleteBut setImage:[UIImage imageNamed:@"bianj_copy"] forState:UIControlStateNormal];
    [self.deleteBut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView).mas_offset(-KFit_W6S(30));
        make.centerY.mas_equalTo(self.contentView);
        make.width.height.mas_equalTo(KFit_W6S(56));
    }];
    
    self.editor = [[UIButton alloc] init];
    [self.contentView addSubview:self.editor];
    [self.editor setImage:[UIImage imageNamed:@"bianj"] forState:UIControlStateNormal];
    [self.editor mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.deleteBut.mas_left).mas_offset(-KFit_W6S(20));
        make.centerY.mas_equalTo(self.contentView);
        make.width.height.mas_equalTo(KFit_W6S(56));
    }];
    
    UILabel *lb = [[UILabel alloc] init];
    [self.contentView addSubview:lb];
    lb.backgroundColor = kColor_N(240, 240, 240);
    [lb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.contentView);
        make.height.mas_equalTo(1);
    }];
}

- (void)setModel:(FMMainModel *)model{
    _model = model;
    XLCache *cache = [XLCache singleton];
    self.time.text = [NSString stringWithFormat:@"%@-%@",[XLCommonUse TimeToInterceptHHmm:model.startTime],[XLCommonUse TimeToInterceptHHmm:model.endTime]];
    self.typeOne.text = model.keMu;
    self.typeTwo.text =[NSString stringWithFormat:@"%@",cache.student_license_type_title[[cache.student_license_type_value indexOfObject:_model.licenseType]]];
}
@end
