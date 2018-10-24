//
//  PracticeCarVC.m
//  MobileProject
//
//  Created by 向蕾 on 2018/10/18.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import "PracticeCarVC.h"
#import "DataBut.h"
#import "TimeSetVC.h"
#import "PracticeCarDetailsVC.h"
#import "SwitchV.h"
#import "ReservationRecordVC.h"
#import "ChooseStudentsVC.h"
@interface PracticeCarVC ()<DataButDelegate>
@property (nonatomic , strong)UIScrollView *scroll;
@property (nonatomic , strong)NSArray *dataArr;
@property (nonatomic , strong)DataBut *selectBut;
@property (nonatomic , strong)SwitchV *opne;
@end

@implementation PracticeCarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self laodNavigation];
    self.dataArr = [XLCommonUse dataWhithDay:15];
    [self loadscroll];
    [self loadBut];
    [self loadSwitchV];
    [self laodPracticeCarDetailsVC];
    // Do any additional setup after loading the view.
    
}
#pragma mark - 导航相关
- (void)laodNavigation{
    [self.navigationView setTitle:@"预约练车"];
    kWeakSelf(self)
    UIButton *navBut = [self.navigationView addRightButtonWithTitle:@"设置" clickCallBack:^(UIView *view) {
        TimeSetVC *vc = [[TimeSetVC alloc] init];
        [weakself.navigationController pushViewController:vc animated:YES];
        
    }];
    [navBut setTitleColor:kColor_N(0, 112, 234) forState:UIControlStateNormal];
    navBut.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    //    [self.choose setTitle:@"完成" forState:UIControlStateSelected];
    
}
- (void)loadscroll{
    self.scroll = [[UIScrollView alloc] init];
    [self.view addSubview:self.scroll];
    self.scroll.showsVerticalScrollIndicator = NO;
    self.scroll.showsHorizontalScrollIndicator = NO;
    [self.scroll mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view).mas_offset(kNavBarH);
        make.height.mas_equalTo(KFit_H6S(225));
    }];
    float w = KFit_W6S(150);
    float h = KFit_H6S(160);
    for (int i = 0; i < self.dataArr.count; i++) {
        DataBut *but = [[DataBut alloc] initWithFrame:CGRectMake(KFit_W6S(30)+i * (w + KFit_W6S(15)), KFit_H6S(30), w, h)];
        [self.scroll addSubview:but];
        but.week.text = [XLCommonUse weekdayStringFromDate:self.dataArr[i]];
        but.data.text =  [XLCommonUse TimeToInterceptMMdd:self.dataArr[i]];
        but.num.text = @"已约0人";
        but.deleget = self;
        if (i < 3) {
            but.textColor = kColor_N(69, 138, 237);
            but.BKColor = kColor_N(206, 226, 251);
        }else{
            but.textColor = kColor_N(162, 172, 190);
            but.BKColor = kColor_N(235, 238, 243);
        }
        if (i == 0 ) {
            self.selectBut = but;
            [but change:but.but];
        }
    }
    self.scroll.contentSize = CGSizeMake(KFit_W6S(30)+self.dataArr.count * (w + KFit_W6S(15)), 0);
}

- (void)loadBut{

    UIButton *yuyue = [[UIButton alloc] init];
    [self.view addSubview:yuyue];
    yuyue.layer.cornerRadius = kFit_Font6(5);
    yuyue.layer.masksToBounds = YES;
    yuyue.layer.borderColor = kColor_N(220, 220, 220).CGColor;
    yuyue.layer.borderWidth = 0.5;
    [yuyue setTitle:@"预约记录" forState:UIControlStateNormal];
    [yuyue setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [yuyue setBackgroundImage:[UIImage createImageWithColor:kColor_N(255, 255, 255)] forState:UIControlStateNormal];
    [yuyue setBackgroundImage:[UIImage createImageWithColor:kRGBAColor(255, 255, 255, 0.6)] forState:UIControlStateHighlighted];
    [yuyue addTarget:self action:@selector(toReservationRecordVC) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    UIButton *hlep = [[UIButton alloc] init];
    [self.view addSubview:hlep];
    hlep.layer.cornerRadius = kFit_Font6(5);
    hlep.layer.masksToBounds = YES;
    [hlep setTitle:@"帮学员预约" forState:UIControlStateNormal];
    [hlep setBackgroundImage:[UIImage createImageWithColor:kColor_N(0, 112, 234)] forState:UIControlStateNormal];
    [hlep setBackgroundImage:[UIImage createImageWithColor:kRGBAColor(0, 112, 234, 0.6)] forState:UIControlStateHighlighted];
    [hlep addTarget:self action:@selector(toChooseStudentsVC) forControlEvents:UIControlEventTouchUpInside];
    
    NSArray *arr = @[yuyue,hlep];
    [arr mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:KFit_W6S(30) leadSpacing:KFit_W6S(30) tailSpacing:KFit_W6S(30)];
    [arr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.view).mas_offset(-KFit_W6S(30));
        make.height.mas_equalTo(KFit_H6S(90));
    }];
}
- (void)loadSwitchV{
    self.opne = [[SwitchV alloc] init];
    [self.view addSubview:self.opne];
    [self.opne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.scroll.mas_bottom);
        make.left.right.mas_equalTo(self.view);
        make.height.mas_equalTo(KFit_H6S(170));
    }];
}

- (void)laodPracticeCarDetailsVC{
    PracticeCarDetailsVC *vc = [[PracticeCarDetailsVC alloc] init];
    [self.view addSubview:vc.view];
    [vc.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.opne.mas_bottom);
        make.bottom.mas_equalTo(self.view).mas_offset(-KFit_H6S(156));
    }];
    [self addChildViewController:vc];
}

- (void)toReservationRecordVC{
    ReservationRecordVC *vc = [[ReservationRecordVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)toChooseStudentsVC{
    ChooseStudentsVC *vc = [[ChooseStudentsVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark - 按钮代理
- (void)DataButTouchUpInset:(DataBut *)but{
    [self.selectBut change:self.selectBut.but];
    self.selectBut = but;
    float w = but.frame.origin.x - SCREEN_WIDTH/2;
    w = w > 0?w:0;
//    if (w > 0 ) {
    [UIView animateWithDuration:0.3 animations:^{
        self.scroll.contentOffset = CGPointMake(w, 0);
    }];
//    }
    
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
