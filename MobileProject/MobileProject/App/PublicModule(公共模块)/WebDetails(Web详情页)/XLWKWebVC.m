//
//  XLWKWebVC.m
//  MobileProject
//
//  Created by 向蕾 on 2018/10/30.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import "XLWKWebVC.h"
#import <WebKit/WebKit.h>
@interface XLWKWebVC ()<WKNavigationDelegate,WKUIDelegate>
@property (nonatomic , strong)WKWebView *webView;
@end

@implementation XLWKWebVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationView setTitle:@""];
    self.webView = [[WKWebView alloc] initWithFrame:self.view.frame];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://pu12561238.m.icoc.me"]]];
    self.webView.navigationDelegate = self;
    self.webView.UIDelegate = self; //开了支持滑动返回
    self.webView.allowsBackForwardNavigationGestures = YES;
    [self.view addSubview:self.webView];
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
