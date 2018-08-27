//
//  OrederExpandV.m
//  MobileProject
//
//  Created by zsgy on 2018/8/2.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import "OrederExpandV.h"

@implementation OrederExpandV

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
        [self loadsubview];
    }
    return self;
}

- (void)loadsubview{
    UILabel *one = [[UILabel alloc] init];
    one.text = @"用电方拓展信息";
    one.font = [UIFont systemFontOfSize:kFit_Font6(15)];
    [self addSubview:one];
    [one mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).mas_offset(KFit_W6S(20));
        make.top.mas_equalTo(self).mas_offset(KFit_W6S(20));
        make.size.mas_equalTo(CGSizeMake(KFit_W6S(350), KFit_H6S(30)));
    }];
    
    UILabel *lb = [[UILabel alloc] init];
    lb.text = @"准入";
    lb.font = [UIFont systemFontOfSize:kFit_Font6(15)];
    lb.textColor = appcoloer;
    lb.textAlignment = NSTextAlignmentRight;
    [self addSubview:lb];
    [lb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self).mas_offset(-KFit_W6S(20));
        make.centerY.mas_equalTo(one);
        make.size.mas_equalTo(CGSizeMake(KFit_W6S(70), KFit_H6S(30)));
    }];
    
    UIImageView *img = [[UIImageView alloc] init];
    [self addSubview:img];
    [img setImage:[UIImage imageNamed:@"Selected"]];
    [img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(lb.mas_left);
        make.centerY.mas_equalTo(one);
        make.size.mas_equalTo(CGSizeMake(KFit_W6S(30), KFit_H6S(30)));
    }];
    
    UILabel *two = [[UILabel alloc] init];
    two.text = @"前年用电总量（万度）";
    two.font = [UIFont systemFontOfSize:kFit_Font6(15)];
    [self addSubview:two];
    [two mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).mas_offset(KFit_W6S(20));
        make.top.mas_equalTo(one.mas_bottom).mas_offset(KFit_W6S(45));
        make.size.mas_equalTo(CGSizeMake(KFit_W6S(350), KFit_H6S(30)));
    }];
    
    
    self.before_last_total = [[UILabel alloc] init];
//    self.before_last_total.text = @"准入";
    self.before_last_total.font = [UIFont systemFontOfSize:kFit_Font6(15)];
    self.before_last_total.textAlignment = NSTextAlignmentRight;
    [self addSubview:self.before_last_total];
    [self.before_last_total mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self).mas_offset(-KFit_W6S(20));
        make.centerY.mas_equalTo(two);
        make.size.mas_equalTo(CGSizeMake(KFit_W6S(350), KFit_H6S(30)));
    }];
    
    
    
    UILabel *three = [[UILabel alloc] init];
    three.text = @"去年用电总量（万度）";
    three.font = [UIFont systemFontOfSize:kFit_Font6(15)];
    [self addSubview:three];
    [three mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).mas_offset(KFit_W6S(20));
        make.top.mas_equalTo(two.mas_bottom).mas_offset(KFit_W6S(45));
        make.size.mas_equalTo(CGSizeMake(KFit_W6S(350), KFit_H6S(30)));
    }];
    
    
    self.yesteryear_total = [[UILabel alloc] init];
//    self.yesteryear_total.text = @"准入";
    self.yesteryear_total.font = [UIFont systemFontOfSize:kFit_Font6(15)];
    self.yesteryear_total.textAlignment = NSTextAlignmentRight;
    [self addSubview:self.yesteryear_total];
    [self.yesteryear_total mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self).mas_offset(-KFit_W6S(20));
        make.centerY.mas_equalTo(three);
        make.size.mas_equalTo(CGSizeMake(KFit_W6S(350), KFit_H6S(30)));
    }];
    
    UILabel *four = [[UILabel alloc] init];
    four.text = @"所属行业";
    four.font = [UIFont systemFontOfSize:kFit_Font6(15)];
    [self addSubview:four];
    [four mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).mas_offset(KFit_W6S(20));
        make.top.mas_equalTo(three.mas_bottom).mas_offset(KFit_W6S(45));
        make.size.mas_equalTo(CGSizeMake(KFit_W6S(350), KFit_H6S(30)));
    }];
    
    self.industry = [[UILabel alloc] init];
//    self.industry.text = @"准入";
    self.industry.font = [UIFont systemFontOfSize:kFit_Font6(15)];
    self.industry.textAlignment = NSTextAlignmentRight;
    [self addSubview:self.industry];
    [self.industry mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self).mas_offset(-KFit_W6S(20));
        make.centerY.mas_equalTo(four);
        make.size.mas_equalTo(CGSizeMake(KFit_W6S(350), KFit_H6S(30)));
    }];
    
    UILabel *firv = [[UILabel alloc] init];
    firv.text = @"所属行政区";
    firv.font = [UIFont systemFontOfSize:kFit_Font6(15)];
    [self addSubview:firv];
    [firv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).mas_offset(KFit_W6S(20));
        make.top.mas_equalTo(four.mas_bottom).mas_offset(KFit_W6S(45));
        make.size.mas_equalTo(CGSizeMake(KFit_W6S(350), KFit_H6S(30)));
    }];
    
    self.area = [[UILabel alloc] init];
//    self.area.text = @"准入";
    self.area.font = [UIFont systemFontOfSize:kFit_Font6(15)];
    self.area.textAlignment = NSTextAlignmentRight;
    [self addSubview:self.area];
    [self.area mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self).mas_offset(-KFit_W6S(20));
        make.centerY.mas_equalTo(firv);
        make.size.mas_equalTo(CGSizeMake(KFit_W6S(450), KFit_H6S(30)));
    }];
    
    UILabel *six = [[UILabel alloc] init];
    six.text = @"生产时段";
    six.font = [UIFont systemFontOfSize:kFit_Font6(15)];
    [self addSubview:six];
    [six mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).mas_offset(KFit_W6S(20));
        make.top.mas_equalTo(firv.mas_bottom).mas_offset(KFit_W6S(45));
        make.size.mas_equalTo(CGSizeMake(KFit_W6S(350), KFit_H6S(30)));
    }];
    
    self.time_slot = [[UILabel alloc] init];
    self.time_slot.font = [UIFont systemFontOfSize:kFit_Font6(15)];
    self.time_slot.textAlignment = NSTextAlignmentRight;
    [self addSubview:self.time_slot];
    [self.time_slot mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self).mas_offset(-KFit_W6S(20));
        make.centerY.mas_equalTo(six);
        make.size.mas_equalTo(CGSizeMake(KFit_W6S(350), KFit_H6S(30)));
    }];
}

- (void)setDic:(NSDictionary *)dic{
    _dic = dic;
    self.yesteryear_total.text = [XLCommonUse separatedDigitStringWithStr:dic[@"yesteryear_total"]];
    self.before_last_total.text = [XLCommonUse separatedDigitStringWithStr:dic[@"before_last_total"]];
    self.industry.text = dic[@"industry"];
    self.area.text = dic[@"area"];
    NSArray *arr = dic[@"time_slot"];
    if (arr.count >1) {
        self.time_slot.text = [NSString stringWithFormat:@"%@~%@",arr[0],arr[1]];
    }
    
}
@end
