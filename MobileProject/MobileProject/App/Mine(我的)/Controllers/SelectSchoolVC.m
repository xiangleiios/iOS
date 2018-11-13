//
//  SelectSchoolVC.m
//  MobileProject
//
//  Created by 向蕾 on 2018/11/13.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import "SelectSchoolVC.h"
#import "SelectSchoolRootVC.h"
@implementation SelectSchoolVC
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kColor_N(240, 240, 240);
    [self laodNavigation];
    [self loadSubview];
    

}


- (void)laodNavigation{
    [self.navigationView setTitle:@""];
    self.navigationView.lineView.hidden = YES;
    [self.navigationView setNavigationBackgroundColor:[UIColor clearColor]];
    [self.navigationView.navigationBackButton setImage:[UIImage imageNamed:@"back_white"] forState:UIControlStateNormal];

}

- (void)loadSubview{
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
    lbone.text = @"请选择";
    lbone.textColor = [UIColor whiteColor];
    lbone.font = [UIFont systemFontOfSize:kFit_Font6(16)];
    [lbone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).mas_offset(KFit_W6S(50));
        make.top.mas_equalTo(self.view).mas_offset(KFit_H6S(240));
        make.height.mas_equalTo(KFit_H6S(30));
    }];
    
    
    UILabel *lbtwo = [[UILabel alloc] init];
    [self.view addSubview:lbtwo];
    lbtwo.textColor = [UIColor whiteColor];
    lbtwo.text = @"所在驾校";
    lbtwo.font = [UIFont systemFontOfSize:kFit_Font6(25) weight:0.5];
    [lbtwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(lbone);
        make.top.mas_equalTo(lbone.mas_bottom);
        make.height.mas_equalTo(KFit_H6S(70));
    }];
    
    UIImageView *imgfour = [[UIImageView alloc] init];
    [self.view addSubview:imgfour];
    [imgfour setImage:[UIImage imageNamed:@"jxiao"]];
    [imgfour mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(imgtwo).mas_offset(KFit_H6S(120));
        make.width.height.mas_equalTo(KFit_W6S(400));
    }];
    
    
    UIButton *butone = [[UIButton alloc] init];
    [imgtwo addSubview:butone];
    [butone setImage:[UIImage imageNamed:@"b_jiant"] forState:UIControlStateNormal];
    [butone setTitleColor:kColor_N(0, 102, 234) forState:UIControlStateNormal];
    butone.titleLabel.font = [UIFont systemFontOfSize:kFit_Font6(20) weight:0.5];
    [butone addTarget:self action:@selector(toLogin:) forControlEvents:UIControlEventTouchUpInside];
    [butone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(imgtwo);
        make.top.mas_equalTo(imgfour.mas_bottom).mas_offset(KFit_H6S(90));
        make.size.mas_equalTo(CGSizeMake(KFit_W6S(340), KFit_H6S(56)));
    }];
}
- (void)toLogin:(UIButton *)senter{
    SelectSchoolRootVC *vc = [[SelectSchoolRootVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
@end
