//
//  WebViewController1.m
//  zsnc
//
//  Created by ifeng on 15/7/17.
//  Copyright (c) 2015年 IFeng. All rights reserved.
//


#import "WebViewController1.h"
@interface WebViewController1 ()<UIWebViewDelegate>
{
    UIWebView* _webView;
}

@end

@implementation WebViewController1

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"关闭" style:UIBarButtonItemStylePlain target:self action:@selector(on_btn_close)];

    self.view.backgroundColor = [UIColor whiteColor];
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH-20-self.navigationController.navigationBar.frame.size.height)];
    
    [self.view addSubview:_webView];
    
    _webView.delegate = self;
    _webView.scalesPageToFit = YES;
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
}

- (void)on_btn_close
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

//- (void)back:(UITapGestureRecognizer*)sender{
//    [self.myWebview stopLoading];
//    if (self.isShow) {
//        
//    }else{
//        [MyTools showTabBar];
//
//    }
//    [self.navigationController popViewControllerAnimated:YES];
//}
//

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

- (void)webViewDidStartLoad:(UIWebView *)webView{
//    [SVProgressHUD show];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
//    [SVProgressHUD dismiss];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
//    [SVProgressHUD dismiss];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
//    self.navigationController.navigationBarHidden = NO;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
//    self.navigationController.navigationBarHidden = YES;
}

@end
