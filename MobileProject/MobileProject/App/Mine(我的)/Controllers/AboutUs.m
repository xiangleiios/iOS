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
