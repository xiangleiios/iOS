//
//  SelectSchoolRootVC.m
//  MobileProject
//
//  Created by 向蕾 on 2018/11/13.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import "SelectSchoolRootVC.h"
#import "PPGetAddressBook.h"
#import "FMSchoolModel.h"
#import "SelectSchoolCell.h"
#import "SelectSchoolRootTwoVC.h"
@interface SelectSchoolRootVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic , strong)UITableView *table;
@property (nonatomic , strong)NSMutableArray *dataArr;
@property (nonatomic, copy) NSDictionary *contactPeopleDict;
@property (nonatomic, copy) NSArray *keys;
@end
@implementation SelectSchoolRootVC

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
    lb.textColor = kColor_N(0, 94, 233);
    lb.font = [UIFont systemFontOfSize:kFit_Font6(22) weight:0.5];
    [lb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).mas_offset(KFit_W6S(30));
        make.top.mas_equalTo(self.view).mas_offset(kNavBarH + KFit_H6S(70));
        make.height.mas_equalTo(KFit_H6S(50));
    }];
    
    UILabel *lbline = [[UILabel alloc] init];
    [self.view addSubview:lbline];
    lbline.backgroundColor = kColor_N(0, 94, 233);
    [lbline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.mas_equalTo(lb);
        make.top.mas_equalTo(lb.mas_bottom).mas_offset(KFit_H6S(25));
        make.height.mas_equalTo(KFit_H6S(5));
    }];
    
    self.table=[[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    [self.view addSubview:self.table];
    [self.table mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lbline.mas_bottom);
        make.left.right.bottom.mas_equalTo(self.view);
    }];
    self.table.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.table.backgroundColor = [UIColor whiteColor];
    self.table.delegate=self;
    self.table.dataSource=self;
    
}



#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _keys.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
        NSString *key = _keys[section];
        return [_contactPeopleDict[key] count];

}
//- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    return _keys[section];
//}

//右侧的索引
- (NSArray*)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return _keys;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    static NSString *reuseIdentifier = @"SelectSchoolCell";
    SelectSchoolCell *cell = (SelectSchoolCell *)[tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell)
    {
        cell = [[SelectSchoolCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }
    NSString *key = _keys[indexPath.section];
    FMSchoolModel *model = [_contactPeopleDict[key] objectAtIndex:indexPath.row];
    cell.title.text = model.name;
//    cell.selectionStyle = UITableViewCellSeparatorStyleNone;
    
    
    
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
    NSString *key = _keys[indexPath.section];
    FMSchoolModel *model = [_contactPeopleDict[key] objectAtIndex:indexPath.row];
    SelectSchoolRootTwoVC *vc = [[SelectSchoolRootTwoVC alloc] init];
    vc.model = model;
    [self.navigationController pushViewController:vc animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.0010;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return KFit_H6S(45);
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 15)];
    UILabel *indexLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 120, 20)];
    indexLabel.text = _keys[section];
    indexLabel.font = [UIFont systemFontOfSize:15];
    indexLabel.textColor = [UIColor darkGrayColor];
    view.backgroundColor = kColor_N(240, 240, 240);
    [view addSubview:indexLabel];
    return view;
    
    
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.01)];
    view.backgroundColor = [UIColor whiteColor];
    return view;
}


- (void)sort{
    [PPGetAddressBook getData:self.dataArr OrderAddressBook:^(NSDictionary<NSString *,NSArray *> *addressBookDict, NSArray *nameKeys) {
        self.keys = nameKeys;
        self.contactPeopleDict = addressBookDict;
        [self.table reloadData];
    }];
}

- (void)loadRefreshData{
    NSString *url = [NSString stringWithFormat:POSTBindSchools,@"武汉市"];
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
        [self sort];
        [self.table reloadData];
    } failureBlock:^(NSError *error) {
        
    } progress:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];
}



@end
