//
//  ChangeCardVC.m
//  MobileProject
//
//  Created by 向蕾 on 2018/8/23.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import "ChangeCardVC.h"
#import "FormsV.h"
#import "XLInformationV.h"
#import "CourseV.h"
#import "TemplateV.h"
@interface ChangeCardVC ()
@property (nonatomic , strong)UIScrollView *scroll;
@property (nonatomic , strong)XLView *backview;
@property (nonatomic , strong)UIImageView *headImg;
@property (nonatomic , strong)AdmissionsFormsV *admissions;
@property (nonatomic , strong)CourseFormsV *course;
@property (nonatomic , strong)NSMutableArray *couresArr;
@property (nonatomic , strong)UITextView *textView;
@end

@implementation ChangeCardVC

- (NSMutableArray *)couresArr{
    if (_couresArr == nil) {
        _couresArr = [NSMutableArray array];
        [_couresArr addObject:@"1"];  // ceshi
        [_couresArr addObject:@"2"];
    }
    return _couresArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self laodNavigation];
    
    [self laodScroll];
    
    [self loadSubview];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - 导航相关
- (void)laodNavigation{
    [self.navigationView setTitle:@"修改资料"];
    UIButton *but =  [self.navigationView addRightButtonWithTitle:@"保存" clickCallBack:^(UIView *view) {
        
    }];
    [but setTitleColor:kColor_N(15, 115, 238) forState:UIControlStateNormal];
}


- (void)laodScroll{
    self.scroll = [[UIScrollView alloc] init];
    [self.view addSubview:self.scroll];
    [self.scroll mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view).mas_offset(kNavBarH);
        make.bottom.mas_equalTo(self.view).mas_offset(-KFit_H6S(150));
    }];
    
    self.backview = [[XLView alloc] init];
    self.backview.frame = CGRectMake(0, 0, SCREEN_WIDTH, [self.backview getLayoutCellHeightWithFlex:KFit_H6S(60)]);
    self.backview.backgroundColor = kColor_N(240, 240, 240);
    [self.scroll addSubview:self.backview];
    
    UIButton *next = [[UIButton alloc] init];
    [self.view addSubview:next];
    [next setTitle:@"保存" forState:UIControlStateNormal];
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

- (void)loadSubview{
    XLInformationV *jiBenZiLiao = [[XLInformationV alloc] informationWithTitle:@"基本资料"];
    [self.backview addSubview:jiBenZiLiao];
    [jiBenZiLiao mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(self.backview);
        make.height.mas_equalTo(KFit_H6S(90));
    }];
    
    UIView *v = [[UIView alloc] init];
    [self.backview addSubview:v];
    v.backgroundColor = [UIColor whiteColor];
    [v mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(jiBenZiLiao.mas_bottom);
        make.left.right.mas_equalTo(self.backview);
        make.height.mas_equalTo(KFit_H6S(160));
    }];
    
    UILabel *head = [[UILabel alloc] init];
    [self.backview addSubview:head];
    head.text = @"头像";
    [head mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.backview).mas_equalTo(KFit_W6S(30));
        make.top.mas_equalTo(jiBenZiLiao.mas_bottom).mas_offset(KFit_H6S(20));
        make.size.mas_equalTo(CGSizeMake(KFit_W6S(220), KFit_W6S(40)));
    }];
    
    
    self.headImg = [[UIImageView alloc] init];
    [self.backview addSubview:self.headImg];
    [self.headImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(jiBenZiLiao.mas_bottom).mas_offset(KFit_H6S(20));
        make.right.mas_equalTo(self.backview).mas_offset(-KFit_W6S(30));
        make.size.mas_equalTo(CGSizeMake(KFit_W6S(120), KFit_W6S(120)));
    }];
    self.headImg.layer.cornerRadius = KFit_W6S(60);
    self.headImg.layer.masksToBounds = YES;
    [self.headImg setImage:[UIImage imageNamed:@"pacture_nor"]];
    
    self.admissions = [[AdmissionsFormsV alloc] init];
    [self.backview addSubview:self.admissions];
    self.admissions.backgroundColor = [UIColor whiteColor];
    [self.admissions mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(v.mas_bottom).mas_offset(1);
        make.left.right.mas_equalTo(self.backview);
        make.height.mas_equalTo(KFit_H6S(720));
    }];
    
    
    XLInformationV *keCheng = [[XLInformationV alloc] informationWithTitle:@"培训课程" ButTile:@"创建课程" ButImg:@"add_cj"];
    [self.backview addSubview:keCheng];
    keCheng.senterBlock = ^{
        CourseV *v = [[CourseV alloc] init];
        [v show];
    };
    [keCheng mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.admissions.mas_bottom).mas_offset(KFit_H6S(20));
        make.left.right.mas_equalTo(self.backview);
        make.height.mas_equalTo(KFit_H6S(90));
    }];
    
    
    self.course = [[CourseFormsV alloc] initWithDataArr:self.couresArr];
    [self.backview addSubview:self.course];
    [self.course mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(keCheng.mas_bottom).mas_offset(1);
        make.left.right.mas_equalTo(self.backview);
        make.height.mas_equalTo(KFit_H6S(140) * self.couresArr.count);
    }];
    
    
    XLInformationV *introduce = [[XLInformationV alloc] informationWithTitle:@"自我介绍" ButTile:@"选择模板" ButImg:nil];
    [self.backview addSubview:introduce];
    introduce.senterBlock = ^{
        TemplateV *v = [[TemplateV alloc] init];
        [v show];
    };
    [introduce mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.course.mas_bottom).mas_offset(KFit_H6S(20));
        make.left.right.mas_equalTo(self.backview);
        make.height.mas_equalTo(KFit_H6S(90));
    }];
    
    UIView *inqutBack = [[UIView alloc] init];
    [self.backview addSubview:inqutBack];
    inqutBack.backgroundColor = [UIColor whiteColor];
    [inqutBack mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(introduce.mas_bottom).mas_offset(1);
        make.left.right.mas_equalTo(self.backview);
        make.height.mas_equalTo(KFit_H6S(250));
    }];
    
    UIImageView *box = [[UIImageView alloc] init];
    [box setImage:[UIImage imageNamed:@"box"]];
    [inqutBack addSubview:box];
    [box mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(inqutBack).mas_offset(KFit_W6S(30));
        make.right.bottom.mas_equalTo(inqutBack).mas_offset(-KFit_W6S(30));
    }];
    
    
    self.textView = [[UITextView alloc] init];
    self.textView.backgroundColor = [UIColor clearColor];
    [inqutBack addSubview:self.textView];
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(inqutBack).mas_offset(KFit_W6S(50));
        make.right.bottom.mas_equalTo(inqutBack).mas_offset(-KFit_W6S(50));
    }];
    
    XLInformationV *environment = [[XLInformationV alloc] informationWithTitle:@"教学环境图" ButTile:nil ButImg:nil];
    [self.backview addSubview:environment];
    [environment mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(inqutBack.mas_bottom).mas_offset(KFit_H6S(20));
        make.left.right.mas_equalTo(self.backview);
        make.height.mas_equalTo(KFit_H6S(90));
    }];
    
    
    
    
    self.backview.frame = CGRectMake(0, 0, SCREEN_WIDTH, [self.backview getLayoutCellHeightWithFlex:KFit_H6S(60)]);
    self.scroll.contentSize = CGSizeMake(0, CGRectGetMaxY(self.backview.frame));
}

- (void)laodCoutesView{
    
}
- (void)nextVC{
    
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
