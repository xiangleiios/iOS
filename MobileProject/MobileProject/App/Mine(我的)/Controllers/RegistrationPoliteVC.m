//
//  RegistrationPoliteVC.m
//  MobileProject
//
//  Created by zsgy on 2018/6/22.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import "RegistrationPoliteVC.h"
#import "RegisteredVC.h"
@interface RegistrationPoliteVC ()
@property (nonatomic , strong)UIButton *registered;
@property (nonatomic , strong)UIWebView *webView;
@end

@implementation RegistrationPoliteVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationView setTitle:@"注册有礼"];
    self.navigationView.titleLabel.textColor = [UIColor blackColor];
    [self loadSubview];
    // Do any additional setup after loading the view.
}
- (void)loadSubview{
    
    self.webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, kNavBarH, kScreenW, kScreenH-kNavBarH-KFit_H6S(200))];
    [self.view addSubview:self.webView];
    //    self.webView.delegate  =  self;
    //    _webView.scrollView.delegate = self;
    //    _webView.scrollView.scrollEnabled = NO;
    _webView.opaque  =  NO;
    _webView.backgroundColor  =  kWhiteColor;
    self.webView.allowsInlineMediaPlayback = YES;
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:HTMLRegistrationPolite]];
    //        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60];
    [self.webView loadRequest:request];
    
    UIView *v =[[UIView alloc] init];
    v.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:v];
    [v mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.view);
        make.height.mas_equalTo(KFit_H6S(200));
    }];
    
    self.registered = [[UIButton alloc] init];
    [self.view addSubview:self.registered];
    self.registered.layer.cornerRadius = 5;
    [self.registered addTarget:self action:@selector(toRegistered) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    UIButton *share = [[UIButton alloc] init];
    [self.view addSubview:share];
    share.layer.cornerRadius = 5;
    [share setTitle:@"分享有礼" forState:UIControlStateNormal];
    [share addTarget:self action:@selector(toShare) forControlEvents:UIControlEventTouchUpInside];
    share.layer.borderColor = kColor_N(201, 201, 201).CGColor;
    share.layer.borderWidth = 0.3;
    NSArray *arr = @[self.registered,share];
    if ([User UserOb].UserLogin) {
        [self.registered setTitle:@"我已注册哦~" forState:UIControlStateNormal];
        [self.registered setBackgroundColor:kColor_N(201, 201, 201)];
        [share setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [share setBackgroundColor:appcoloer];
    }else{
        [self.registered setTitle:@"注册有礼" forState:UIControlStateNormal];
        [self.registered setBackgroundColor:appcoloer];
        [share setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [share setBackgroundColor:[UIColor whiteColor]];
    }
    [arr mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:KFit_W6S(40) leadSpacing:KFit_W6S(40) tailSpacing:KFit_W6S(40)];
    [arr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.view).mas_offset(-KFit_H6S(80));
        make.height.mas_equalTo(KFit_H6S(80));
    }];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)toRegistered{
    if (![User UserOb].UserLogin) {
        RegisteredVC *vc = [[RegisteredVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
