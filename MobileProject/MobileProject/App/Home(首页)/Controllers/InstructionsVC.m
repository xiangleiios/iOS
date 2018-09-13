//
//  InstructionsVC.m
//  MobileProject
//
//  Created by 向蕾 on 2018/9/13.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import "InstructionsVC.h"

@interface InstructionsVC ()

@end

@implementation InstructionsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationView setTitle:@"招生日报说明"];
    self.view.backgroundColor = kColor_N(255, 255, 255);
    
    UIView *v1 = [self viewWithTitle:@"1.今日咨询说明" Subtitle:@"统计今日新增且未将资料提交至总校审核的学员数量！"];
    [self.view addSubview:v1];
    [v1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).mas_offset(kNavBarH);
        make.left.mas_equalTo(self.view).mas_offset(KFit_W6S(30));
        make.right.mas_equalTo(self.view).mas_offset(-KFit_W6S(30));
        make.height.mas_equalTo(KFit_H6S(170));
    }];
    
    UIView *v2 = [self viewWithTitle:@"1.今日报名说明" Subtitle:@"统计今日将学员资料提交至总校审核的学员数量！"];
    [self.view addSubview:v2];
    [v2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(v1.mas_bottom);
        make.left.mas_equalTo(self.view).mas_offset(KFit_W6S(30));
        make.right.mas_equalTo(self.view).mas_offset(-KFit_W6S(30));
        make.height.mas_equalTo(KFit_H6S(170));
    }];
    UIView *v3 = [self viewWithTitle:@"1.本月报名说明" Subtitle:@"统计本月将学员资料提交至总校审核的学员数量总计！"];
    [self.view addSubview:v3];
    [v3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(v2.mas_bottom);
        make.left.mas_equalTo(self.view).mas_offset(KFit_W6S(30));
        make.right.mas_equalTo(self.view).mas_offset(-KFit_W6S(30));
        make.height.mas_equalTo(KFit_H6S(170));
    }];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIView *)viewWithTitle:(NSString *)title Subtitle:(NSString *)sub{
    UIView *v = [[UIView alloc] init];
    v.backgroundColor = kColor_N(255, 255, 255);
    UILabel *titlelb = [[UILabel alloc] init];
    titlelb.text = title;
    [v addSubview:titlelb];
    [titlelb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(v).mas_offset(KFit_H6S(30));
        make.left.right.mas_equalTo(v);
        make.height.mas_equalTo(KFit_H6S(40));
    }];
    
    UILabel *sublb = [[UILabel alloc] init];
    [v addSubview:sublb];
    sublb.text = sub;
    sublb.font = [UIFont systemFontOfSize:kFit_Font6(13)];
    sublb.textColor = kColor_N(75, 87, 115);
    [sublb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(titlelb.mas_bottom).mas_offset(KFit_H6S(20));
        make.right.mas_equalTo(v);
        make.left.mas_equalTo(v).mas_offset(KFit_W6S(20));
        make.height.mas_equalTo(KFit_H6S(40));
    }];
    
    UILabel *lb = [[UILabel alloc] init];
    [v addSubview:lb];
    lb.backgroundColor = kColor_N(235, 235, 235);
    [lb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.mas_equalTo(v);
        make.height.mas_equalTo(1);
    }];
    
    return v;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
