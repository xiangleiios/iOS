//
//  CommentDetailsVC.m
//  MobileProject
//
//  Created by zsgy on 17/8/7.
//  Copyright © 2017年 ZSGY. All rights reserved.
//

#import "CommentDetailsVC.h"
#import "XLInputvc.h"
#import "FMMainModel.h"
#import "FMCommentCell.h"
#import "MJRefresh+FooterManger.h"
#import "UITableView+FMPlaceholder.h"

@interface CommentDetailsVC ()<UITableViewDelegate,UITableViewDataSource,XLInputvcDelegate>
@property (nonatomic , strong)XLInputvc *input;
@property(nonatomic, strong) UITableView *table;
@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation CommentDetailsVC
- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray =[[NSMutableArray alloc] init];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    self.title=@"评论详情";
    [self addTableView];
    _table.needPlaceholderView = YES;
    __weak __typeof(self)weakSelf = self;
    self.table.reloadBlock = ^{
        [weakSelf.table.mj_header beginRefreshing];
        [weakSelf headerRefresh];
    };
    self.input = [[XLInputvc alloc]init];
    self.input.view.frame = CGRectMake(0, SCREEN_HEIGHT - kFit_Font6(50)-64, SCREEN_WIDTH, SCREEN_HEIGHT);
    [self.view addSubview:self.input.view];
    [self addChildViewController:self.input];
    self.input.pushvc = self;
    self.input.delegate = self;
    self.input.model = self.model;
}

- (void)chatBoxViewController:(XLInputvc *)Inputvc didChangeChatBoxHeight:(CGFloat)height{
    self.input.view.frame=CGRectMake(0, SCREEN_HEIGHT - kNavBarH - height, SCREEN_WIDTH, height);
}

- (void)chatBoxViewController:(XLInputvc *)Inputvc isSendCommentContentComplete:(BOOL)isComplete {
    if (isComplete) {
        [_table.mj_header beginRefreshing];
    }
}

#pragma mark - 网络请求
- (void)headerRefresh{
    self.pageNum = 1;
    [self uploadDataReqWithIsRefresh];
}

- (void)footerRefresh {
    self.pageNum++;
    [self uploadDataReqWithIsRefresh];
}

- (void)uploadDataReqWithIsRefresh{


    
}

#pragma mark - 创建UI
- (void)addTableView {
    self.table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH -kNavBarH - kTabBarH) style:UITableViewStylePlain];
    _table.dataSource = self;
    _table.delegate = self;
    _table.tableFooterView = [UIView new];
    [self.view addSubview:_table];
    
    [_table registerClass:[FMCommentCell class] forCellReuseIdentifier:@"FMCommentCell"];
    _table.mj_header = [XLHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefresh)];
    _table.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefresh)];
    _table.footRefreshState = MJFooterRefreshStateNormal; //当数据木有一屏幕时隐藏上拉加载
    [_table.mj_header beginRefreshing];
    _table.needPlaceholderView = YES;
    __weak __typeof(self)weakSelf = self;
    [_table setReloadBlock:^{
        [weakSelf.table.mj_header beginRefreshing];
    }];
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
    
//    if (!cell) {
        cell = [[FMCommentCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
//    }
   
    cell.pushVC = self;
    cell.model = self.dataArray[indexPath.row];
    cell.voteCommentDelete = ^(BOOL isVoteCommentDeleteOk) {
        if (isVoteCommentDeleteOk) {
            [self.table.mj_header beginRefreshing];
        }
    };
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    //因为先走了创建cell的代理方法，所以通过此方法能够获取到视图布局后的cell高度
    FMCommentCell *cell = (FMCommentCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
    
    NSDictionary *attrs = @{NSFontAttributeName : cell.yfText.font};
    CGSize maxSize = CGSizeMake(kScreenW - KFit_W6S(140), MAXFLOAT);
    // 计算文字占据的高度
    CGSize size = [cell.yfText.text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
    return size.height + kFit_Font6(60);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
