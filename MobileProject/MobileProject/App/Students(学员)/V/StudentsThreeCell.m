//
//  StudentsThreeCell.m
//  MobileProject
//
//  Created by 向蕾 on 2018/8/28.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import "StudentsThreeCell.h"
#import "XLCache.h"
@implementation StudentsThreeCell

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
    
    self.selelctBut = [[UIButton alloc] init];
    [self.contentView addSubview:self.selelctBut];
    [self.selelctBut setImage:[UIImage imageNamed:@"nor_button"] forState:UIControlStateNormal];
    [self.selelctBut setImage:[UIImage imageNamed:@"down_button"] forState:UIControlStateSelected];
    [self.selelctBut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView).mas_offset(KFit_W6S(27));
        make.centerY.mas_equalTo(self.contentView);
        make.width.height.mas_equalTo(KFit_W6S(56));
    }];
    
    
    UIImageView * img = [[UIImageView alloc] init];
    [self.contentView addSubview:img];
    [img setImage:[UIImage imageNamed:@"head_nor"]];
    [img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.selelctBut.mas_right).mas_offset(KFit_W6S(30));
        make.centerY.mas_equalTo(self.contentView);
        make.width.height.mas_equalTo(KFit_W6S(80));
    }];
    
    self.title = [[UILabel alloc] init];
    self.title.text = @"丽丽  13333333333";
    self.title.font = [UIFont systemFontOfSize:kFit_Font6(16)];
    [self.contentView addSubview:self.title];
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(img.mas_right).mas_offset(KFit_W6S(30));
        make.centerY.mas_equalTo(self.contentView).mas_offset(-KFit_H6S(25));
        make.size.mas_equalTo(CGSizeMake(KFit_W6S(350), KFit_H6S(40)));
    }];
    
    self.typeone = [[UILabel alloc] init];
    [self.contentView addSubview:self.typeone];
    self.typeone.layer.borderWidth = 0.3;
    self.typeone.layer.borderColor = kColor_N(0, 110, 230).CGColor;
    self.typeone.layer.cornerRadius = 3;
    self.typeone.textColor = kColor_N(0, 110, 230);
    self.typeone.font = [UIFont systemFontOfSize:kFit_Font6(12)];
    self.typeone.textAlignment = NSTextAlignmentCenter;
    self.typeone.text = @"已收费";
    [self.typeone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(img.mas_right).mas_offset(KFit_W6S(30));
        make.centerY.mas_equalTo(self.contentView).mas_offset(KFit_H6S(25));
        make.size.mas_equalTo(CGSizeMake(KFit_W6S(110), KFit_H6S(40)));
    }];
    
    self.typetwo = [[UILabel alloc] init];
    [self.contentView addSubview:self.typetwo];
    self.typetwo.layer.borderWidth = 0.3;
    self.typetwo.layer.borderColor = kColor_N(0, 110, 230).CGColor;
    self.typetwo.layer.cornerRadius = 3;
    self.typetwo.textColor = kColor_N(0, 110, 230);
    self.typetwo.font = [UIFont systemFontOfSize:kFit_Font6(12)];
    self.typetwo.textAlignment = NSTextAlignmentCenter;
    self.typetwo.text = @"明安驾校";
    [self.typetwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.typeone.mas_right).mas_offset(KFit_W6S(10));
        make.centerY.mas_equalTo(self.typeone);
        make.size.mas_equalTo(CGSizeMake(KFit_W6S(110), KFit_H6S(40)));
    }];
    
    self.typethree = [[UILabel alloc] init];
    [self.contentView addSubview:self.typethree];
    self.typethree.layer.borderWidth = 0.3;
    self.typethree.layer.borderColor = kColor_N(0, 110, 230).CGColor;
    self.typethree.layer.cornerRadius = 3;
    self.typethree.textColor = kColor_N(0, 110, 230);
    self.typethree.font = [UIFont systemFontOfSize:kFit_Font6(12)];
    self.typethree.textAlignment = NSTextAlignmentCenter;
    self.typethree.text = @"已收费";
    [self.typethree mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.typetwo.mas_right).mas_offset(KFit_W6S(10));
        make.centerY.mas_equalTo(self.typetwo);
        make.size.mas_equalTo(CGSizeMake(KFit_W6S(110), KFit_H6S(40)));
    }];
    
    self.typefour = [[UILabel alloc] init];
    [self.contentView addSubview:self.typefour];
    self.typefour.layer.cornerRadius = 3;
    self.typefour.layer.masksToBounds = YES;
    self.typefour.textColor = [UIColor whiteColor];
    self.typefour.font = [UIFont systemFontOfSize:kFit_Font6(15)];
    self.typefour.textAlignment = NSTextAlignmentCenter;
    self.typefour.backgroundColor = [UIColor redColor];
    self.typefour.text = @"未提交";
    [self.typefour mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView).mas_offset(-KFit_W6S(30));
        make.centerY.mas_equalTo(self.title);
        make.size.mas_equalTo(CGSizeMake(KFit_W6S(110), KFit_H6S(40)));
    }];
    
    UILabel *lb = [[UILabel alloc] init];
    [self.contentView addSubview:lb];
    lb.backgroundColor = kColor_N(240, 240, 240);
    [lb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.mas_equalTo(self.contentView);
        make.height.mas_equalTo(1);
    }];
    
}


- (void)setModel:(FMMainModel *)model{
    _model = model;
    
    XLCache *cache = [XLCache singleton];
    self.title.text = [NSString stringWithFormat:@"%@ %@",model.studentName,model.studentPhone];
    self.typetwo.text = [NSString stringWithFormat:@"%@", cache.teamCode_title[[cache.teamCode_value indexOfObject:_model.teamCode]]];
    self.typethree.text = [NSString stringWithFormat:@"%@",cache.student_license_type_title[[cache.student_license_type_value indexOfObject:_model.carType]]];
    //1 报名到总校，2、未报名到总校
    if ([model.signupState  isEqual: @"1"]) {
        // 1 未审核，2、审核通过、3、拒绝
        if ([model.auditState  isEqual:@"1"]) {
            self.typefour.backgroundColor = kColor_N(248, 167, 53);
            self.typefour.text = @"审核中";
            self.selelctBut.hidden = YES;
        }else if ([model.auditState  isEqual:@"2"]){
            self.typefour.backgroundColor = kColor_N(0, 194, 154);
            self.typefour.text = @"通过";
            self.selelctBut.hidden = YES;
        }else if ([model.auditState  isEqual:@"3"]){
            self.typefour.backgroundColor = kColor_N(148, 159, 181);
            self.typefour.text = @"未通过";
            self.selelctBut.hidden = NO;
        }
    }else{
        self.typefour.backgroundColor = [UIColor redColor];
        self.typefour.text = @"未提交";
        self.selelctBut.hidden = NO;
    }
    
    
}





@end
