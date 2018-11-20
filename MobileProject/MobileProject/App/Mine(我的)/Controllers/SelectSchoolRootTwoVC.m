//
//  SelectSchoolRootTwoVC.m
//  MobileProject
//
//  Created by 向蕾 on 2018/11/14.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import "SelectSchoolRootTwoVC.h"
#import "SelectSchoolCell.h"
@interface SelectSchoolRootTwoVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic , strong)UITableView *table;
@property (nonatomic , strong)NSMutableArray *dataArr;

@end

@implementation SelectSchoolRootTwoVC

- (NSMutableArray *)dataArr{
    if (_dataArr == nil) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //    self.view.backgroundColor = kColor_N(240, 240, 240);
    [self laodNavigation];
    [self loadSubview];
    [self loadRefreshData];
}
- (void)laodNavigation{
    [self.navigationView setTitle:@"选择所在驾校"];
    
}

- (void)loadSubview{
    UILabel *lb = [[UILabel alloc] init];
    [self.view addSubview:lb];
    lb.text = @"武汉市";
    lb.font = [UIFont systemFontOfSize:kFit_Font6(22) weight:0.5];
    [lb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).mas_offset(KFit_W6S(30));
        make.top.mas_equalTo(self.view).mas_offset(kNavBarH + KFit_H6S(70));
        make.height.mas_equalTo(KFit_H6S(50));
    }];
    
    UILabel *lbt = [[UILabel alloc] init];
    [self.view addSubview:lbt];
    lbt.text = self.model.name;
    lbt.textColor = kColor_N(0, 94, 233);
    lbt.font = [UIFont systemFontOfSize:kFit_Font6(22) weight:0.5];
    [lbt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(lb.mas_right).mas_offset(KFit_W6S(30));
        make.top.mas_equalTo(self.view).mas_offset(kNavBarH + KFit_H6S(70));
        make.height.mas_equalTo(KFit_H6S(50));
    }];
    
    UILabel *lbline = [[UILabel alloc] init];
    [self.view addSubview:lbline];
    lbline.backgroundColor = kColor_N(0, 94, 233);
    [lbline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.mas_equalTo(lbt);
        make.top.mas_equalTo(lbt.mas_bottom).mas_offset(KFit_H6S(25));
        make.height.mas_equalTo(KFit_H6S(5));
    }];
    
    UILabel *lblineone = [[UILabel alloc] init];
    [self.view addSubview:lblineone];
    lblineone.backgroundColor = kColor_N(240, 240, 240);
    [lblineone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(lbline.mas_bottom);
        make.height.mas_equalTo(KFit_H6S(1));
    }];
    
    self.table=[[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.view addSubview:self.table];
    [self.table mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lblineone.mas_bottom);
        make.left.right.bottom.mas_equalTo(self.view);
    }];
    self.table.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.table.backgroundColor = [UIColor whiteColor];
    self.table.delegate=self;
    self.table.dataSource=self;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuseIdentifier = @"SelectSchoolCell";
    SelectSchoolCell *cell = (SelectSchoolCell *)[tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell)
    {
        cell = [[SelectSchoolCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }
    FMSchoolModel *model = self.dataArr[indexPath.row];
    cell.title.text = model.name;
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return KFit_H6S(90);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    FMSchoolModel *model = self.dataArr[indexPath.row];
    [self bangdingWithModel:model];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.0010;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.0010;
}



- (void)loadRefreshData{
    NSString *url = [NSString stringWithFormat:POSTBindTeamSchools,self.model.deptId];
    NSString* url1 = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    [FMNetworkHelper fm_request_postWithUrlString:url1 isNeedCache:NO parameters:nil successBlock:^(id responseObject) {
        KKLog(@"%@",responseObject);
        if (kResponseObjectStatusCodeIsEqual(200)) {
            NSArray *arr = responseObject[@"list"];
            for (NSDictionary *dic in arr) {
                FMSchoolModel *model = [FMSchoolModel mj_objectWithKeyValues:dic];
                [self.dataArr addObject:model];
            }
        }
        [self.table reloadData];
    } failureBlock:^(NSError *error) {
        
    } progress:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];
}


- (void)bangdingWithModel:(FMSchoolModel *)model{
//    NSString *url = [NSString stringWithFormat:POSTBindBindCoach,[User UserOb].userId,self.model.deptId,model.deptId];
    NSString *url = POSTBindBindCoach;
    NSString* url1 = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSDictionary *dic = @{@"id":[User UserOb].userId,@"originalDeptId":self.model.deptId,@"schoolId":model.deptId};
    [FMNetworkHelper fm_request_postWithUrlString:url1 isNeedCache:NO parameters:dic successBlock:^(id responseObject) {
        KKLog(@"%@",responseObject);
        if (kResponseObjectStatusCodeIsEqual(200)) {
            [MBProgressHUD showMsgHUD:@"绑定成功，请再次登录"];
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
        
    } failureBlock:^(NSError *error) {
        
    } progress:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];
}
@end
