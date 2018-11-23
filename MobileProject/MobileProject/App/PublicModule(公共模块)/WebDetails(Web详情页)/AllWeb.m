//
//  AllWeb.m
//  MobileProject
//
//  Created by 向蕾 on 2018/11/22.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import "AllWeb.h"
#import <WebKit/WebKit.h>
@interface AllWeb ()<WKNavigationDelegate,WKUIDelegate>
@property (nonatomic , strong)WKWebView *webView;
@end

@implementation AllWeb

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationView setTitle:@""];
    self.webView = [[WKWebView alloc] init];
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
    self.webView.navigationDelegate = self;
    self.webView.UIDelegate = self; //开了支持滑动返回
    self.webView.allowsBackForwardNavigationGestures = YES;
    [self.view addSubview:self.webView];
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.view);
        make.top.mas_equalTo(kNavBarH);
    }];
    // Do any additional setup after loading the view.
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
