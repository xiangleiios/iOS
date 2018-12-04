//
//  PosterListVC.m
//  MobileProject
//
//  Created by 向蕾 on 2018/9/29.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import "PosterListVC.h"
#import "UITableView+FMPlaceholder.h"
#import "PictureCell.h"
#import "PosterVC.h"
@interface PosterListVC ()<UITableViewDelegate,UITableViewDataSource,RemarksCellDelegate>
@property (nonatomic , strong)UITableView *table;
@property (nonatomic , strong)NSMutableArray <FMMainModel *>*dataArr;
@property (nonatomic , assign)NSInteger pageNum;
@property (nonatomic, strong) NSMutableDictionary *cellIsShowAll;
@end

@implementation PosterListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadtable];
    // Do any additional setup after loading the view.
}
- (NSMutableDictionary *)dic{
    if (_dic == nil) {
        _dic = [NSMutableDictionary dictionary];
        [_dic setObject:@"20" forKey:@"pageSize"];
    }
    return _dic;
}
- (NSMutableDictionary *)cellIsShowAll{
    if (_cellIsShowAll == nil) {
        _cellIsShowAll = [NSMutableDictionary dictionary];
    }
    return _cellIsShowAll;
}
- (NSMutableArray *)dataArr{
    if (_dataArr==nil) {
        _dataArr=[NSMutableArray array];
    }
    return _dataArr;
}
- (void)loadtable{
    self.table=[[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.view addSubview:self.table];
    [self.table mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view);
        make.left.right.bottom.mas_equalTo(self.view);
    }];
    self.table.delegate=self;
    self.table.dataSource=self;
    _table.tableFooterView = [UIView new];
    self.table.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.table.mj_header=[XLHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefresh)];
    //    self.table.mj_footer=[MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefresh)];
    _table.needPlaceholderView = YES;
    __weak __typeof(self)weakSelf = self;
    _table.mj_footer.ignoredScrollViewContentInsetBottom = iPhoneX;
    self.table.estimatedRowHeight = 0;
    self.table.estimatedSectionHeaderHeight = 0;
    self.table.estimatedSectionFooterHeight = 0;
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
    [self.dic setObject:[NSNumber numberWithInteger:self.pageNum] forKey:@"pageNum"];
    [_dic setObject:@"20" forKey:@"pageSize"];
    [self loadRefreshData];
}
- (void)footerRefresh{
    self.pageNum++;
    [self.dic setObject:[NSNumber numberWithInteger:self.pageNum] forKey:@"pageNum"];
    [_dic setObject:@"20" forKey:@"pageSize"];
    [self loadRefreshData];
}
- (void)loadRefreshData{
    [FMNetworkHelper fm_request_postWithUrlString:_url isNeedCache:NO parameters:self.dic successBlock:^(id responseObject) {
        KKLog(@"%@",responseObject);
        if (kResponseObjectStatusCodeIsEqual(200)) {
            if (self.pageNum==1) {
                [self.dataArr removeAllObjects];
            }
            [XLSingleton singleton].scanPhotoIp =responseObject[@"data"][@"scanPhotoIp"];
            NSArray *arr = responseObject[@"data"][@"list"][@"rows"];
            for (NSDictionary *dic in arr) {
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
//        return 2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellID = [NSString stringWithFormat:@"PictureCell"];
//    PictureCell *cell = (PictureCell *)[tableView dequeueReusableCellWithIdentifier:cellID];
//    if (!cell) {
        PictureCell *cell = [[PictureCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
//    }
    FMMainModel *model = self.dataArr[indexPath.row];
    [cell setCellContent:model.content andIsShow:[[self.cellIsShowAll objectForKey:[NSString stringWithFormat:@"%ld", indexPath.row]] boolValue]  andCellIndexPath:indexPath];
    cell.model = model;
    cell.delegate = self;
    if (indexPath.row >2) {
        cell.typeImg.hidden = YES;
    }else{
        cell.typeImg.hidden = NO;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    PictureCell *cell = (PictureCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
    return [cell getLayoutCellHeight];
//    return 200;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    PosterVC *vc = [[PosterVC alloc] init];
    vc.url = POSTSysDetail;
    vc.model = self.dataArr[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)remarksCellShowContrntWithDic:(NSDictionary *)dic andCellIndexPath:(NSIndexPath *)indexPath
{
    [self.cellIsShowAll setObject:[dic objectForKey:@"isShow"] forKey:[NSString stringWithFormat:@"%@",[dic objectForKey:@"row"]]];
    [_table reloadData];
    
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
