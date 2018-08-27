//
//  XLSMWebVC.m
//  FSZX
//
//  Created by zsgy on 16/11/8.
//  Copyright © 2016年 王文辉. All rights reserved.
//

#import "XLSMWebVC.h"
//#import "AFNetworking.h"
//#import "MyLoginViewController.h"

@interface XLSMWebVC ()
@property(nonatomic, strong) NSString *tipsString; //兑换码的类型（如会员，订阅）
@end

@implementation XLSMWebVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupNavigationItem];
    
    if (self.jump_bar_code) {
        [self setupLabel];
    } else {
        [self setupWebView];
    }
    
    // Do any additional setup after loading the view.
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)setupNavigationItem {
    UIButton *left_Button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 44)];
    [left_Button setTitle:@"返回" forState:UIControlStateNormal];
    [left_Button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [left_Button addTarget:self action:@selector(left_BarButtonItemAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *left_BarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:left_Button];
    self.navigationItem.leftBarButtonItem = left_BarButtonItem;
}

- (void)left_BarButtonItemAction {
    NSArray *viewControllers = @[self.navigationController.viewControllers.firstObject,self.navigationController.viewControllers.lastObject];
    self.navigationController.viewControllers = viewControllers;
    [self.navigationController popViewControllerAnimated:YES];
}

// 添加Label，加载扫描过来的内容
- (void)setupLabel {
    
    
    NSArray *arr = [self.jump_bar_code componentsSeparatedByString:@"/"];
    if ([[arr firstObject] isEqualToString:@"members"]) {
        _tipsString = @"会员";
    } else  if ([[arr firstObject] isEqualToString:@"categories"]) {
        _tipsString = @"订阅";
    }
    
    
}

// 添加webView，加载扫描过来的内容
- (void)setupWebView {
    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    
    webView.frame = self.view.bounds;
    
    // 1. URL 定位资源,需要资源的地址
    NSString *urlStr = self.jump_URL;
    
    NSURL *url = [NSURL URLWithString:urlStr];
    
    // 2. 把URL告诉给服务器,请求,从m.baidu.com请求数据
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    // 3. 发送请求给服务器
    [webView loadRequest:request];
    
    [self.view addSubview:webView];
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
