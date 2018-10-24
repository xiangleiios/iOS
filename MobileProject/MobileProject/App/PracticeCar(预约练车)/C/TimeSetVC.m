//
//  TimeSetVC.m
//  MobileProject
//
//  Created by 向蕾 on 2018/10/19.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import "TimeSetVC.h"
#import "UITableView+FMPlaceholder.h"
#import "TimeSetCell.h"
#import "XLInformationV.h"
#import "EditTimeVC.h"
@interface TimeSetVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic , strong)UITableView *table;
@property (nonatomic , strong)NSMutableArray <FMMainModel *>*dataArr;

@end

@implementation TimeSetVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationView setTitle:@"设置"];
    [self loadtable];
    // Do any additional setup after loading the view.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void)loadtable{
    self.table=[[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.view addSubview:self.table];
    [self.table mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).mas_offset(kNavBarH);
        make.left.right.bottom.mas_equalTo(self.view);
    }];
    self.table.delegate=self;
    self.table.dataSource=self;
    
    _table.tableHeaderView = [self headview];
    _table.tableFooterView = [self footerview];
    self.table.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.table.mj_header=[MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefresh)];
    _table.needPlaceholderView = YES;
    self.table.backgroundColor = kColor_N(240, 240, 240);
    __weak __typeof(self)weakSelf = self;
    _table.mj_footer.ignoredScrollViewContentInsetBottom = iPhoneX;
    _table.reloadBlock = ^{
        [weakSelf.table.mj_header beginRefreshing];
    };
    [self headerRefresh];
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


- (UIView *)headview{
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, KFit_H6S(170))];
    v.backgroundColor = [UIColor whiteColor];
    XLInformationV *ts = [[XLInformationV alloc] informationWithTitle:@"默认时段设置(设置以后对该训练场生效)"];
    [v addSubview:ts];
    [ts mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(v);
        make.height.mas_equalTo(KFit_H6S(85));
    }];
    
    UILabel *title = [[UILabel alloc] init];
    [v addSubview:title];
    title.text = @"可预约时间段";
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(v).mas_offset(KFit_W6S(30));
        make.bottom.mas_equalTo(v);
        make.top.mas_equalTo(ts.mas_bottom);
        make.width.mas_equalTo(KFit_W6S(400));
    }];
    
    UIButton *but = [[UIButton alloc] init];
    [v addSubview:but];
    but.layer.cornerRadius = 3;
    but.layer.masksToBounds = YES;
    but.titleLabel.font = [UIFont systemFontOfSize:kFit_Font6(16)];
    [but setTitle:@"+ 添加时段" forState:UIControlStateNormal];
    [but setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [but setBackgroundImage:[UIImage createImageWithColor:kColor_N(0, 112, 234)] forState:UIControlStateNormal];
    [but setBackgroundImage:[UIImage createImageWithColor:kRGBAColor(0, 112, 234, 0.6)] forState:UIControlStateHighlighted];
    [but addTarget:self action:@selector(toEditTimeVC) forControlEvents:UIControlEventTouchUpInside];
    [but mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(v).mas_offset(-KFit_W6S(30));
        make.centerY.mas_equalTo(title);
        make.height.mas_equalTo(KFit_H6S(50));
        make.width.mas_equalTo(KFit_W6S(200));
    }];
    UILabel *lb = [[UILabel alloc] init];
    lb.backgroundColor = kColor_N(240, 240, 240);
    [v addSubview:lb];
    [lb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(v);
        make.height.mas_equalTo(1);
    }];
    return v;
}


- (UIView *)footerview{
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, KFit_H6S(270))];
    v.backgroundColor = [UIColor whiteColor];
    XLInformationV *ts = [[XLInformationV alloc] informationWithTitle:@"训练场信息"];
    XLInformationV *name = [[XLInformationV alloc] informationWithTitle:@"训练场名称" SubTitle:@""];
    XLInformationV *address = [[XLInformationV alloc] informationWithTitle:@"训练场地址" SubTitle:@""];
    
    [v addSubview:ts];
    [v addSubview:name];
    [v addSubview:address];
    NSArray *arr = @[ts,name,address];
    [arr mas_distributeViewsAlongAxis:MASAxisTypeVertical withFixedSpacing:0.1 leadSpacing:0.1 tailSpacing:0.1];
    [arr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(v);
    }];
    return v;
}

- (void)toEditTimeVC{
    EditTimeVC *vc = [[EditTimeVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    [vc.navigationView setTitle:@"添加时段"];
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
    NSString *cellID = [NSString stringWithFormat:@"TimeSetCell"];
    TimeSetCell *cell = (TimeSetCell *)[tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[TimeSetCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    cell.model = self.dataArr[indexPath.row];
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return KFit_H6S(120);
}
@end
