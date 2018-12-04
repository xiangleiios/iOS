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
#import "InstructionsVC.h"
#import "SubordinateVC.h"
#import "VehicleVC.h"
#import "BusinessCardListVC.h"
#import "StudentsListTwoVC.h"
#import "XLxqbut.h"
#import "CYLTabBarControllerConfig.h"
#import "TrainingListVC.h"
#import "PracticeCarListVC.h"
#import "MyNewsRootVC.h"
#import "XLWKWebVC.h"
#import "AllWeb.h"
#import "BranchSchoolListVC.h"
#import "CoachListVc.h"
#import "BusinessCardVC.h"
#import "InvitationCoachVC.h"
@interface XLHomeVC ()<SDCycleScrollViewDelegate,FMAskZhengViewDelegate,PagingButtonViewDelegate>
@property (nonatomic , strong)UIScrollView *scroll;
@property (nonatomic , strong)XLView *backview;
@property (nonatomic , strong) SDCycleScrollView *banner;
@property (nonatomic , strong)HomeControlsV *one;
@property (nonatomic , strong)HomeControlsV *two;
@property (nonatomic , strong)HomeControlsV *three;
@property (nonatomic, strong) FMAskZhengView *yfAskZhengView; ///最新消息
@property (nonatomic, strong) PagingButtonView *pagingScr;
@property (nonatomic , strong)NSMutableArray *newsArr;
@property (nonatomic , strong)UILabel *xiaoxi;

@property (nonatomic , strong)FMMainModel *coachModel;
@end

@implementation XLHomeVC
- (NSMutableArray *)newsArr{
    if (_newsArr == nil) {
        _newsArr = [NSMutableArray array];
    }
    return _newsArr;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadCoachInfo];
    [self loadnews];
    //加载导航
    [self laodNavigation];
    
    [self loadscroll];
    
    [self addBannerScroll];

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
    UIButton *new = [self.navigationView addRightButtonWithImage:kImage(@"news_nor") hightImage:kImage(@"news_down") clickCallBack:^(UIView *view) {
        MyNewsRootVC *vc = [[MyNewsRootVC alloc] init];
        [weakself.navigationController pushViewController:vc animated:YES];
    }];
    self.xiaoxi = [[UILabel alloc] init];
    [new addSubview:self.xiaoxi];
    [self.xiaoxi mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.mas_equalTo(new);
        make.height.width.mas_equalTo(KFit_W6S(30));
    }];
    self.xiaoxi.backgroundColor = [UIColor redColor];
    self.xiaoxi.textColor = [UIColor whiteColor];
    self.xiaoxi.font = [UIFont systemFontOfSize:kFit_Font6(12)];
//    self.xiaoxi.text = @"1";
    self.xiaoxi.hidden = YES;
    self.xiaoxi.layer.cornerRadius = KFit_W6S(15);
    self.xiaoxi.layer.masksToBounds = YES;
    self.xiaoxi.textAlignment = NSTextAlignmentCenter;
}

#pragma mark - 添加一个滚动的背景
- (void)loadscroll{
    self.scroll = [[UIScrollView alloc] init];
    [self.view addSubview:self.scroll];
    [self.scroll mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view).mas_offset(kNavBarH);
    }];
    self.backview = [[XLView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [self.scroll addSubview:self.backview];

}
#pragma mark - 轮播图
- (void)addBannerScroll {
    if (_banner) {
        [_banner removeFromSuperview];
    }
    
    
    self.banner = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(KFit_W6S(30),KFit_W6S(30), kScreenW - KFit_W6S(60),KFit_H6S(310) ) delegate:self placeholderImage:[UIImage imageNamed:@"banner"]];
    _banner.autoScrollTimeInterval = 3.0;// 自动滚动时间间隔
    _banner.pageControlStyle = SDCycleScrollViewPageContolStyleNone; //无pagecontrol
    _banner.placeholderImage = [UIImage imageNamed:@"banner"];
    _banner.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
    _banner.clipsToBounds = YES;
    _banner.backgroundColor = kWhiteColor;
    _banner.titleLabelTextFont = [UIFont systemFontOfSize:kFit_Font6(15)];
    _banner.titleLabelHeight = kFit_Font6(40);
    if (USERFZR) {
        _banner.localizationImageNamesGroup = @[@"banner",@"banner2",@"banner4",@"banner3"];
    }else{
        _banner.localizationImageNamesGroup = @[@"banner",@"banner2",@"banner4"];
    }
    
    [self.backview addSubview:_banner];
    
}

#pragma mark -轮播图回调 SDCycleScrollViewDelegate
/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    KKLog(@"%d",index);
    if (index == 0) {
        AppDelegate * appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
        appDelegate.tab.tabBarController.selectedIndex = 1;
    }else if(index == 1){
        XLWKWebVC *vc = [[XLWKWebVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (index == 2){
        InvitationCoachVC *vc = [[InvitationCoachVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (index == 3){
        AllWeb *vc = [[AllWeb alloc] init];
        vc.url = KURL(@"plat/#/members/members");
        [self.navigationController pushViewController:vc animated:YES];
        [vc.navigationView setTitle:@"会员福利"];
    }
}

/** 图片滚动回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index {
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self viewWillLayoutSubviews];
}

- (void)loadBut{
    XLxqbut *butone = [[XLxqbut alloc] init];
    [butone addTarget:self action:@selector(toZhaosheng) forControlEvents:UIControlEventTouchUpInside];
    [butone setImage:[UIImage imageNamed:@"zshb"] forState:UIControlStateNormal];
    [butone setTitle:@"招生海报" forState:UIControlStateNormal];
    [butone setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    XLxqbut *buttwo = [[XLxqbut alloc] init];
    [buttwo addTarget:self action:@selector(toMingpan) forControlEvents:UIControlEventTouchUpInside];
    [buttwo setImage:[UIImage imageNamed:@"jlmp"] forState:UIControlStateNormal];
    [buttwo setTitle:@"招生名片" forState:UIControlStateNormal];
    [buttwo setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    XLxqbut *butthree = [[XLxqbut alloc] init];
    [butthree addTarget:self action:@selector(toAddStudent) forControlEvents:UIControlEventTouchUpInside];
    [butthree setImage:[UIImage imageNamed:@"tjxy"] forState:UIControlStateNormal];
    [butthree setTitle:@"添加学员" forState:UIControlStateNormal];
    [butthree setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    XLxqbut *butfour = [[XLxqbut alloc] init];
    [butfour addTarget:self action:@selector(toPracticeCarListVC) forControlEvents:UIControlEventTouchUpInside];
    [butfour setImage:[UIImage imageNamed:@"yycl"] forState:UIControlStateNormal];
    [butfour setTitle:@"预约练车" forState:UIControlStateNormal];
    [butfour setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [self.backview addSubview:butone];
    [self.backview addSubview:buttwo];
    [self.backview addSubview:butthree];
    [self.backview addSubview:butfour];

    NSArray *toolarr = @[butone,buttwo,butthree,butfour];
    [toolarr mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedItemLength:KFit_W6S(140) leadSpacing:KFit_W6S(40) tailSpacing:KFit_W6S(40)];
    [toolarr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.banner.mas_bottom).mas_offset(KFit_H6S(40));
        make.height.mas_equalTo(KFit_W6S(180));
    }];
    
    
    UIImageView *img = [[UIImageView alloc] init];
    [self.backview addSubview:img];
    img.userInteractionEnabled = YES;
    [img setImage:[UIImage imageNamed:@"bg_white"]];
    [img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(butone.mas_bottom).mas_offset(KFit_H6S(40));
        make.left.mas_equalTo(self.backview).mas_offset(KFit_W6S(30));
        make.right.mas_equalTo(self.backview).mas_offset(-KFit_W6S(30));
        make.height.mas_equalTo(KFit_H6S(116));
    }];
    
    self.yfAskZhengView = [[FMAskZhengView alloc] initWithFrame:CGRectMake(KFit_W6S(5),KFit_H6S(20), kScreenW - KFit_W6S(70), KFit_H6S(76))];
    self.yfAskZhengView.dataArr = self.newsArr;
    self.yfAskZhengView.delegate = self;
    [img addSubview:self.yfAskZhengView];
    
    
    
    XLColumnsV *admissions = [[XLColumnsV alloc] initWithTitle:@"招生日报" Color:[UIColor blackColor]];
    [self.backview addSubview:admissions];
    [admissions mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(img.mas_bottom).mas_offset(KFit_H6S(50));
        make.left.right.mas_equalTo(self.view);
        make.height.mas_equalTo(KFit_H6S(40));
    }];
    
    UIButton *zhaosheng = [[UIButton alloc] init];
    [zhaosheng setImage:[UIImage imageNamed:@"question_mark"] forState:UIControlStateNormal];
    [self.backview addSubview:zhaosheng];
    [zhaosheng addTarget:self action:@selector(tozhaosheng) forControlEvents:UIControlEventTouchUpInside];
    [zhaosheng mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(admissions);
        make.right.mas_equalTo(self.view).mas_offset(-KFit_W6S(30));
        make.width.height.mas_equalTo(KFit_W6S(60));
    }];
    
    _one = [[HomeControlsV alloc] init];
    _one.title.text = @"0";
    _one.subtitle.text = @"今日咨询";
    _one.but.tag = 1;
    [_one.but addTarget:self action:@selector(statistical:) forControlEvents:UIControlEventTouchUpInside];
    [self.backview addSubview:_one];
    
    _two = [[HomeControlsV alloc] init];
    _two.title.text = @"0";
    _two.subtitle.text = @"今日报名";
    _two.but.tag = 2;
    [_two.but addTarget:self action:@selector(statistical:) forControlEvents:UIControlEventTouchUpInside];
    [self.backview addSubview:_two];
    
    _three = [[HomeControlsV alloc] init];
    _three.title.text = @"0";
    _three.subtitle.text = @"本月报名";
    _three.but.tag = 3;
    [_three.but addTarget:self action:@selector(statistical:) forControlEvents:UIControlEventTouchUpInside];
    [self.backview addSubview:_three];
    
    NSArray *arr = @[_one,_two,_three];
    
    [arr mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedItemLength:KFit_W6S(236) leadSpacing:KFit_W6S(30) tailSpacing:KFit_W6S(30)];
    [arr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(admissions.mas_bottom).mas_offset(KFit_H6S(30));
        make.height.mas_equalTo(KFit_W6S(236));
    }];
    
    if (USERFZR) {
        XLColumnsV *management = [[XLColumnsV alloc] initWithTitle:@"分校管理" Color:kColor_N(64, 75, 105)];
        [self.backview addSubview:management];
        [management mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_one.mas_bottom).mas_offset(KFit_H6S(50));
            make.left.right.mas_equalTo(self.view);
            make.height.mas_equalTo(KFit_H6S(30));
        }];
        
        UIButton *jiaxiao = [[UIButton alloc] init];
        [jiaxiao addTarget:self action:@selector(toJiaxiao) forControlEvents:UIControlEventTouchUpInside];
        [self.backview addSubview:jiaxiao];
        [jiaxiao setImage:[UIImage imageNamed:@"suosujiax"] forState:UIControlStateNormal];
        
        UIButton *cehliang = [[UIButton alloc] init];
        [cehliang addTarget:self action:@selector(toCheliang) forControlEvents:UIControlEventTouchUpInside];
        [self.backview addSubview:cehliang];
        [cehliang setImage:[UIImage imageNamed:@"cheliangguanl"] forState:UIControlStateNormal];
        
        NSArray *arrtwo = @[jiaxiao,cehliang];
        [arrtwo mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedItemLength:KFit_W6S(362) leadSpacing:KFit_W6S(20) tailSpacing:KFit_W6S(20)];
        [arrtwo mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(management.mas_bottom).mas_offset(KFit_H6S(30));
            make.height.mas_equalTo(KFit_W6S(146));
        }];
        
        UIButton *xunlianchang = [[UIButton alloc] init];
        [xunlianchang addTarget:self action:@selector(toTrainingListVC) forControlEvents:UIControlEventTouchUpInside];
        [self.backview addSubview:xunlianchang];
        [xunlianchang setImage:[UIImage imageNamed:@"xlcgl"] forState:UIControlStateNormal];
        
        [self.backview addSubview:xunlianchang];
        [xunlianchang mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.height.mas_equalTo(jiaxiao);
            make.top.mas_equalTo(jiaxiao.mas_bottom).mas_offset(KFit_H6S(5));
        }];
       
            UIButton *jiaolian = [[UIButton alloc] init];
            [jiaolian addTarget:self action:@selector(toCoachListVC) forControlEvents:UIControlEventTouchUpInside];
            [self.backview addSubview:jiaolian];
            [jiaolian setImage:[UIImage imageNamed:@"jlgl"] forState:UIControlStateNormal];
            
            [self.backview addSubview:jiaolian];
            [jiaolian mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.height.mas_equalTo(cehliang);
                make.top.mas_equalTo(cehliang.mas_bottom).mas_offset(KFit_H6S(5));
            }];
        
    }
    
    
    
    self.backview.frame = CGRectMake(0, 0, SCREEN_WIDTH, [self.backview getLayoutCellHeightWithFlex:KFit_H6S(30)]);
    self.scroll.contentSize = CGSizeMake(0, CGRectGetMaxY(self.backview.frame));
    
}
- (void)toJiaxiao{
    if (USERFZR) {
        BranchSchoolListVC *vc = [[BranchSchoolListVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        SubordinateVC *vc =[[SubordinateVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    
}

- (void)toCheliang{
    VehicleVC *vc =[[VehicleVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)toZhaosheng{
    AppDelegate * appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    appDelegate.tab.tabBarController.selectedIndex = 1;
}


- (void)toMingpan{
    User *user = [User UserOb];
    if ([user.type  isEqual: @"1"]) {
        BranchSchoolListVC *vc = [[BranchSchoolListVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        
        if (self.coachModel) {
            BusinessCardVC *vc = [[BusinessCardVC alloc] init];
            vc.type = @"coach";
            vc.model = self.coachModel;
            [self.navigationController pushViewController:vc animated:YES];
            [vc.navigationView setTitle:@"招生名片"];
        }else{
            [self loadCoachInfoToVC];
        }
        
    }
}

- (void)loadCoachInfo{
    User *uer = [User UserOb];
    KKLog(@"%@",uer.userId);
    NSString *url = [NSString stringWithFormat:POSTCoachEnrollInfo,[User UserOb].userId];
    [FMNetworkHelper fm_request_postWithUrlString:url isNeedCache:NO parameters:nil successBlock:^(id responseObject) {
        KKLog(@"%@",responseObject);
        if (kResponseObjectStatusCodeIsEqual(200)) {
            FMMainModel *model = [FMMainModel mj_objectWithKeyValues:responseObject[@"data"]];
            self.coachModel = model;
            
        }
        
    } failureBlock:^(NSError *error) {
        KKLog(@"%@", error);
        
    } progress:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];
}

- (void)loadCoachInfoToVC{
    User *uer = [User UserOb];
    KKLog(@"%@",uer.userId);
    NSString *url = [NSString stringWithFormat:POSTCoachEnrollInfo,[User UserOb].userId];
    [FMNetworkHelper fm_request_postWithUrlString:url isNeedCache:NO parameters:nil successBlock:^(id responseObject) {
        KKLog(@"%@",responseObject);
        if (kResponseObjectStatusCodeIsEqual(200)) {
            FMMainModel *model = [FMMainModel mj_objectWithKeyValues:responseObject[@"data"]];
            self.coachModel = model;
            BusinessCardVC *vc = [[BusinessCardVC alloc] init];
            vc.type = @"coach";
            vc.model = self.coachModel;
            [self.navigationController pushViewController:vc animated:YES];
            [vc.navigationView setTitle:@"招生名片"];
        }else{
            [MBProgressHUD showMsgHUD:responseObject[@"message"]];
        }
        
    } failureBlock:^(NSError *error) {
        KKLog(@"%@", error);
        
    } progress:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];
}
- (void)toAddStudent{
    AddStudentVC *vc = [[AddStudentVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)toTrainingListVC{
    TrainingListVC *vc = [[TrainingListVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)toPracticeCarListVC{
    PracticeCarListVC *vc = [[PracticeCarListVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)toCoachListVC{
    CoachListVc *vc = [[CoachListVc alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)statistical:(UIButton *)senter{
    KKLog(@"1111");
    
    if (senter.tag == 1) {
        StudentsListTwoVC *vc = [[StudentsListTwoVC alloc] init];
//        [vc.navigationView setTitle:@"今日咨询"];
        if (USERFZR) {
            vc.url = POSTCensiusList;
        }else{
            vc.url = POSTCensiusListcoach;
        }
        
        [self.navigationController pushViewController:vc animated:YES];
        [vc.navigationView setTitle:@"今日咨询"];
    }else if (senter.tag == 2){
        StudentsListTwoVC *vc = [[StudentsListTwoVC alloc] init];
        //        [vc.navigationView setTitle:@"今日咨询"];
        
        if (USERFZR) {
            vc.url = POSTSignList;
        }else{
            vc.url = POSTSignListcoach;
        }
        [self.navigationController pushViewController:vc animated:YES];
        vc.PayCost = YES;
        [vc.navigationView setTitle:@"今日报名"];
    }else if (senter.tag == 3){
        StudentsListTwoVC *vc = [[StudentsListTwoVC alloc] init];
        //        [vc.navigationView setTitle:@"今日咨询"];
        
        if (USERFZR) {
            vc.url = POSTMonthSignList;
        }else{
            vc.url = POSTMonthSignListcoach;
        }
        vc.PayCost = YES;
        [self.navigationController pushViewController:vc animated:YES];
        [vc.navigationView setTitle:@"本月报名"];
    }

}


- (void)jumpMethod:(UIButton *)senter{
    
}


- (void)askZhengView:(FMAskZhengView *)askZhengView tagIndex:(NSInteger)index {
    KKLog(@"%ld",(long)index);
    MyNewsRootVC *vc = [[MyNewsRootVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loaddata];
    [self loadnews];
}
- (void)loaddata{
    
    NSString *url;
    if (USERFZR) {
        url = POSTCensusList;
    }else{
        url = POSTCensusListcoach;
    }
    [FMNetworkHelper fm_request_postWithUrlString:url isNeedCache:NO parameters:nil successBlock:^(id responseObject) {
        KKLog(@"%@",responseObject);
        if (kResponseObjectStatusCodeIsEqual(200)) {
            _one.title.text = [NSString stringWithFormat:@"%@",responseObject[@"consultCount"]];
            _two.title.text = [NSString stringWithFormat:@"%@",responseObject[@"signCount"]];
            _three.title.text = [NSString stringWithFormat:@"%@",responseObject[@"monthSignCount"]];
        }
    } failureBlock:^(NSError *error) {
        KKLog(@"%@", error);
        
    } progress:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];
}



- (void)loadnews{
    NSString *url;
    if (USERFZR) {
        url = POSTFirstList;
    }else{
        url = POSTFirstcoachList;
    }
    //    NSString *urlstr = [NSString stringWithFormat:@"%@?pageNum=%ld&pageSize=20",self.url,self.pageNum];
    [FMNetworkHelper fm_request_postWithUrlString:url isNeedCache:NO parameters:nil successBlock:^(id responseObject) {
        KKLog(@"%@",responseObject);
        [self.newsArr removeAllObjects];
        NSArray *tpArray = responseObject[@"list"][@"rows"];
        if (tpArray) {
            for (int i = 0; i <tpArray.count; i++) {
                NSDictionary *dic = tpArray[i];
                [self.newsArr addObject:dic[@"content"]];
                if (i>= 3) {
                    break;
                }
            }
            
        }
        self.yfAskZhengView.dataArr = self.newsArr;
        self.xiaoxi.text =[NSString stringWithFormat:@"%@",responseObject[@"unReadNum"]] ;
        if ([self.xiaoxi.text intValue] == 0) {
            self.xiaoxi.hidden = YES;
        }else{
            self.xiaoxi.hidden = NO;
        }
        
        
    } failureBlock:^(NSError *error) {
        KKLog(@"%@", error);
            } progress:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];
}


- (void)tozhaosheng{
    InstructionsVC *VC = [[InstructionsVC alloc] init];
    [self.navigationController pushViewController:VC animated:YES];
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
