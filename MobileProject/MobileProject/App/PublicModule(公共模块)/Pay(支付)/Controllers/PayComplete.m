//
//  PayComplete.m
//  MobileProject
//
//  Created by zsgy on 2018/7/13.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import "PayComplete.h"
#import "MyAccountVC.h"
#import "PayVc.h"
@interface PayComplete ()

@end

@implementation PayComplete

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationView setTitle:self.title];
    [self loadSubview];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadSubview{
    UIImageView *img = [[UIImageView alloc] init];
    [self.view addSubview:img];
    [img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).mas_offset(kNavBarH + KFit_H6S(120));
        make.centerX.mas_equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(KFit_H6S(200), KFit_H6S(200)));
    }];
    
    UILabel *lb = [[UILabel alloc] init];
    [self.view addSubview:lb];
    lb.textAlignment = NSTextAlignmentCenter;
    [lb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(img.mas_bottom).mas_offset(KFit_H6S(40));
        make.centerX.mas_equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(KFit_W6S(670), KFit_H6S(30)));
    }];
    
    UIButton *but = [[UIButton alloc] init];
    [self.view addSubview:but];
    but.backgroundColor = appcoloer;
    but.layer.cornerRadius = 5;
    [but setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [but mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(img.mas_bottom).mas_offset(KFit_H6S(130));
        make.centerX.mas_equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(KFit_W6S(670), KFit_H6S(80)));
    }];
    [but addTarget:self action:@selector(toBack) forControlEvents:UIControlEventTouchUpInside];
    if (self.success) {
        [img setImage:[UIImage imageNamed:@"success"]];
        [but setTitle:@"支付成功" forState:UIControlStateNormal];
    }else{
        lb.text = @"支付失败";
        [img setImage:[UIImage imageNamed:@"fail"]];
        [but setTitle:@"返  回" forState:UIControlStateNormal];
    }
}

- (void)toBack{
    for (UIViewController *controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[MyAccountVC class]]) {
            [self.navigationController popToViewController:controller animated:YES];
        }
        if ([controller isKindOfClass:[PayVc class]]) {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
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
