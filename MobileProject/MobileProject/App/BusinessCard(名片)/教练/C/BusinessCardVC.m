//
//  BusinessCardVC.m
//  MobileProject
//
//  Created by 向蕾 on 2018/8/22.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import "BusinessCardVC.h"
#import "ChangeCardVC.h"
#import "CodeShareV.h"
#import "ChangeCardHeadVC.h"
#import "FMJS.h"
#import "AddCoachVC.h"
@interface BusinessCardVC ()<UIWebViewDelegate,AppJSObjectDelegate>
@property (nonatomic , strong)UIWebView *webView;
@property (nonatomic , strong)NSMutableArray *dataArr;
@end

@implementation BusinessCardVC
- (NSMutableArray *)dataArr{
    if (_dataArr==nil) {
        _dataArr=[NSMutableArray array];
    }
    return _dataArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self laodNavigation];
    [self loadWebview];
    if (!USERFZR) {
        [self loadSubview];
    }
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - 导航相关
#pragma mark - 导航相关
- (void)laodNavigation{
    
    kWeakSelf(self)
    [self.navigationView setNavigationBackButtonCallback:^(UIView *view) {
        if (weakself.webView.canGoBack == YES) {
            [weakself.webView goBack];
            return;
        }else{
            [weakself.navigationController popViewControllerAnimated:YES];
        }
    }];
    
    [self.navigationView.navigationBackButton setImage:[UIImage imageNamed:@"back_white"] forState:UIControlStateNormal];
    self.navigationView.titleLabel.textColor = [UIColor whiteColor];
    [self.navigationView setNavigationBackgroundImage:[UIImage imageNamed:@"jiaxiao_bg"]];
    if (USERFZR) {
        [self.navigationView addRightButtonWithImage:[UIImage imageNamed:@"chakan"] clickCallBack:^(UIView *view) {
            AddCoachVC *vc = [[AddCoachVC alloc] init];
            vc.type = 1;
            vc.model = weakself.model;
            [weakself.navigationController pushViewController:vc animated:YES];
        }];
    }
    
    //web进度条
//    _progressLayer = [LMWebProgressLayer new];
//    _progressLayer.frame = CGRectMake(0, self.navigationController.navigationBar.height - 2, kScreenW, 2);
//    [self.navigationController.navigationBar.layer addSublayer:_progressLayer];
}

- (void)loadWebview{
    UIWebView *web = [[UIWebView alloc] init];
    self.webView = web;
    [self.view addSubview:web];
    if (USERFZR) {
        [web mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(self.view);
            make.top.mas_equalTo(self.view).mas_offset(kNavBarH);
            make.bottom.mas_equalTo(self.view);
        }];
    }else{
        
        [web mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(self.view);
            make.top.mas_equalTo(self.view).mas_offset(kNavBarH);
            make.bottom.mas_equalTo(self.view).mas_offset(-KFit_H6S(150));
        }];
    }
    self.webView.delegate = self;
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self load];
}
- (void)load{
    NSString *urls =  [NSString stringWithFormat:HTMLMINGPIAN,self.type,self.model.coachId];
    KKLog(@"url :%@",urls);
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urls]];
    [self.webView loadRequest:request];
}
- (void)loadSubview{
    UIButton *change = [[UIButton alloc] init];
    [self.view addSubview:change];
    [change setTitle:@"修改资料" forState:UIControlStateNormal];
    [change setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [change addTarget:self action:@selector(toChange) forControlEvents:UIControlEventTouchUpInside];
    [change setBackgroundImage:[UIImage createImageWithColor:kColor_N(0, 112, 234)] forState:UIControlStateNormal];
    [change setBackgroundImage:[UIImage createImageWithColor:kRGBAColor(0, 112, 234, 0.6)] forState:UIControlStateHighlighted];
    change.layer.cornerRadius = 5;
    change.layer.masksToBounds = YES;
    
    
    
    UIButton *share = [[UIButton alloc] init];
    [self.view addSubview:share];
    share.layer.cornerRadius = kFit_Font6(5);
    share.layer.masksToBounds = YES;
    share.layer.borderColor = kColor_N(0, 112, 234).CGColor;
    share.layer.borderWidth = 0.5;
    [share setTitle:@"分享" forState:UIControlStateNormal];
    [share setTitleColor:kColor_N(0, 112, 234) forState:UIControlStateNormal];
    [share addTarget:self action:@selector(share) forControlEvents:UIControlEventTouchUpInside];
    share.layer.cornerRadius = 5;
    share.layer.masksToBounds = YES;
    
    NSArray *arr = @[change,share];
    [arr mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:KFit_W6S(30) leadSpacing:KFit_W6S(30) tailSpacing:KFit_W6S(30)];
    [arr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.view).mas_offset(-KFit_H6S(30));
        make.height.mas_equalTo(KFit_H6S(90));
    }];
    
}

- (void)toChange{
    ChangeCardVC *vc = [[ChangeCardVC alloc] init];
//    vc.model = self.model;
    vc.idid = self.model.idid;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)share{
    XLSingleton *sing = [XLSingleton singleton];
    sing.type = 2;
    sing.shareId = self.model.idid;
    CodeShareV *v = [[CodeShareV alloc] init];
    v.type = ShareTypeText;
    XLshare *share = [[XLshare alloc]init];
    share.title = [NSString stringWithFormat:@"我是%@的%@,邀您来学车！",self.model.schoolName,self.model.name];
    share.subTitle = _model.introduce;
    share.url = [NSString stringWithFormat:HTMLMINGPIANFENXIANG,self.model.coachId];
    share.xcxurl = [NSString stringWithFormat:@"pages/index/detail/detail?id=%@",self.model.coachId];
    v.share = share;
    [v show];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    JSContext *context = [self.webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    
    FMJS *jsObject = [FMJS new];
    jsObject.delegate = self;
    context[@"jsObject"] = jsObject;
    
//    context.exceptionHandler = ^(JSContext *context, JSValue *exceptionValue) {
//        context.exception = exceptionValue;
//        NSLog(@"jsContext异常信息：%@", exceptionValue);
//    };
//    context[@"jsObject"] = self;
    //定义好JS要调用的方法, share就是调用的share方法名
    context[@"jsObject"][@"submit"] = ^() {
        NSLog(@"+++++++Begin Log+++++++");
        NSArray *args = [JSContext currentArguments];
        for (JSValue *jsVal in args) {
            NSLog(@"%@", jsVal.toString);
            [self.dataArr addObject:jsVal.toString];
        }
        [self loadRefreshData];
        NSLog(@"-------End Log-------");
    };
}


-(void)submit:(NSString *)message ID:(NSString *)idid{
    
    KKLog(@"wwwwwww    %@",message);
}
#pragma mark - UIWebViewDelegate

- (void)loadRefreshData{
    NSString *url = POSTReplyAdd;
    if (self.dataArr.count < 2) {
        [MBProgressHUD showMsgHUD:@"请填写回复内容"];
        return;
    }
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:[self.dataArr firstObject] forKey:@"appraiseId"];
    [dic setObject:[self.dataArr lastObject] forKey:@"content"];
    [FMNetworkHelper fm_request_postWithUrlString:url isNeedCache:NO parameters:dic successBlock:^(id responseObject) {
        KKLog(@"%@",responseObject);
        [self load];
    } failureBlock:^(NSError *error) {
        KKLog(@"%@", error);
        
    } progress:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];
    //    POSTTeamSchoolList
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
