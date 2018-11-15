//
//  PracticeCarVC.m
//  MobileProject
//
//  Created by 向蕾 on 2018/10/18.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import "PracticeCarVC.h"
#import "DataBut.h"
#import "TimeSetVC.h"
#import "PracticeCarDetailsVC.h"
#import "SwitchV.h"
#import "ReservationRecordVC.h"
#import "ChooseStudentsVC.h"
#import "EmptyV.h"
@interface PracticeCarVC ()<DataButDelegate>
@property (nonatomic , strong)UIScrollView *scroll;
@property (nonatomic , strong)NSArray *dataArr;
@property (nonatomic , strong)DataBut *selectBut;
@property (nonatomic , strong)SwitchV *opne;
@property (nonatomic , strong)EmptyV *empty; // 未设置默认时间的 默认页面
@property (nonatomic , strong)EmptyV *emptytwo; // 休息的默认页面

@property (nonatomic , strong)NSMutableArray *butArr;
@property (nonatomic , weak)PracticeCarDetailsVC *practiceCarDetailsVC;

@property (nonatomic , strong)UILabel *redlb;
//@property (nonatomic , strong)
@end

@implementation PracticeCarVC

- (NSMutableArray *)butArr{
    if (_butArr == nil) {
        _butArr = [NSMutableArray array];
    }
    return _butArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self laodNavigation];
    self.dataArr = [XLCommonUse dataWhithDay:14];
    self.selectTime = [XLCommonUse TimeToInterceptYYYYMMddHHMMSS:self.dataArr[0]];
    [self loadscroll];
    [self loadBut];
    [self loadSwitchV];
    [self laodPracticeCarDetailsVC];
    [self loadEmptyV];
    [self loadEmptytwoV];
//    [self loadDataWithTime:self.selectTime];
    // Do any additional setup after loading the view.
    
}
#pragma mark - 导航相关
- (void)laodNavigation{
    [self.navigationView setTitle:@"预约练车"];
    kWeakSelf(self)
    
    if (USERFZR) {
        UIButton *navBut = [self.navigationView addRightButtonWithTitle:@"设置" clickCallBack:^(UIView *view) {
            TimeSetVC *vc = [[TimeSetVC alloc] init];
            vc.groundId = weakself.groundId;
            vc.model = weakself.model;
            [weakself.navigationController pushViewController:vc animated:YES];
            
        }];
        [navBut setTitleColor:kColor_N(0, 112, 234) forState:UIControlStateNormal];
        navBut.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    }
}
- (void)loadscroll{
    self.scroll = [[UIScrollView alloc] init];
    [self.view addSubview:self.scroll];
    self.scroll.showsVerticalScrollIndicator = NO;
    self.scroll.showsHorizontalScrollIndicator = NO;
    [self.scroll mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view).mas_offset(kNavBarH);
        make.height.mas_equalTo(KFit_H6S(225));
    }];
    float w = KFit_W6S(150);
    float h = KFit_H6S(160);
    for (int i = 0; i < self.dataArr.count; i++) {
        DataBut *but = [[DataBut alloc] initWithFrame:CGRectMake(KFit_W6S(30)+i * (w + KFit_W6S(15)), KFit_H6S(30), w, h)];
        [self.scroll addSubview:but];
        but.week.text = [XLCommonUse weekdayStringFromDate:self.dataArr[i]];
        but.data.text =  [XLCommonUse TimeToInterceptMMdd:self.dataArr[i]];
        but.num.text = @"已约0人";
        but.deleget = self;
        but.tag = i;
        but.textColor = kColor_N(69, 138, 237);
        but.BKColor = kColor_N(206, 226, 251);
        if (i == 0 ) {
            self.selectBut = but;
            but.week.text = @"今天";
            [but change:but.but];
        }
        [self.butArr addObject:but];
    }
    self.scroll.contentSize = CGSizeMake(KFit_W6S(30)+self.dataArr.count * (w + KFit_W6S(15)), 0);
}

- (void)loadBut{

    UIButton *yuyue = [[UIButton alloc] init];
    [self.view addSubview:yuyue];
    yuyue.layer.cornerRadius = kFit_Font6(5);
    yuyue.layer.masksToBounds = YES;
    yuyue.layer.borderColor = kColor_N(220, 220, 220).CGColor;
    yuyue.layer.borderWidth = 0.5;
    [yuyue setTitle:@"预约记录" forState:UIControlStateNormal];
    [yuyue setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [yuyue setBackgroundImage:[UIImage createImageWithColor:kColor_N(255, 255, 255)] forState:UIControlStateNormal];
    [yuyue setBackgroundImage:[UIImage createImageWithColor:kRGBAColor(255, 255, 255, 0.6)] forState:UIControlStateHighlighted];
    [yuyue addTarget:self action:@selector(toReservationRecordVC) forControlEvents:UIControlEventTouchUpInside];
    
    self.redlb = [[UILabel alloc] init];
    [yuyue addSubview:self.redlb];
    self.redlb.layer.cornerRadius = KFit_W6S(7);
    self.redlb.layer.masksToBounds = YES;
    self.redlb.hidden = YES;
    self.redlb.backgroundColor = [UIColor redColor];
    [self.redlb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(yuyue);
        make.right.mas_equalTo(yuyue).mas_offset(-KFit_W6S(60));
        make.width.height.mas_equalTo(KFit_W6S(14));
    }];
    
    UIButton *hlep = [[UIButton alloc] init];
    [self.view addSubview:hlep];
    hlep.layer.cornerRadius = kFit_Font6(5);
    hlep.layer.masksToBounds = YES;
    [hlep setTitle:@"帮学员预约" forState:UIControlStateNormal];
    [hlep setBackgroundImage:[UIImage createImageWithColor:kColor_N(0, 112, 234)] forState:UIControlStateNormal];
    [hlep setBackgroundImage:[UIImage createImageWithColor:kRGBAColor(0, 112, 234, 0.6)] forState:UIControlStateHighlighted];
    [hlep addTarget:self action:@selector(toChooseStudentsVC) forControlEvents:UIControlEventTouchUpInside];
    
    NSArray *arr = @[yuyue,hlep];
    [arr mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:KFit_W6S(30) leadSpacing:KFit_W6S(30) tailSpacing:KFit_W6S(30)];
    [arr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.view).mas_offset(-KFit_W6S(30));
        make.height.mas_equalTo(KFit_H6S(90));
    }];
}

- (void)loadEmptyV{
    self.empty = [[EmptyV alloc] init];
    
    [self.view addSubview:self.empty];
    [self.empty mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.scroll.mas_bottom);
        make.left.right.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view).mas_offset(-KFit_H6S(150));
    }];
    self.empty.hidden = YES;
    [self.empty.but addTarget:self action:@selector(toTimeSetVC) forControlEvents:UIControlEventTouchUpInside];
    if (USERFZR) {
        self.empty.title.text = @"您还没有设置默认的预约练车时段哦~";
        self.empty.but.hidden = NO;
    }else{
        self.empty.title.text = @"管理员还没有设置默认预约练车时段\n请与分校管理员联系哦~";
        self.empty.but.hidden = YES;
    }
}

- (void)loadEmptytwoV{
    self.emptytwo = [[EmptyV alloc] init];
    self.emptytwo.title.text = @"今天休息，暂无安排";
    [self.view addSubview:self.emptytwo];
    [self.emptytwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.opne.mas_bottom);
        make.left.right.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view).mas_offset(-KFit_H6S(150));
    }];
    self.emptytwo.but.hidden = YES;
    self.emptytwo.hidden = YES;
}

- (void)loadSwitchV{
    self.opne = [[SwitchV alloc] init];
    [self.view addSubview:self.opne];
    [self.opne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.scroll.mas_bottom);
        make.left.right.mas_equalTo(self.view);
        make.height.mas_equalTo(KFit_H6S(170));
    }];
    [self.opne.opne addTarget:self action:@selector(valueChanged:) forControlEvents:(UIControlEventValueChanged)];
}

- (void)laodPracticeCarDetailsVC{
    PracticeCarDetailsVC *vc = [[PracticeCarDetailsVC alloc] init];
    [self.view addSubview:vc.view];
    [vc.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.opne.mas_bottom);
        make.bottom.mas_equalTo(self.view).mas_offset(-KFit_H6S(156));
    }];
    [self addChildViewController:vc];
    vc.groundId = self.groundId;
    vc.selectTime = self.selectTime;
    vc.vc = self;
    self.practiceCarDetailsVC = vc;
}
- (void)toTimeSetVC{
    TimeSetVC *vc = [[TimeSetVC alloc] init];
    vc.groundId = self.groundId;
    vc.model = self.model;
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)toReservationRecordVC{
    ReservationRecordVC *vc = [[ReservationRecordVC alloc] init];
    vc.groundId = self.groundId;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)toChooseStudentsVC{
    ChooseStudentsVC *vc = [[ChooseStudentsVC alloc] init];
    vc.groundId = self.groundId;
    vc.model = self.model;
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark - 按钮代理
- (void)DataButTouchUpInset:(DataBut *)but{
    [self.selectBut change:self.selectBut.but];
    self.selectBut = but;
    float w = but.frame.origin.x - SCREEN_WIDTH/2;
    w = w > 0?w:0;
//    if (w > 0 ) {
    [UIView animateWithDuration:0.3 animations:^{
        self.scroll.contentOffset = CGPointMake(w, 0);
    }];
    KKLog(@"%@",self.dataArr[but.tag]);
    self.selectTime = [XLCommonUse TimeToInterceptYYYYMMddHHMMSS:self.dataArr[but.tag]];
    [self loadDataWithTime:self.selectTime];
//    }
    
}

- (void)loadDataWithTime:(NSString *)time{
    NSDictionary *dic = @{@"groundId":self.groundId,@"startTime":time};
//    NSString *url = [NSString stringWithFormat:POSTTrainingRecordTwoWeekRecords,self.groundId,time];
    NSString *url = POSTTrainingRecordTwoWeekRecords;
    [FMNetworkHelper fm_request_postWithUrlString:url isNeedCache:NO parameters:dic successBlock:^(id responseObject) {
        KKLog(@"%@",responseObject);
        if (kResponseObjectStatusCodeIsEqual(200)) {
            NSArray *arr = responseObject[@"towWeekList"];
            BOOL b = [responseObject[@"falg"] boolValue];
            if (b) {
                self.redlb.hidden = NO;
            }else{
                self.redlb.hidden = YES;
            }
            self.practiceCarDetailsVC.dataArr = responseObject[@"trainingInfoList"];
            self.practiceCarDetailsVC.selectTime = self.selectTime;
            [self.practiceCarDetailsVC.table reloadData];
            [self loadButWithArr:arr];
            self.empty.hidden = YES;
        }else if (kResponseObjectStatusCodeIsEqual(405)){
            self.empty.hidden = NO;
        }
        
    } failureBlock:^(NSError *error) {
        KKLog(@"%@", error);
        
    } progress:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];
}

- (void)loadButWithArr:(NSArray *)arr{
    if (arr.count == self.butArr.count) {
        for (int i = 0; i<self.butArr.count; i++) {
            DataBut *but = self.butArr[i];
            NSDictionary *dic = arr[i];
            but.num.text = [NSString stringWithFormat:@"已约%@人",dic[@"count"]];
            BOOL b =[dic[@"isOpen"] boolValue];
            if (self.selectBut == but) {
                continue;
            }
            if (b) {
                but.textColor = kColor_N(69, 138, 237);
                but.BKColor = kColor_N(206, 226, 251);
            }else{
                but.textColor = kColor_N(162, 172, 190);
                but.BKColor = kColor_N(235, 238, 243);
            }

        }
        NSDictionary *dic = arr[self.selectBut.tag];
        BOOL b =[dic[@"isOpen"] boolValue];
        if (b) {
            /// 开启
            self.emptytwo.hidden = YES;
            self.opne.title.text = @"开启预约";
            self.opne.subtitle.text = @"预约练车开启中，关闭后为休息日";
            self.opne.opne.on = YES;
            
        }else{
            ///  关闭状态
            self.emptytwo.hidden = NO;
            self.opne.title.text = @"休息";
            self.opne.subtitle.text = @"休息中，打开按钮，学员可预约练车";
            self.opne.opne.on = NO;
        }
        
    }
}



- (void)valueChanged:(UISwitch *)op{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    [dic setObject:self.groundId forKey:@"groundId"];
    [dic setObject:[XLCommonUse TimeToInterceptYYYYMMddWithStr:self.selectTime] forKey:@"openTime"];
    if (op.on) {
        [dic setObject:@"2" forKey:@"isOpen"];
    }else{
        [dic setObject:@"1" forKey:@"isOpen"];
    }
    [self toCloseOrOpen:dic];
}

- (void)toCloseOrOpen:(NSDictionary *)dic{
    NSString *url = POSTToCloseOrOpen;
    [FMNetworkHelper fm_request_postWithUrlString:url isNeedCache:NO parameters:dic successBlock:^(id responseObject) {
        KKLog(@"%@",responseObject);
        if (kResponseObjectStatusCodeIsEqual(200)) {
            NSString *str;
            if ([dic[@"isOpen"]  isEqual: @"1"]) {
                str = @"关闭预约成功，当天为休息时间，学员不可预约练车哦";
            }else{
                str = @"开启预约成功，学员可以预约练车";
            }
            XLAlertView *alert = [[XLAlertView alloc] initWithTitle:@"提示" message:str sureBtn:@"确定" cancleBtn:nil];
            alert.resultIndex = ^(NSInteger index) {
                
            };
            [alert showXLAlertView];
        }else{
            XLAlertView *alert = [[XLAlertView alloc] initWithTitle:@"提示" message:responseObject[@"message"] sureBtn:@"确定" cancleBtn:nil];
            alert.resultIndex = ^(NSInteger index) {
                
            };
            [alert showXLAlertView];
        }
        [self loadDataWithTime:self.selectTime];
        
    } failureBlock:^(NSError *error) {
        KKLog(@"%@", error);
        
    } progress:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];
}





- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadDataWithTime:self.selectTime];
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
