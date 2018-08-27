//
//  FMWebViewVC.m
//  MobileProject
//
//  Created by Mingo on 2017/8/4.
//  Copyright © 2017年 ZSGY. All rights reserved.
//

#import "FMWebViewVC.h"
#import "XLEwmVC.h"
#import "Feedback.h"
#import "UIWebView+FMSetTonkenToCookie.h"
#import "FMPayRequest.h"
#import "LoginVC.h"
#import "LMWebProgressLayer.h"


#define CALL_APP_LOGIN @"login"
#define CALL_APP_PAY @"pay"
#define CALL_APP_ALIPAY @"alipay"
#define CALL_APP_WECHAT @"wechat"
#define CALL_APP_SHOW_TABBAR @"showTabbar"
#define CALL_APP_OPEN_CAMERA @"openCamera"


@interface FMWebViewVC ()<UIWebViewDelegate,UINavigationControllerDelegate>{
    LMWebProgressLayer *_progressLayer; ///< 网页加载进度条
}

@property(nonatomic, strong) NSString *currentURL; // 获取当前网页的URL
@property(nonatomic, strong) NSString *currentHTML; // 获取当前网页的html
@property(nonatomic, strong) NSString *mallHomeUrl; // 商城主页
@property(nonatomic, assign) CGFloat fixios9_H;
@end

@implementation FMWebViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    if (isIOS10below) {
        self.fixios9_H = kNavStateBarH;
    }
    self.mallHomeUrl = GETmall;
    self.webView =[[UIWebView alloc]initWithFrame:CGRectMake(0,_fixios9_H , kScreenW, kScreenH - kNavBarH - _fixios9_H)];
    _webView.backgroundColor = kWhiteColor;
    _webView.delegate = self;
    [self.view addSubview:self.webView];
    _webView.opaque = NO;
    self.webView.allowsInlineMediaPlayback = YES;
    [self.webView setScalesPageToFit:NO]; //是否缩放
    //web进度条
    _progressLayer = [LMWebProgressLayer new];
    _progressLayer.frame = CGRectMake(0, 20, kScreenW, 2);
    [[UIApplication sharedApplication].keyWindow.rootViewController.view.layer addSublayer:_progressLayer];
    switch (self.detailType) {
        case detailTypeMall: {//商城
            _webView.height = kScreenH - kTabBarH - _fixios9_H;
            _webView.scrollView.bounces = NO;
            //滑动返回取消
//            UISwipeGestureRecognizer * pan = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(gesturesToBack)];
//            [pan setDirection:(UISwipeGestureRecognizerDirectionRight)];
//            [self.view addGestureRecognizer:pan];
        }
            break;
        case detailTypePano: {//全景
            self.webView.frame  = CGRectMake(0, -kNavStateBarH, kScreenW, kScreenH + kNavStateBarH);
            [self.navigationController setNavigationBarHidden:YES animated:YES];
            [self addGobackPop];
            [MBProgressHUD showLoadToView:self.webView];
//            [self headerRefresh];
        }
            break;
        default:{
        }
            break;
    }
}

-(void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.view.height = kScreenH + kTabBarH;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    switch (self.detailType) {
        case detailTypePano:
            break;
        case detailTypeMall:
            [self.navigationController fm_setStatusBarBackgroundColor:kNavBarColor];
            [self.navigationController setNavigationBarHidden:YES animated:NO];
            break;
        default:{
        }
            break;
    }
    [self headerRefresh];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    switch (self.detailType) {
        case detailTypePano:
            [self.navigationController setNavigationBarHidden:NO animated:NO];
            break;
        case detailTypeMall:
            [self.navigationController setNavigationBarHidden:NO animated:NO];
//            self.webView.height = kScreenH -  ;
            break;
        default:{
        }
            break;
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
}

#pragma mark - 手势返回
-(void)gesturesToBack{
    [self.webView goBack];
}

//用苹果自带的返回键按钮处理如下(自定义的返回按钮)
- (void)back:(UIBarButtonItem *)btn {
    if ([self.webView canGoBack]) {
        [self.webView goBack];
    }else{
        [self.view resignFirstResponder];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)addGobackPop {
    UIButton *back = [UIButton fm_initButtonNormalTitleColor:nil backgroundColor:nil font:0 normalImage:[UIImage imageNamed:@"icon_back_r"] cornerRadius:0 addToSuperView:self.webView normalTitle:nil];
    [back mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(kFit_Font6(40));
        make.left.mas_equalTo(kFit_Font6(0));
        make.width.mas_equalTo(kFit_Font6(50));
        make.height.mas_equalTo(kFit_Font6(30));
    }];
    
    [back addTarget:self action:@selector(goBackAction:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)goBackAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)headerRefresh {
    NSString *url = nil;
    self.view.height = kScreenH + kTabBarH;
    if (self.model.link.length && (self.model.link_type != 0)) {
        url = self.model.link;
    }else {
        switch (self.detailType) {
            case detailTypePano://全景
                url = self.model.pano_url;
                break;
            case detailTypeMall: //商城
                if (self.currentURL.length) {
                    url = self.currentURL;
                    self.currentURL = @"";
                    dispatch_async(dispatch_get_main_queue(), ^{
                        self.webView.height = kScreenH -_fixios9_H ;
                        self.tabBarController.tabBar.hidden = YES;
                    });
                }else {
                    if (_mallHomeUrl.length) {
                        url = _mallHomeUrl;
                    }else{
                        if ([FMSingle shareSingle].needReloadWeb) {
                            [FMSingle shareSingle].needReloadWeb = NO;
                             [self.webView reload];
                        }
                        return;
                    }
                
                }
                break;
            default:
                break;
        }
    }
    [self reloadURL:url];
}


#pragma mark - public methods
- (void)reloadURL:(NSString *)url{
    if (_webView) {
        url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [UIWebView fm_setTokenToUIWebViewCookie];
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
//        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60];
        [self.webView loadRequest:request];
    }
}

#pragma mark  - webview delegate
- (void)webViewDidStartLoad:(UIWebView *)webView {
    [_progressLayer startLoad];
    //获取当前页面的title
    NSString * satrtWebtitle = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    //获取当前网页的html
    NSString *satrtWebUrl = webView.request.URL.absoluteString;
    NSString *currentURL = [webView stringByEvaluatingJavaScriptFromString:@"document.location.href"];
    KKLog(@"StartTitle:%@--url:%@;currentURL:%@",satrtWebtitle,satrtWebUrl,currentURL);
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [_progressLayer finishedLoad];
    [self.webView.scrollView.mj_header endRefreshing];
    [MBProgressHUD hideAllHUDsForView:self.webView animated:YES];
}

//如果是H5页面里面自带的返回按钮处理如下:
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    NSString * requestString = [[request URL] absoluteString];
    requestString = [requestString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    //获取H5页面里面按钮的操作方法,根据这个进行判断返回是内部的还是push的上一级页面
    //    if ([requestString hasPrefix:@"goback:"]) {
    //        [self.navigationController popViewControllerAnimated:YES];
    //    }else{
    //        [self.webView goBack];
    //    }
    
    return YES;
}

//获取当前页面的title和url
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [_progressLayer finishedLoad];
    [self.webView.scrollView.mj_header endRefreshing];
    [MBProgressHUD hideAllHUDsForView:self.webView animated:YES];
    
    // 禁止复弹框复制
    [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitUserSelect='none';"];
    [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitTouchCallout='none';"];
    
    //获取当前页面的title
    NSString * title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    //获取当前网页的html
//    self.currentURL = webView.request.URL.absoluteString;
    NSString *currentURL = [webView stringByEvaluatingJavaScriptFromString:@"document.location.href"];
    
    KKLog(@"DidFinishTitle-%@--;location.href:%@",title,currentURL);
    NSString *lJs = @"document.documentElement.innerHTML";
    self.currentHTML = [webView stringByEvaluatingJavaScriptFromString:lJs];
    _mallHomeUrl = @"";
    if ([currentURL isEqualToString:@"about:blank"]) {
        //出现白屏情况，从新加载页面
        KKLog(@">@>>>webView.request.URL>>>>>>>>:%@",webView.request.URL);
        [webView reload];
    }
    // JS 回调
    [self checkWebCallAppEvents:webView];

}

-(void)dealloc {
    [_progressLayer closeTimer];
    [_progressLayer removeFromSuperlayer];
    _progressLayer = nil;
}

#pragma mark - 监测是否执行二维码扫描
- (void)checkWebCallAppEvents:(UIWebView *)webView {
    JSContext *jsContext = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    
    jsContext.exceptionHandler = ^(JSContext *context, JSValue *exceptionValue) {
        context.exception = exceptionValue;
        NSLog(@"jsContext异常信息：%@", exceptionValue);
    };
    if ([FMSingle shareSingle].yfQrCode.length > 1) {//有二维码就发送给H5
        JSValue *Callback = jsContext[@"getQrCode"];
        [Callback callWithArguments:@[[FMSingle shareSingle].yfQrCode]];
    }
    
    __weak __typeof(self) weakSelf = self;
    //和H5开发定义好JS要调用的方法, CallApp就是调用的方法名
    jsContext[@"CallApp"] = ^() {
        NSArray *args = [JSContext currentArguments];
        // args 第一个值是方法名字，后面都该方法的参数 [showTabbar,0];
        NSString *funName = [NSString stringWithFormat:@"%@",[args firstObject]];
        
        if ([funName isEqualToString:CALL_APP_SHOW_TABBAR]) {
            if (args.count >= 2) {
                NSString *arg2 = [NSString stringWithFormat:@"%@",args[1]];
                if ([arg2 isEqualToString:@"0"]) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        self.webView.height = kScreenH -_fixios9_H ;
                        self.tabBarController.tabBar.hidden = YES;
                    });
                }else if ([arg2 isEqualToString:@"1"]) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        self.webView.height = kScreenH - kTabBarH -_fixios9_H;
                        self.tabBarController.tabBar.hidden = NO;
                    });
                }
            }
        } else if ([funName isEqualToString:CALL_APP_OPEN_CAMERA]) {
            dispatch_async(dispatch_get_main_queue(), ^{
                AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
                if (device) {
                    XLEwmVC *VC = [[XLEwmVC alloc] init];
                    VC.hidesBottomBarWhenPushed=YES;
                    [weakSelf.navigationController pushViewController:VC animated:YES];
                } else
                    NSLog(@"未检测到摄像头");
            });
           
        } else if ([funName isEqualToString:CALL_APP_PAY]) {
            if (args.count >= 3) {
                NSString *payType = [NSString stringWithFormat:@"%@",args[1]];
                NSString *order_id = [NSString stringWithFormat:@"%@",args[2]];
                FMMainModel *model = [[FMMainModel alloc] init];
                model.idid = [order_id integerValue];
//                if ([payType isEqualToString:CALL_APP_ALIPAY]) {
//                    [FMPayRequest fm_payRequestWithModel:model pushVc:self isAlipay:YES needOutTickets:NO];
//                }else if ([payType isEqualToString:CALL_APP_WECHAT]) {
//                    [FMPayRequest fm_payRequestWithModel:model pushVc:self isAlipay:NO needOutTickets:NO];
//                }
            }
        }else if ([funName isEqualToString:CALL_APP_LOGIN]) {
            if (args.count >= 2) {
                NSString *arg2 = [NSString stringWithFormat:@"%@",args[1]];
                self.currentURL = KURL(arg2);
                dispatch_async(dispatch_get_main_queue(), ^{
                    [FMHelper fm_showLoginAlertWithController:self tipsStringIfNilShowDefault:nil];
                });
                
            }
        }
    };
}


@end
