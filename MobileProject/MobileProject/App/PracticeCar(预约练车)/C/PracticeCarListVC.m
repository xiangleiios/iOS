//
//  PracticeCarListVC.m
//  MobileProject
//
//  Created by 向蕾 on 2018/10/18.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import "PracticeCarListVC.h"
#import "UITableView+FMPlaceholder.h"
#import "PracticeCarCell.h"
#import "PracticeCarVC.h"
#import "TrainingVC.h"
@interface PracticeCarListVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic , strong)UITableView *table;
@property (nonatomic , strong)NSMutableArray <FMMainModel *>*dataArr;

@end

@implementation PracticeCarListVC
- (NSMutableArray *)dataArr{
    if (_dataArr ==nil) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationView setTitle:@"预约练车"];
    [self loadtable];
    // Do any additional setup after loading the view.
}
- (void)loadtable{
    self.table=[[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.view addSubview:self.table];
    [self.table mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).mas_offset(kNavBarH);
        make.left.right.bottom.mas_equalTo(self.view);
    }];
    self.table.delegate=self;
    self.table.dataSource=self;
    
    //设置可编辑
    //    self.table.allowsMultipleSelectionDuringEditing = YES;
    _table.tableFooterView = [UIView new];
    self.table.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.table.mj_header=[XLHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefresh)];
    //    self.table.mj_footer=[MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefresh)];
    UIButton *but = [[UIButton alloc] init];
    [but setTitle:@"立即添加" forState:UIControlStateNormal];
    [but addTarget:self action:@selector(toTrainingVC) forControlEvents:UIControlEventTouchUpInside];
    [but setBackgroundImage:[UIImage imageWithColor:kColor_N(0, 112, 234)] forState:UIControlStateNormal];
    if (USERFZR) {
        [self.table addEmptyViewWithImageName:@"placeholder" title:@"还没有添加训练场信息哦~" But:but];
    }else{
        [self.table addEmptyViewWithImageName:@"placeholder" title:@"还没有添加训练场信息哦~" But:nil];
    }
    
    _table.emptyView.hidden = YES;
    self.table.backgroundColor = kColor_N(240, 240, 240);
    _table.mj_footer.ignoredScrollViewContentInsetBottom = iPhoneX;
    
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
    NSString *url = POSTTrainingRecordTrainingList;
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
        if (self.dataArr.count > 0) {
            _table.emptyView.hidden = YES;
        }else{
            _table.emptyView.hidden = NO;
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
//    return 0;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellID = [NSString stringWithFormat:@"PracticeCarCell"];
    PracticeCarCell *cell = (PracticeCarCell *)[tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[PracticeCarCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    cell.model = self.dataArr[indexPath.row];
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return KFit_H6S(230);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    PracticeCarVC *vc = [[PracticeCarVC alloc] init];
    FMMainModel *model = self.dataArr[indexPath.row];
    vc.groundId =model.teamTrainning[@"teamTrainingId"];
    vc.model = model;
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)toTrainingVC{
    TrainingVC *vc = [[TrainingVC alloc] init];
    vc.type = 1;
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
