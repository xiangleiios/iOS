//
//  TrainingListVC.m
//  MobileProject
//
//  Created by 向蕾 on 2018/10/17.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import "TrainingListVC.h"
#import "UITableView+FMPlaceholder.h"
#import "FMTableViewCell.h"
#import "TrainingVC.h"

@interface TrainingListVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic , strong)UITableView *table;
@property (nonatomic , strong)NSMutableArray <FMMainModel *>*dataArr;
@property (nonatomic , strong)NSMutableArray <FMCoachModel *>*coachArr;

@end

@implementation TrainingListVC
- (NSMutableArray *)dataArr{
    if (_dataArr ==nil) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}
- (NSMutableArray *)coachArr{
    if (_coachArr == nil) {
        _coachArr = [NSMutableArray array];
    }
    return _coachArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationView setTitle:@"训练场"];
    [self loadtable];
    if (USERFZR) {
        [self loadBut];
    }
    // Do any additional setup after loading the view.
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
    [next setTitle:@"添加训练场" forState:UIControlStateNormal];
    [next addTarget:self action:@selector(addAddress) forControlEvents:UIControlEventTouchUpInside];
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

- (void)loadtable{
    self.table=[[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.view addSubview:self.table];
    if (USERFZR) {
        [self.table mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.view).mas_offset(kNavBarH);
            make.left.right.mas_equalTo(self.view);
            make.bottom.mas_equalTo(self.view).mas_offset(-KFit_H6S(150));
        }];
    }else{
        [self.table mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.view).mas_offset(kNavBarH);
            make.left.right.mas_equalTo(self.view);
            make.bottom.mas_equalTo(self.view);
        }];
    }
    
    self.table.delegate=self;
    self.table.dataSource=self;
    
    //设置可编辑
    //    self.table.allowsMultipleSelectionDuringEditing = YES;
    _table.tableFooterView = [UIView new];
    self.table.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.table.mj_header=[XLHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefresh)];
    //    self.table.mj_footer=[MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefresh)];
    _table.needPlaceholderView = YES;
    self.table.backgroundColor = kColor_N(240, 240, 240);
    __weak __typeof(self)weakSelf = self;
    _table.mj_footer.ignoredScrollViewContentInsetBottom = iPhoneX;
    _table.reloadBlock = ^{
        [weakSelf.table.mj_header beginRefreshing];
    };
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self headerRefresh];
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
    NSString *url = POSTTeamtrainingList;
    [FMNetworkHelper fm_request_postWithUrlString:url isNeedCache:NO parameters:nil successBlock:^(id responseObject) {
        KKLog(@"%@",responseObject);
        NSArray *tpArray = responseObject[@"data"][@"rows"];
        NSArray *coacharr = responseObject[@"coachList"];
        if (self.pageNum==1) {
            [self.dataArr removeAllObjects];
        }
        if (tpArray) {
            for (NSDictionary *dic in tpArray) {
                FMMainModel *mode=[FMMainModel mj_objectWithKeyValues:dic];
                [self.dataArr addObject:mode];
            }
        }
        [self.coachArr removeAllObjects];
        for (NSDictionary *dic in coacharr) {
            FMCoachModel *model = [FMCoachModel mj_objectWithKeyValues:dic];
            [self.coachArr addObject:model];
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
    return self.dataArr.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellID = [NSString stringWithFormat:@"FMTableViewCell"];
    FMTableViewCell *cell = (FMTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[FMTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    cell.model = self.dataArr[indexPath.row];
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return KFit_H6S(160);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    TrainingVC *vc = [[TrainingVC alloc] init];
    vc.type = 0;
    vc.coachArr = self.coachArr;
    vc.model = self.dataArr[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
    [vc.navigationView setTitle:@"训练场详情"];
}


- (void)addAddress{
    TrainingVC *vc = [[TrainingVC alloc] init];
    vc.type = 1;
    vc.coachArr = self.coachArr;
    [self.navigationController pushViewController:vc animated:YES];
    [vc.navigationView setTitle:@"添加训练场"];
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
