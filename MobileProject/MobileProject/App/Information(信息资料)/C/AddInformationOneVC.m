//
//  AddInformationOneVC.m
//  MobileProject
//
//  Created by 向蕾 on 2018/8/22.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import "AddInformationOneVC.h"
#import "FormsV.h"
#import "AddInformationTwoVC.h"
@interface AddInformationOneVC ()
@property (nonatomic , strong)FormsV *SFZforms;
@end

@implementation AddInformationOneVC

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
    [self.navigationView setTitle:@"填写资料"];
    
}

- (void)loadSubview{
    UIView *v = [[UIView alloc] init];
    [self.view addSubview:v];
    v.backgroundColor = kColor_N(240, 240, 240);
    [v mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view).mas_offset(kNavBarH);
        make.height.mas_equalTo(KFit_H6S(320));
    }];
    
    UIView *backView = [[UIView alloc] init];
    [v addSubview:backView];
    backView.backgroundColor = [UIColor whiteColor];
    backView.layer.cornerRadius = 5;
    backView.layer.masksToBounds = YES;
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(v).mas_offset(KFit_H6S(40));
        make.bottom.mas_equalTo(v).mas_offset(-KFit_H6S(40));
        make.left.mas_equalTo(v).mas_offset(KFit_H6S(50));
        make.right.mas_equalTo(v).mas_offset(-KFit_H6S(50));
    }];
    
    UIButton *but = [[UIButton alloc] init];
    [backView addSubview:but];
    [but setImage:[UIImage imageNamed:@"card_nor"] forState:UIControlStateNormal];
    [but mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(backView);
        make.left.mas_equalTo(backView).mas_offset(KFit_W6S(30));
        make.size.mas_equalTo(CGSizeMake(KFit_W6S(250), KFit_H6S(160)));
    }];
    
    UILabel *lbone = [[UILabel alloc] init];
    [backView addSubview:lbone];
    lbone.text = @"点击读取身份证信息";
    lbone.font = [UIFont systemFontOfSize:kFit_Font6(16)];
    [lbone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(but.mas_right).mas_offset(KFit_W6S(30));
        make.right.mas_equalTo(backView).mas_offset(-KFit_W6S(30));
        make.centerY.mas_equalTo(backView).mas_offset(-KFit_H6S(25));
        make.height.mas_equalTo(KFit_H6S(40));
    }];
    
    UILabel *lbtwo = [[UILabel alloc] init];
    [backView addSubview:lbtwo];
    lbtwo.text = @"身份证正面";
    lbtwo.font = [UIFont systemFontOfSize:kFit_Font6(14)];
    lbtwo.textColor = kColor_N(64, 75, 105);
    [lbtwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(but.mas_right).mas_offset(KFit_W6S(30));
        make.right.mas_equalTo(backView).mas_offset(-KFit_W6S(30));
        make.centerY.mas_equalTo(backView).mas_offset(KFit_H6S(25));
        make.height.mas_equalTo(KFit_H6S(40));
    }];
    
    self.SFZforms = [[FormsV alloc] init];
    [self.view addSubview:self.SFZforms];
    [self.SFZforms mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(v.mas_bottom);
        make.height.mas_equalTo(KFit_H6S(540));
    }];
    
    UIButton *next = [[UIButton alloc] init];
    [self.view addSubview:next];
    [next setTitle:@"下一步" forState:UIControlStateNormal];
    [next addTarget:self action:@selector(nextVC) forControlEvents:UIControlEventTouchUpInside];
    next.backgroundColor = kColor_N(0, 112, 234);
    [next setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    next.layer.cornerRadius = 5;
    next.layer.masksToBounds = YES;
    [next mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).mas_offset(KFit_W6S(70));
        make.right.mas_equalTo(self.view).mas_offset(-KFit_W6S(70));
        make.bottom.mas_equalTo(self.view).mas_offset(-KFit_W6S(40));
        make.height.mas_equalTo(KFit_H6S(90));
    }];
}



- (void)nextVC{
    AddInformationTwoVC *vc = [[AddInformationTwoVC alloc] init];
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
