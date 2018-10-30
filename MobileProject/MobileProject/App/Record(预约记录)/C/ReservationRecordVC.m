//
//  ReservationRecordVC.m
//  MobileProject
//
//  Created by 向蕾 on 2018/10/22.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import "ReservationRecordVC.h"
#import "ReservationRecordListVC.h"
@interface ReservationRecordVC ()<JXCategoryViewDelegate>
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) JXCategoryTitleView *myCategoryView;
@property (nonatomic, strong) UIScrollView *scrollView;
@end

@implementation ReservationRecordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationView setTitle:@"预约记录"];
    _titles = @[@"未完成",@"已完成",@"已取消"];
    [self loadMyCategoryView];
    [self loadScroll];
    // Do any additional setup after loading the view.
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
}

- (void)loadScroll{
    self.scrollView = [[UIScrollView alloc] init];
    [self.view addSubview:self.scrollView];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.view);
        make.top.mas_equalTo(self.myCategoryView.mas_bottom);
    }];
    self.scrollView.pagingEnabled = YES;
    self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH * 3, 0);
    self.myCategoryView.contentScrollView = self.scrollView;
    
    ReservationRecordListVC *vc = [[ReservationRecordListVC alloc] init];
    vc.dic = @{@"type":@"1",@"groundId":self.groundId};
    vc.url = POSTGetTrainingRecordInfoList;
    [self addChildViewController:vc];
    [self.scrollView addSubview:vc.view];
    vc.view.frame = CGRectMake(0, 0, self.scrollView.frame.size.width , self.scrollView.frame.size.height);
    
    ReservationRecordListVC *vctwo = [[ReservationRecordListVC alloc] init];
    vctwo.dic = @{@"type":@"2",@"groundId":self.groundId};
    vctwo.url = POSTGetTrainingRecordInfoList;
    [self addChildViewController:vctwo];
    [self.scrollView addSubview:vctwo.view];
    vctwo.view.frame = CGRectMake(SCREEN_WIDTH, 0, self.scrollView.frame.size.width , self.scrollView.frame.size.height);
    
    ReservationRecordListVC *vcthree = [[ReservationRecordListVC alloc] init];
    vcthree.dic = @{@"type":@"3",@"groundId":self.groundId};
    vcthree.url = POSTGetTrainingRecordInfoList;
    [self addChildViewController:vcthree];
    [self.scrollView addSubview:vcthree.view];
    vcthree.view.frame = CGRectMake(SCREEN_WIDTH * 2, 0, self.scrollView.frame.size.width , self.scrollView.frame.size.height);
}


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.navigationController.interactivePopGestureRecognizer.enabled = (self.myCategoryView.selectedIndex == 0);
}
- (void)categoryView:(JXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index {
    [self.scrollView setContentOffset:CGPointMake(self.scrollView.bounds.size.width*index, 0) animated:YES];
    //侧滑手势处理
    //    self.navigationController.interactivePopGestureRecognizer.enabled = (index == 0);
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
