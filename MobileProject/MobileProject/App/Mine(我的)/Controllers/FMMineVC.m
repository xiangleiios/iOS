//
//  FMMineVC.m
//  MobileProject
//
//  Created by Mingo on 2017/7/31.
//  Copyright © 2017年 ZSGY. All rights reserved.
//

#import "FMMineVC.h"
#import "XLInformationV.h"
#import "AboutUs.h"
#import "MyInfoVC.h"
#import "XLMineCell.h"
#import "FMClearCacheTool.h"
#define HEADERHEI KFit_H6S(320)

@interface FMMineVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic , strong)UITableView *table;
@property (nonatomic , strong)NSArray *imgarr;
@property (nonatomic , strong)NSArray *titlerr;
@property (nonatomic , strong)NSString *cacheSize;
@end

@implementation FMMineVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titlerr = @[@"账户信息",@"关于我们",@"清除缓存"];
    self.imgarr = @[@"my_news_icon",@"my_about_icon",@"my_clean_icon"];
    [self laodNavigation];
    
    [self loadtable];
    
    
    [self loadfunctionbut];
//    [self laodSubview];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma mark - 导航相关
- (void)laodNavigation{
    [self.navigationView setTitle:@"我的"];
    
}
- (void)laodSubview{
    
    UIView *backview = [[UIView alloc] init];
    [self.view addSubview:backview];
    [backview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view).mas_offset(kNavBarH + KFit_H6S(40));
        make.height.mas_equalTo(KFit_H6S(450));
    }];
    
    XLInformationV *manual = [[XLInformationV alloc] informationLevelWithTitle:@"账户信息" SubTitle:@"" ImageName:@"my_news_icon"];
    [backview addSubview:manual];
    manual.senterBlock = ^{
        KKLog(@"dianji");
        MyInfoVC *VC = [[MyInfoVC alloc] init];
        [self.navigationController pushViewController:VC animated:YES];
    };
    
    XLInformationV *automatic = [[XLInformationV alloc] informationLevelWithTitle:@"关于我们" SubTitle:@"" ImageName:@"my_about_icon"];
    [backview addSubview:automatic];
    automatic.senterBlock = ^{
        KKLog(@"dianji111");
        AboutUs *vc = [[AboutUs alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    };
    
    XLInformationV *Clear = [[XLInformationV alloc] informationLevelWithTitle:@"清除缓存" SubTitle:@"0M" ImageName:@"my_clean_icon"];
    [backview addSubview:Clear];
    Clear.senterBlock = ^{
        KKLog(@"dianji111");
    };
    NSArray *arr = @[manual,automatic,Clear];
    [arr mas_distributeViewsAlongAxis:MASAxisTypeVertical withFixedSpacing:1 leadSpacing:1 tailSpacing:1];
    [arr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
    }];
    
    
}


- (void)loadtable{
    self.table=[[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.view addSubview:self.table];
    [self.table mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).mas_offset(kNavBarH + KFit_H6S(30));
        make.left.right.bottom.mas_equalTo(self.view);
    }];
    self.table.delegate=self;
    self.table.dataSource=self;
    self.table.scrollEnabled = NO;
    //设置可编辑
    //    self.table.allowsMultipleSelectionDuringEditing = YES;
    _table.tableFooterView = [UIView new];
    self.table.separatorStyle = UITableViewCellSeparatorStyleNone;
//    self.table.mj_header=[MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefresh)];
//    self.table.mj_footer=[MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefresh)];
//    _table.needPlaceholderView = YES;
//    __weak __typeof(self)weakSelf = self;
//    _table.reloadBlock = ^{
//        [weakSelf.table.mj_header beginRefreshing];
//    };
//    [self headerRefresh];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //    [self.table.mj_header beginRefreshing];
}



#pragma mark-tableview代理
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.titlerr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellID = [NSString stringWithFormat:@"XLMineCell"];
    XLMineCell *cell = (XLMineCell *)[tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[XLMineCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    cell.title.text = self.titlerr[indexPath.row];
    [cell.img setImage:[UIImage imageNamed:self.imgarr[indexPath.row]]];
    if (indexPath.row == 2) {
        cell.subtitle.text = [FMClearCacheTool fm_getCacheSizeWithFilePath:kCachePath];;
    }
    //    cell.model = self.dataArr[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return KFit_H6S(150);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        MyInfoVC *VC = [[MyInfoVC alloc] init];
        [self.navigationController pushViewController:VC animated:YES];
    }
    if (indexPath.row == 1) {
        AboutUs *vc = [[AboutUs alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (indexPath.row == 2) {
        [self cleanUpcache];
    }
    
}


- (void)cleanUpcache{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否清除缓存" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {}]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        [FMRegExpTool clearFile];
        if ([FMClearCacheTool fm_clearCacheWithFilePath:kCachePath]) {
            [MBProgressHUD showAutoMessage:@"已清除缓存"];
        }
        [self.table reloadData];
    }]];
    [self presentViewController:alert animated:YES completion:nil];
}
- (void)theLoginStatusChange{
    
}


- (void)loadfunctionbut{
    UIButton *next = [[UIButton alloc] init];
    [self.view addSubview:next];
    [next setTitle:@"退出登录" forState:UIControlStateNormal];
    [next addTarget:self action:@selector(logOut:) forControlEvents:UIControlEventTouchUpInside];
    next.backgroundColor = kColor_N(0, 112, 234);
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
- (void)logOut:(UIButton *)sender{
    XLAlertView *alert = [[XLAlertView alloc] initWithTitle:@"提示" message:@"是否退出登录" sureBtn:@"确定" cancleBtn:@"取消"];
    [alert showXLAlertView];
    alert.resultIndex = ^(NSInteger index) {
        KKLog(@"%ld",(long)index);
        if (index == 2) {
            [[User UserOb] UserQuit];
            LoginVC *Loginvc = [[LoginVC alloc] init];
            AppDelegate *delegete = (AppDelegate *)[UIApplication sharedApplication].delegate;
            UIViewController *vc = delegete.window.rootViewController;
            delegete.window.rootViewController = Loginvc;
            vc = nil;
            [self presentViewController:Loginvc animated:YES completion:NULL];
        }
    };
    
    
}
@end
