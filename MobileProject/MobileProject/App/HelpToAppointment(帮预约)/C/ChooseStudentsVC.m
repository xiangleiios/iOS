//
//  ChooseStudentsVC.m
//  MobileProject
//
//  Created by 向蕾 on 2018/10/22.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import "ChooseStudentsVC.h"
#import "ChooseStudentsListVC.h"
#import "ChooseTimeVC.h"
@interface ChooseStudentsVC ()<JXCategoryViewDelegate>
@property (nonatomic, strong) NSMutableArray *titles;
@property (nonatomic, strong) JXCategoryTitleAttributeView *myCategoryView;

@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation ChooseStudentsVC
- (NSMutableArray *)titles{
    if (_titles == nil) {
        NSMutableAttributedString *one = [[NSMutableAttributedString alloc] initWithString:@"科一\n10" attributes:nil];
        NSMutableAttributedString *two = [[NSMutableAttributedString alloc] initWithString:@"科二\n1000" attributes:nil];
        NSMutableAttributedString *three = [[NSMutableAttributedString alloc] initWithString:@"科三\n10" attributes:nil];
        NSMutableAttributedString *four= [[NSMutableAttributedString alloc] initWithString:@"科四\n10" attributes:nil];
        NSMutableAttributedString *five = [[NSMutableAttributedString alloc] initWithString:@"结业\n10" attributes:nil];
        _titles = [NSMutableArray arrayWithObjects:one,two,three,four,five, nil];
    }
    return _titles;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationView setTitle:@"选择学员"];
    
    [self loadMyCategoryView];
    [self loadScroll];
    [self loadBut];
    // Do any additional setup after loading the view.
}
- (void)loadMyCategoryView{
    self.myCategoryView = [[JXCategoryTitleAttributeView alloc] initWithFrame:CGRectMake(0,kNavBarH, SCREEN_WIDTH, KFit_H6S(160))];
    self.myCategoryView.delegate = self;
    self.myCategoryView.attributeTitles = self.titles;
    self.myCategoryView.titleColorGradientEnabled = YES;
    self.myCategoryView.titleColor = kColor_N(72, 82, 110);
    self.myCategoryView.titleSelectedColor = [UIColor blackColor];
    self.myCategoryView.titleFont = [UIFont systemFontOfSize:kFit_Font6(15)];
    self.myCategoryView.titleSelectedFont = [UIFont systemFontOfSize:kFit_Font6(15) weight:0.3];
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
        make.left.right.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view).mas_offset(-KFit_H6S(150));
        make.top.mas_equalTo(self.myCategoryView.mas_bottom);
    }];
    self.scrollView.pagingEnabled = YES;
    self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH * 5, 0);
    self.myCategoryView.contentScrollView = self.scrollView;
    
    ChooseStudentsListVC *vc = [[ChooseStudentsListVC alloc] init];
    [self addChildViewController:vc];
    [self.scrollView addSubview:vc.view];
    vc.view.frame = CGRectMake(0, 0, self.scrollView.frame.size.width , self.scrollView.frame.size.height);
}
- (void)loadBut{
    UIImageView *img = [[UIImageView alloc] init];
    [self.view addSubview:img];
    [img setImage:[UIImage imageNamed:@"white_bg_"]];
    [img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.view);
        make.height.mas_equalTo(KFit_H6S(164));
    }];
    
    UIButton *next = [[UIButton alloc] init];
    [self.view addSubview:next];
    [next setTitle:@"下一步" forState:UIControlStateNormal];
    [next addTarget:self action:@selector(next) forControlEvents:UIControlEventTouchUpInside];
    [next setBackgroundImage:[UIImage createImageWithColor:kColor_N(0, 112, 234)] forState:UIControlStateNormal];
    [next setBackgroundImage:[UIImage createImageWithColor:kRGBAColor(0, 112, 234, 0.6)] forState:UIControlStateHighlighted];
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

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.navigationController.interactivePopGestureRecognizer.enabled = (self.myCategoryView.selectedIndex == 0);
}
- (void)categoryView:(JXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index {
    [self.scrollView setContentOffset:CGPointMake(self.scrollView.bounds.size.width*index, 0) animated:YES];
    //侧滑手势处理
    //    self.navigationController.interactivePopGestureRecognizer.enabled = (index == 0);
}


- (void)next{
    ChooseTimeVC *vc = [[ChooseTimeVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
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
