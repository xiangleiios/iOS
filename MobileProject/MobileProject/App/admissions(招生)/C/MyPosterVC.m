//
//  MyPosterVC.m
//  MobileProject
//
//  Created by 向蕾 on 2018/10/9.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import "MyPosterVC.h"
#import "CodeShareV.h"
#import "PosterVC.h"
@interface MyPosterVC ()
@property (nonatomic , strong)UIWebView *webView;
@property (nonatomic , strong)UIButton *share;
@end

@implementation MyPosterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationView setTitle:@"图文海报"];
    
    
    
    [self loadWebview];
    // Do any additional setup after loading the view.
}
- (void)loadWebview{
    UIWebView *web = [[UIWebView alloc] init];
    
    
    
    self.webView = web;
    [self.view addSubview:web];
    [web mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view).mas_offset(kNavBarH);
        make.bottom.mas_equalTo(self.view);
    }];
//    self.webView.delegate = self;
    
    self.share = [[UIButton alloc] init];
    [self.view addSubview:self.share];
    self.share.layer.cornerRadius = kFit_Font6(5);
    self.share.layer.masksToBounds = YES;
    [self.share setTitle:@"分享 " forState:UIControlStateNormal];
    [self.share setBackgroundImage:[UIImage createImageWithColor:kColor_N(0, 112, 234)] forState:UIControlStateNormal];
    [self.share setBackgroundImage:[UIImage createImageWithColor:kRGBAColor(0, 112, 234, 0.6)] forState:UIControlStateHighlighted];
    [self.share addTarget:self action:@selector(toShare) forControlEvents:UIControlEventTouchUpInside];
    [self.share mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).mas_offset(KFit_W6S(30));
        make.right.bottom.mas_equalTo(self.view).mas_offset(-KFit_W6S(30));
        make.height.mas_equalTo(KFit_H6S(90));
    }];
    
}
#pragma mark -调用分享
- (void)toShare{
//    CodeShareV *v = [[CodeShareV alloc] init];
//    v.type = ShareTypeText;
//    XLshare *share = [[XLshare alloc]init];
//    share.shareImgUrl = self.model.memo;
//    v.share = share;
//    [v show];
    
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSArray *arr = self.navigationController.viewControllers;
    NSMutableArray *marr = [[NSMutableArray alloc]initWithArray:arr];
    for (UIViewController *vc in arr) {
        if ([vc isKindOfClass:[PosterVC class]]) {
            [marr removeObject:vc];
        }
    }
    [self.navigationController setViewControllers:marr animated:NO];
    [self load];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
}
- (void)load{
//    NSString *urls =  [NSString stringWithFormat:HTMLMINGPIAN,self.model.idid];
    NSString *urls =  [NSString stringWithFormat:HTMLHAIBAO,self.idid,@"app"];
    
    KKLog(@"url :%@",urls);
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urls]];
    [self.webView loadRequest:request];
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
