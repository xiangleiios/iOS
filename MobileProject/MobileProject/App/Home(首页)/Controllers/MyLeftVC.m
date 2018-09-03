//
//  MyLeftVC.m
//  MobileProject
//
//  Created by zsgy on 2018/5/23.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import "MyLeftVC.h"
#import "XLMineCell.h"
#import "LoginVC.h"
#import "ChangePasswordVC.h"
#import "MyAccountVC.h"
#import "MyCouponVC.h"
#import "HWebVc.h"
#import "Feedback.h"
@interface MyLeftVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic , strong)NSMutableArray *data;
@property (nonatomic , strong)UITableView *table;
@property (nonatomic , strong)UILabel *lb_line;

@property (nonatomic , strong)UIButton *name;
@property (nonatomic , strong)UIImageView *redImg;
@end

@implementation MyLeftVC
- (NSMutableArray *)data{
    if (_data == nil) {
        _data = [NSMutableArray array];
    }
    return _data;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadsubview];
    [self loaddata];
    // Do any additional setup after loading the view.
}


- (void)loadsubview{
    UILabel *lb = [[UILabel alloc] init];
    [self.view addSubview:lb];
    [lb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(self.view);
        make.width.mas_equalTo(kFit_Font6(1));
        make.left.mas_equalTo(self.view).mas_offset(self.view.frame.size.width * LEFT_WIDTH_RATIO);
    }];
    

    self.loginBut = [[UIButton alloc] init];
    [self.view addSubview:self.loginBut];
    [self.loginBut setTitleColor:kColor_N(40, 174, 104) forState:UIControlStateNormal];
//    [self.loginBut setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
    [self.loginBut addTarget:self action:@selector(toLogin:) forControlEvents:UIControlEventTouchUpInside];
    [self.loginBut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view).mas_offset(KFit_H6S(90));
        make.height.mas_equalTo(KFit_H6S(50));
        make.right.mas_equalTo(lb.mas_left);
    }];
    
    self.name = [[UIButton alloc] init];
    [self.view addSubview:self.name];
    [self.name setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.name addTarget:self action:@selector(ModifyNname) forControlEvents:UIControlEventTouchUpInside];
    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view);
        make.top.mas_equalTo(self.loginBut.mas_bottom).mas_offset(KFit_H6S(40));
        make.height.mas_equalTo(KFit_H6S(50));
        make.right.mas_equalTo(lb.mas_left);
    }];
    
    UIButton *butone = [[UIButton alloc] init];
    [self.name addSubview:butone];
    [butone setImage:[UIImage imageNamed:@"ret"] forState:UIControlStateNormal];
    [butone addTarget:self action:@selector(ModifyNname) forControlEvents:UIControlEventTouchUpInside];
    [butone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(self.name);
        make.right.mas_equalTo(self.name).mas_offset(-KFit_W6S(30));
        make.width.mas_equalTo(KFit_W6S(40));
    }];
    
    
    self.outBut = [[UIButton alloc] init];
    [self.view addSubview:self.outBut];
    [self.outBut setTitle:@"退出登录" forState:UIControlStateNormal];
    [self.outBut setTitleColor:kColor_N(40, 174, 104) forState:UIControlStateNormal];
    [self.outBut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.view).mas_offset(-KFit_H6S(40));
        make.height.mas_equalTo(KFit_H6S(80));
        make.left.mas_equalTo(self.view).mas_offset(KFit_W6S(40));
        make.right.mas_equalTo(lb.mas_left).mas_offset(-KFit_W6S(40));
    }];
    [self.outBut addTarget:self action:@selector(logOut) forControlEvents:UIControlEventTouchUpInside];
    
    self.lb_line = [[UILabel alloc] init];
    [self.view addSubview:self.lb_line];
    self.lb_line.backgroundColor = [UIColor colorWithWhite:240/255.0 alpha:1];
    [self.lb_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).mas_offset(KFit_W6S(20));
        make.right.mas_equalTo(lb.mas_left).mas_offset(-KFit_W6S(20));
        make.height.mas_equalTo(kFit_Font6(1));
        make.top.mas_equalTo(self.loginBut.mas_bottom).mas_offset(KFit_H6S(40));
    }];
    
    self.table = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.view addSubview:self.table];
    self.table.delegate = self;
    self.table.dataSource = self;
    self.table.scrollEnabled = NO;
    self.table.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.table mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.outBut.mas_top).mas_offset(-KFit_H6S(40));
        make.right.mas_equalTo(lb.mas_left);
        make.top.mas_equalTo(self.lb_line.mas_bottom).mas_offset(KFit_H6S(30));
    }];
    
    self.redImg = [[UIImageView alloc] init];
    [self.table addSubview:self.redImg];
    self.redImg.backgroundColor = [UIColor redColor];
    self.redImg.layer.cornerRadius = KFit_W6S(7);
    self.redImg.layer.masksToBounds = YES;
    self.redImg.hidden = YES;
    [self.redImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.table).mas_offset(KFit_H6S(20));
        make.left.mas_equalTo(self.table).mas_offset(KFit_W6S(235));
        make.size.mas_equalTo(CGSizeMake(KFit_W6S(14), KFit_W6S(14)));
    }];
}

- (void)logOut{
    User *user = [User UserOb];
    [user UserQuit];
  
    [self loaddata];
    
}
- (void)toLogin:(UIButton *)senter{
    if (senter.selected) {
        KKLog(@"跳登录");
        LoginVC *vc = [[LoginVC alloc] init];
        self.back(vc);
    }
}
#pragma mark - table相关代理

#pragma mark-tableview代理
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.data.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return KFit_H6S(80);
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    XLMineCell *cell = [tableView dequeueReusableCellWithIdentifier:@"XLMineCell"];
    if (cell == nil) {
        cell = [[XLMineCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"XLMineCell"];
    }
    cell.model = self.data[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
   
}

- (void)toShare{
    XLshare *share = [[XLshare alloc]init];
    share.title = @"淘电宝，您身边的售电专家";
    share.image_url = @"http://tdb.asia-cloud.com/uploads/images/2018/0702/20180702105337108.png";
    share.subTitle = @"邀请您使用淘电宝APP，欢迎下载使用，注册有礼哦~~";
    if ([User UserOb].UserLogin) {
        share.url = [NSString stringWithFormat:URLMemberInviteUID,[User UserOb].idid];
    }else{
        share.url = URLMemberInvite;
    }
    
    [share umengShare:self.view];
}

#pragma mark - 个人中心数据
- (void)loaddata{
    [self.data removeAllObjects];
    User *user = [User UserOb];
    MineModel *model;
    if (user.UserLogin) {
        self.outBut.hidden = NO;
        self.loginBut.selected = NO;
        //添加登录要显示的数据
        model = [[MineModel alloc] init];
        model.title = @"我的订单";
        model.img = @"Orders";
        model.subtitle = @"6个";
        [self.data addObject:model];
        model = [[MineModel alloc] init];
        model.title = @"我的优惠券";
        model.img = @"coupon";
        model.subtitle = @"";
        [self.data addObject:model];
        model = [[MineModel alloc] init];
        model.title = @"我的账户";
        model.img = @"account";
        model.subtitle = @"";
        [self.data addObject:model];
        model = [[MineModel alloc] init];
        model.title = @"修改密码";
        model.img = @"change-Password";
        model.subtitle = @"";
        [self.data addObject:model];
        [self.loginBut setTitle:[NSString fm_hiddenMiddleNumOfPhoneNum:user.mobile] forState:UIControlStateNormal];
        self.name.hidden = NO;
        [self.name setTitle:user.nick_name forState:UIControlStateNormal];
        [self.lb_line mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.view).mas_offset(KFit_W6S(20));
            make.right.mas_equalTo(self.loginBut).mas_offset(-KFit_W6S(20));
            make.height.mas_equalTo(kFit_Font6(1));
            make.top.mas_equalTo(self.name.mas_bottom).mas_offset(KFit_H6S(40));
        }];
        [self loadMembersInfomation];
    }else{
        self.redImg.hidden = YES;
        self.outBut.hidden = YES;
        self.loginBut.selected = YES;
        self.name.hidden = YES;
        [self.loginBut setTitle:@"点击登录" forState:UIControlStateNormal];
        [self.lb_line mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.view).mas_offset(KFit_W6S(20));
            make.right.mas_equalTo(self.loginBut).mas_offset(-KFit_W6S(20));
            make.height.mas_equalTo(kFit_Font6(1));
            make.top.mas_equalTo(self.loginBut.mas_bottom).mas_offset(KFit_H6S(40));
        }];
    }
    model = [[MineModel alloc] init];
    model.title = @"邀请好友";
    model.img = @"invite";
    model.subtitle = @"";
    [self.data addObject:model];
    model = [[MineModel alloc] init];
    model.title = @"淘电宝业务介绍";
    model.img = @"Introduce";
    model.subtitle = @"";
    [self.data addObject:model];
    model = [[MineModel alloc] init];
    model.title = @"联系客服";
    model.img = @"Customer-service";
    model.subtitle = @"";
    [self.data addObject:model];
    
    if (user.UserLogin) {
    model = [[MineModel alloc] init];
    model.title = @"意见反馈";
    model.img = @"opinion";
    model.subtitle = @"";
    [self.data addObject:model];
    }
    
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    model = [[MineModel alloc] init];
    model.title = @"版本";
    model.img = @"Version";
    model.subtitle = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    [self.data addObject:model];
    [self.table reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}

- (void)ModifyNname{
    XLAlertView *alert = [[XLAlertView alloc] initWithInputboxTitle:@"修改单位全称"];
    [alert showXLAlertView];
    alert.input.text = [User UserOb].nick_name;
    alert.inputText = ^(NSString *text) {
        if (text.length < 1) {
            [MBProgressHUD showAutoMessage:@"请输入公司名"];
            return ;
        }
        [self changeNickRequest:text];
    };
}
- (void)changeNickRequest:(NSString *)name{
    NSString *url=[NSString stringWithFormat:POSTChangeTheNickname,[User UserOb].token,name];
    [FMNetworkHelper fm_request_postWithUrlString:[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] isNeedCache:NO parameters:nil successBlock:^(id responseObject) {
        if (kResponseObjectStatusCodeIsEqual(200)) {
            [MBProgressHUD showAutoMessage:@"修改成功"];
            User *use=[User UserOb];
            use.nick_name=[name stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults setObject:use.nick_name forKey:@"nick_name"];
            [defaults synchronize];
            [self loaddata];
        }else{
            [MBProgressHUD showAutoMessage:responseObject[@"message"]];
        }
    } failureBlock:^(NSError *error) {
        
    } progress:nil];
}



- (void)loadMembersInfomation{
    NSString *url = [NSString stringWithFormat:GETMembersInfomation,[User UserOb].token];
    [FMNetworkHelper fm_request_getWithUrlString:url isNeedCache:NO parameters:nil successBlock:^(id responseObject) {
        if (kResponseObjectStatusCodeIsEqual(200)) {
            NSDictionary *dic = responseObject[@"data"];
            MineModel *model = self.data[0];
            model.subtitle = [NSString stringWithFormat:@"%@个",dic[@"order_info_num"]];
            MineModel *modelone = self.data[1];
            modelone.subtitle = [NSString stringWithFormat:@"%@元",dic[@"point"]];
            if ([dic[@"order_info_notice"]  isEqual: @1]) {
                self.redImg.hidden = NO;
            }else{
                self.redImg.hidden = YES;
            }
            [self.table reloadData];
        }
    } failureBlock:^(NSError *error) {
        
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
