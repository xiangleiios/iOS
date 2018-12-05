//
//  CoachListVc.m
//  MobileProject
//
//  Created by 向蕾 on 2018/11/13.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import "CoachListVc.h"
#import "LLSearchViewController.h"


#import "AddCoachListVC.h"
#import "CoachTabviewVC.h"

@interface CoachListVc ()
@property (nonatomic, strong) UIView *sousuoview;
@end

@implementation CoachListVc

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationView setTitle:@"教练列表"];
    [self loadSousuo];
    [self loadBut];
    [self loadTabview];
    // Do any additional setup after loading the view.
}

- (void)loadSousuo{
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, kNavBarH, SCREEN_WIDTH, KFit_H6S(100))];
    v.backgroundColor = kColor_N(240, 240, 240);
    [self.view addSubview:v];
    self.sousuoview = v;
    UIButton *lb = [[UIButton alloc] init];
    [v addSubview:lb];
    [lb setTitle:@"搜索" forState:UIControlStateNormal];
    lb.titleLabel.font = [UIFont systemFontOfSize:kFit_Font6(15)];
    lb.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [lb setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [lb addTarget:self action:@selector(toSearech) forControlEvents:UIControlEventTouchUpInside];
    [lb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(v).mas_offset(-KFit_W6S(30));
        make.top.mas_equalTo(v).mas_offset(KFit_H6S(20));
        make.bottom.mas_equalTo(v).mas_offset(-KFit_H6S(20));
        make.width.mas_equalTo(KFit_W6S(80));
    }];
    
    UIButton *searech = [[UIButton alloc] init];
    [v addSubview:searech];
    [searech setTitle:@"请输入学员姓名或手机号进行搜索" forState:UIControlStateNormal];
    [searech setTitleColor:kColor_N(169, 179, 196) forState:UIControlStateNormal];
    [searech addTarget:self action:@selector(toSearech) forControlEvents:UIControlEventTouchUpInside];
    searech.titleLabel.font = [UIFont systemFontOfSize:kFit_Font6(15)];
    searech.backgroundColor = [UIColor whiteColor];
    searech.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    searech.titleEdgeInsets = UIEdgeInsetsMake(0, KFit_W6S(30), 0, 0);
    
    [searech mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(v).mas_offset(KFit_W6S(30));
        make.top.mas_equalTo(v).mas_offset(KFit_H6S(20));
        make.bottom.mas_equalTo(v).mas_offset(-KFit_H6S(20));
        make.right.mas_equalTo(lb.mas_left).mas_offset(-KFit_W6S(20));
    }];
    
    UIImageView *img = [[UIImageView alloc] init];
    [searech addSubview:img];
    [img setImage:[UIImage imageNamed:@"seek"]];
    [img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(searech);
        make.right.mas_equalTo(searech).mas_offset(-KFit_W6S(30));
        make.height.width.mas_equalTo(KFit_W6S(30));
    }];
}
- (void)loadTabview{
    CoachTabviewVC *vc = [[CoachTabviewVC alloc] init];
    [self.view addSubview:vc.view];
    [self addChildViewController:vc];
    [vc.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.sousuoview.mas_bottom);
        make.left.right.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view).mas_offset(-KFit_H6S(150));
    }];
}
- (void)toSearech{
    LLSearchViewController *seachVC = [[LLSearchViewController alloc] init];
    seachVC.PayCost = NO;
    seachVC.type = SearchTypeCoach;
    [self.navigationController pushViewController:seachVC animated:YES];
}
- (void)loadBut{
    UIImageView *img = [[UIImageView alloc] init];
    [self.view addSubview:img];
    [img setImage:[UIImage imageNamed:@"white_bg_"]];
    [img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.view);
        make.height.mas_equalTo(KFit_H6S(164));
    }];
    
    UIButton *next = [[UIButton alloc] init];
    [self.view addSubview:next];
    [next setTitle:@"添加教练" forState:UIControlStateNormal];
    [next addTarget:self action:@selector(addAddress) forControlEvents:UIControlEventTouchUpInside];
    [next setBackgroundImage:[UIImage createImageWithColor:kColor_N(0, 112, 234)] forState:UIControlStateNormal];
    [next setBackgroundImage:[UIImage createImageWithColor:kRGBAColor(0, 112, 234, 0.6)] forState:UIControlStateHighlighted];
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



- (void)addAddress{
    AddCoachListVC *vc = [[AddCoachListVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];

}
@end
