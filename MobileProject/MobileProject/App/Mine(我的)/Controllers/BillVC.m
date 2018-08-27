//
//  BillVC.m
//  MobileProject
//
//  Created by zsgy on 2018/6/22.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import "BillVC.h"
#import "UITableView+FMPlaceholder.h"
#import "BillCell.h"
@interface BillVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic , strong)UITableView *table;
@property (nonatomic , strong)NSMutableArray *dataArr;
@end

@implementation BillVC
- (NSMutableArray *)dataArr{
    if (_dataArr==nil) {
        _dataArr=[NSMutableArray array];
    }
    return _dataArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationView setTitle:@"账户流水明细"];
    [self loadtable];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)loadtable{
    self.table=[[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.view addSubview:self.table];
    [self.table mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view).mas_offset(kNavBarH);
    }];
    self.table.delegate=self;
    self.table.dataSource=self;
    
    //设置可编辑
    //    self.table.allowsMultipleSelectionDuringEditing = YES;
    _table.tableFooterView = [UIView new];
    self.table.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.table.mj_header=[MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefresh)];
    self.table.mj_footer=[MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefresh)];
    [self headerRefresh];
    _table.needPlaceholderView = YES;
    __weak __typeof(self)weakSelf = self;
    _table.reloadBlock = ^{
        [weakSelf.table.mj_header beginRefreshing];
    };
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
    NSString *url = [NSString stringWithFormat:GETMembersAccountDetail,[User UserOb].token,self.pageNum];
    [FMNetworkHelper fm_request_getWithUrlString:url isNeedCache:NO parameters:nil successBlock:^(id responseObject) {
        NSArray *tpArray = responseObject[@"data"];
        if (self.pageNum==1) {
            [self.dataArr removeAllObjects];
        }
        if (tpArray) {
            for (NSDictionary *dic in tpArray) {
                AccountModel *mode=[AccountModel mj_objectWithKeyValues:dic];
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
    NSString *cellID = [NSString stringWithFormat:@"BillCell"];
    BillCell * cell = [[BillCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    AccountModel *model = self.dataArr[indexPath.row];
    cell.model = model;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    BillCell *cell = (BillCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
    return [cell getLayoutCellHeight];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    AccountModel *model = self.dataArr[indexPath.row];
    
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
