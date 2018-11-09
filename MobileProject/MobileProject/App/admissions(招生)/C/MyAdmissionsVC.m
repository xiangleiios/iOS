//
//  MyAdmissionsVC.m
//  MobileProject
//
//  Created by 向蕾 on 2018/10/8.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import "MyAdmissionsVC.h"
#import "MyPicturePosterListVC.h"
#import "MyPosterListVC.h"

@interface MyAdmissionsVC ()<JXCategoryViewDelegate>
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) JXCategoryTitleView *myCategoryView;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIButton *choose;
@property (nonatomic, strong) NSMutableArray *dataArr;
@end

@implementation MyAdmissionsVC
- (NSMutableArray *)dataArr{
    if (_dataArr == nil) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self laodNavigation];
    _titles = @[@"图片海报", @"图文海报" ];
    [self loadMyCategoryView];
    [self loadScroll];
    
    
    // Do any additional setup after loading the view.
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
    self.myCategoryView.cellWidth = (SCREEN_WIDTH - KFit_W6S(140))/2;
    self.myCategoryView.titleColor = kColor_N(0, 112, 234);
    self.myCategoryView.titleSelectedColor = [UIColor whiteColor];
    self.myCategoryView.titleLabelMaskEnabled = YES;
    
    JXCategoryIndicatorBackgroundView *backgroundView = [[JXCategoryIndicatorBackgroundView alloc] init];
    backgroundView.backgroundViewColor = kColor_N(0, 112, 234);
    backgroundView.backgroundViewWidth = JXCategoryViewAutomaticDimension;
    backgroundView.backgroundViewCornerRadius = 2;
    self.myCategoryView.indicators = @[backgroundView];
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
    
    MyPicturePosterListVC *vc = [[MyPicturePosterListVC alloc] init];
    vc.type = PostersListTypeMy;
    vc.url = POSTUserList;
    [vc.dic setValue:@"1" forKey:@"type"];
    [self addChildViewController:vc];
    [self.scrollView addSubview:vc.view];
    vc.view.frame = CGRectMake(0, 0, self.scrollView.frame.size.width , self.scrollView.frame.size.height);
    
    MyPosterListVC *vct = [[MyPosterListVC alloc] init];
    vct.type = PostersListTypeMy;
    vct.url = POSTUserList;
    [vct.dic setValue:@"2" forKey:@"type"];
    [self addChildViewController:vct];
    [self.scrollView addSubview:vct.view];
    vct.view.frame = CGRectMake(SCREEN_WIDTH, 0, self.scrollView.frame.size.width , self.scrollView.frame.size.height);
}
#pragma mark - 导航相关
- (void)laodNavigation{
    [self.navigationView setTitle:@"我的海报"];
//    kWeakSelf(self)
//    self.choose = [self.navigationView addRightButtonWithTitle:@"我的海报" clickCallBack:^(UIView *view) {
//
//
//    }];
//    [self.choose setTitleColor:kColor_N(0, 112, 234) forState:UIControlStateNormal];
//    self.choose.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    //    [self.choose setTitle:@"完成" forState:UIControlStateSelected];
    
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
