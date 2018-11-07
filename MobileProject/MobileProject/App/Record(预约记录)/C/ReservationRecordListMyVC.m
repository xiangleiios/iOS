//
//  ReservationRecordListMyVC.m
//  MobileProject
//
//  Created by 向蕾 on 2018/10/27.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import "ReservationRecordListMyVC.h"

#import "UITableView+FMPlaceholder.h"
#import "ReservationRecordCell.h"
#import "ReservationDetailsVC.h"
#import "CGXPickerView.h"
@interface ReservationRecordListMyVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic , strong)UITableView *table;
@property (nonatomic , strong)NSMutableArray <FMMainModel *>*dataArr;

@end

@implementation ReservationRecordListMyVC
- (NSMutableArray *)dataArr{
    if (_dataArr ==nil) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationView setTitle:@"练车记录"];
    [self loadtable];
    // Do any additional setup after loading the view.
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
    self.table.mj_header=[XLHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefresh)];
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
    NSString *url = POSTGetStuRecordsList;
    [FMNetworkHelper fm_request_postWithUrlString:url isNeedCache:NO parameters:_dic successBlock:^(id responseObject) {
        KKLog(@"%@",responseObject);
        NSArray *tpArray = responseObject[@"trainingRecords"];
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
    //    return 3;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellID = [NSString stringWithFormat:@"ReservationRecordCell"];
    ReservationRecordCell *cell = (ReservationRecordCell *)[tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[ReservationRecordCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    cell.model = self.dataArr[indexPath.row];
    [cell.butOne addTarget:self action:@selector(cancel:) forControlEvents:UIControlEventTouchUpInside];
    [cell.butTwo addTarget:self action:@selector(deleteOrduanxing:) forControlEvents:UIControlEventTouchUpInside];
    cell.butOne.tag = indexPath.row;
    cell.butTwo.tag = indexPath.row;
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return KFit_H6S(320);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ReservationDetailsVC *vc = [[ReservationDetailsVC alloc] init];
    vc.model = self.dataArr[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
    
}

#pragma mark - 删除预约
- (void)deleteOrduanxing:(UIButton *)senter{
    FMMainModel *model = self.dataArr[senter.tag];
    if ([model.type intValue] == 0|| [model.type intValue] == 1) {
        //发短信
        
    }else{
        //删除
        NSString *url = [NSString stringWithFormat:POSTTrainingRecordDelete,model.idid];
        [self deleteWithURL:url];
    }
}

- (void)deleteWithURL:(NSString *)url{
    XLAlertView *alert = [[XLAlertView alloc] initWithTitle:@"提示" message:@"删除后，无法查看该学员此次预约记录，是否确认删除" sureBtn:@"确定" cancleBtn:@"去想想"];
    [alert showXLAlertView];
    alert.resultIndex = ^(NSInteger index) {
        if (index == 2) {
            [FMNetworkHelper fm_request_postWithUrlString:url isNeedCache:NO parameters:nil successBlock:^(id responseObject) {
                KKLog(@"%@",responseObject);
                if (kResponseObjectStatusCodeIsEqual(200)) {
                    [MBProgressHUD showMsgHUD:@"删除成功"];
                    [self headerRefresh];
                }
            } failureBlock:^(NSError *error) {
                KKLog(@"%@", error);
                
            } progress:^(int64_t bytesProgress, int64_t totalBytesProgress) {
                
            }];
        }
    };
    
}

#pragma mark - 取消预约
- (void)cancel:(UIButton *)senter{
    FMMainModel *model = self.dataArr[senter.tag];
    [CGXPickerView showStringPickerWithTitle:@"取消预约" DataSource:@[@"临时有事",@"今日休息",@"预约错误",@"其他原因",] DefaultSelValue:nil IsAutoSelect:NO ResultBlock:^(id selectValue, id selectRow) {
        NSLog(@"%@",selectValue);
        int i = [selectRow intValue];
        if (i == 3) {
            XLAlertView *alert = [[XLAlertView alloc] initWithInputboxTitle:@"请输入原因"];
            [alert showXLAlertView];
            alert.inputText = ^(NSString *text) {
                if (text.length < 1) {
                    [MBProgressHUD showMsgHUD:@"请输入原因"];
                    return ;
                }
                NSDictionary *dic = @{@"memo":text,@"id":model.idid};
                [self cancelByDic:dic];
            };
        }else{
            NSDictionary *dic = @{@"memo":selectValue,@"id":model.idid};
            [self cancelByDic:dic];
        }
    }];
}


- (void)cancelByDic:(NSDictionary *)dic{
    NSString *url = POSTCancelById;
    [FMNetworkHelper fm_request_postWithUrlString:url isNeedCache:NO parameters:dic successBlock:^(id responseObject) {
        KKLog(@"%@",responseObject);
        if (kResponseObjectStatusCodeIsEqual(200)) {
            [MBProgressHUD showMsgHUD:@"取消预约成功"];
            [self headerRefresh];
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
