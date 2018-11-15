//
//  PracticeCarDetailsVC.m
//  MobileProject
//
//  Created by 向蕾 on 2018/10/19.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import "PracticeCarDetailsVC.h"
//#import "UITableView+FMPlaceholder.h"
#import "PracticeCarDetailsCell.h"
#import "PracticeCarHeaderV.h"
#import "EditTimeVC.h"
#import "ReservationDetailsVC.h"
@interface PracticeCarDetailsVC ()<UITableViewDelegate,UITableViewDataSource>
//@property (nonatomic , strong)NSArray *studentArr;

@end

@implementation PracticeCarDetailsVC

- (void)setDataArr:(NSArray *)dataArr{
    _dataArr = [dataArr copy];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadtable];
    // Do any additional setup after loading the view.
}
- (void)loadtable{
    self.table=[[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    [self.view addSubview:self.table];
    [self.table mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(self.view).mas_offset(kNavBarH);
        make.top.left.right.bottom.mas_equalTo(self.view);
    }];
    self.table.delegate=self;
    self.table.dataSource=self;
    
    //设置可编辑
    //    self.table.allowsMultipleSelectionDuringEditing = YES;
    _table.tableFooterView = [UIView new];
    self.table.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.table.showsVerticalScrollIndicator = NO;
    self.table.showsHorizontalScrollIndicator = NO;
    self.table.backgroundColor = kColor_N(240, 240, 240);
    _table.mj_footer.ignoredScrollViewContentInsetBottom = iPhoneX;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //    [self.table.mj_header beginRefreshing];
}




#pragma mark-tableview代理
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArr.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSDictionary *dic = self.dataArr[section];
    NSArray *arr = dic[@"trainingRecords"];
    return arr.count;
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    NSDictionary *dic = self.dataArr[section];
    if (section == 0) {
        PracticeCarHeaderOneV *v = [[PracticeCarHeaderOneV alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, KFit_H6S(250))];
        v.dic = dic;
        if (USERFZR) {
            [v.addBut addTarget:self action:@selector(toEditTimeVC) forControlEvents:UIControlEventTouchUpInside];
            v.modifyBut.tag =section;
            [v.modifyBut addTarget:self action:@selector(xiugai:) forControlEvents:UIControlEventTouchUpInside];
        }
        return v;
    }else{
    PracticeCarHeaderV *v = [[PracticeCarHeaderV alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, KFit_H6S(160))];
        if (USERFZR) {
            v.modifyBut.tag =section;
            [v.modifyBut addTarget:self action:@selector(xiugai:) forControlEvents:UIControlEventTouchUpInside];
        }
        v.dic = dic;
    return v;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return KFit_H6S(250);
    }else{
        return KFit_H6S(160);
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellID = [NSString stringWithFormat:@"PracticeCarDetailsCell"];
    PracticeCarDetailsCell *cell = (PracticeCarDetailsCell *)[tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[PracticeCarDetailsCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    cell.vc = self;
    NSDictionary *dic = self.dataArr[indexPath.section];
    KKLog(@"%@",dic);
    NSArray *arr = dic[@"trainingRecords"];
    cell.dic = arr[indexPath.row];
    cell.model = [FMMainModel mj_objectWithKeyValues:dic];
    cell.but.tag = indexPath.row;
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return KFit_H6S(90);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ReservationDetailsVC *vc = [[ReservationDetailsVC alloc] init];
    NSDictionary *dic = self.dataArr[indexPath.section];
    NSArray *arr = dic[@"trainingRecords"];
    NSDictionary *dictwo = arr[indexPath.row];
    FMMainModel *model = [FMMainModel mj_objectWithKeyValues:dictwo];
    vc.model = model;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)toEditTimeVC{
    EditTimeVC *vc = [[EditTimeVC alloc] init];
    vc.groundId = self.groundId;
    vc.editorType = 2;
    vc.selectTime = self.selectTime;
    [self.navigationController pushViewController:vc animated:YES];
    [vc.navigationView setTitle:@"添加时段"];
}


- (void)xiugai:(UIButton *)senter{
    NSDictionary *dic = self.dataArr[senter.tag];
    
    NSArray *arr = dic[@"trainingRecords"];
    if (arr.count > 0) {
        [MBProgressHUD showMsgHUD:@"当前时间有人预约，不可修改"];
        return;
    }
    EditTimeVC *vc = [[EditTimeVC alloc] init];
    vc.groundId = self.groundId;
    vc.editorType = 3;
    vc.selectTime = self.selectTime;
    vc.model = [FMMainModel mj_objectWithKeyValues:dic];
    [self.navigationController pushViewController:vc animated:YES];
    [vc.navigationView setTitle:@"修改时段"];
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
