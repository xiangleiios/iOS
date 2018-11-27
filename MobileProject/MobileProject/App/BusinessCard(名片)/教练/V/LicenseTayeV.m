//
//  LicenseTayeV.m
//  MobileProject
//
//  Created by 向蕾 on 2018/8/23.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import "LicenseTayeV.h"
#import "XLCache.h"
@implementation LicenseTayeV

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
        [self loadSubview];
    }
    return self;
}
- (instancetype)initWithDictionary:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        self.dic = dic;
    }
    return self;
}
- (void)loadSubview{
    UILabel *redlb = [[UILabel alloc] init];
    [self addSubview:redlb];
    redlb.text = @"*";
    redlb.textColor = [UIColor redColor];
    [redlb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).mas_offset(KFit_W6S(30));
        make.top.mas_equalTo(self).mas_offset(KFit_H6S(35));
        make.width.mas_equalTo(KFit_W6S(20));
        make.height.mas_equalTo(KFit_W6S(30));
    }];
    UILabel *titleLable = [[UILabel alloc] init];
    [self addSubview:titleLable];
    titleLable.text = @"驾照类型";
    titleLable.font = [UIFont systemFontOfSize:kFit_Font6(17)];
    [titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(redlb.mas_right).mas_offset(KFit_W6S(10));
        make.centerY.mas_equalTo(redlb);
        make.height.mas_equalTo(KFit_H6S(50));
        //                make.width.mas_equalTo(KFit_W6S(280));
    }];
    
//    NSArray *arrone = @[@"C1",@"C2",@"C3",@"A1",@"A2",@"A3",@"B1",@"B2"];
    
    NSArray *arrone = [XLCache singleton].student_license_type_title;
    NSArray *arrtwo = [XLCache singleton].student_license_type_value;
    float w = KFit_W6S(100);
    float h = KFit_H6S(60);
    for (int i = 0; i < arrone.count; i++) {
        UIButton *but = [[UIButton alloc] initWithFrame:CGRectMake(KFit_W6S(30) + (w + KFit_W6S(50))* (i % 4), KFit_H6S(80) + h *(i/4), w, h)];
        [self addSubview:but];
        but.tag = [arrtwo[i] integerValue];
        if ([self.dic[@"licenseType"] integerValue] == but.tag) {
            [self selectBut:but];
        }
        [but setTitle:arrone[i] forState:UIControlStateNormal];
        [but setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        but.titleLabel.font = [UIFont systemFontOfSize:kFit_Font6(17)];
        but.titleEdgeInsets = UIEdgeInsetsMake(0, KFit_W6S(15), 0, 0);
        [but setImage:[UIImage imageNamed:@"button_nor"] forState:UIControlStateNormal];
        [but setImage:[UIImage imageNamed:@"button_down"] forState:UIControlStateSelected];
        [but addTarget:self action:@selector(selectBut:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    UILabel *lb = [[UILabel alloc] init];
    [self addSubview:lb];
    lb.backgroundColor = kColor_N(240, 240, 240);
    [lb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.mas_equalTo(self);
        make.height.mas_equalTo(1);
    }];
}


- (void)selectBut:(UIButton *)senter{
    self.selectebut.selected = NO;
    senter.selected = YES;
    self.selectebut = senter;
    self.textBlock([NSString stringWithFormat:@"%ld",(long)senter.tag]);
}

- (void)setDic:(NSDictionary *)dic{
    _dic = dic;
    [self loadSubview];
}


@end
