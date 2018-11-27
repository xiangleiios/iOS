//
//  ExamStudentsListVC.m
//  MobileProject
//
//  Created by 向蕾 on 2018/10/18.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import "ExamStudentsListVC.h"
#import "UITableView+FMPlaceholder.h"
#import "ExamStudentsCell.h"
#import "ExamStudentsDetailsVC.h"
#import "CGXPickerView.h"
@interface ExamStudentsListVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic , strong)UITableView *table;
@property (nonatomic , strong)NSMutableArray <FMMainModel *>*dataArr;
@end

@implementation ExamStudentsListVC
- (NSMutableDictionary *)dic{
    if (_dic == nil) {
        _dic = [NSMutableDictionary dictionary];
        [_dic setObject:@"20" forKey:@"pageSize"];
    }
    return _dic;
}
- (NSMutableArray *)dataArr{
    if (_dataArr==nil) {
        _dataArr=[NSMutableArray array];
    }
    return _dataArr;
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
        make.top.left.right.bottom.mas_equalTo(self.view);
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
//    [self headerRefresh];
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
    NSString *url;
    if (USERFZR) {
        url = POSTTeamStuStateList;
    }else{
        url = POSTCoachTeamStuStateList;
    }
    
    [FMNetworkHelper fm_request_postWithUrlString:url isNeedCache:NO parameters:self.dic successBlock:^(id responseObject) {
        KKLog(@"%@",responseObject);
        if (self.pageNum==1) {
            [self.dataArr removeAllObjects];
        }
        NSArray *tpArray = responseObject[@"data"][@"rows"];
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
    NSString *cellID = [NSString stringWithFormat:@"ExamStudentsCell"];
    ExamStudentsCell *cell = (ExamStudentsCell *)[tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[ExamStudentsCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    cell.model = self.dataArr[indexPath.row];
    cell.state.tag = indexPath.row;
    [cell.state addTarget:self action:@selector(chooseKM:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return KFit_H6S(150);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ExamStudentsDetailsVC *vc = [[ExamStudentsDetailsVC alloc] init];
    vc.model = self.dataArr[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
    
}


- (void)chooseKM:(UIButton *)senter{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    FMMainModel *model = self.dataArr[senter.tag];
    [dic setObject:model.idid forKey:@"id"];
    [CGXPickerView showStringPickerWithTitle:@"请选择科目" DataSource:@[@"科目一",@"科目二",@"科目三",@"科目四",@"拿证",@"作废（补考五次挂科）"] DefaultSelValue:nil IsAutoSelect:NO ResultBlock:^(id selectValue, id selectRow) {
        NSLog(@"%@  %@",selectValue,selectRow);
        int i= [selectRow intValue];
        [dic setObject:[NSString stringWithFormat:@"%d",(i + 1)] forKey:@"progress"];
        if (i == 5) {
            XLAlertView *alert = [[XLAlertView alloc] initWithTitle:@"提示" message:@"是否更改为作废" sureBtn:@"确定" cancleBtn:@"取消"];
            [alert showXLAlertView];
            alert.resultIndex = ^(NSInteger index) {
                if (index == 2) {
                    [self teamStuStateEdit:dic AndModel:model];
                }
            };
        }else{
            
            [self teamStuStateEdit:dic AndModel:model];
        }
        
    }];
}

- (void)teamStuStateEdit:(NSDictionary *)dic AndModel:(FMMainModel *)model{
    NSString *url =POSTTeamStuStateEdit;
    [FMNetworkHelper fm_request_postWithUrlString:url isNeedCache:NO parameters:dic successBlock:^(id responseObject) {
        [MBProgressHUD hideHUD];
        KKLog(@"%@",responseObject);
        if (kResponseObjectStatusCodeIsEqual(200)) {
            [MBProgressHUD showMsgHUD:@"修改成功"];
            [self.dataArr removeObject:model];
            [self.table reloadData];
            [self.vc loadRefreshData];
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
