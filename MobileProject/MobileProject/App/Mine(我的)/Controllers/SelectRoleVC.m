//
//  SelectRoleVC.m
//  MobileProject
//
//  Created by 向蕾 on 2018/11/13.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import "SelectRoleVC.h"
#import "LoginVC.h"
#import "SelectSchoolVC.h"
#import "GDMapVC.h"
@implementation SelectRoleVC
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationView.hidden = YES;
    self.view.backgroundColor = kColor_N(240, 240, 240);
    UIImageView *imgone = [[UIImageView alloc] init];
    [imgone setImage:[UIImage imageNamed:@"rtboard_bg"]];
    [self.view addSubview:imgone];
    [imgone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(self.view);
        make.height.mas_equalTo(KFit_H6S(617));
    }];
    
    UIImageView *imgtwo = [[UIImageView alloc] init];
    [self.view addSubview:imgtwo];
    imgtwo.userInteractionEnabled = YES;
    [imgtwo setImage:[UIImage imageNamed:@"rtboard_white"]];
    [imgtwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view).mas_offset(-KFit_H6S(40));
        make.size.mas_equalTo(CGSizeMake(KFit_W6S(710), KFit_H6S(892)));
    }];
    
    UIImageView *imgthree = [[UIImageView alloc] init];
    [self.view addSubview:imgthree];
    [imgthree setImage:[UIImage imageNamed:@"car_jiaose"]];
    [imgthree mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(imgtwo).mas_offset(-KFit_W6S(40));
        make.bottom.mas_equalTo(imgtwo.mas_top).mas_offset(KFit_W6S(10));
        make.size.mas_equalTo(CGSizeMake(KFit_W6S(236), KFit_H6S(275)));
    }];
    
    UILabel *lbone = [[UILabel alloc] init];
    [self.view addSubview:lbone];
    lbone.text = @"您的角色是?";
    lbone.textColor = [UIColor whiteColor];
    lbone.font = [UIFont systemFontOfSize:kFit_Font6(25) weight:0.5];
    [lbone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).mas_offset(KFit_W6S(50));
        make.top.mas_equalTo(self.view).mas_offset(KFit_H6S(240));
        make.height.mas_equalTo(KFit_H6S(70));
    }];
    
    
    UILabel *lbtwo = [[UILabel alloc] init];
    [self.view addSubview:lbtwo];
    lbtwo.textColor = [UIColor whiteColor];
    lbtwo.text = @"我们根据角色为您提供精准服务";
    lbtwo.font = [UIFont systemFontOfSize:kFit_Font6(16)];
    [lbtwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(lbone);
        make.top.mas_equalTo(lbone.mas_bottom);
        make.height.mas_equalTo(KFit_H6S(40));
    }];
    
    
    UIButton *butone = [[UIButton alloc] init];
    [imgtwo addSubview:butone];
    butone.tag = 0;
    [butone setImage:[UIImage imageNamed:@"jiaolian"] forState:UIControlStateNormal];
    [butone addTarget:self action:@selector(toLogin:) forControlEvents:UIControlEventTouchUpInside];
    [butone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(imgtwo);
        make.top.mas_equalTo(imgtwo).mas_offset(KFit_H6S(65));
        make.size.mas_equalTo(CGSizeMake(KFit_W6S(560), KFit_H6S(200)));
    }];
    
    UIButton *buttwo = [[UIButton alloc] init];
    [imgtwo addSubview:buttwo];
    buttwo.tag = 1;
    [buttwo setImage:[UIImage imageNamed:@"fenxiao"] forState:UIControlStateNormal];
    [buttwo addTarget:self action:@selector(toLogin:) forControlEvents:UIControlEventTouchUpInside];
    [buttwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(imgtwo);
        make.top.mas_equalTo(butone.mas_bottom).mas_offset(KFit_H6S(45));
        make.size.mas_equalTo(CGSizeMake(KFit_W6S(560), KFit_H6S(200)));
    }];
    
}


- (void)toLogin:(UIButton *)senter{
//    SelectSchoolVC *vc = [[SelectSchoolVC alloc] init];
//    [self.navigationController pushViewController:vc animated:YES];
    LoginVC *vc = [[LoginVC alloc] init];
    vc.type = senter.tag;
    [self.navigationController pushViewController:vc animated:YES];
}
@end
