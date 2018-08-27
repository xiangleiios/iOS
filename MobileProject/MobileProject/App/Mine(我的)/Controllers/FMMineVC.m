//
//  FMMineVC.m
//  MobileProject
//
//  Created by Mingo on 2017/7/31.
//  Copyright © 2017年 ZSGY. All rights reserved.
//

#import "FMMineVC.h"
#import "XLInformationV.h"
#import "AboutUs.h"
#import "MyInfoVC.h"
#define HEADERHEI KFit_H6S(320)

@interface FMMineVC ()


@end

@implementation FMMineVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self laodNavigation];
    [self laodSubview];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma mark - 导航相关
- (void)laodNavigation{
    [self.navigationView setTitle:@"我的"];
    
}
- (void)laodSubview{
    
    UIView *backview = [[UIView alloc] init];
    [self.view addSubview:backview];
    [backview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view).mas_offset(kNavBarH + KFit_H6S(40));
        make.height.mas_equalTo(KFit_H6S(450));
    }];
    
    XLInformationV *manual = [[XLInformationV alloc] informationLevelWithTitle:@"账户信息" SubTitle:@"" ImageName:@"my_news_icon"];
    [backview addSubview:manual];
    manual.senterBlock = ^{
        KKLog(@"dianji");
        MyInfoVC *VC = [[MyInfoVC alloc] init];
        [self.navigationController pushViewController:VC animated:YES];
    };
    
    XLInformationV *automatic = [[XLInformationV alloc] informationLevelWithTitle:@"关于我们" SubTitle:@"" ImageName:@"my_about_icon"];
    [backview addSubview:automatic];
    automatic.senterBlock = ^{
        KKLog(@"dianji111");
        AboutUs *vc = [[AboutUs alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    };
    
    XLInformationV *Clear = [[XLInformationV alloc] informationLevelWithTitle:@"清除缓存" SubTitle:@"0M" ImageName:@"my_clean_icon"];
    [backview addSubview:Clear];
    Clear.senterBlock = ^{
        KKLog(@"dianji111");
    };
    NSArray *arr = @[manual,automatic,Clear];
    [arr mas_distributeViewsAlongAxis:MASAxisTypeVertical withFixedSpacing:1 leadSpacing:1 tailSpacing:1];
    [arr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
    }];
    
    
}
- (void)theLoginStatusChange{
    
}
@end
