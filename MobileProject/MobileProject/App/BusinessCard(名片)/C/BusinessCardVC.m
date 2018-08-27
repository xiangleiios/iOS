//
//  BusinessCardVC.m
//  MobileProject
//
//  Created by 向蕾 on 2018/8/22.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import "BusinessCardVC.h"
#import "ChangeCardVC.h"
@interface BusinessCardVC ()

@end

@implementation BusinessCardVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self laodNavigation];
    
    [self loadSubview];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - 导航相关
- (void)laodNavigation{
    [self.navigationView setTitle:@"招生名片"];
    
}

- (void)loadSubview{
    UIButton *change = [[UIButton alloc] init];
    [self.view addSubview:change];
    [change setTitle:@"修改资料" forState:UIControlStateNormal];
    [change setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [change addTarget:self action:@selector(toChange) forControlEvents:UIControlEventTouchUpInside];
    change.backgroundColor = kColor_N(0, 104, 215);
    change.layer.cornerRadius = 5;
    change.layer.masksToBounds = YES;
    
    UIButton *share = [[UIButton alloc] init];
    [self.view addSubview:share];
    [share setTitle:@"分享" forState:UIControlStateNormal];
    [share setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    share.backgroundColor = kColor_N(148, 160, 181);
    share.layer.cornerRadius = 5;
    share.layer.masksToBounds = YES;
    
    NSArray *arr = @[change,share];
    [arr mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:KFit_W6S(30) leadSpacing:KFit_W6S(30) tailSpacing:KFit_W6S(30)];
    [arr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.view).mas_offset(-KFit_H6S(30));
        make.height.mas_equalTo(KFit_H6S(90));
    }];
    
}

- (void)toChange{
    ChangeCardVC *vc = [[ChangeCardVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
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
