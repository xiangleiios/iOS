//
//  MyNewsRootVC.m
//  MobileProject
//
//  Created by 向蕾 on 2018/10/29.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import "MyNewsRootVC.h"
#import "MyNewsVC.h"
@interface MyNewsRootVC ()<JXCategoryViewDelegate>
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) JXCategoryTitleView *myCategoryView;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong)MyNewsVC *one;
@property (nonatomic, strong)MyNewsVC *two;
@end

@implementation MyNewsRootVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _titles = @[@"系统消息", @"通知公告"];
    self.view.backgroundColor = [UIColor whiteColor];
    [self laodNavigation];
    [self loadMyCategoryView];
    [self loadScroll];
    // Do any additional setup after loading the view.
}
- (void)laodNavigation{
    //    kWeakSelf(self)
    [self.navigationView setTitle:@"消息"];
    //添加一个带图片的按钮，如果这个按钮只有点击事件，可以这样写，更加简洁。
    kWeakSelf(self)
    UIButton *but =  [self.navigationView addRightButtonWithTitle:@"全部标记已读" clickCallBack:^(UIView *view) {
        [weakself allRead];
    }];
    [but setTitleColor:kColor_N(15, 115, 238) forState:UIControlStateNormal];
    
    
}
- (void)loadMyCategoryView{
    self.myCategoryView = [[JXCategoryTitleView alloc] initWithFrame:CGRectMake(0,kNavBarH, SCREEN_WIDTH, KFit_H6S(90))];
    self.myCategoryView.delegate = self;
    self.myCategoryView.titles = self.titles;
    self.myCategoryView.titleColorGradientEnabled = YES;
    self.myCategoryView.titleColor = kColor_N(72, 82, 110);
    self.myCategoryView.titleSelectedColor = [UIColor blackColor];
    
    JXCategoryIndicatorLineView *lineView = [[JXCategoryIndicatorLineView alloc] init];
    lineView.indicatorLineWidth = KFit_W6S(40);
    lineView.indicatorLineViewHeight = 3;
    lineView.indicatorLineViewColor = [UIColor blackColor];
    lineView.lineStyle = JXCategoryIndicatorLineStyle_JD;
    self.myCategoryView.indicators = @[lineView];
    [self.view addSubview:self.myCategoryView];
    
    UILabel *lb = [[UILabel alloc] init];
    [self.view addSubview:lb];
    lb.backgroundColor = kColor_N(240, 240, 240);
    [lb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.myCategoryView.mas_bottom);
        make.height.mas_equalTo(KFit_H6S(20));
    }];
}

- (void)loadScroll{
    self.scrollView = [[UIScrollView alloc] init];
    [self.view addSubview:self.scrollView];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.view);
        make.top.mas_equalTo(self.myCategoryView.mas_bottom).mas_offset(KFit_H6S(20));
    }];
    self.scrollView.pagingEnabled = YES;
    self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH * 2, 0);
    self.myCategoryView.contentScrollView = self.scrollView;
    
    MyNewsVC *vc = [[MyNewsVC alloc] init];
    self.one = vc;
    vc.type = 1;
    if (USERFZR) {
        vc.url = POSTFirstList;
    }else{
        vc.url = POSTFirstcoachList;
    }
    
    [self addChildViewController:vc];
    [self.scrollView addSubview:vc.view];
    vc.view.frame = CGRectMake(0, 0, self.scrollView.frame.size.width , self.scrollView.frame.size.height);
    
    MyNewsVC *vctwo = [[MyNewsVC alloc] init];
    self.two = vctwo;
    vctwo.type = 0;
    vctwo.url = POSTNoticetwoList;
    [self addChildViewController:vctwo];
    [self.scrollView addSubview:vctwo.view];
    vctwo.view.frame = CGRectMake(SCREEN_WIDTH, 0, self.scrollView.frame.size.width , self.scrollView.frame.size.height);
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void)allRead{
    NSString *url = POSTUpdateAllRead;
    [FMNetworkHelper fm_request_postWithUrlString:url isNeedCache:NO parameters:nil successBlock:^(id responseObject) {
        KKLog(@"%@",responseObject);
        [self.one headerRefresh];
        [self.two headerRefresh];
    } failureBlock:^(NSError *error) {
        KKLog(@"%@", error);
        
    } progress:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];
}
@end
