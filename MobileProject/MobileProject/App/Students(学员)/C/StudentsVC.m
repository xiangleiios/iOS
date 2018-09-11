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
@property (nonatomic, strong) UIButton *choose;
@property (nonatomic, strong) NSMutableArray *dataArr;
@end

@implementation StudentsVC
- (NSMutableArray *)dataArr{
    if (_dataArr == nil) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self laodNavigation];
    _titles = @[@"咨询学员", @"报名学员" ];
    [self loadMyCategoryView];
    [self loadScroll];
    [self loadAddBut];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(studentsSubmit:) name:@"NotificationStudentsSubmit" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(studentsDelete:) name:@"NotificationStudentsDelete" object:nil];
    // Do any additional setup after loading the view.
}

-(void)dealloc{
    //移除观察者，Observer不能为nil
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
    kWeakSelf(self)
    self.choose = [self.navigationView addRightButtonWithTitle:@"提交资料" clickCallBack:^(UIView *view) {
        [weakself discloseTheTnformation];
        
    }];
    [self.choose setTitleColor:kColor_N(0, 112, 234) forState:UIControlStateNormal];
    self.choose.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
//    [self.choose setTitle:@"完成" forState:UIControlStateSelected];
    
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.navigationController.interactivePopGestureRecognizer.enabled = (self.myCategoryView.selectedIndex == 0);
}
- (void)categoryView:(JXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index {
    if (index) {
        self.choose.hidden = YES;
    }else{
        self.choose.hidden = NO;
    }
    [self.scrollView setContentOffset:CGPointMake(self.scrollView.bounds.size.width*index, 0) animated:YES];
    //侧滑手势处理
//    self.navigationController.interactivePopGestureRecognizer.enabled = (index == 0);
}


#pragma mark - 提交资料
- (void)studentsSubmit:(NSNotification *)idid{
    NSString *s = [idid object];
    NSNumber *str = [NSNumber numberWithInteger:[s integerValue]];
    XLSingleton *single = [XLSingleton singleton];
    [single.dateArr addObject:str];
    KKLog(@"%@",single.dateArr);
}

- (void)studentsDelete:(NSNotification *)idid{
    NSString *s = [idid object];
    NSNumber *str = [NSNumber numberWithInteger:[s integerValue]];
    
    XLSingleton *single = [XLSingleton singleton];
    [single.dateArr removeObject:str];
    KKLog(@"%@",single.dateArr);
    
}

- (void)discloseTheTnformation{
    [MBProgressHUD showLoadingHUD:@"正在提交"];
    [FMNetworkHelper fm_setValue:[User UserOb].token forHTTPHeaderKey:@"token"];
    [FMNetworkHelper fm_setValue:@"Mobile" forHTTPHeaderKey:@"loginType"];
//    NSString *url = POSTSignStudent;
    if ([XLSingleton singleton].dateArr.count <= 0) {
        [MBProgressHUD showMsgHUD:@"请选择学员"];
        return;
    }
    NSString *url = [NSString stringWithFormat:@"%@?ids=%@",POSTSignStudent,[[XLSingleton singleton].dateArr componentsJoinedByString:@","]];
    NSDictionary *dic = [NSDictionary dictionaryWithObject:[[XLSingleton singleton].dateArr componentsJoinedByString:@","] forKey:@"ids"];
    [FMNetworkHelper fm_request_postWithUrlString:url isNeedCache:NO parameters:nil successBlock:^(id responseObject) {
        KKLog(@"%@",responseObject);
        [MBProgressHUD hideLoadingHUD];
        if ([responseObject[@"code"] integerValue] == 200) {
            XLAlertView *alert = [[XLAlertView alloc] initWithMessage:@"提交成功" SuccessOrFailure:YES];
            [alert showPrompt];
            [[XLSingleton singleton].dateArr removeAllObjects];
        }else{
            [MBProgressHUD showMsgHUD:responseObject[@"message"]];
            [[XLSingleton singleton].dateArr removeAllObjects];
        }
        
    } failureBlock:^(NSError *error) {
        KKLog(@"%@", error);
       
    } progress:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];
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
