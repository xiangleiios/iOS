//
//  InvitedRecordList.m
//  MobileProject
//
//  Created by 向蕾 on 2018/11/21.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import "InvitedRecordList.h"
#import "InvitedRecordCell.h"
@interface InvitedRecordList ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic , strong)UITableView *table;
@property (nonatomic , strong)NSMutableArray <FMMainModel *>*dataArr;
@property (nonatomic , strong)UILabel *lbnum;

@end

@implementation InvitedRecordList
- (NSMutableArray *)dataArr{
    if (_dataArr ==nil) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationView setTitle:@"邀请记录"];
    [self loadSubView];
    [self loadBut];
    [self loadtable];
    // Do any additional setup after loading the view.
}

- (void)loadSubView{
    UILabel *lb = [[UILabel alloc] init];
    self.lbnum = lb;
    lb.backgroundColor = kColor_N(230, 241, 252);
    lb.textColor = kColor_N(0, 120, 235);
    lb.text = @"    邀请总数：";
    [self.view addSubview:lb];
    [lb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view).mas_offset(kNavBarH);
        make.height.mas_equalTo(KFit_H6S(150));
    }];
    
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
    [next setTitle:@"去邀请" forState:UIControlStateNormal];
    [next addTarget:self action:@selector(toBack) forControlEvents:UIControlEventTouchUpInside];
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
    [self.table mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).mas_offset(kNavBarH + KFit_H6S(150));
        make.left.right.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view).mas_offset(-KFit_H6S(150));
    }];
    self.table.delegate=self;
    self.table.dataSource=self;
    
    //设置可编辑
    //    self.table.allowsMultipleSelectionDuringEditing = YES;
    _table.tableFooterView = [UIView new];
    self.table.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.table.mj_header=[XLHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefresh)];
    //    self.table.mj_footer=[MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefresh)];
    self.table.backgroundColor = kColor_N(240, 240, 240);
    [self.table addEmptyViewWithImageName:@"placeholder" title:@"您还未邀请成功\n快邀请教练下载APP，注册并绑定分校\n即可提升您的排名哦~" But:nil];
    _table.emptyView.hidden = YES;
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
    NSString *url;
    if (USERFZR) {
        url = POSTInvitationrecordListSchool;
    }else{
        url = POSTInvitationrecordListCoach;
    }
    [FMNetworkHelper fm_request_postWithUrlString:url isNeedCache:NO parameters:nil successBlock:^(id responseObject) {
        KKLog(@"%@",responseObject);
        NSArray *tpArray = responseObject[@"list"][@"rows"];
        self.lbnum.text = [NSString stringWithFormat:@"    邀请总数：%@",responseObject[@"list"][@"total"]];
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
    //    return 2;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellID = [NSString stringWithFormat:@"InvitedRecordCell"];
    InvitedRecordCell *cell = (InvitedRecordCell *)[tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[InvitedRecordCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    cell.model = self.dataArr[indexPath.row];
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return KFit_H6S(90);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
}



- (void)toBack{
    [self.navigationController popViewControllerAnimated:YES];
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
