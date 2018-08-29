//
//  XLHomeVC.m
//  MobileProject
//
//  Created by 向蕾 on 2018/8/16.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import "XLHomeVC.h"
#import <SDCycleScrollView.h>
#import "XLColumnsV.h"
#import "HomeControlsV.h"
#import "AddStudentVC.h"
#import "FMAskZhengView.h"
#import "XLButton.h"
#import "PagingButtonView.h"
#import "MyNewsVC.h"
#import "BusinessCardVC.h"
#import "SubordinateVC.h"
#import "VehicleVC.h"
@interface XLHomeVC ()<SDCycleScrollViewDelegate,FMAskZhengViewDelegate,PagingButtonViewDelegate>
@property (nonatomic , strong)UIScrollView *scroll;
@property (nonatomic , strong)XLView *backview;
@property (nonatomic , strong) SDCycleScrollView *banner;
@property (nonatomic , strong)HomeControlsV *one;
@property (nonatomic , strong)HomeControlsV *two;
@property (nonatomic , strong)HomeControlsV *three;
@property (nonatomic, strong) FMAskZhengView *yfAskZhengView; ///最新消息
@property (nonatomic, strong) PagingButtonView *pagingScr;
@end

@implementation XLHomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //加载导航
    [self laodNavigation];
    
    [self loadscroll];
    
    [self addBannerScroll];
    
    [self addAskZhengView];
    [self loadBut];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - 导航相关
- (void)laodNavigation{
    kWeakSelf(self)
    [self.navigationView setTitle:@"中天驾校"];
    //添加一个带图片的按钮，如果这个按钮只有点击事件，可以这样写，更加简洁。
    [self.navigationView addRightButtonWithImage:kImage(@"news_nor") hightImage:kImage(@"news_nor") clickCallBack:^(UIView *view) {
        MyNewsVC *vc = [[MyNewsVC alloc] init];
        [weakself.navigationController pushViewController:vc animated:YES];
    }];
}

#pragma mark - 添加一个滚动的背景
- (void)loadscroll{
    self.scroll = [[UIScrollView alloc] init];
    [self.view addSubview:self.scroll];
    [self.scroll mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.mas_equalTo(self.view);
    }];
    self.backview = [[XLView alloc] init];
    [self.scroll addSubview:self.backview];
    [self.backview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view).mas_offset(kNavBarH);
        make.height.mas_equalTo(SCREEN_HEIGHT);
    }];
}
#pragma mark - 轮播图
- (void)addBannerScroll {
    if (_banner) {
        [_banner removeFromSuperview];
    }
    
    
    self.banner = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0,0, kScreenW,KFit_H6S(250) ) delegate:self placeholderImage:[UIImage imageNamed:@"lb-jiazaitu"]];
    _banner.autoScrollTimeInterval = 3.0;// 自动滚动时间间隔
    _banner.pageControlStyle = SDCycleScrollViewPageContolStyleNone; //无pagecontrol
    _banner.placeholderImage = [UIImage imageNamed:@"lb-jiazaitu"];
    _banner.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
    _banner.clipsToBounds = YES;
    _banner.backgroundColor = kWhiteColor;
    _banner.titleLabelTextFont = [UIFont systemFontOfSize:kFit_Font6(15)];
    _banner.titleLabelHeight = kFit_Font6(40);
    [self.backview addSubview:_banner];
    
}

#pragma mark -轮播图回调 SDCycleScrollViewDelegate
/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
   
}

/** 图片滚动回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index {
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self viewWillLayoutSubviews];
}

- (void)loadBut{
    
    UILabel *lbline = [[UILabel alloc] init];
    [self.backview addSubview:lbline];
    lbline.backgroundColor = kColor_N(240, 240, 240);
    [lbline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.yfAskZhengView.mas_bottom).mas_offset(KFit_W6S(20));
        make.left.mas_equalTo(self.backview).mas_offset(KFit_W6S(30));
        make.right.mas_equalTo(self.backview).mas_offset(-KFit_W6S(30));
        make.height.mas_equalTo(kFit_Font6(1));
    }];
    
    XLColumnsV *tool = [[XLColumnsV alloc] initWithTitle:@"招生工具" Color:kColor_N(15, 115, 238)];
    [self.backview addSubview:tool];
    [tool mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lbline.mas_bottom).mas_offset(KFit_H6S(30));
        make.left.right.mas_equalTo(self.view);
        make.height.mas_equalTo(KFit_H6S(24));
    }];
    
    XLButton *add = [[XLButton alloc] initWithTitle:@"添加学员" SubTitle:@"学员信息录入" BackgroundImg:@"student_card"];
    XLButton *card = [[XLButton alloc] initWithTitle:@"招生名片" SubTitle:@"招生信息编辑" BackgroundImg:@"buss_card"];
    [self.backview addSubview:add];
    [self.backview addSubview:card];
    add.senterBlock = ^{
        AddStudentVC *vc = [[AddStudentVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    };
    card.senterBlock = ^{
        BusinessCardVC *vc = [[BusinessCardVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    };
    NSArray *toolarr = @[add,card];
    [toolarr mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:kFit_Font6(11) leadSpacing:KFit_W6S(30) tailSpacing:KFit_W6S(30)];
    [toolarr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(tool.mas_bottom).mas_offset(KFit_H6S(20));
        make.height.mas_equalTo(KFit_W6S(160));
    }];
    
    
    UILabel *backlb = [[UILabel alloc] init];
    backlb.backgroundColor = kColor_N(240, 240, 240);
    [self.backview addSubview:backlb];
    [backlb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(add.mas_bottom).mas_offset(KFit_H6S(30));
        make.left.right.mas_equalTo(self.backview);
        make.height.mas_equalTo(KFit_H6S(20));
    }];
    
    XLColumnsV *admissions = [[XLColumnsV alloc] initWithTitle:@"招生日报" Color:kColor_N(15, 115, 238)];
    [self.backview addSubview:admissions];
    [admissions mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(backlb.mas_bottom).mas_offset(KFit_H6S(30));
        make.left.right.mas_equalTo(self.view);
        make.height.mas_equalTo(KFit_H6S(24));
    }];
    
    _one = [[HomeControlsV alloc] init];
    _one.title.text = @"25";
    _one.subtitle.text = @"今日询价";
    [self.backview addSubview:_one];
    
    _two = [[HomeControlsV alloc] init];
    _two.title.text = @"9";
    _two.subtitle.text = @"今日报名";
    [self.backview addSubview:_two];
    
    _three = [[HomeControlsV alloc] init];
    _three.title.text = @"146";
    _three.subtitle.text = @"近一月报名";
    [self.backview addSubview:_three];
    
    NSArray *arr = @[_one,_two,_three];
    
    [arr mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:kFit_Font6(1) leadSpacing:KFit_W6S(30) tailSpacing:KFit_W6S(30)];
    [arr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(admissions.mas_bottom).mas_offset(KFit_H6S(30));
        make.height.mas_equalTo(KFit_W6S(90));
    }];
    
    UILabel *backlbtwo = [[UILabel alloc] init];
    backlbtwo.backgroundColor = kColor_N(240, 240, 240);
    [self.backview addSubview:backlbtwo];
    [backlbtwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_one.mas_bottom).mas_offset(KFit_H6S(30));
        make.left.right.mas_equalTo(self.backview);
        make.height.mas_equalTo(KFit_H6S(20));
    }];
    
    XLColumnsV *management = [[XLColumnsV alloc] initWithTitle:@"分校管理" Color:kColor_N(15, 115, 238)];
    [self.backview addSubview:management];
    [management mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(backlbtwo.mas_bottom).mas_offset(KFit_H6S(30));
        make.left.right.mas_equalTo(self.view);
        make.height.mas_equalTo(KFit_H6S(24));
    }];
    
    UIView *v = [[UIView alloc] init];
    [self.backview addSubview:v];
    [v mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(management.mas_bottom).mas_offset(KFit_H6S(10));
        make.left.right.mas_equalTo(self.view);
        make.height.mas_equalTo(KFit_H6S(150));
    }];
    
    NSArray *imgarr = @[@"drive_card",@"car_card",@"drill_card",@"drill_card"];
    NSArray *titlearr = @[@"所属驾校",@"车辆管理",@"教练管理",@"所属驾校"];
    self.pagingScr = [[PagingButtonView alloc] init];
    _pagingScr.pageControlStyle = PageControlStyleHiden;
    _pagingScr.pagingRow = 1; //设置行，不设置默认2行
    _pagingScr.pagingColumn = 4; //设置列 不设置默认4列
    [_pagingScr yfm_createPagingButtonViewWithFrame:CGRectMake(0, 0,kScreenW,KFit_H6S(150))  showToSuperView:v delegate:self iconUrlsOrNamesArr:imgarr buttonTextColorArrOrOneColor:nil buttonTitleArray:titlearr];
    
}
- (void)PagingButtonView:(PagingButtonView *)actionView clickButtonWithIndex:(NSInteger)index {
    switch (index) {
        case 0:{
            SubordinateVC *vc =[[SubordinateVC alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            return;
        }
            break;
        case 1:{
            VehicleVC *vc =[[VehicleVC alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 2:{
            
        }
            break;
        case 3:{
            
        }
            break;
            
        default:
            break;
    }
}
- (void)jumpMethod:(UIButton *)senter{
    
}


#pragma mark -最新消息
- (void)addAskZhengView{
//    UILabel *titleLb = [[UILabel alloc] initWithFrame:CGRectMake(KFit_W6S(30),kNavBarH + KFit_H6S(280), KFit_W6S(200), KFit_H6S(30))];
//    [self.view addSubview:titleLb];
//    titleLb.textColor = [UIColor redColor];
//    titleLb.text = @"最新消息";
    
    self.yfAskZhengView = [[FMAskZhengView alloc] initWithFrame:CGRectMake(KFit_W6S(30),kNavBarH + KFit_H6S(270), kScreenW - KFit_W6S(60), KFit_H6S(50))];
    self.yfAskZhengView.dataArr = @[@"11111111111111111111111",@"2222222222222222222222",@"3333333333333333333333"];
    self.yfAskZhengView.delegate = self;
    [self.view addSubview:self.yfAskZhengView];
    
    
}

- (void)askZhengView:(FMAskZhengView *)askZhengView tagIndex:(NSInteger)index {
    KKLog(@"%ld",(long)index);
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
