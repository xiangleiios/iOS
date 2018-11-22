//
//  RuleDescriptionVC.m
//  MobileProject
//
//  Created by 向蕾 on 2018/11/21.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import "RuleDescriptionVC.h"

@interface RuleDescriptionVC ()

@end

@implementation RuleDescriptionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationView setTitle:@"规则说明"];
    self.view.backgroundColor = kColor_N(240, 240, 240);
    UIImageView *img = [[UIImageView alloc] init];
    [self.view addSubview:img];
    [img setImage:[UIImage imageNamed:@"text"]];
    [img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view).mas_offset(kNavBarH + KFit_H6S(30));
        make.size.mas_equalTo(CGSizeMake(KFit_W6S(682), KFit_H6S(826)));
    }];
    // Do any additional setup after loading the view.
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
