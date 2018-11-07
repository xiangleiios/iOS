//
//  DetailsVC.m
//  MobileProject
//
//  Created by zsgy on 17/8/4.
//  Copyright © 2017年 ZSGY. All rights reserved.
//

#import "DetailsVC.h"
#import "ToolbarVC.h"
#import "FMCommentCell.h"
#import "UIWebView+FMSetTonkenToCookie.h"
#import "LMWebProgressLayer.h"

static NSString  *kcontentSize = @"contentSize";

@interface DetailsVC () <UITableViewDelegate,UITableViewDataSource,UIWebViewDelegate,XLInputvcDelegate> {
    LMWebProgressLayer *_progressLayer; ///< 网页加载进度条
}
@property(nonatomic, strong) UITableView *table;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic , strong)ToolbarVC *toolbar;
@property (nonatomic , strong)UIWebView *webView;


@end

@implementation DetailsVC

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray =[[NSMutableArray alloc] init];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"详情页";
    [self addTableView];
    
    [self loadweb];

    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(begainFullScreen) name:UIWindowDidBecomeVisibleNotification object:nil];//进入全屏
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(endFullScreen) name:UIWindowDidBecomeHiddenNotification object:nil];//退出全屏
    
}
- (void)loadrightBarButtonItem{
    //定制右按钮
    
    UIButton *but = [[UIButton alloc] initWithFrame:CGRectMake(0,0, KFit_W6S(150), KFit_W6S(60))];
    [but setImage:[UIImage imageNamed:@"icon_ticket_one"] forState:UIControlStateNormal];
    [but addTarget:self action:@selector(ticket)forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem  *barBut = [[UIBarButtonItem alloc]initWithCustomView:but];
    self.navigationItem.rightBarButtonItem = barBut;
}
-(void)ticket{
   
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self touchRefresh];
    [self begainFullScreen];

}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
        [_webView reload]; //重新加载 防止web中如果有视频，正在播放的视频在页面消失后还在播放。
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
}

#pragma mark - 创建UI
- (void)addTableView {
    self.table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH -kNavBarH - kFit_Font6(50)) style:UITableViewStylePlain];
    _table.dataSource = self;
    _table.delegate = self;
    _table.tableFooterView = [UIView new];
    [self.view addSubview:_table];
    
    [_table registerClass:[FMCommentCell class] forCellReuseIdentifier:@"FMCommentCell"];
//    _table.separatorStyle = UITableViewCellSeparatorStyleNone;
//    _table.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshData)];
//    _table.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(getMoreData)];
//    [_table.mj_header beginRefreshing];
    
}
#pragma mark - 购票
- (void)loadTicket{
    UIButton *ticket=[[UIButton alloc] init];
    [self.view addSubview:ticket];
    [ticket mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.view);
        make.height.mas_equalTo(kFit_Font6(50));
    }];
    [ticket setTitle:@"购票" forState:UIControlStateNormal];
    [ticket setBackgroundImage:[UIImage imageNamed:@"comment_background"] forState:UIControlStateNormal];
    [ticket setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [ticket addTarget:self action:@selector(toTicket) forControlEvents:UIControlEventTouchUpInside];
}

- (void)toTicket{
    
    
}
#pragma mark - 输入框
- (void)loadinput{
    self.inputvc=[[XLInputvc alloc]init];
    self.inputvc.view.frame=CGRectMake(0, SCREEN_HEIGHT-64 - kFit_Font6(50), SCREEN_WIDTH, SCREEN_HEIGHT);
    [self.view addSubview:self.inputvc.view];
    [self addChildViewController:self.inputvc];
    self.inputvc.pushvc=self;
    self.inputvc.delegate=self;
    self.inputvc.model=self.model;
}

- (void)loadweb{
    self.webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH-KFit_H6S(100)-kNavBarH)];
    self.table.tableHeaderView =  self.webView;
    self.webView.delegate  =  self;
    _webView.scrollView.delegate = self;
    _webView.scrollView.scrollEnabled = NO;
    _webView.opaque  =  NO;
    _webView.backgroundColor  =  kWhiteColor;
    self.webView.allowsInlineMediaPlayback = YES;

    //web进度条
    _progressLayer = [LMWebProgressLayer new];
    _progressLayer.frame = CGRectMake(0, self.navigationController.navigationBar.height - 2, kScreenW, 2);
    [self.navigationController.navigationBar.layer addSublayer:_progressLayer];
    
    self.webView.scrollView.mj_header  =  [XLHeader headerWithRefreshingTarget:self refreshingAction:@selector(touchRefresh)];
    [self performSelector:@selector(stopLoadingHud) withObject:nil afterDelay:15.0];

//    [self.webView.scrollView.mj_header beginRefreshing];
    [self touchRefresh];
    for (UIView * views in [self.webView subviews]) {
        if ([views isKindOfClass:[UIScrollView class]]) {
            //去掉水平方向的滑动条
            [(UIScrollView *)views setShowsHorizontalScrollIndicator:NO];
            //去掉垂直方向的滑动条
            [(UIScrollView *)views setShowsVerticalScrollIndicator:NO];
            for (UIView * inScrollView in views.subviews) {
                if ([inScrollView isKindOfClass:[UIImageView class]]) {
                    //隐藏上下滚动出边界时的黑色的图片
                    inScrollView.hidden = YES;
                }
            }
        }
    }
}

- (void)stopLoadingHud {
    [self.webView.scrollView.mj_header endRefreshing];
}

- (void)touchRefresh {
    NSString *url = @"";
    NSLog(@"webUrl:%@",url);
    [self reloadURL:url];
}

- (void)reloadURL:(NSString *)url{
    if (_webView) {
        url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [UIWebView fm_setTokenToUIWebViewCookie];
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
        //        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60];
        [self.webView loadRequest:request];
    }
}

- (void)loadtoolbar{
    ToolbarVC *vc = [[ToolbarVC alloc]init];
    vc.model = self.model;
    vc.viewcontroller = self;
    [self.view addSubview:vc.view];
    self.toolbar = vc;
    vc.view.frame = CGRectMake(0, kScreenH - kFit_Font6(50) - kNavBarH,kScreenW,kFit_Font6(50) + kNavBarH);
    [self addChildViewController:vc];
}

#pragma mark -  --------------UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    [_progressLayer startLoad];

}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [_progressLayer finishedLoad];

    [self.webView.scrollView.mj_header endRefreshing];
    
    CGFloat webViewHeight =[[webView stringByEvaluatingJavaScriptFromString:@"document.body.offsetHeight"] floatValue];
    // CGFloat webViewHeight= [[webViewstringByEvaluatingJavaScriptFromString:@document.body.scrollHeight]floatValue];
    CGRect newFrame = webView.frame;
    newFrame.size.height = webViewHeight;
//    webView.frame= newFrame;
    
    self.webView.frame = newFrame;
    [self.table beginUpdates];
    self.table.tableHeaderView = self.webView;
    [self.table endUpdates];
    
    [self.webView.scrollView addObserver:self forKeyPath:kcontentSize options:NSKeyValueObservingOptionNew context:nil];
    [self uploadDataReqWithIsRefresh];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [_progressLayer finishedLoad];
    [self.webView.scrollView.mj_header endRefreshing];
    
}
#pragma mark - 评论框代理
- (void)chatBoxViewController:(XLInputvc *)Inputvc
        didChangeChatBoxHeight:(CGFloat)height{
    self.inputvc.view.frame=CGRectMake(0, SCREEN_HEIGHT - kNavBarH - height, SCREEN_WIDTH, height);
}
- (void)chatBoxViewController:(XLInputvc *)Inputvc isSendCommentContentComplete:(BOOL)isComplete{
    KKLog(@"发送成功");
    [self uploadDataReqWithIsRefresh];
    
}
- (void)uploadDataReqWithIsRefresh{
    
}


#pragma mark - UITableViewDataSource && Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellID = [NSString stringWithFormat:@"FMCommentCell"];
    FMCommentCell *cell = (FMCommentCell *)[tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (!cell) {
        cell = [[FMCommentCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    cell.model = self.dataArray[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    //因为先走了创建cell的代理方法，所以通过此方法能够获取到视图布局后的cell高度
    FMCommentCell *cell = (FMCommentCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
    //cell.contentView上添加的最后一个视图距离底部的距离为8
    return [cell getLayoutCellHeightWithFlex:5];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (self.dataArray.count) {
        return kFit_Font6(35);
    }else {
        return 0.01;
    }
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *back = [[UIView alloc] init];
    if (self.dataArray.count) {
        back.backgroundColor = kWhiteColor;
        [back setFrame:CGRectMake(0, 0, kScreenW, kFit_Font6(25))];
        UIView *line  = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, 0.7)];
        [back addSubview:line];
        line.backgroundColor = kGreyColor;
        UIView *line2  = [[UIView alloc] initWithFrame:CGRectMake(0, kFit_Font6(35) - 0.3, kScreenW, 0.3)];
        [back addSubview:line2];
        line2.backgroundColor = kGreyColor3;
        
        UILabel *lab = [UILabel fm_initUIlabelWithTextColor:kRGBColor(252, 207, 66) backColor:nil textAlignment_Left0_Center1_Right2:0 font:16 cornerRadius:0 addToSuperView:back title:@"最新评论"];
        [lab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(back);
            make.left.with.offset(kFit_Font6(10));
            make.size.mas_equalTo(CGSizeMake(kFit_Font6(100), kFit_Font6(18)));
        }];
    }
    return back;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    
    [self.webView.scrollView removeObserver:self forKeyPath:kcontentSize context:nil];
    [_progressLayer closeTimer];
    [_progressLayer removeFromSuperlayer];
    _progressLayer = nil;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    
    if ([keyPath isEqualToString:kcontentSize]) {
        CGFloat webViewHeight =[[self.webView stringByEvaluatingJavaScriptFromString:@"document.body.offsetHeight"] floatValue];
        // CGFloat webViewHeight= [[webViewstringByEvaluatingJavaScriptFromString:@document.body.scrollHeight]floatValue];
        CGRect newFrame = self.webView.frame;
        newFrame.size.height= webViewHeight + kFit_Font6(20);
        self.webView.frame= newFrame;
        [self.table beginUpdates];
        self.table.tableHeaderView = self.webView;
        [self.table endUpdates];
        
    }else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

//- (void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//    float height = [[_webView stringByEvaluatingJavaScriptFromString:@"document.body.offsetHeight"] floatValue];
//    
//    if( _commentListView )
//    {
//        CGRect rc = _commentListView.frame;
//        {
//            rc.origin.y = height;
//            _commentListView.frame = rc;
//            _webView.scrollView.contentSize = CGSizeMake(_webView.frame.size.width, _commentListView.frame.origin.y + _commentListView.frame.size.height);
//        }
//    }
//    
//}
// 进入全屏

-(void)begainFullScreen

{
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    appDelegate.allowRotate = 1;
    
}

// 退出全屏

-(void)endFullScreen

{
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    appDelegate.allowRotate = 0;
    
    //强制归正：
    
    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
        
        SEL selector = NSSelectorFromString(@"setOrientation:");
        
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
        
        [invocation setSelector:selector];
        
        [invocation setTarget:[UIDevice currentDevice]];
        
        int val =UIInterfaceOrientationPortrait;
        
        [invocation setArgument:&val atIndex:2];
        
        [invocation invoke];
        
    }
    
}


@end
