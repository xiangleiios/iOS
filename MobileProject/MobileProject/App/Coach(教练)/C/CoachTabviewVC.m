//
//  CoachTabviewVC.m
//  MobileProject
//
//  Created by 向蕾 on 2018/12/4.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import "CoachTabviewVC.h"
#import "UITableView+FMPlaceholder.h"
#import "CoachCell.h"
#import "BusinessCardVC.h"
@interface CoachTabviewVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic , strong)UITableView *table;
@property (nonatomic , strong)NSMutableArray <FMMainModel *>*dataArr;

@end

@implementation CoachTabviewVC
- (NSMutableArray *)dataArr{
    if (_dataArr ==nil) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

- (NSMutableDictionary *)dic{
    if (_dic == nil) {
        _dic = [NSMutableDictionary dictionary];
    }
    return _dic;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadtable];
    // Do any additional setup after loading the view.
}
- (void)loadtable{
    self.table=[[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.view addSubview:self.table];
    [self.table mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(self.sousuoview.mas_bottom);
        make.bottom.top.left.right.mas_equalTo(self.view);
//        make.bottom.mas_equalTo(self.view).mas_offset(-KFit_H6S(150));
    }];
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
    NSString *url = POSTTeamSchoolCoachCoachList;
    [FMNetworkHelper fm_request_postWithUrlString:url isNeedCache:NO parameters:self.dic successBlock:^(id responseObject) {
        KKLog(@"%@",responseObject);
        NSArray *tpArray = responseObject[@"list"][@"rows"];
        if (tpArray.count < 1 && self.dic) {
            [MBProgressHUD showMsgHUD:@"暂无结果"];
        }
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
    return self.dataArr.count;
    //    return 2;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellID = [NSString stringWithFormat:@"FMTableViewCell"];
    CoachCell *cell = (CoachCell *)[tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[CoachCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    cell.model = self.dataArr[indexPath.row];
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    //    CoachCell *cell = (CoachCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
    //    return [cell getLayoutCellHeightWithFlex:KFit_H6P(30)];
    return KFit_H6S(180);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    BusinessCardVC *vc = [[BusinessCardVC alloc] init];
    vc.type = @"school";
    vc.model = self.dataArr[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
    [vc.navigationView setTitle:@"教练详情"];
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
