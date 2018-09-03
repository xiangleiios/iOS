//
//  ControllersListVC.m
//  MobileProject
//
//  Created by zsgy on 2017/11/10.
//  Copyright © 2017年 ZSGY. All rights reserved.
//

#import "ControllersListVC.h"
#import "UITableView+FMPlaceholder.h"


@interface ControllersListVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic , strong)UITableView *table;
@property (nonatomic , strong)NSMutableArray <FMMainModel *>*dataArr;
@property (nonatomic , strong)NSMutableArray <FMMainModel *>*selectArray;
@end

@implementation ControllersListVC
- (NSMutableArray *)dataArr{
    if (_dataArr==nil) {
        _dataArr=[NSMutableArray array];
    }
    return _dataArr;
}
- (NSMutableArray *)selectArray{
    if (_selectArray==nil) {
        _selectArray=[NSMutableArray array];
    }
    return _selectArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadtable];
    [self loadDelet];
    // Do any additional setup after loading the view.
}


- (void)loadDelet{
    UIButton *but=[[UIButton alloc] init];
    [self.view addSubview:but];
    [but mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.mas_equalTo(self.view);
        make.top.mas_equalTo(self.table.mas_bottom);
        make.height.mas_equalTo(KFit_H6S(100));
    }];
    [but setTitle:@"删除" forState:UIControlStateNormal];
    [but setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [but addTarget:self action:@selector(DeleteTheCollection) forControlEvents:UIControlEventTouchUpInside];
    but.backgroundColor=kRGBColor(248, 108, 85);
    
}
#pragma mark - 删除收藏
- (void)DeleteTheCollection{
    if (self.selectArray.count<1) {
        return;
    }
   
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)loadtable{
    self.table=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.view.height-kNavBarH) style:UITableViewStylePlain];
    [self.view addSubview:self.table];
    self.table.delegate=self;
    self.table.dataSource=self;
    //设置可编辑
    self.table.allowsMultipleSelectionDuringEditing = YES;
    _table.tableFooterView = [UIView new];
//    self.table.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.table.mj_header=[MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefresh)];
    self.table.mj_footer=[MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefresh)];
    [_table.mj_header beginRefreshing];
    __weak __typeof(self)weakSelf = self;
    _table.needPlaceholderView = YES;
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
    
}


#pragma mark-tableview代理
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    FMMainModel *model=self.dataArr[indexPath.row];
    //进去可编辑状态
    if (tableView.editing == YES) {
        if (![self.selectArray containsObject:model]) {
            [self.selectArray addObject:model];
        }
        return;
    }
    
    
    
}


#pragma mark 取消选中行
-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!tableView.editing)
        return;
    FMMainModel *model=self.dataArr[indexPath.row];
    if ([self.selectArray containsObject:model]) {
        [self.selectArray removeObject:model];
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 10;
}
//是否可以编辑  默认的时YES

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return YES;
    
}
//设置进入编辑状态时，Cell缩进
- (BOOL)tableView: (UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}



//选择你要对表进行处理的方式  默认是删除方式

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return UITableViewCellEditingStyleDelete | UITableViewCellEditingStyleInsert;
    
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)enterTheEdit{
    self.table.editing=YES;
    [UIView animateWithDuration:1 animations:^{
        self.table.frame=CGRectMake(0, 0, SCREEN_WIDTH, self.view.height-KFit_H6S(100)-kNavBarH);
    }];
    [self.selectArray removeAllObjects];
}
- (void)ExittheEditor{
    self.table.editing= NO;
    [UIView animateWithDuration:1 animations:^{
        self.table.frame=CGRectMake(0, 0, SCREEN_WIDTH, self.view.height-kNavBarH);
    }];
    [self.selectArray removeAllObjects];
}

@end
