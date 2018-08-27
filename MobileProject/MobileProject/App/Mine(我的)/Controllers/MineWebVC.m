//
//  MineWebVC.m
//  MobileProject
//
//  Created by zsgy on 2017/12/1.
//  Copyright © 2017年 ZSGY. All rights reserved.
//

#import "MineWebVC.h"
#import <WebKit/WebKit.h>
@interface MineWebVC ()

@end

@implementation MineWebVC

- (void)viewDidLoad {
    [super viewDidLoad];
    WKWebView *webView = [[WKWebView alloc]init];
    [self.view addSubview:webView];
    [webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(self.view);
    }];
//    NSURL *url = [NSURL URLWithString:@"https://www.baidu.com"];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.url]];
    [webView loadRequest:request];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
