//
//  ConsultingVC.m
//  MobileProject
//
//  Created by 向蕾 on 2018/8/24.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import "ConsultingVC.h"
#import "JXCategoryTitleView.h"
#import "LLSearchViewController.h"

#import "StudentsListVC.h"

@interface ConsultingVC ()<JXCategoryViewDelegate>
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) JXCategoryTitleView *myCategoryView;
@property (nonatomic, strong) UIScrollView *scrollView;
@end

@implementation ConsultingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _titles = @[@"全部",@"未完善",@"已完善"];
    [self loadSousuo];
    [self loadMyCategoryView];
    [self loadScroll];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadSousuo{
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, KFit_H6S(100))];
    v.backgroundColor = kColor_N(240, 240, 240);
    [self.view addSubview:v];
    
    UILabel *lb = [[UILabel alloc] init];
    [v addSubview:lb];
    lb.text = @"搜索";
    lb.font = [UIFont systemFontOfSize:kFit_Font6(15)];
    lb.textAlignment = NSTextAlignmentRight;
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

- (void)toSearech{
    LLSearchViewController *seachVC = [[LLSearchViewController alloc] init];
    [self.navigationController pushViewController:seachVC animated:YES];
}

- (void)loadMyCategoryView{
    self.myCategoryView = [[JXCategoryTitleView alloc] initWithFrame:CGRectMake(0,KFit_H6S(100), SCREEN_WIDTH, KFit_H6S(90))];
    self.myCategoryView.delegate = self;
    self.myCategoryView.titles = self.titles;
    self.myCategoryView.titleColorGradientEnabled = YES;
//    self.myCategoryView.indicatorLineViewShowEnabled = NO;
    self.myCategoryView.indicatorLineViewShowEnabled = YES;
//    self.myCategoryView.indicatorLineViewShowEnabled = YES;
    self.myCategoryView.titleColor = kColor_N(72, 82, 110);
    self.myCategoryView.titleSelectedColor = [UIColor blackColor];
    self.myCategoryView.indicatorLineViewColor = [UIColor blackColor];
    self.myCategoryView.indicatorLineWidth = KFit_W6S(40);
    self.myCategoryView.lineStyle = JXCategoryLineStyle_JD;
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
    
    StudentsListVC *vc = [[StudentsListVC alloc] init];
    vc.url = POSTStudenteamList;
    vc.PayCost = NO;
    [self addChildViewController:vc];
    [self.scrollView addSubview:vc.view];
    vc.view.frame = CGRectMake(0, 0, self.scrollView.frame.size.width , self.scrollView.frame.size.height);

    StudentsListVC *vctwo = [[StudentsListVC alloc] init];
    vctwo.url = POSTStudenteamList;
    [vctwo.dic setObject:@"1" forKey:@"isComplete"];
    vctwo.PayCost = NO;
    [self addChildViewController:vctwo];
    [self.scrollView addSubview:vctwo.view];
    vctwo.view.frame = CGRectMake(SCREEN_WIDTH, 0, self.scrollView.frame.size.width , self.scrollView.frame.size.height);
    
    StudentsListVC *vcthree = [[StudentsListVC alloc] init];
    vcthree.url = POSTStudenteamList;
    [vcthree.dic setObject:@"2" forKey:@"isComplete"];
    vcthree.PayCost = NO;
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
