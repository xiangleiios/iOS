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
#import "SelectRoleVC.h"
#import "SchoolRankingListVC.h"
#import "InvitationCoachVC.h"
#import "RankingDetailsVC.h"
#define HEADERHEI KFit_H6S(320)

@interface FMMineVC ()<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate>

@property (nonatomic , strong)UITableView *table;
@property (nonatomic , strong)NSArray *imgarr;
@property (nonatomic , strong)NSArray *titlerr;
@property (nonatomic , strong)NSString *cacheSize;

@property (nonatomic , strong)UILabel *pho;
@end

@implementation FMMineVC

- (void)viewDidLoad {
    [super viewDidLoad];
    if (USERFZR) {
        self.titlerr = @[@"会员福利",@"分校排名",@"邀请教练",@"账户信息",@"关于我们",@"清除缓存"];
        self.imgarr = @[@"benefits",@"branch",@"invite",@"account",@"about",@"my_clean_icon"];
    }else{
        self.titlerr = @[@"教练排名",@"邀请教练",@"账户信息",@"关于我们",@"清除缓存"];
        self.imgarr = @[@"branch",@"invite",@"account",@"about",@"my_clean_icon"];
    }
    
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
    kWeakSelf(self)
    XLInformationV *manual = [[XLInformationV alloc] informationLevelWithTitle:@"账户信息" SubTitle:@"" ImageName:@"my_news_icon"];
    [backview addSubview:manual];
    manual.senterBlock = ^{
        KKLog(@"dianji");
        MyInfoVC *VC = [[MyInfoVC alloc] init];
        VC.vc = weakself;
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
        make.top.mas_equalTo(self.view).mas_offset(kNavBarH);
        make.left.right.bottom.mas_equalTo(self.view);
    }];
    self.table.delegate=self;
    self.table.dataSource=self;
//    self.table.scrollEnabled = NO;
    _table.tableFooterView = [self FooterView];
    _table.tableHeaderView = [self headerview];
    self.table.separatorStyle = UITableViewCellSeparatorStyleNone;

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //    [self.table.mj_header beginRefreshing];
}
- (UIView *)FooterView{
    UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, KFit_H6S(150))];
    UIButton *next = [[UIButton alloc] init];
    [footer addSubview:next];
    [next setTitle:@"退出登录" forState:UIControlStateNormal];
    [next addTarget:self action:@selector(logOut:) forControlEvents:UIControlEventTouchUpInside];
    next.backgroundColor = kColor_N(0, 112, 234);
    [next setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    next.layer.cornerRadius = 5;
    next.layer.masksToBounds = YES;
    [next mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(footer).mas_offset(KFit_W6S(70));
        make.right.mas_equalTo(footer).mas_offset(-KFit_W6S(70));
        make.bottom.mas_equalTo(footer).mas_offset(-KFit_W6S(30));
        make.height.mas_equalTo(KFit_H6S(90));
    }];
    return footer;
}
- (UIView *)headerview{
    UIView *head = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, KFit_H6S(400))];
    UIImageView *img = [[UIImageView alloc] init];
    [head addSubview:img];
    [img setImage:[UIImage imageNamed:@"bg_my"]];
    [img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(head);
        make.top.mas_equalTo(head).mas_offset(KFit_W6S(40));
        make.width.mas_equalTo(KFit_W6S(730));
        make.height.mas_equalTo(KFit_H6S(360));
    }];
    
    UILabel *lb = [[UILabel alloc] init];
    lb.backgroundColor = [UIColor whiteColor];
    [head addSubview:lb];
    [lb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(img).mas_offset(-KFit_H6S(10));
        make.left.mas_equalTo(img).mas_offset(KFit_W6S(60));
        make.width.height.mas_equalTo(KFit_W6S(120));
    }];
    lb.layer.cornerRadius = KFit_W6S(60);
    lb.layer.masksToBounds = YES;
    
    
    self.HeadPortrait = [[UIImageView alloc] init];
    [head addSubview:self.HeadPortrait];
    [self.HeadPortrait mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(lb);
//        make.left.mas_equalTo(img).mas_offset(KFit_W6S(60));
        make.width.height.mas_equalTo(KFit_W6S(100));
    }];
    self.HeadPortrait.userInteractionEnabled = YES;
    self.HeadPortrait.layer.cornerRadius = KFit_W6S(50);
    self.HeadPortrait.layer.masksToBounds = YES;
    self.HeadPortrait.contentMode = UIViewContentModeScaleAspectFill;
//    [self.HeadPortrait fm_setCircleHeader:];
    
//    [self.HeadPortrait sd_setImageWithURL: ];
    [self.HeadPortrait sd_setImageWithURL:[NSURL URLWithString:KURLIma([User UserOb].teamUserHead)] placeholderImage:[UIImage imageNamed:@"touxiang_nor"]];
    KKLog(@"%@",KURLIma([User UserOb].teamUserHead));
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(changeUp)];
    // 允许用户交互
    [self.HeadPortrait addGestureRecognizer:tap];
    
//    [self.HeadPortrait fm]
    
    self.pho = [[UILabel alloc] init];
    [head addSubview:self.pho];
    self.pho.textColor = [UIColor whiteColor];
    [self.pho mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.HeadPortrait);
        make.left.mas_equalTo(self.HeadPortrait.mas_right).mas_offset(KFit_W6S(25));
        make.size.mas_equalTo(CGSizeMake(KFit_W6S(300), KFit_H6S(40)));
    }];
    self.pho.text = [User UserOb].mobile;
    
    UIImageView *imgrz = [[UIImageView alloc] init];
    [head addSubview:imgrz];
    [imgrz setImage:[UIImage imageNamed:@"attestation"]];
    [imgrz mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.pho);
        make.right.mas_equalTo(head).mas_offset(-KFit_W6S(80));
        make.size.mas_equalTo(CGSizeMake(KFit_W6S(90), KFit_H6S(30)));
    }];
    return head;
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
    if ([self.titlerr[indexPath.row]  isEqual: @"清除缓存"]) {
        cell.subtitle.text = [FMClearCacheTool fm_getCacheSizeWithFilePath:kCachePath];;
    }
//    if ([self.titlerr[indexPath.row]  isEqual: @"邀请教练"]) {
//        cell.subtitle.text = @"奖励8元现金";
//    }
    //    cell.model = self.dataArr[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return KFit_H6S(150);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSInteger i = indexPath.row;
    if (!USERFZR) {
        i++;
    }
    if (i == 0) {
        
    }
    if (i == 1) {
        if (USERFZR) {
            SchoolRankingListVC *vc = [[SchoolRankingListVC alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            [self loadRefreshData];
        }
    }
    if (i == 2) {
        InvitationCoachVC *vc = [[InvitationCoachVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (i == 3) {
        MyInfoVC *VC = [[MyInfoVC alloc] init];
        VC.vc = self;
        [self.navigationController pushViewController:VC animated:YES];
    }
    if (i == 4) {
        AboutUs *vc = [[AboutUs alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (i == 5) {
        [self cleanUpcache];
    }
    
}

- (void)loadRefreshData{
    NSString *url = POSTRankingCoachRankings;
    [FMNetworkHelper fm_request_postWithUrlString:url isNeedCache:NO parameters:nil successBlock:^(id responseObject) {
        KKLog(@"%@",responseObject);
        FMMainModel *mode=[FMMainModel mj_objectWithKeyValues:responseObject[@"list"]];
        RankingDetailsVC *vc = [[RankingDetailsVC alloc] init];
        vc.model = mode;
        [self.navigationController pushViewController:vc animated:YES];
    } failureBlock:^(NSError *error) {
        KKLog(@"%@", error);
        
    } progress:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];
    //    POSTTeamSchoolList
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
    
}
- (void)logOut:(UIButton *)sender{
    XLAlertView *alert = [[XLAlertView alloc] initWithTitle:@"提示" message:@"是否退出登录" sureBtn:@"确定" cancleBtn:@"取消"];
    [alert showXLAlertView];
    alert.resultIndex = ^(NSInteger index) {
        KKLog(@"%ld",(long)index);
        if (index == 2) {
            [[User UserOb] UserQuit];
            SelectRoleVC *Loginvc = [[SelectRoleVC alloc] init];
            EasyNavigationController * LoginvcNavigationController = [[EasyNavigationController alloc]initWithRootViewController:Loginvc];
            AppDelegate *delegete = (AppDelegate *)[UIApplication sharedApplication].delegate;
            UIViewController *vc = delegete.window.rootViewController;
            delegete.window.rootViewController = LoginvcNavigationController;
            vc = nil;
//            [self presentViewController:Loginvc animated:YES completion:NULL];
        }
    };
    
    
}





- (void)changeUp{
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"请选择添加途径" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    //默认只有标题 没有操作的按钮:添加操作的按钮 UIAlertAction
    
    UIAlertAction *cancelBtn = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        //        NSLog(@"取消");
        [self PhotoLibrary];
    }];
    
    UIAlertAction *cancelBtXJ = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [self xiangji];
        NSLog(@"取消");
        
    }];
    //添加确定
    UIAlertAction *sureBtn = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"确定");
        
    }];
    //设置`确定`按钮的颜色
    //    [sureBtn setValue:[UIColor redColor] forKey:@"titleTextColor"];
    //将action添加到控制器
    [alertVc addAction:cancelBtn];
    [alertVc addAction:cancelBtXJ];
    [alertVc addAction :sureBtn];
    //展示
    [self presentViewController:alertVc animated:YES completion:nil];
    
    
}


///
- (void)xiangji{
    UIImagePickerController * imagePickerController = [[UIImagePickerController alloc]init];
    imagePickerController.mediaTypes = [NSArray arrayWithObject:(__bridge NSString *)kUTTypeImage];
    imagePickerController.delegate = self;
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIAlertView * alerr = [[UIAlertView alloc]initWithTitle:@"警告!" message:@"未找到该硬件设备或设备已损坏" delegate:self cancelButtonTitle:nil otherButtonTitles:@"我知道了", nil];
        [alerr show];
    }else{
        imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        imagePickerController.allowsEditing = YES;
    }
    //利用模态进行调用系统框架
    [self.navigationController presentViewController:imagePickerController animated:YES completion:nil];
    
}
//照片库
- (void)PhotoLibrary{
    UIImagePickerController * imagePickerController = [[UIImagePickerController alloc]init];
    imagePickerController.mediaTypes = [NSArray arrayWithObject:(__bridge NSString *)kUTTypeImage];
    imagePickerController.delegate = self;
    imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePickerController.allowsEditing = YES;
    [self.navigationController presentViewController:imagePickerController animated:YES completion:nil];;
}

#pragma mark -相册代理
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    KKLog(@"%@    ----- %@",picker,info);
    [self uploadPictures:info[UIImagePickerControllerOriginalImage]];
    [picker dismissViewControllerAnimated:YES completion:NULL];
}


- (void)uploadPictures:(UIImage *)image{
    [MBProgressHUD showLoadingHUD:@"正在上传图片"];
    
    
    NSString *url = POSTUpLoadFile;
    
    
    
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer setValue:[User UserOb].token forHTTPHeaderField:@"token"];
    [manager.requestSerializer setValue:@"Mobile" forHTTPHeaderField:@"loginType"];
    [manager POST:url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:UIImageJPEGRepresentation(image, 0.1) name:@"file" fileName:@"tupian.png" mimeType:@"image/png"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"成功返货=============%@",responseObject);
        [MBProgressHUD hideLoadingHUD];
        if (kResponseObjectStatusCodeIsEqual(200)) {
            NSDictionary *dic =responseObject[@"data"][@"data"];
//            [self.imgarr addObject:dic[@"url"]];
            [self chengHeader:dic[@"url"]];
            
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [MBProgressHUD hideLoadingHUD];
    }];
}




- (void)chengHeader:(NSString *)img{
    [FMNetworkHelper fm_request_postWithUrlString:[NSString stringWithFormat:POSTUpdateTeamUserHeadImg,img] isNeedCache:NO parameters:nil successBlock:^(id responseObject) {
        KKLog(@"%@",responseObject);
        if (kResponseObjectStatusCodeIsEqual(200)) {
            NSUserDefaults *defaults  =  [NSUserDefaults standardUserDefaults];
            [defaults setObject:KURLIma(img) forKey:@"teamUserHead"];
            [defaults synchronize];
            [self.HeadPortrait sd_setImageWithURL:[NSURL URLWithString:KURLIma(img)] placeholderImage:[UIImage imageNamed:@"touxiang_nor"]];
            
        }
        
    } failureBlock:^(NSError *error) {
        KKLog(@"%@", error);
        
    } progress:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];
}
@end
