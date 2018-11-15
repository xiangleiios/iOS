//
//  PracticeCarHeaderV.m
//  MobileProject
//
//  Created by 向蕾 on 2018/10/19.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import "PracticeCarHeaderV.h"

@implementation PracticeCarHeaderV

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.time = [[UILabel alloc] init];
        [self addSubview:self.time];
        self.time.text = @"08:00-20:00";
        [self.time mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).mas_offset(KFit_W6S(30));
            make.centerY.mas_equalTo(self).mas_offset(-KFit_H6S(30));
            make.height.mas_equalTo(KFit_H6S(40));
            make.width.mas_equalTo(KFit_W6S(200));
        }];
        self.typeOne = [[UILabel alloc] init];
        [self addSubview:self.typeOne];
        self.typeOne.text = @"科二";
        self.typeOne.textAlignment = NSTextAlignmentCenter;
        self.typeOne.layer.borderWidth = 0.5;
        self.typeOne.textColor = kColor_N(0, 121, 236);
        self.typeOne.font = [UIFont systemFontOfSize:kFit_Font6(13)];
        self.typeOne.layer.borderColor = kColor_N(0, 121, 236).CGColor;
        [self.typeOne mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.time.mas_right).mas_offset(KFit_W6S(20));
            make.centerY.mas_equalTo(self.time);
            make.width.mas_equalTo(KFit_W6S(100));
            make.height.mas_equalTo(KFit_W6S(40));
        }];
        
        self.typeTwo = [[UILabel alloc] init];
        [self addSubview:self.typeTwo];
        self.typeTwo.text = @"C1";
        self.typeTwo.textAlignment = NSTextAlignmentCenter;
        self.typeTwo.layer.borderWidth = 0.5;
        self.typeTwo.textColor = kColor_N(255, 134, 7);
        self.typeTwo.font = [UIFont systemFontOfSize:kFit_Font6(13)];
        self.typeTwo.layer.borderColor = kColor_N(255, 134, 7).CGColor;
        [self.typeTwo mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.typeOne.mas_right).mas_offset(KFit_W6S(20));
            make.centerY.mas_equalTo(self.time);
            make.width.mas_equalTo(KFit_W6S(100));
            make.height.mas_equalTo(KFit_W6S(40));
        }];
        
        self.num = [[UILabel alloc] init];
        [self addSubview:self.num];
        self.num.text = @"已约2";
        self.num.font = [UIFont systemFontOfSize:kFit_Font6(14)];
        self.num.textColor = kColor_N(117, 127, 149);
        [self.num mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).mas_offset(KFit_W6S(30));
            make.centerY.mas_equalTo(self).mas_offset(KFit_H6S(30));
            make.height.mas_equalTo(KFit_H6S(40));
            make.width.mas_equalTo(KFit_W6S(200));
        }];
        
        UILabel *lb = [[UILabel alloc] init];
        [self addSubview:lb];
        lb.backgroundColor = kColor_N(240, 240, 240);
        [lb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(self);
            make.height.mas_equalTo(1);
        }];
        
        self.modifyBut = [[UIButton alloc] init];
        [self addSubview:self.modifyBut];
        [self.modifyBut mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.bottom.mas_equalTo(self);
        }];
    }
    return self;
}

- (void)setDic:(NSDictionary *)dic{
    XLCache *cache = [XLCache singleton];
    _dic = dic;
    self.time.text = [NSString stringWithFormat:@"%@-%@",dic[@"startDay"],dic[@"endDay"]];
    self.typeOne.text = dic[@"keMu"];
    self.typeTwo.text = [NSString stringWithFormat:@"%@",cache.student_license_type_title[[cache.student_license_type_value indexOfObject:[NSString stringWithFormat:@"%@",dic[@"licenseType"]]]]];
    NSArray *arr =dic[@"trainingRecords"];
    self.num.text = [NSString stringWithFormat:@"已约%lu",(unsigned long)arr.count];

}
@end


@implementation PracticeCarHeaderOneV

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UILabel *lb = [[UILabel alloc] init];
        [self addSubview:lb];
        lb.text = @"当日安排";
        [lb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_equalTo(self).mas_offset(KFit_W6S(30));
            make.height.mas_equalTo(KFit_H6S(30));
        }];
        if (USERFZR) {
            
            UIButton *but = [[UIButton alloc] init];
            self.addBut = but;
            [self addSubview:but];
            but.layer.cornerRadius = 3;
            but.layer.masksToBounds = YES;
            but.titleLabel.font = [UIFont systemFontOfSize:kFit_Font6(16)];
            [but setTitle:@"+ 添加当日时段" forState:UIControlStateNormal];
            [but setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [but setBackgroundImage:[UIImage createImageWithColor:kColor_N(0, 112, 234)] forState:UIControlStateNormal];
            [but setBackgroundImage:[UIImage createImageWithColor:kRGBAColor(0, 112, 234, 0.6)] forState:UIControlStateHighlighted];
            [but mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(self).mas_offset(-KFit_W6S(30));
                make.centerY.mas_equalTo(lb);
                make.height.mas_equalTo(KFit_H6S(50));
                make.width.mas_equalTo(KFit_W6S(250));
            }];
        }
        UILabel *lbline = [[UILabel alloc] init];
        lbline.backgroundColor = kColor_N(240, 240, 240);
        [self addSubview:lbline];
        [lbline mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(self);
            make.height.mas_equalTo(1);
            make.top.mas_equalTo(self).mas_offset(KFit_H6S(89));
        }];
        
        UIView *v = [[UIView alloc] init];
        [self addSubview:v];
        [v mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(self);
            make.top.mas_equalTo(lbline.mas_bottom);
        }];
        self.backgroundColor = [UIColor whiteColor];
        self.time = [[UILabel alloc] init];
        [v addSubview:self.time];
        self.time.text = @"08:00-20:00";
        [self.time mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).mas_offset(KFit_W6S(30));
            make.centerY.mas_equalTo(v).mas_offset(-KFit_H6S(30));
            make.height.mas_equalTo(KFit_H6S(40));
            make.width.mas_equalTo(KFit_W6S(200));
        }];
        self.typeOne = [[UILabel alloc] init];
        [v addSubview:self.typeOne];
        self.typeOne.text = @"科二";
        self.typeOne.textAlignment = NSTextAlignmentCenter;
        self.typeOne.layer.borderWidth = 0.5;
        self.typeOne.textColor = kColor_N(0, 121, 236);
        self.typeOne.font = [UIFont systemFontOfSize:kFit_Font6(13)];
        self.typeOne.layer.borderColor = kColor_N(0, 121, 236).CGColor;
        [self.typeOne mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.time.mas_right).mas_offset(KFit_W6S(20));
            make.centerY.mas_equalTo(self.time);
            make.width.mas_equalTo(KFit_W6S(100));
            make.height.mas_equalTo(KFit_W6S(40));
        }];
        
        self.typeTwo = [[UILabel alloc] init];
        [v addSubview:self.typeTwo];
        self.typeTwo.text = @"C1";
        self.typeTwo.textAlignment = NSTextAlignmentCenter;
        self.typeTwo.layer.borderWidth = 0.5;
        self.typeTwo.textColor = kColor_N(255, 134, 7);
        self.typeTwo.font = [UIFont systemFontOfSize:kFit_Font6(13)];
        self.typeTwo.layer.borderColor = kColor_N(255, 134, 7).CGColor;
        [self.typeTwo mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.typeOne.mas_right).mas_offset(KFit_W6S(20));
            make.centerY.mas_equalTo(self.time);
            make.width.mas_equalTo(KFit_W6S(100));
            make.height.mas_equalTo(KFit_W6S(40));
        }];
        
        self.num = [[UILabel alloc] init];
        [v addSubview:self.num];
        self.num.text = @"已约2";
        self.num.font = [UIFont systemFontOfSize:kFit_Font6(14)];
        self.num.textColor = kColor_N(117, 127, 149);
        [self.num mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).mas_offset(KFit_W6S(30));
            make.centerY.mas_equalTo(v).mas_offset(KFit_H6S(30));
            make.height.mas_equalTo(KFit_H6S(40));
            make.width.mas_equalTo(KFit_W6S(200));
        }];
        
        UILabel *lblinet = [[UILabel alloc] init];
        [self addSubview:lblinet];
        lblinet.backgroundColor = kColor_N(240, 240, 240);
        [lblinet mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(self);
            make.height.mas_equalTo(1);
        }];
        self.modifyBut = [[UIButton alloc] init];
        [self addSubview:self.modifyBut];
        [self.modifyBut mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(self);
            make.top.mas_equalTo(lbline);
        }];
    }
    return self;
}

- (void)setDic:(NSDictionary *)dic{
    XLCache *cache = [XLCache singleton];
    _dic = dic;
    self.time.text = [NSString stringWithFormat:@"%@-%@",dic[@"startDay"],dic[@"endDay"]];
    self.typeOne.text = dic[@"keMu"];
    self.typeTwo.text = [NSString stringWithFormat:@"%@",cache.student_license_type_title[[cache.student_license_type_value indexOfObject:[NSString stringWithFormat:@"%@",dic[@"licenseType"]]]]];
    NSArray *arr =dic[@"trainingRecords"];
    self.num.text = [NSString stringWithFormat:@"已约%lu",(unsigned long)arr.count];
    
}
@end
