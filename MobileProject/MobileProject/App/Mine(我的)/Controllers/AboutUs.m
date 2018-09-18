//
//  AboutUs.m
//  MobileProject
//
//  Created by zsgy on 17/8/3.
//  Copyright © 2017年 ZSGY. All rights reserved.
//

#import "AboutUs.h"

@interface AboutUs ()

@end

@implementation AboutUs

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationView setTitle:@"关于我们"];
    
    UIImageView *img=[[UIImageView alloc]init];
//    self.logimg=img;
    [self.view addSubview:img];
    [img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).mas_offset(KFit_H6S(150)+kNavBarH);
        make.centerX.mas_equalTo(self.view);
        make.height.width.mas_equalTo(KFit_W6S(200));
    }];
    [img setImage:[UIImage imageNamed:@"logo_icon"]];
    
    
    UILabel *lb = [[UILabel alloc] init];
    [self.view addSubview:lb];
    lb.textAlignment = NSTextAlignmentCenter;
    lb.font = [UIFont systemFontOfSize:kFit_Font6(16)];
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary]; 
    lb.text = [NSString stringWithFormat:@"iOS v%@",[infoDictionary objectForKey:@"CFBundleShortVersionString"]];
    [lb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(img.mas_bottom).mas_offset(KFit_H6S(50));
        make.left.right.mas_equalTo(self.view);
        make.height.mas_equalTo(KFit_H6S(50));
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
