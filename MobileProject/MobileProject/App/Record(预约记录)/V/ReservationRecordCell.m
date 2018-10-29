//
//  ReservationRecordCell.m
//  MobileProject
//
//  Created by 向蕾 on 2018/10/22.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import "ReservationRecordCell.h"

@implementation ReservationRecordCell

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
    UILabel *lblineOne = [[UILabel alloc] init];
    [self.contentView addSubview:lblineOne];
    lblineOne.backgroundColor = kColor_N(240, 240, 240);
    [lblineOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(self.contentView);
        make.height.mas_equalTo(KFit_H6S(20));
    }];
    
    self.time = [[UILabel alloc] init];
    [self.contentView addSubview:self.time];
    self.time.textColor = kColor_N(181, 188, 204);
    self.time.text = @"2018-10-1 10:21";
    [self.time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView).mas_offset(KFit_W6S(30));
        make.top.mas_equalTo(lblineOne.mas_bottom);
        make.height.mas_equalTo(KFit_H6S(60));
        make.width.mas_equalTo(KFit_W6S(300));
    }];
    
    self.typeOne = [[UILabel alloc] init];
    [self.contentView addSubview:self.typeOne];
    self.typeOne.textColor = kColor_N(184, 191, 205);
    self.typeOne.text = @"等待练车";
    self.typeOne.textAlignment = NSTextAlignmentRight;
    [self.typeOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView).mas_offset(-KFit_W6S(30));
        make.top.mas_equalTo(lblineOne.mas_bottom);
        make.height.mas_equalTo(KFit_H6S(60));
        make.width.mas_equalTo(KFit_W6S(150));
    }];
    
    UILabel *lineTwo = [[UILabel alloc] init];
    [self.contentView addSubview:lineTwo];
    lineTwo.backgroundColor = kColor_N(240, 240, 240);
    [lineTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.contentView);
        make.top.mas_equalTo(self.time.mas_bottom);
        make.height.mas_equalTo(1);
    }];
    
    UIImageView *img = [[UIImageView alloc] init];
    self.tx = img;
//    [img setImage:[UIImage imageNamed:@"head_nor"]];
    img.layer.cornerRadius = KFit_H6S(40);
    img.layer.masksToBounds = YES;
    [self.contentView addSubview:img];
    [img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView).mas_offset(KFit_W6S(30));
        make.top.mas_equalTo(lineTwo.mas_bottom).mas_offset(KFit_H6S(30));
        make.width.height.mas_equalTo(KFit_W6S(80));
    }];
    
    self.redlb = [[UILabel alloc] init];
    [self.contentView addSubview:self.redlb];
    self.redlb.layer.cornerRadius = KFit_W6S(7);
    self.redlb.layer.masksToBounds = YES;
    self.redlb.hidden = YES;
    self.redlb.backgroundColor = [UIColor redColor];
    [self.redlb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(img);
        make.width.height.mas_equalTo(KFit_W6S(14));
    }];
    
    
    self.name = [[UILabel alloc] init];
    self.name.text = @"向蕾";
    [self.contentView addSubview:self.name];
    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(img).mas_offset(-KFit_H6S(20));
        make.left.mas_equalTo(img.mas_right).mas_offset(20);
        make.height.mas_equalTo(KFit_H6S(30));
    }];
    self.pho = [[UILabel alloc] init];
    self.pho.text = @"13131313132";
    [self.contentView addSubview:self.pho];
    [self.pho mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.name);
        make.left.mas_equalTo(self.name.mas_right).mas_offset(20);
        make.height.mas_equalTo(KFit_H6S(30));
    }];
    
    self.timeCar = [[UILabel alloc] init];
    self.timeCar.text = @"10-25 (周五) 10:00-12:11";
    self.timeCar.textColor = ZTColor;
    self.timeCar.font = [UIFont systemFontOfSize:kFit_Font6(14)];
    [self.contentView addSubview:self.timeCar];
    [self.timeCar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(img).mas_offset(KFit_H6S(25));
        make.left.mas_equalTo(img.mas_right).mas_offset(20);
        make.height.mas_equalTo(KFit_H6S(30));
    }];
    
    self.typeTwo = [[UILabel alloc] init];
    [self.contentView addSubview:self.typeTwo];
    self.typeTwo.text = @"科二";
    self.typeTwo.textAlignment = NSTextAlignmentCenter;
    self.typeTwo.layer.borderWidth = 0.5;
    self.typeTwo.textColor = kColor_N(0, 121, 236);
    self.typeTwo.font = [UIFont systemFontOfSize:kFit_Font6(13)];
    self.typeTwo.layer.borderColor = kColor_N(0, 121, 236).CGColor;
    [self.typeTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.timeCar.mas_right).mas_offset(KFit_W6S(20));
        make.centerY.mas_equalTo(self.timeCar);
        make.width.mas_equalTo(KFit_W6S(100));
        make.height.mas_equalTo(KFit_W6S(40));
    }];
    
    self.typeThree = [[UILabel alloc] init];
    [self.contentView addSubview:self.typeThree];
    self.typeThree.text = @"C1";
    self.typeThree.textAlignment = NSTextAlignmentCenter;
    self.typeThree.layer.borderWidth = 0.5;
    self.typeThree.textColor = kColor_N(255, 134, 7);
    self.typeThree.font = [UIFont systemFontOfSize:kFit_Font6(13)];
    self.typeThree.layer.borderColor = kColor_N(255, 134, 7).CGColor;
    [self.typeThree mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.typeTwo.mas_right).mas_offset(KFit_W6S(20));
        make.centerY.mas_equalTo(self.typeTwo);
        make.width.mas_equalTo(KFit_W6S(100));
        make.height.mas_equalTo(KFit_W6S(40));
    }];
    
    UILabel *lineThree = [[UILabel alloc] init];
    [self.contentView addSubview:lineThree];
    lineThree.backgroundColor = kColor_N(240, 240, 240);
    [lineThree mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.contentView);
        make.top.mas_equalTo(img.mas_bottom).mas_offset(KFit_H6S(30));
        make.height.mas_equalTo(1);
    }];
    
    self.butOne = [[UIButton alloc] init];
    [self.contentView addSubview:self.butOne];
    self.butOne.titleLabel.font = [UIFont systemFontOfSize:kFit_Font6(14)];
    self.butOne.layer.cornerRadius = kFit_Font6(5);
    self.butOne.layer.masksToBounds = YES;
    [self.butOne setTitle:@"取消预约" forState:UIControlStateNormal];
    [self.butOne setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.butOne setBackgroundImage:[UIImage createImageWithColor:kColor_N(0, 112, 234)] forState:UIControlStateNormal];
    [self.butOne setBackgroundImage:[UIImage createImageWithColor:kRGBAColor(0, 112, 234, 0.6)] forState:UIControlStateHighlighted];
    [self.butOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView).mas_offset(-KFit_H6S(30));
        make.bottom.mas_equalTo(self.contentView).mas_offset(-KFit_H6S(20));
        make.size.mas_equalTo(CGSizeMake(KFit_W6S(130), KFit_H6S(50)));
    }];
    
    self.butTwo = [[UIButton alloc] init];
    [self.contentView addSubview:self.butTwo];
    self.butTwo.titleLabel.font = [UIFont systemFontOfSize:kFit_Font6(14)];
    [self.butTwo setTitle:@"发短信" forState:UIControlStateNormal];
    [self.butTwo setTitleColor:ZTColor forState:UIControlStateNormal];
    self.butTwo.layer.cornerRadius = kFit_Font6(5);
    self.butTwo.layer.masksToBounds = YES;
    self.butTwo.layer.borderColor = ZTColor.CGColor;
    self.butTwo.layer.borderWidth = 0.5;
    [self.butTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.butOne.mas_left).mas_offset(-KFit_H6S(20));
        make.bottom.mas_equalTo(self.contentView).mas_offset(-KFit_H6S(20));
        make.size.mas_equalTo(CGSizeMake(KFit_W6S(130), KFit_H6S(50)));
    }];
    
    self.butThree = [[UIButton alloc] init];
    [self.contentView addSubview:self.butThree];
    self.butThree.titleLabel.font = [UIFont systemFontOfSize:kFit_Font6(14)];
    [self.butThree setTitle:@"打电话" forState:UIControlStateNormal];
    [self.butThree setTitleColor:ZTColor forState:UIControlStateNormal];
    self.butThree.layer.cornerRadius = kFit_Font6(5);
    self.butThree.layer.masksToBounds = YES;
    self.butThree.layer.borderColor = ZTColor.CGColor;
    self.butThree.layer.borderWidth = 0.5;
    [self.butThree addTarget:self action:@selector(dianhua) forControlEvents:UIControlEventTouchUpInside];
    [self.butThree mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.butTwo.mas_left).mas_offset(-KFit_H6S(20));
        make.bottom.mas_equalTo(self.contentView).mas_offset(-KFit_H6S(20));
        make.size.mas_equalTo(CGSizeMake(KFit_W6S(130), KFit_H6S(50)));
    }];
    
    
}

- (void)setModel:(FMMainModel *)model{
    _model = model;
    XLCache *cache = [XLCache singleton];
    [self.tx sd_setImageWithURL:[NSURL URLWithString:model.wxHead] placeholderImage:[UIImage imageNamed:@"head_nor"]];
    self.name.text = model.studentName;
    self.pho.text = model.studentPhone;
    if (_model.cueForCoach == 1) {
        self.redlb.hidden = YES;//一不提示
    }else{
        self.redlb.hidden = NO;//2 提示
    }
//    NSArray *arr = [model.trainingTime componentsSeparatedByString:@"-"];
    self.timeCar.text = [model.trainingTime substringFromIndex:5];
    
    self.typeTwo.text = model.keMu;
    self.typeThree.text =[NSString stringWithFormat:@"%@",cache.student_license_type_title[[cache.student_license_type_value indexOfObject:_model.licenseType]]];
    switch ([model.type intValue]) {
        case 0:
            self.typeOne.text = @"等待练车";
            self.typeOne.textColor = kColor_N(0, 189, 27);
            [self laodButOne];
            break;
        case 1:
            self.typeOne.text = @"练车中";
            self.typeOne.textColor = kColor_N(0, 133, 237);
            [self laodButOne];
            break;
        case 2:
            self.typeOne.text = @"已完成";
            self.typeOne.textColor = kColor_N(184, 191, 205);
            [self laodButTwo];
            break;
        case 3:
            self.typeOne.text = @"已取消";
            self.typeOne.textColor = kColor_N(184, 191, 205);
            [self laodButTwo];
            break;
            
        default:
            break;
    }
}
- (void)laodButOne{
    [self.butOne setTitle:@"取消预约" forState:UIControlStateNormal];
    [self.butTwo setTitle:@"发短信" forState:UIControlStateNormal];
    [self.butThree setTitle:@"打电话" forState:UIControlStateNormal];
    self.butThree.hidden = NO;
//    [self.butOne addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
}

- (void)laodButTwo{
    [self.butOne setTitle:@"查看详情" forState:UIControlStateNormal];
    [self.butTwo setTitle:@"删除" forState:UIControlStateNormal];
    self.butThree.hidden = YES;
    self.butOne.userInteractionEnabled = NO;
//    [self.butOne addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
}

- (void)dianhua{
    if (_model.studentPhone) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"telprompt:%@",_model.studentPhone]]];
    }
}
@end
