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
@interface ChooseTimeVC ()<DataButDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic , strong)UIScrollView *scroll;
@property (nonatomic , strong)NSArray *timeArr;
@property (nonatomic , strong)DataBut *selectBut;
@property (nonatomic , strong)UILabel *people;
@property (nonatomic , strong)UITableView *table;
@property (nonatomic , strong)NSMutableArray <FMMainModel *>*dataArr;
@end

@implementation ChooseTimeVC
- (NSMutableArray *)dataArr{
    if (_dataArr ==nil) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationView setTitle:@"选择时间"];
    self.timeArr = [XLCommonUse dataWhithDay:15];
    [self loadSub];
    [self loadscroll];
    
    [self loadtable];
    
    [self loadBut];
    // Do any additional setup after loading the view.
}
- (void)loadSub{
    self.people = [[UILabel alloc] init];
    [self.view addSubview:self.people];
    self.people.textAlignment = NSTextAlignmentCenter;
    self.people.backgroundColor = kColor_N(240, 240, 240);
    [self.people mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view).mas_offset(kNavBarH);
        make.height.mas_equalTo(KFit_H6S(80));
    }];
    
    
    
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
        if (i < 3) {
            but.textColor = kColor_N(69, 138, 237);
            but.BKColor = kColor_N(206, 226, 251);
        }else{
            but.textColor = kColor_N(162, 172, 190);
            but.BKColor = kColor_N(235, 238, 243);
        }
        if (i == 0 ) {
            self.selectBut = but;
            [but change:but.but];
        }
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
    self.table.mj_header=[MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefresh)];
    //    self.table.mj_footer=[MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefresh)];
    _table.needPlaceholderView = YES;
    self.table.backgroundColor = kColor_N(240, 240, 240);
    __weak __typeof(self)weakSelf = self;
    _table.mj_footer.ignoredScrollViewContentInsetBottom = iPhoneX;
    _table.reloadBlock = ^{
        [weakSelf.table.mj_header beginRefreshing];
    };
    [self headerRefresh];
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
    //    [self.table.mj_header beginRefreshing];
}

- (void)headerRefresh{
    self.pageNum=1;
    
    [self loadRefreshData];
}
- (void)footerRefresh{
    self.pageNum++;
    [self loadRefreshData];
}
- (void)loadRefreshData{
    NSString *url = POSTTeamSchoolList;
    [FMNetworkHelper fm_request_postWithUrlString:url isNeedCache:NO parameters:nil successBlock:^(id responseObject) {
        KKLog(@"%@",responseObject);
        NSArray *tpArray = responseObject[@"list"];
        if (self.pageNum==1) {
            [self.dataArr removeAllObjects];
        }
        if (tpArray) {
            for (NSDictionary *dic in tpArray) {
                FMMainModel *mode=[FMMainModel mj_objectWithKeyValues:dic];
                [self.dataArr addObject:mode];
            }
        }
        [_table reloadData];
        [_table.mj_footer endRefreshing];
        [_table.mj_header endRefreshing];
    } failureBlock:^(NSError *error) {
        KKLog(@"%@", error);
        [_table.mj_footer endRefreshing];
        [_table.mj_header endRefreshing];
    } progress:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];
    //    POSTTeamSchoolList
}

#pragma mark-tableview代理
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //    return self.dataArr.count;
    return 3;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellID = [NSString stringWithFormat:@"ChooseTimeCell"];
    ChooseTimeCell *cell = (ChooseTimeCell *)[tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[ChooseTimeCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
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

@end
