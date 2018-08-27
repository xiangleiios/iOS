//
//  OrderView.m
//  MobileProject
//
//  Created by zsgy on 2018/6/8.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import "OrderView.h"
#define ImgHigrt KFit_W6S(40)
#define ImgSize CGSizeMake(ImgHigrt, ImgHigrt)
@implementation OrderView
{
    UIColor *_titlecolor;
    CGFloat _higet;
    CGFloat _font;
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)init
{
    self = [super init];
    if (self) {
        _titlecolor = kColor_N(87, 87, 87);
        _higet = KFit_H6S(65);
        _font = kFit_Font6(14);
        [self loadSubview];
    }
    return self;
}

- (instancetype)initWithstyle:(BOOL)Default{
    self = [super init];
    if (self) {
        //默认为小间距模式
        if (Default) {
            _titlecolor = kColor_N(87, 87, 87);
            _higet = KFit_H6S(65);
            _font = kFit_Font6(14);
        }else{
            _titlecolor = kColor_N(0, 0, 0);
            _higet = KFit_H6S(90);
            _font = kFit_Font6(16);
        }
        [self loadSubview];
    }
    return self;
}

- (void)loadSubview{
    
    self.layer.borderColor = appcoloer_line.CGColor;
    self.layer.borderWidth = 0.7;
    
    
    self.orderNo = [[UILabel alloc] init];
    self.orderNo.font = [UIFont systemFontOfSize:kFit_Font6(16)];
    self.orderNo.backgroundColor =kColor_N(232, 232, 232);
    [self addSubview:self.orderNo];
    [self.orderNo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self);
        make.right.left.mas_equalTo(self);
        make.height.mas_equalTo(KFit_H6S(89));
    }];
    
    UILabel *lb = [[UILabel alloc] init];
    lb.backgroundColor = appcoloer_line;
    [self addSubview:lb];
    [lb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self);
        make.top.mas_equalTo(self.orderNo.mas_bottom);
        make.height.mas_equalTo(kFit_Font6(1));
    }];
    
    UILabel *lbtwo = [[UILabel alloc] init];
    lbtwo.backgroundColor = appcoloer_line;
    [self addSubview:lbtwo];
    [lbtwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self);
        make.top.mas_equalTo(lb.mas_bottom).mas_offset(_higet);
        make.height.mas_equalTo(kFit_Font6(1));
    }];
    
    UILabel *lbthree = [[UILabel alloc] init];
    lbthree.backgroundColor = appcoloer_line;
    [self addSubview:lbthree];
    [lbthree mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self);
        make.top.mas_equalTo(lbtwo.mas_bottom).mas_offset(_higet);
        make.height.mas_equalTo(kFit_Font6(1));
    }];
    
    
    
    UIImageView *imgone = [[UIImageView alloc] init];
    [imgone setImage:[UIImage imageNamed:@"position"]];
    [self addSubview:imgone];
    [imgone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.orderNo.mas_bottom).mas_offset((_higet - ImgHigrt)/2.0);
        make.left.mas_equalTo(self).mas_offset(KFit_W6S(20));
        make.size.mas_equalTo(ImgSize);
    }];
    
    self.address = [[UILabel alloc] init];
    self.address.text = @"山东省 青岛市";
    self.address.font = [UIFont systemFontOfSize:_font];
    self.address.textColor = _titlecolor;
    [self addSubview:self.address];
    [self.address mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.height.mas_equalTo(imgone);
        make.left.mas_equalTo(imgone.mas_right).mas_offset(KFit_W6S(20));
        make.width.mas_equalTo(KFit_W6S(280));
    }];
    
    
    UIImageView *imgoneRight = [[UIImageView alloc] init];
    [imgoneRight setImage:[UIImage imageNamed:@"voltage"]];
    [self addSubview:imgoneRight];
    [imgoneRight mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.orderNo.mas_bottom).mas_offset(KFit_H6S(20));
        make.centerX.mas_equalTo(self).mas_offset(KFit_W6S(60));
        make.size.mas_equalTo(ImgSize);
    }];
    
    self.voltage = [[UILabel alloc] init];
    self.voltage.text = @"110 KV";
    self.voltage.font = [UIFont systemFontOfSize:_font];
    self.voltage.textColor = _titlecolor;
    [self addSubview:self.voltage];
    [self.voltage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.height.mas_equalTo(imgoneRight);
        make.left.mas_equalTo(imgoneRight.mas_right).mas_offset(KFit_W6S(20));
        make.width.mas_equalTo(KFit_W6S(200));
    }];
    
    
    
    
    
    UIImageView *imgtwo = [[UIImageView alloc] init];
    [imgtwo setImage:[UIImage imageNamed:@"buy"]];
    [self addSubview:imgtwo];
    [imgtwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lbtwo.mas_bottom).mas_offset((_higet - ImgHigrt)/2.0);
        make.left.mas_equalTo(self).mas_offset(KFit_W6S(20));
        make.size.mas_equalTo(ImgSize);
    }];
    self.dosage = [[UILabel alloc] init];
    self.dosage.text = @"2000万度";
    self.dosage.font = [UIFont systemFontOfSize:_font];
    self.dosage.textColor = _titlecolor;
    [self addSubview:self.dosage];
    [self.dosage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.height.mas_equalTo(imgtwo);
        make.left.mas_equalTo(imgtwo.mas_right).mas_offset(KFit_W6S(20));
        make.width.mas_equalTo(KFit_W6S(250));
    }];
    
    
    UIImageView *imgtwoRight = [[UIImageView alloc] init];
    [imgtwoRight setImage:[UIImage imageNamed:@"price"]];
    [self addSubview:imgtwoRight];
    [imgtwoRight mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(imgtwo);
        make.left.mas_equalTo(imgoneRight);
        make.size.mas_equalTo(ImgSize);
    }];
    
    self.price = [[UILabel alloc] init];
    self.price.text = @"6.15远/度";
    self.price.font = [UIFont systemFontOfSize:_font];
    self.price.textColor = _titlecolor;
    [self addSubview:self.price];
    [self.price mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.height.mas_equalTo(imgtwoRight);
        make.left.mas_equalTo(imgtwoRight.mas_right).mas_offset(KFit_W6S(20));
        make.width.mas_equalTo(KFit_W6S(250));
    }];
    
    
    
    
    
    UIImageView *imgthree = [[UIImageView alloc] init];
    [imgthree setImage:[UIImage imageNamed:@"starting-time"]];
    [self addSubview:imgthree];
    [imgthree mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lbthree.mas_bottom).mas_offset((_higet - ImgHigrt)/2.0);
        make.left.mas_equalTo(self).mas_offset(KFit_W6S(20));
        make.size.mas_equalTo(ImgSize);
    }];
    
    self.start_time = [[UILabel alloc] init];
    self.start_time.text = @"2018-01-24";
    self.start_time.font = [UIFont systemFontOfSize:_font];
    self.start_time.textColor = _titlecolor;
    [self addSubview:self.start_time];
    [self.start_time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.height.mas_equalTo(imgthree);
        make.left.mas_equalTo(imgthree.mas_right).mas_offset(KFit_W6S(20));
        make.width.mas_equalTo(KFit_W6S(250));
    }];
    
    UIImageView *imgthreeRight = [[UIImageView alloc] init];
    [imgthreeRight setImage:[UIImage imageNamed:@"end-time"]];
    [self addSubview:imgthreeRight];
    [imgthreeRight mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(imgthree);
        make.left.mas_equalTo(imgoneRight);
        make.size.mas_equalTo(ImgSize);
    }];
    
    self.end_time = [[UILabel alloc] init];
    self.end_time.text = @"2018-02-26";
    self.end_time.font = [UIFont systemFontOfSize:_font];
    self.end_time.textColor = _titlecolor;
    [self addSubview:self.end_time];
    [self.end_time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.height.mas_equalTo(imgthreeRight);
        make.left.mas_equalTo(imgthreeRight.mas_right).mas_offset(KFit_W6S(20));
        make.width.mas_equalTo(KFit_W6S(250));
    }];
    
//    UILabel *lbone = [[UILabel alloc] init];
//    [self addSubview:lbone];
//    lbone.text = @"~";
//    [lbone mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.mas_equalTo(self);
//        make.centerY.mas_equalTo(imgthree);
//        make.size.mas_equalTo(CGSizeMake(KFit_W6S(30), KFit_W6S(30)));
//    }];
    
}

- (void)setModel:(FMMainModel *)model{
    _model = model;
    self.orderNo.text = [NSString stringWithFormat:@" 订单编号:%@",model.code];
    self.address.text = model.province;
    self.voltage.text = [NSString stringWithFormat:@"%@ kV",model.voltage];;
    self.dosage.text = [NSString stringWithFormat:@"%@万度",[XLCommonUse separatedDigitStringWithStr:[NSString stringWithFormat:@"%.2lf",model.num]]];//
    self.price.text = [NSString stringWithFormat:@"%.4lf元/度",model.max_price];
    self.start_time.text = model.start_date;
    self.end_time.text = model.end_date;
}

@end
