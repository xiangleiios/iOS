//
//  StudentsVC.m
//  MobileProject
//
//  Created by 向蕾 on 2018/8/20.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import "StudentsVC.h"
//#import <JXCategoryTitleView.h>
#import "JXCategoryTitleView.h"
#import "ConsultingVC.h"
#import "EnrollVC.h"
#import "AddInformationOneVC.h"
@interface StudentsVC ()<JXCategoryViewDelegate>
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) JXCategoryTitleView *myCategoryView;
@property (nonatomic, strong) UIScrollView *scrollView;
@end

@implementation StudentsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self laodNavigation];
    _titles = @[@"咨询学员", @"报名学员" ];
    [self loadMyCategoryView];
    [self loadScroll];
    [self loadAddBut];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadAddBut{
    UIButton *but = [[UIButton alloc] init];
    [self.view addSubview:but];
    [but setImage:[UIImage imageNamed:@"suspension_button"] forState:UIControlStateNormal];
    [but addTarget:self action:@selector(toAddStudents) forControlEvents:UIControlEventTouchUpInside];
    [but mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.mas_equalTo(self.view).mas_offset(-KFit_W6S(1));
        make.width.height.mas_equalTo(KFit_W6S(237));
    }];
}

- (void)toAddStudents{
    AddInformationOneVC *vc = [[AddInformationOneVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)loadMyCategoryView{
    self.myCategoryView = [[JXCategoryTitleView alloc] initWithFrame:CGRectMake(KFit_W6S(70), kNavBarH + KFit_H6S(20), SCREEN_WIDTH - KFit_W6S(140), KFit_H6S(70))];
    self.myCategoryView.delegate = self;
    self.myCategoryView.layer.cornerRadius = 2;
    self.myCategoryView.layer.masksToBounds = YES;
    
    self.myCategoryView.layer.borderColor = kColor_N(0, 112, 234).CGColor;
    self.myCategoryView.layer.borderWidth = 1/[UIScreen mainScreen].scale;
    self.myCategoryView.titles = self.titles;
    self.myCategoryView.cellSpacing = 0;
    self.myCategoryView.titleColor = kColor_N(0, 112, 234);
    self.myCategoryView.titleSelectedColor = [UIColor whiteColor];
    self.myCategoryView.indicatorLineViewShowEnabled = NO;
    self.myCategoryView.backgroundEllipseLayerShowEnabled = YES;
    self.myCategoryView.backgroundEllipseLayerHeight = KFit_H6S(70);
    self.myCategoryView.backgroundEllipseLayerCornerRadius = 2;
    self.myCategoryView.backgroundEllipseLayerWidthIncrement = 0;
    self.myCategoryView.titleLabelMaskEnabled = YES;
    self.myCategoryView.backgroundEllipseLayerColor = kColor_N(0, 112, 234);
    [self.view addSubview:self.myCategoryView];
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
    
    ConsultingVC *vc = [[ConsultingVC alloc] init];
    [self addChildViewController:vc];
    [self.scrollView addSubview:vc.view];
    vc.view.frame = CGRectMake(0, 0, self.scrollView.frame.size.width , self.scrollView.frame.size.height);
    
    EnrollVC *vct = [[EnrollVC alloc] init];
    [self addChildViewController:vct];
    [self.scrollView addSubview:vct.view];
    vct.view.frame = CGRectMake(SCREEN_WIDTH, 0, self.scrollView.frame.size.width , self.scrollView.frame.size.height);
}
#pragma mark - 导航相关
- (void)laodNavigation{
    [self.navigationView setTitle:@"学员"];
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
