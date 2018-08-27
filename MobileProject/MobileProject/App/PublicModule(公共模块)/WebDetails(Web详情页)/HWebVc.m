//
//  HWebVc.m
//  MobileProject
//
//  Created by zsgy on 2018/6/28.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import "HWebVc.h"

@interface HWebVc ()
@property (nonatomic , strong)UIWebView *webView;
@end

@implementation HWebVc

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationView setTitle:self.title];
    [self loadSubview];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)loadSubview{
    self.webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, kNavBarH, kScreenW, kScreenH-kNavBarH)];
    [self.view addSubview:self.webView];
//    self.webView.delegate  =  self;
//    _webView.scrollView.delegate = self;
//    _webView.scrollView.scrollEnabled = NO;
    _webView.opaque  =  NO;
    _webView.backgroundColor  =  kWhiteColor;
    self.webView.allowsInlineMediaPlayback = YES;
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:_url]];
    //        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60];
    [self.webView loadRequest:request];
}
- (void)setUrl:(NSString *)url{
    _url = url;
    
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
