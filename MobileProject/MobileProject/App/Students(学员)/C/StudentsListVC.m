//
//  StudentsListVC.m
//  MobileProject
//
//  Created by 向蕾 on 2018/8/24.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import "StudentsListVC.h"
#import "UITableView+FMPlaceholder.h"
#import "StudentsOneCell.h"
#import "StudentsTwoCell.h"
#import "StudentDetailsEditorVC.h"
#import "StudentDetailsVC.h"
@interface StudentsListVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic , strong)UITableView *table;
@property (nonatomic , strong)NSMutableArray <FMMainModel *>*dataArr;
@end

@implementation StudentsListVC
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
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(headerRefresh) name:@"NotificationStudentsListHeaderRefresh" object:nil];
    // Do any additional setup after loading the view.
}

-(void)dealloc{
    //移除观察者，Observer不能为nil
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (NSInteger)pageNum {
    
    if (_pageNum < 1) {
        _pageNum = 1;
    }
    
    return _pageNum;
}

- (NSInteger)pageSize {
    
    if (_pageSize < 1) {
        _pageSize = 20;
    }
    return _pageSize;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    __weak __typeof(self)weakSelf = self;
    _table.reloadBlock = ^{
        [weakSelf.table.mj_header beginRefreshing];
    };
    [self headerRefresh];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self headerRefresh];
    //    [self.table.mj_header beginRefreshing];
}

- (void)headerRefresh{
    self.pageNum=1;
    [self.dic setObject:[NSNumber numberWithInteger:self.pageNum] forKey:@"pageNum"];
    [_dic setObject:@"20" forKey:@"pageSize"];
    [self loadRefreshData];
}
- (void)footerRefresh{
    self.pageNum++;
    [self.dic setObject:[NSNumber numberWithInteger:self.pageNum] forKey:@"pageNum"];
    [self loadRefreshData];
}
- (void)loadRefreshData{
//    NSString *urlstr = [NSString stringWithFormat:@"%@?pageNum=%ld&pageSize=20",self.url,self.pageNum];
    [FMNetworkHelper fm_request_postWithUrlString:_url isNeedCache:NO parameters:self.dic successBlock:^(id responseObject) {
        KKLog(@"%@",responseObject);
        
        NSArray *tpArray;
        if (self.PayCost) {
            tpArray =responseObject[@"list"];
        }else{
            NSDictionary *listDic = responseObject[@"list"];
            tpArray = listDic[@"rows"];
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
}

#pragma mark-tableview代理
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.PayCost) {
        NSString *cellID = [NSString stringWithFormat:@"StudentsOneCell"];
        StudentsOneCell *cell = (StudentsOneCell *)[tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell = [[StudentsOneCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
        }
        cell.type = CellTypeBaoMinXueYuan;
        cell.model = self.dataArr[indexPath.row];
        return cell;
    }else{
        NSString *cellID = [NSString stringWithFormat:@"StudentsTwoCell"];
        StudentsTwoCell *cell = (StudentsTwoCell *)[tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell = [[StudentsTwoCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
        }
        
        [cell.selelctBut addTarget:self action:@selector(choose:) forControlEvents:UIControlEventTouchUpInside];
        cell.model = self.dataArr[indexPath.row];
        return cell;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return KFit_H6S(150);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    FMMainModel *model = self.dataArr[indexPath.row];
    
    KKLog(@"----%@ ----------%@",model.signupState,model.auditState);
    //1 报名到总校，2、未报名到总校
    if ([model.signupState  isEqual: @"1"]) {
        // 1 未审核，2、审核通过、3、拒绝
        if ([model.auditState  isEqual:@"1"]) {
            StudentDetailsVC *vc = [[StudentDetailsVC alloc] init];
            vc.model = self.dataArr[indexPath.row];
            [self.navigationController pushViewController:vc animated:YES];
        }else if ([model.auditState  isEqual:@"2"]){
            StudentDetailsVC *vc = [[StudentDetailsVC alloc] init];
            vc.model = self.dataArr[indexPath.row];
            [self.navigationController pushViewController:vc animated:YES];
        }else if ([model.auditState  isEqual:@"3"]){
            StudentDetailsEditorVC *vc = [[StudentDetailsEditorVC alloc] init];
            vc.PayCost = self.PayCost;
            vc.model = self.dataArr[indexPath.row];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }else{
        StudentDetailsEditorVC *vc = [[StudentDetailsEditorVC alloc] init];
        vc.PayCost = self.PayCost;
        vc.model = self.dataArr[indexPath.row];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    
}

- (void)choose:(UIButton *)senter{
    senter.selected = !senter.selected;
    KKLog(@"%ld",(long)senter.tag);
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    for (FMMainModel *model in self.dataArr) {
        if ([model.idid integerValue] == senter.tag) {
            [dic setValue:model.studentName forKey:@"name"];
            [dic setValue:model.idid forKey:@"idid"];
        }
    }
    if (senter.selected) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"NotificationStudentsSubmit" object:dic];
    }else{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"NotificationStudentsDelete" object:dic];
    }
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
