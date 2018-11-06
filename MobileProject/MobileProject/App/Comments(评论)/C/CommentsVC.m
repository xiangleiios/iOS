//
//  CommentsVC.m
//  MobileProject
//
//  Created by 向蕾 on 2018/11/5.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import "CommentsVC.h"
#import "CommentsListVC.h"
@interface CommentsVC ()<JXCategoryViewDelegate>
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) JXCategoryTitleView *myCategoryView;
@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation CommentsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationView setTitle:@"评价列表"];
    _titles = @[@"已回复评价",@"待回复评价"];
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
    
    UILabel *lb = [[UILabel alloc] init];
    [self.view addSubview:lb];
    lb.backgroundColor = kColor_N(240, 240, 240);
    [lb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.myCategoryView.mas_bottom).mas_offset(-1);
        make.height.mas_equalTo(1);
    }];
}
- (void)loadScroll{
    self.scrollView = [[UIScrollView alloc] init];
    [self.view addSubview:self.scrollView];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.view);
        make.top.mas_equalTo(self.myCategoryView.mas_bottom);
    }];
    self.scrollView.pagingEnabled = YES;
    self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH * 2, 0);
    self.myCategoryView.contentScrollView = self.scrollView;
    
    CommentsListVC *vc = [[CommentsListVC alloc] init];
    vc.url = [NSString stringWithFormat:@"%@?type=1&enrollCode=%@&openId=%@",POSTTeamSchoolTeamAppraise,self.model.enrollCode,self.model.deptId];
    vc.deptId = self.model.deptId;
//    [vc.dic setValue:@"1" forKey:@"type"];
//    [vc.dic setValue:self.model.enrollCode forKey:@"enrollCode"];
    vc.type = 1;
    [self addChildViewController:vc];
    [self.scrollView addSubview:vc.view];
    vc.view.frame = CGRectMake(0, 0, self.scrollView.frame.size.width , self.scrollView.frame.size.height);
    
    
    CommentsListVC *vcthree = [[CommentsListVC alloc] init];
    vcthree.url = [NSString stringWithFormat:@"%@?type=2&enrollCode=%@&openId=%@",POSTTeamSchoolTeamAppraise,self.model.enrollCode,self.model.deptId];
    vcthree.type = 2;
    vcthree.deptId = self.model.deptId;
    [self addChildViewController:vcthree];
    [self.scrollView addSubview:vcthree.view];
    vcthree.view.frame = CGRectMake(SCREEN_WIDTH * 1, 0, self.scrollView.frame.size.width , self.scrollView.frame.size.height);
    
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
