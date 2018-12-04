//
//  ExamStudentsCell.m
//  MobileProject
//
//  Created by 向蕾 on 2018/10/18.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import "ExamStudentsCell.h"

@implementation ExamStudentsCell

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
    UIImageView *img = [[UIImageView alloc] init];
    [self.contentView addSubview:img];
    [img setImage:[UIImage imageNamed:@"head_nor"]];
    [img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView).mas_offset(KFit_W6S(30));
        make.centerY.mas_equalTo(self.contentView);
        make.width.height.mas_equalTo(KFit_W6S(80));
    }];
    
    self.title = [[UILabel alloc] init];
    self.title.text = @"丽丽";
    self.title.font = [UIFont systemFontOfSize:kFit_Font6(16)];
    [self.contentView addSubview:self.title];
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(img.mas_right).mas_offset(KFit_W6S(30));
        make.centerY.mas_equalTo(self.contentView).mas_offset(-KFit_H6S(25));
        make.height.mas_equalTo(KFit_H6S(40));
    }];
    
    self.type = [[UILabel alloc] init];
    [self.contentView addSubview:self.type];
    self.type.layer.borderWidth = 0.3;
    self.type.layer.cornerRadius = 3;
    self.type.font = [UIFont systemFontOfSize:kFit_Font6(13)];
    self.type.textAlignment = NSTextAlignmentCenter;
    
    [self.type mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(img.mas_right).mas_offset(KFit_W6S(30));
        make.centerY.mas_equalTo(self.contentView).mas_offset(KFit_H6S(25));
        make.size.mas_equalTo(CGSizeMake(KFit_W6S(160), KFit_H6S(40)));
    }];
    
    self.typeOne = [[UILabel alloc] init];
    [self.contentView addSubview:self.typeOne];
        self.typeOne.layer.borderWidth = 0.3;
        self.typeOne.layer.borderColor = kColor_N(0, 110, 230).CGColor;
        self.typeOne.layer.cornerRadius = 3;
        self.typeOne.textColor = kColor_N(0, 110, 230);
        self.typeOne.font = [UIFont systemFontOfSize:kFit_Font6(11)];
        self.typeOne.textAlignment = NSTextAlignmentCenter;
        self.typeOne.text = @"已收费";
    [self.typeOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.type.mas_right).mas_offset(KFit_W6S(10));
        make.centerY.mas_equalTo(self.contentView).mas_offset(KFit_H6S(25));
        make.size.mas_equalTo(CGSizeMake(KFit_W6S(130), KFit_H6S(40)));
    }];
    
    self.typeTwo = [[UILabel alloc] init];
    [self.contentView addSubview:self.typeTwo];
    self.typeTwo.layer.borderWidth = 0.3;
    self.typeTwo.layer.borderColor = kColor_N(0, 110, 230).CGColor;
    self.typeTwo.layer.cornerRadius = 3;
    self.typeTwo.textColor = kColor_N(0, 110, 230);
    self.typeTwo.font = [UIFont systemFontOfSize:kFit_Font6(11)];
    self.typeTwo.textAlignment = NSTextAlignmentCenter;
    self.typeTwo.text = @"明安驾校";
    [self.typeTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.typeOne.mas_right).mas_offset(KFit_W6S(10));
        make.centerY.mas_equalTo(self.typeOne);
        make.size.mas_equalTo(CGSizeMake(KFit_W6S(130), KFit_H6S(40)));
    }];
    
    self.typeThree = [[UILabel alloc] init];
    [self.contentView addSubview:self.typeThree];
    self.typeThree.layer.borderWidth = 0.3;
    self.typeThree.layer.borderColor = kColor_N(0, 110, 230).CGColor;
    self.typeThree.layer.cornerRadius = 3;
    self.typeThree.textColor = kColor_N(0, 110, 230);
    self.typeThree.font = [UIFont systemFontOfSize:kFit_Font6(11)];
    self.typeThree.textAlignment = NSTextAlignmentCenter;
    self.typeThree.text = @"已收费";
    [self.typeThree mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.typeTwo.mas_right).mas_offset(KFit_W6S(10));
        make.centerY.mas_equalTo(self.typeTwo);
        make.size.mas_equalTo(CGSizeMake(KFit_W6S(130), KFit_H6S(40)));
    }];
    
    self.typeFour = [[UILabel alloc] init];
    [self.contentView addSubview:self.typeFour];
    self.typeFour.layer.cornerRadius = 3;
    self.typeFour.layer.masksToBounds = YES;
    self.typeFour.textColor = [UIColor whiteColor];
    self.typeFour.font = [UIFont systemFontOfSize:kFit_Font6(12)];
    self.typeFour.textAlignment = NSTextAlignmentCenter;
    self.typeFour.backgroundColor = [UIColor redColor];
    self.typeFour.text = @"补考2次";
    [self.typeFour mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.title.mas_right).mas_offset(KFit_W6S(30));
        make.centerY.mas_equalTo(self.title);
        make.size.mas_equalTo(CGSizeMake(KFit_W6S(110), KFit_H6S(40)));
    }];
    
    
    self.state = [[UIButton alloc] init];
    [self.contentView addSubview:self.state];
    [self.state setTitle:@"科一 ▾" forState:UIControlStateNormal];
    [self.state setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.state.titleLabel.font = [UIFont systemFontOfSize:kFit_Font6(16)];
    [self.state mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.title);
        make.right.mas_equalTo(self.contentView).mas_offset(-KFit_W6S(30));
        make.size.mas_equalTo(CGSizeMake(KFit_W6S(110), KFit_H6S(40)));
    }];
    
    
    UIButton *but = [[UIButton alloc] init];
    [but setImage:[UIImage imageNamed:@"phone_bule"] forState:UIControlStateNormal];
    [self.contentView addSubview:but];
    [but addTarget:self action:@selector(dianhua) forControlEvents:UIControlEventTouchUpInside];
    [but mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.title);
        make.right.mas_equalTo(self.state.mas_left);
        make.width.height.mas_equalTo(KFit_W6S(70));
    }];
    
    UILabel *lb = [[UILabel alloc] init];
    [self.contentView addSubview:lb];
    lb.backgroundColor = kColor_N(240, 240, 240);
    [lb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.mas_equalTo(self.contentView);
        make.height.mas_equalTo(1);
    }];
}
- (void)dianhua{
    if (_model.student[@"studentPhone"]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"telprompt:%@",_model.student[@"studentPhone"]]]];
    }
}
- (void)setModel:(FMMainModel *)model{
    _model = model;
    self.title.text = model.student[@"studentName"];
    NSArray *arr;
    if (model.stuTags.length > 0) {
        arr = [model.stuTags componentsSeparatedByString:@","];
    }
    
    KKLog(@"%d",_model.failNum);
    if (_model.failNum > 0) {
        self.typeFour.text = [NSString stringWithFormat:@"补考%d次",_model.failNum];
        self.typeFour.hidden = NO;
    }else{
        self.typeFour.hidden = YES;
    }
    if (_model.coachName) {
        self.type.text = _model.coachName;
        if (model.coachStatus) {
            self.type.textColor = kColor_N(204, 209, 218);
            self.type.layer.borderColor = kColor_N(204, 209, 218).CGColor;
        }else{
            self.type.textColor = kColor_N(255, 132, 30);
            self.type.layer.borderColor = kColor_N(255, 132, 30).CGColor;
        }
        
    }else{
        self.type.text = @"分校";
        self.type.textColor = kColor_N(255, 132, 30);
        self.type.layer.borderColor = kColor_N(255, 132, 30).CGColor;
        
    }
    if (arr.count == 0) {
        self.typeOne.hidden =YES;
        self.typeTwo.hidden = YES;
        self.typeThree.hidden = YES;
    }else if (arr.count == 1){
        self.typeOne.text = arr[0];
        self.typeOne.hidden =NO;
        self.typeTwo.hidden = YES;
        self.typeThree.hidden = YES;
    }else if (arr.count == 2){
        self.typeOne.text = arr[0];
        self.typeTwo.text = arr[1];
        self.typeOne.hidden =NO;
        self.typeTwo.hidden =NO;
        self.typeThree.hidden = YES;
    }else if (arr.count >=3){
        self.typeOne.text = arr[0];
        self.typeTwo.text = arr[1];
        self.typeThree.text = arr[2];
        self.typeOne.hidden =NO;
        self.typeTwo.hidden =NO;
        self.typeThree.hidden = NO;
    }
    switch (model.progress) {
        case 1:
            [self.state setTitle:@"科一 ▾" forState:UIControlStateNormal];
            break;
        case 2:
            [self.state setTitle:@"科二 ▾" forState:UIControlStateNormal];
            break;
        case 3:
            [self.state setTitle:@"科三 ▾" forState:UIControlStateNormal];
            break;
        case 4:
            [self.state setTitle:@"科四 ▾" forState:UIControlStateNormal];
            break;
        case 5:
            [self.state setTitle:@"拿证 ▾" forState:UIControlStateNormal];
            break;
        case 6:
            [self.state setTitle:@"作废 ▾" forState:UIControlStateNormal];
            break;
            
        default:
            break;
    }
}

@end
