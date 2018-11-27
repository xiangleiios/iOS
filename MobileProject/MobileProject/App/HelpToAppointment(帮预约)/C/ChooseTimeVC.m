//
//  ChooseTimeVC.m
//  MobileProject
//
//  Created by 向蕾 on 2018/10/22.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import "ChooseTimeVC.h"
#import "DataBut.h"
#import "UITableView+FMPlaceholder.h"
#import "ChooseTimeCell.h"
#import "PromptSuccessV.h"
#import "PracticeCarVC.h"
@interface ChooseTimeVC ()<DataButDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic , strong)UIScrollView *scroll;
@property (nonatomic , strong)NSArray *timeArr;
@property (nonatomic , strong)DataBut *selectBut;
@property (nonatomic , strong)UILabel *people;
@property (nonatomic , strong)UITableView *table;
@property (nonatomic , strong)NSString *selectTime;
@property (nonatomic , strong)NSMutableArray <FMMainModel *>*dataArr;
@property (nonatomic , strong)NSMutableArray *butArr;
@end

@implementation ChooseTimeVC
- (NSMutableArray *)dataArr{
    if (_dataArr ==nil) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}
- (NSMutableArray *)butArr{
    if (_butArr == nil) {
        _butArr = [NSMutableArray array];
    }
    return _butArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationView setTitle:@"选择时间"];
    self.timeArr = [XLCommonUse dataWhithDay:14];
    self.selectTime = [XLCommonUse TimeToInterceptYYYYMMddHHMMSS:self.timeArr[0]];
    [self loadSub];
    [self loadscroll];
    
    [self loadtable];
    
    [self loadBut];
    
    [[XLSingleton singleton].timeArr removeAllObjects];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(studentsSubmit:) name:@"NotificationPracticeStudentsTimeSubmit" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(studentsDelete:) name:@"NotificationPracticeStudentsTimeDelete" object:nil];
    
    // Do any additional setup after loading the view.
}
- (void)loadSub{
    self.people = [[UILabel alloc] init];
    [self.view addSubview:self.people];
    self.people.textColor = ZTColor;
    self.people.font = [UIFont systemFontOfSize:kFit_Font6(15)];
    self.people.textAlignment = NSTextAlignmentCenter;
    self.people.backgroundColor = kColor_N(240, 240, 240);
    [self.people mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view).mas_offset(kNavBarH);
        make.height.mas_equalTo(KFit_H6S(80));
    }];
    NSMutableString *str = [NSMutableString stringWithFormat:@"您已选择"];
    XLSingleton *sing = [XLSingleton singleton];
    for (int i = 0; i < sing.practiceArr.count; i ++) {
        NSDictionary *dic = sing.practiceArr[i];
        [str appendString:[NSString stringWithFormat:@"%@,",dic[@"name"]]];
        if (i == 3 ) {
            return;
        }
        
    }
    if (sing.practiceArr.count > 3) {
        [str appendString:[NSString stringWithFormat:@"等%ld名学员",sing.practiceArr.count]];
    }else{
        [str appendString:[NSString stringWithFormat:@"%ld名学员",sing.practiceArr.count]];
    }
    self.people.text = str;
    
}
- (void)loadscroll{
    self.scroll = [[UIScrollView alloc] init];
    [self.view addSubview:self.scroll];
    self.scroll.showsVerticalScrollIndicator = NO;
    self.scroll.showsHorizontalScrollIndicator = NO;
    [self.scroll mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.people.mas_bottom);
        make.height.mas_equalTo(KFit_H6S(225));
    }];
    float w = KFit_W6S(150);
    float h = KFit_H6S(160);
    for (int i = 0; i < self.timeArr.count; i++) {
        DataBut *but = [[DataBut alloc] initWithFrame:CGRectMake(KFit_W6S(30)+i * (w + KFit_W6S(15)), KFit_H6S(30), w, h)];
        [self.scroll addSubview:but];
        but.week.text = [XLCommonUse weekdayStringFromDate:self.timeArr[i]];
        but.data.text =  [XLCommonUse TimeToInterceptMMdd:self.timeArr[i]];
        but.num.text = @"已约0人";
        but.deleget = self;
        but.tag = i;
//        if (i < 3) {
//            but.textColor = kColor_N(69, 138, 237);
//            but.BKColor = kColor_N(206, 226, 251);
//        }else{
//            but.textColor = kColor_N(162, 172, 190);
//            but.BKColor = kColor_N(235, 238, 243);
//        }
        if (i == 0 ) {
            self.selectBut = but;
            [but change:but.but];
            but.week.text = @"今天";
        }
        [self.butArr addObject:but];
    }
    self.scroll.contentSize = CGSizeMake(KFit_W6S(30)+self.timeArr.count * (w + KFit_W6S(15)), 0);
}




- (void)loadtable{
    UILabel *lb = [[UILabel alloc] init];
    [self.view addSubview:lb];
    lb.backgroundColor = kColor_N(240, 240, 240);
    [lb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.scroll.mas_bottom);
        make.height.mas_equalTo(KFit_H6S(20));
    }];
    self.table=[[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.view addSubview:self.table];
    [self.table mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lb.mas_bottom);
        make.left.right.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view).mas_offset(-KFit_H6S(150));
    }];
    self.table.delegate=self;
    self.table.dataSource=self;
    
    //设置可编辑
    //    self.table.allowsMultipleSelectionDuringEditing = YES;
    _table.tableFooterView = [UIView new];
    self.table.separatorStyle = UITableViewCellSeparatorStyleNone;
    _table.needPlaceholderView = YES;
    self.table.backgroundColor = kColor_N(240, 240, 240);
    __weak __typeof(self)weakSelf = self;
    _table.mj_footer.ignoredScrollViewContentInsetBottom = iPhoneX;
    _table.reloadBlock = ^{
        [weakSelf.table.mj_header beginRefreshing];
    };

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
    [next setTitle:@"完成" forState:UIControlStateNormal];
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

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self loadDataWithTime:self.selectTime];
    //    [self.table.mj_header beginRefreshing];
}



#pragma mark-tableview代理
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
    
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellID = [NSString stringWithFormat:@"ChooseTimeCell"];
    ChooseTimeCell *cell = (ChooseTimeCell *)[tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[ChooseTimeCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    [cell.but addTarget:self action:@selector(choose:) forControlEvents:UIControlEventTouchUpInside];
    cell.model = self.dataArr[indexPath.row];
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return KFit_H6S(160);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    PracticeCarVC *vc = [[PracticeCarVC alloc] init];
//
//    //    vc.model = self.dataArr[indexPath.row];
//    [self.navigationController pushViewController:vc animated:YES];
    
}





- (void)next{
    [self trainingRecordAdd];
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
    XLSingleton *single = [XLSingleton singleton];
    [single.timeArr removeAllObjects];
    self.selectTime = [XLCommonUse TimeToInterceptYYYYMMddHHMMSS:self.timeArr[but.tag]];
    [self loadDataWithTime:self.selectTime];
    //    }
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void)loadDataWithTime:(NSString *)time{
    NSDictionary *dic = @{@"groundId":self.groundId,@"startTime":time};
    //    NSString *url = [NSString stringWithFormat:POSTTrainingRecordTwoWeekRecords,self.groundId,time];
    NSString *url = POSTTrainingRecordTwoWeekRecords;
    [FMNetworkHelper fm_request_postWithUrlString:url isNeedCache:NO parameters:dic successBlock:^(id responseObject) {
        KKLog(@"%@",responseObject);
        if (kResponseObjectStatusCodeIsEqual(200)) {
            [self.dataArr removeAllObjects];
            NSArray *week = responseObject[@"towWeekList"];
            [self loadButWithArr:week];
            NSArray *arr = responseObject[@"trainingInfoList"];
            if (arr) {
                for (NSDictionary *dic in arr) {
                    FMMainModel *model = [FMMainModel mj_objectWithKeyValues:dic];
                    [self.dataArr addObject:model];
                }
            }
            [self.table reloadData];
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
    }
}
-(void)dealloc{
    //移除观察者，Observer不能为nil
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - 提交资料
- (void)studentsSubmit:(NSNotification *)idid{
    NSDictionary *dic = [idid object];
    XLSingleton *single = [XLSingleton singleton];
    if ([single.timeArr containsObject: dic]) {
        return;
    }
    //    ;
    [single.timeArr addObject:dic];
    KKLog(@"%@",single.timeArr);
}

- (void)studentsDelete:(NSNotification *)idid{
    NSDictionary *dic = [idid object];
    XLSingleton *single = [XLSingleton singleton];
    [single.timeArr removeObject:dic];
    KKLog(@"%@",single.timeArr);
    
}

- (void)choose:(UIButton *)senter{
    senter.selected = !senter.selected;
    KKLog(@"%ld",(long)senter.tag);
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    for (FMMainModel *model in self.dataArr) {
        if ([model.idid integerValue] == senter.tag) {
            [dic setValue:model.idid forKey:@"idid"];
            
            NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
            [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
            NSDate* date = [formatter dateFromString:model.startTime];
            NSString *time = [NSString stringWithFormat:@"%@(%@)%@-%@",[XLCommonUse TimeToInterceptYYYYMMddWithStr:model.startTime],[XLCommonUse weekdayStringFromDate:date],model.startDay,model.endDay];
            [dic setValue:time forKey:@"time"];
        }
    }
    if (senter.selected) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"NotificationPracticeStudentsTimeSubmit" object:dic];
    }else{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"NotificationPracticeStudentsTimeDelete" object:dic];
    }
}



- (void)trainingRecordAdd{
    
    
    
    XLSingleton *sing = [XLSingleton singleton];
    if (sing.timeArr.count < 1) {
        [MBProgressHUD showMsgHUD:@"请至少选择一个时段"];
        return;
    }
    NSDictionary *dic = [NSMutableDictionary dictionary];
    
    NSMutableArray *codeArr = [NSMutableArray array];
    NSMutableArray *studentPhoneArr = [NSMutableArray array];;
    for (NSDictionary *dic in sing.practiceArr) {
        [codeArr addObject:dic[@"sysStudentCode"]];
        [studentPhoneArr addObject:dic[@"studentPhone"]];
    }
    NSMutableArray *tiemArr = [NSMutableArray array];
    NSMutableArray *idArr = [NSMutableArray array];
    for (NSDictionary *dic in sing.timeArr) {
        [idArr addObject:dic[@"idid"]];
        [tiemArr addObject:dic[@"time"]];
    }
    [dic setValue:[codeArr componentsJoinedByString:@","] forKey:@"sysStudentCode"];
    [dic setValue:[idArr componentsJoinedByString:@","] forKey:@"ids"];
    [dic setValue:_model.teamTrainning[@"address"] forKey:@"groundAddress"];
    [dic setValue:_model.teamTrainning[@"teamTrainingName"] forKey:@"groundName"];
    [dic setValue:self.groundId forKey:@"groundId"];
    [MBProgressHUD showLoadingHUD:@"正在提交"];
    NSString *url = POSTTrainingRecordAdd;
    [FMNetworkHelper fm_request_postWithUrlString:url isNeedCache:NO parameters:dic successBlock:^(id responseObject) {
        KKLog(@"%@",responseObject);
        [MBProgressHUD hideHUD];
        if (kResponseObjectStatusCodeIsEqual(200)) {
            [MBProgressHUD showMsgHUD:@"提交成功"];
            
            PromptSuccessV * v = [[PromptSuccessV alloc] init];
            v.groundName = _model.teamTrainning[@"teamTrainingName"];
            v.groundAddress = _model.teamTrainning[@"address"];
            v.studentPhoneArr = studentPhoneArr;
            v.teamSchoolName = _model.teamTrainning[@"teamSchoolName"];
            v.tiemArr = tiemArr;
            v.vc = self;
            [v show];
            
            
            [sing.practiceArr removeAllObjects];
            [sing.timeArr removeAllObjects];
        }else{
            [MBProgressHUD showMsgHUD:responseObject[@"message"]];
//            [sing.timeArr removeAllObjects];
        }
    } failureBlock:^(NSError *error) {
        [MBProgressHUD hideHUD];
        KKLog(@"%@", error);
        
    } progress:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];
}
@end
