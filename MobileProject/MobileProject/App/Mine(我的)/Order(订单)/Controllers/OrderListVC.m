//
//  OrderListVC.m
//  MobileProject
//
//  Created by zsgy on 2017/11/13.
//  Copyright © 2017年 ZSGY. All rights reserved.
//

#import "OrderListVC.h"
#import "OrderCell.h"
#import "FMPayVC.h"
#import "FMOutTicketVC.h"
#import "UITableView+FMPlaceholder.h"
#import "OrderDetailsVC.h"
@interface OrderListVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic , strong)UITableView *table;
@property (nonatomic , strong)NSMutableArray <FMMainModel *>*dataArr;
@end

@implementation OrderListVC
- (NSMutableArray *)dataArr{
    if (_dataArr==nil) {
        _dataArr=[NSMutableArray array];
    }
    return _dataArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadtable];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)loadtable{
    self.table=[[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.view addSubview:self.table];
    [self.table mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.mas_equalTo(self.view);
    }];
    self.table.delegate=self;
    self.table.dataSource=self;
    
    //设置可编辑
//    self.table.allowsMultipleSelectionDuringEditing = YES;
    _table.tableFooterView = [UIView new];
    self.table.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.table.mj_header=[MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefresh)];
    self.table.mj_footer=[MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefresh)];
    _table.needPlaceholderView = YES;
    __weak __typeof(self)weakSelf = self;
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
    NSString *url=[NSString stringWithFormat:GETordersList,self.pageNum,[User UserOb].token,self.orderType];
    [FMNetworkHelper fm_request_getWithUrlString:url isNeedCache:NO parameters:nil successBlock:^(id responseObject) {
        NSArray *tpArray = responseObject[@"data"];
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
}

#pragma mark-tableview代理
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellID = [NSString stringWithFormat:@"OrderCell"];
    OrderCell *cell = (OrderCell *)[tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
    cell = [[OrderCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    cell.model = self.dataArr[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return KFit_H6S(480);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    FMMainModel *model = self.dataArr[indexPath.row];
    model.read = 1;
    OrderDetailsVC *vc = [[OrderDetailsVC alloc] init];
    vc.title = model.code;
    vc.model = model;
    [self.navigationController pushViewController:vc animated:YES];
    [self.table reloadData];
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
