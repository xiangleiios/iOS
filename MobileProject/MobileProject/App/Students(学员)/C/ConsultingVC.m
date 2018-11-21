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
#import "ScreeningV.h"

@interface ConsultingVC ()<JXCategoryViewDelegate,ScreeningVDelegate>
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) JXCategoryTitleView *myCategoryView;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIButton *screeningOne;
@property (nonatomic, strong) UIButton *screeningTwo;
@property (nonatomic, strong) UIView *sousuoview;

@property (nonatomic, strong) ScreeningV *information;
@property (nonatomic, strong) ScreeningV *scholl;

@property (nonatomic, strong) NSArray *informationArr;
@property (nonatomic, strong) NSArray *schollArr;

@property (nonatomic, strong) NSMutableDictionary *dic;
@property (nonatomic, strong) StudentsListVC *studentsvc;
@end

@implementation ConsultingVC


- (NSMutableDictionary *)dic{
    if (_dic == nil) {
        _dic = [NSMutableDictionary dictionary];
    }
    return _dic;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    XLCache *coche = [XLCache singleton];
    _titles = @[@"全部",@"未完善",@"已完善"];
    _informationArr = @[@"全部状态",@"信息已完善",@"信息未完善"];
    NSMutableArray *arr = [NSMutableArray arrayWithObject:@"全部驾校"];
    [arr addObjectsFromArray:coche.teamCode_title];
    _schollArr = [NSArray arrayWithArray:arr];
    [self loadSousuo];
    [self loadScreningBut];
    
    
    
    [self laodScreeningV];
    [self laodStudenListVC];
//    [self loadMyCategoryView];
//    [self loadScroll];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)loadScreningBut{
    self.screeningOne = [[UIButton alloc] init];
    [self.screeningOne setTitle:@"信息状态  ▾" forState:UIControlStateNormal];
    self.screeningOne.titleLabel.font = [UIFont systemFontOfSize:kFit_Font6(16)];
    [self.screeningOne setTitleColor:kColor_N(64, 78, 108) forState:UIControlStateNormal];
    [self.view addSubview:self.screeningOne];
    self.screeningOne.layer.borderWidth = 0.3;
    self.screeningOne.layer.borderColor = kColor_N(235, 235, 235).CGColor;
    [self.screeningOne addTarget:self action:@selector(xingXi:) forControlEvents:UIControlEventTouchUpInside];
    
    self.screeningTwo = [[UIButton alloc] init];
    [self.screeningTwo setTitle:@"报名驾校  ▾" forState:UIControlStateNormal];
    self.screeningTwo.titleLabel.font = [UIFont systemFontOfSize:kFit_Font6(16)];
    [self.screeningTwo setTitleColor:kColor_N(64, 78, 108) forState:UIControlStateNormal];
    [self.view addSubview:self.screeningTwo];
    self.screeningTwo.layer.borderWidth = 0.3;
    self.screeningTwo.layer.borderColor = kColor_N(235, 235, 235).CGColor;
    [self.screeningTwo addTarget:self action:@selector(jiaXiao:) forControlEvents:UIControlEventTouchUpInside];
    
    NSArray *arr = @[self.screeningOne,self.screeningTwo];
    [arr mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:0.1 leadSpacing:0.1 tailSpacing:0.1];
    [arr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.sousuoview.mas_bottom);
        make.height.mas_equalTo(KFit_H6S(90));
    }];
}


- (void)laodScreeningV{
    self.information = [[ScreeningV alloc] init];
    self.information.dataArr = _informationArr;
    self.information.delegate =self;
    
    self.scholl = [[ScreeningV alloc] init];
    self.scholl.dataArr = _schollArr;
    self.scholl.delegate =self;
//    [self.information show];
}
- (void)xingXi:(UIButton *)senter{
    [self.information show];
}
- (void)jiaXiao:(UIButton *)senter{
    [self.scholl show];
}
- (void)loadSousuo{
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, KFit_H6S(100))];
    v.backgroundColor = kColor_N(240, 240, 240);
    [self.view addSubview:v];
    self.sousuoview = v;
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

- (void)toSearech{
    LLSearchViewController *seachVC = [[LLSearchViewController alloc] init];
    seachVC.PayCost = NO;
    [self.navigationController pushViewController:seachVC animated:YES];
}


- (void)laodStudenListVC{
    self.studentsvc = [[StudentsListVC alloc] init];
    if (USERFZR) {
        self.studentsvc.url = POSTStudenteamList;
    }else{
        self.studentsvc.url = POSTCoachStudenteamList;
    }
    
    self.studentsvc.PayCost = NO;
    [self.studentsvc.dic setObject:@"0" forKey:@"isComplete"];
    [self.studentsvc.dic setObject:@"" forKey:@"teamCode"];
    [self addChildViewController:self.studentsvc];
    [self.view addSubview:self.studentsvc.view];
    [self.studentsvc.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.view);
        make.top.mas_equalTo(self.screeningOne.mas_bottom);
    }];
}



- (void)ScreeningVDelegat:(ScreeningV *)screnningv Index:(NSInteger)index{
    if (screnningv == self.information) {
        if (index == 0) {
            [self.studentsvc.dic setObject:@"0" forKey:@"isComplete"];
            [self.screeningOne setTitle:@"全部状态  ▾" forState:UIControlStateNormal];
        }else if (index == 1){
            [self.studentsvc.dic setObject:@"2" forKey:@"isComplete"];
            [self.screeningOne setTitle:@"信息已完善  ▾" forState:UIControlStateNormal];
        }else if (index == 2){
            [self.studentsvc.dic setObject:@"1" forKey:@"isComplete"];
            [self.screeningOne setTitle:@"信息未完善  ▾" forState:UIControlStateNormal];
        }
    }
    if (screnningv == self.scholl) {
        if (index == 0) {
            [self.studentsvc.dic setObject:@"" forKey:@"teamCode"];
            [self.screeningTwo setTitle:@"全部驾校  ▾" forState:UIControlStateNormal];
        }else{
            [self.screeningTwo setTitle:[NSString stringWithFormat:@"%@  ▾",_schollArr[index]] forState:UIControlStateNormal];
            NSInteger i = (index - 1);
            XLCache *coche = [XLCache singleton];
            [self.studentsvc.dic setObject:coche.teamCode_value[i] forKey:@"teamCode"];
        }
    }
    [self.studentsvc headerRefresh];
    
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
