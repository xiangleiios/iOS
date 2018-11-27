//
//  ExamStudentsVC.m
//  MobileProject
//
//  Created by 向蕾 on 2018/10/17.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import "ExamStudentsVC.h"
#import "LLSearchViewController.h"
#import "ExamStudentsListVC.h"
@interface ExamStudentsVC ()<JXCategoryViewDelegate>
@property (nonatomic, strong) NSMutableArray *titles;
@property (nonatomic, strong) JXCategoryTitleAttributeView *myCategoryView;

@property (nonatomic, strong) UIScrollView *scrollView;
@end

@implementation ExamStudentsVC
- (NSMutableArray *)titles{
    if (_titles == nil) {
        NSMutableAttributedString *one = [[NSMutableAttributedString alloc] initWithString:@"科一\n0" attributes:nil];
        NSMutableAttributedString *two = [[NSMutableAttributedString alloc] initWithString:@"科二\n0" attributes:nil];
        NSMutableAttributedString *three = [[NSMutableAttributedString alloc] initWithString:@"科三\n0" attributes:nil];
        NSMutableAttributedString *four= [[NSMutableAttributedString alloc] initWithString:@"科四\n0" attributes:nil];
        NSMutableAttributedString *five = [[NSMutableAttributedString alloc] initWithString:@"结业\n0" attributes:nil];
        _titles = [NSMutableArray arrayWithObjects:one,two,three,four,five, nil];
    }
    return _titles;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadSousuo];
    [self loadMyCategoryView];
    [self loadScroll];
    // Do any additional setup after loading the view.
}
- (void)loadSousuo{
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, KFit_H6S(100))];
    v.backgroundColor = kColor_N(240, 240, 240);
    [self.view addSubview:v];
    
    UIButton *lb = [[UIButton alloc] init];
    [v addSubview:lb];
    [lb setTitle:@"搜索" forState:UIControlStateNormal];
    lb.titleLabel.font = [UIFont systemFontOfSize:kFit_Font6(15)];
    lb.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [lb setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [lb addTarget:self action:@selector(toSearech) forControlEvents:UIControlEventTouchUpInside];
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

- (void)loadMyCategoryView{
    self.myCategoryView = [[JXCategoryTitleAttributeView alloc] initWithFrame:CGRectMake(0,KFit_H6S(100), SCREEN_WIDTH, KFit_H6S(160))];
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

- (void)loadBut{
//    _butOne = [self chooseBut];
//    
//    _butTwo = [self chooseBut];
//    _butThree = [self chooseBut];
//    _butFour = [self chooseBut];
//    _butFive = [self chooseBut];
//    [_butOne setTitle:@"科一\n10" forState:UIControlStateNormal];
//    [_butTwo setTitle:@"科二\n10" forState:UIControlStateNormal];
//    [_butThree setTitle:@"科三\n10" forState:UIControlStateNormal];
//    [_butFour setTitle:@"科四\n10" forState:UIControlStateNormal];
//    [_butFive setTitle:@"结业\n10" forState:UIControlStateNormal];
//    [self.view addSubview:_butOne];
//    [self.view addSubview:_butTwo];
//    [self.view addSubview:_butThree];
//    [self.view addSubview:_butFour];
//    [self.view addSubview:_butFive];
//    
//    NSArray *arr = @[_butOne,_butTwo,_butThree,_butFour,_butFive];
//    [arr mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedItemLength:KFit_W6S(100) leadSpacing:KFit_W6S(30) tailSpacing:KFit_W6S(30)];
//    [arr mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(self.view).mas_offset(KFit_H6S(130));
//        make.height.mas_equalTo(KFit_H6S(100));
//    }];
}

- (void)loadScroll{
    self.scrollView = [[UIScrollView alloc] init];
    [self.view addSubview:self.scrollView];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view).mas_offset(KFit_H6S(250));
    }];
    self.scrollView.pagingEnabled = YES;
    self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH * 5, 0);
    self.myCategoryView.contentScrollView = self.scrollView;
    
    ExamStudentsListVC *vc = [[ExamStudentsListVC alloc] init];
    vc.vc = self;
    [vc.dic setObject:@"1" forKey:@"progress"];
    [self addChildViewController:vc];
    [self.scrollView addSubview:vc.view];
    vc.view.frame = CGRectMake(0, 0, self.scrollView.frame.size.width , self.scrollView.frame.size.height);
    
    ExamStudentsListVC *vctwo = [[ExamStudentsListVC alloc] init];
    vctwo.vc = self;
    [vctwo.dic setObject:@"2" forKey:@"progress"];
    [self addChildViewController:vctwo];
    [self.scrollView addSubview:vctwo.view];
    vctwo.view.frame = CGRectMake(SCREEN_WIDTH, 0, self.scrollView.frame.size.width , self.scrollView.frame.size.height);
    
    ExamStudentsListVC *vcthree = [[ExamStudentsListVC alloc] init];
    vcthree.vc = self;
    [vcthree.dic setObject:@"3" forKey:@"progress"];
    [self addChildViewController:vcthree];
    [self.scrollView addSubview:vcthree.view];
    vcthree.view.frame = CGRectMake(SCREEN_WIDTH * 2, 0, self.scrollView.frame.size.width , self.scrollView.frame.size.height);
    
    ExamStudentsListVC *vcfour = [[ExamStudentsListVC alloc] init];
    vcfour.vc = self;
    [vcfour.dic setObject:@"4" forKey:@"progress"];
    [self addChildViewController:vcfour];
    [self.scrollView addSubview:vcfour.view];
    vcfour.view.frame = CGRectMake(SCREEN_WIDTH * 3, 0, self.scrollView.frame.size.width , self.scrollView.frame.size.height);
    
    ExamStudentsListVC *vcfive = [[ExamStudentsListVC alloc] init];
    vcfive.vc = self;
    [vcfive.dic setObject:@"5" forKey:@"progress"];
    [self addChildViewController:vcfive];
    [self.scrollView addSubview:vcfive.view];
    vcfive.view.frame = CGRectMake(SCREEN_WIDTH * 4, 0, self.scrollView.frame.size.width , self.scrollView.frame.size.height);
}




























- (UIButton *)chooseBut{
    UIButton *but = [[UIButton alloc] init];
    [but setTitleColor:kColor_N(185, 193, 199) forState:UIControlStateNormal];
    [but setBackgroundImage:[UIImage createImageWithColor:kColor_N(238, 240, 245)] forState:UIControlStateNormal];
    [but setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [but setBackgroundImage:[UIImage createImageWithColor:kColor_N(0, 123, 236)] forState:UIControlStateSelected];
    but.titleLabel.numberOfLines = 2;
    but.titleLabel.textAlignment = NSTextAlignmentCenter;
    but.titleLabel.font = [UIFont systemFontOfSize:kFit_Font6(16)];
    but.layer.cornerRadius = 3;
    but.layer.masksToBounds = YES;
    return but;
}


- (void)toSearech{
    LLSearchViewController *seachVC = [[LLSearchViewController alloc] init];
    seachVC.PayCost = YES;
    [self.navigationController pushViewController:seachVC animated:YES];
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

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadRefreshData];
}

- (void)loadRefreshData{
    NSString *url;
    if (USERFZR) {
        url = POSTTeamStuStateList;
    }else{
        url = POSTCoachTeamStuStateList;
    }
    NSDictionary *dic = @{@"progress":@"1"};
    [FMNetworkHelper fm_request_postWithUrlString:url isNeedCache:NO parameters:dic successBlock:^(id responseObject) {
        KKLog(@"%@",responseObject);
        if (kResponseObjectStatusCodeIsEqual(200)) {
            [self.titles removeAllObjects];
            NSMutableAttributedString *one = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"科一\n%@",responseObject[@"keMu1"]] attributes:nil];
            NSMutableAttributedString *two = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"科二\n%@",responseObject[@"keMu2"]] attributes:nil];
            NSMutableAttributedString *three = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"科三\n%@",responseObject[@"keMu3"]] attributes:nil];
            NSMutableAttributedString *four= [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"科四\n%@",responseObject[@"keMu4"]] attributes:nil];
            NSMutableAttributedString *five = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"结业\n%@",responseObject[@"keMu5"]] attributes:nil];
            _titles = [NSMutableArray arrayWithObjects:one,two,three,four,five, nil];
            self.myCategoryView.attributeTitles = _titles;
            [self.myCategoryView reloadData];
        }
        
    } failureBlock:^(NSError *error) {
        KKLog(@"%@", error);
        
    } progress:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];
    //    POSTTeamSchoolList
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
