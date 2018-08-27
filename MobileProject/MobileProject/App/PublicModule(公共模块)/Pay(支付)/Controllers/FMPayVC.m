//
//  FMPayVC.m
//  MobileProject
//
//  Created by Mingo on 2017/11/3.
//  Copyright © 2017年 ZSGY. All rights reserved.
//

#import "FMPayVC.h"
#import "PPNumberButton.h"
#import "FMPayCell.h"
#import "HcdDateTimePickerView.h"
#import "NSString+FMDate.h"
#import "NSDate+JYHandle.h"
#import "NSString+FMDate.h"
#import "FMPayRequest.h"

#define mainBackColor kRGBColor(239, 239, 244)
#define padding KFit_W6S(20)

@interface FMPayVC () <UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UIView *backHeader;
@property (nonatomic, strong) UITableView *table;
@property (nonatomic, strong) NSMutableArray <FMMainModel *>*dataTable;
@property (nonatomic, strong) UILabel *yfRemainingTimeTitle;
@property (nonatomic, strong) UILabel *yfRemainingTimeText;
@property (nonatomic, strong) NSTimer *yfRemainingTimer;

/// 顶部封面图
@property (nonatomic, strong) UIImageView *yfCoverIma;
/// 价格标题
@property (nonatomic, strong) UILabel *yfPriceTitle;
/// 订单号
@property (nonatomic, strong) UILabel *yfOrderTitle;
/// 商品标题
@property (nonatomic, strong) UILabel *yfProductTitle;
/// 商品数量
@property (nonatomic, strong) UILabel *yfProductNumLab;
/// 确认支付
@property (nonatomic, strong) UIButton *yfSurePay;
@property (nonatomic, strong) UIButton *yfSeletcAlipay;
@property (nonatomic, strong) UIButton *yfSeletcWechatPay;
@property(nonatomic, assign) NSTimeInterval countDownNum;

/// 验证码（二维码）
@property (nonatomic, strong) NSMutableArray <FMMainModel *>*dataTicketCodes;

@end

@implementation FMPayVC

- (NSMutableArray *)dataTicketCodes{
    if (!_dataTicketCodes) {
        _dataTicketCodes =[[NSMutableArray alloc] init];
    }
    return _dataTicketCodes;
}

- (NSMutableArray *)dataTable{
    if (!_dataTable) {
        _dataTable =[[NSMutableArray alloc] init];
        FMMainModel *model = [[FMMainModel alloc] init];
        model.name = @"支付宝支付";
        model.image_url = @"alipay"; //wechatpay  pay_pitchon  pay_unselected
        
        FMMainModel *model2 = [[FMMainModel alloc] init];
        model2.name = @"微信支付";
        model2.image_url = @"wechatpay"; //wechatpay  pay_pitchon  pay_unselected
        [_dataTable addObject:model];
        [_dataTable addObject:model2];
    }
    return _dataTable;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kBgGreyColor;
    self.title = @"支付";
    [self addTableView];
    //底部创建订单按钮
    [self createSurePayButton];
    [self fm_determineOrderTime];
    
    
    self.yfRemainingTimer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(countDownAction) userInfo:nil repeats:YES];
//    [self tableView:self.table didSelectRowAtIndexPath:self.index];

}

#pragma mark - 判断订货时间是否满足15min
- (void)fm_determineOrderTime {
    NSDate *createOrderTime = [NSDate dateWithYYYYMMddHHmmss:self.model.created_at];
    NSTimeInterval createTimeNum = [createOrderTime timeIntervalSince1970];
    
    NSString *nowTimeStr = [NSString fm_creatrTimeStrCurrentWithSecond];
    NSDate *nowTime = [NSDate dateWithYYYYMMddHHmmss:nowTimeStr];
    NSTimeInterval nowTimeNum = [nowTime timeIntervalSince1970];
    
    NSTimeInterval leftTime = nowTimeNum - createTimeNum;
    
    NSTimeInterval sec15x60 = 15*60;
    UIView *line = [[UIView alloc] init];
    [_backHeader addSubview:line];
    line.backgroundColor = kRGBColor(258, 208, 86);
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(0.3);
        make.centerX.mas_equalTo(_yfRemainingTimeText);
        make.top.mas_equalTo(_yfRemainingTimeText.mas_bottom).with.offset(kFit_Font6(5));
        make.width.mas_equalTo(kFit_Font6(220));
    }];
    if (sec15x60 - leftTime) {
        self.countDownNum = sec15x60 - leftTime;
    }else {
        self.countDownNum = 0;
        self.yfRemainingTimeText.text = @"订单已经失效！";
        self.yfSurePay.hidden = YES;
    }
}

- (void)countDownAction {
    self.countDownNum --;
    
    if (self.countDownNum < 1) {
        self.yfRemainingTimeText.text = @"订单已经失效！";
        self.yfSurePay.hidden = YES;
    }else{
        NSString *timeStr = [self getTimeString:self.countDownNum];
        [self.yfRemainingTimeText setText:timeStr];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

-(void)dealloc {
    [self.yfRemainingTimer invalidate];
    self.yfRemainingTimer = nil;
}

- (void)addTableView{
    self.table =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH - kNavBarH) style:UITableViewStylePlain];
    self.table.delegate= self;
    self.table.dataSource=self;
    //    self.table.separatorStyle=UITableViewCellSeparatorStyleNone;
//    self.table.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefresh)];
    //    self.table.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefresh)];
    self.table.tableHeaderView = [self creatTabelHeaderView];
    self.table.tableFooterView = [UIView new];
    self.table.tableHeaderView.userInteractionEnabled = YES;
//    [self.table.mj_header beginRefreshing];
    [self.view addSubview:self.table];
}

#pragma mark - TableView代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataTable.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return KFit_H6S(100);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"FMPayCell";
    
    FMPayCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[FMPayCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }

    cell.model = self.dataTable[indexPath.row];
    
    
    return cell;
}

#pragma mark - table点击
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        [_yfSeletcAlipay setImage:[UIImage imageNamed:@"pay_pitchon"] forState:UIControlStateNormal];
        [_yfSeletcWechatPay setImage:[UIImage imageNamed:@"pay_unselected"] forState:UIControlStateNormal];
        self.yfSurePay.tag = 1 ;
    }else{
        [_yfSeletcAlipay setImage:[UIImage imageNamed:@"pay_unselected"] forState:UIControlStateNormal];
        [_yfSeletcWechatPay setImage:[UIImage imageNamed:@"pay_pitchon"] forState:UIControlStateNormal];
        self.yfSurePay.tag = 2 ;
    }
    

    //    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //    AskZhengDetails *vc = [[AskZhengDetails alloc]init];
    //    vc.model = self.dataTable[indexPath.row];
    //    kPushToVC(vc);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - creatTabelHeaderView
- (UIView *)creatTabelHeaderView {
    
    self.backHeader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, KFit_H6S(450))];
    _backHeader.userInteractionEnabled = YES;
  
    
    self.yfRemainingTimeTitle = [UILabel fm_initUIlabelWithTextColor:kBlackColor backColor:nil textAlignment_Left0_Center1_Right2:1 font:kFit_Font6(20) cornerRadius:0 addToSuperView:_backHeader title:@"剩余支付时间"];
    [_yfRemainingTimeTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.with.offset(KFit_H6S(35));
        make.centerX.mas_equalTo(_backHeader);
        make.size.mas_equalTo(CGSizeMake(kFit_Font6(180), kFit_Font6(20)));
    }];
    
    self.yfRemainingTimeText = [UILabel fm_initUIlabelWithTextColor:kMianRed backColor:nil textAlignment_Left0_Center1_Right2:1 font:kFit_Font6(18) cornerRadius:0 addToSuperView:_backHeader title:@""];
    [_yfRemainingTimeText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_yfRemainingTimeTitle.mas_bottom).offset(KFit_H6S(25));
        make.centerX.mas_equalTo(_backHeader);
        make.size.mas_equalTo(CGSizeMake(kFit_Font6(180), kFit_Font6(20)));
    }];
    
    UIView *line = [[UIView alloc] init];
    [_backHeader addSubview:line];
    line.backgroundColor = kGreyColor;
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.with.offset(KFit_W6S(20));
        make.right.with.offset(-KFit_W6S(20));
        make.top.mas_equalTo(_yfRemainingTimeText.mas_bottom).with.offset(kFit_Font6(30));
        make.height.mas_equalTo(0.5);
    }];
    
    self.yfCoverIma = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_ticket"]];
    [_backHeader addSubview:_yfCoverIma];
    [_yfCoverIma mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(line);
        make.top.mas_equalTo(line.mas_bottom).with.offset(kFit_Font6(20));
        make.size.mas_equalTo(CGSizeMake(kFit_Font6(40), kFit_Font6(40) * (95.0/114.0)));
    }];
   
    self.yfPriceTitle = [UILabel fm_initUIlabelWithTextColor:kMianRed backColor:nil textAlignment_Left0_Center1_Right2:0 font:kFit_Font6(22) cornerRadius:0 addToSuperView:_backHeader title:[NSString stringWithFormat:@"￥%.2lf",self.model.sum]];
    [_yfPriceTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_yfCoverIma.mas_right).with.offset(kFit_Font6(10));
        make.centerY.mas_equalTo(_yfCoverIma);
        make.height.mas_equalTo(kFit_Font6(24));
        make.right.with.offset(-kFit_Font6(3));
    }];
    
    self.yfOrderTitle = [UILabel fm_initUIlabelWithTextColor:kMainTitleColor backColor:nil textAlignment_Left0_Center1_Right2:0 font:15 cornerRadius:0 addToSuperView:_backHeader title:[NSString stringWithFormat:@"订单号:%@",self.model.code]];
    [_yfOrderTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_yfPriceTitle);
        make.top.mas_equalTo(_yfPriceTitle.mas_bottom).with.offset(kFit_Font6(10));
        make.right.with.offset(-kFit_Font6(3));
        make.height.mas_equalTo(kFit_Font6(16));
    }];
    
    self.yfProductTitle = [UILabel fm_initUIlabelWithTextColor:kTitleColor backColor:nil textAlignment_Left0_Center1_Right2:0 font:13 cornerRadius:0 addToSuperView:_backHeader title:[NSString stringWithFormat:@"%@   X%@",self.model.title,self.model.num]];
    [_yfProductTitle fm_attributedStringWithRangeColor:kMianRed needUnderline:NO rangeString:[NSString stringWithFormat:@"X%@",self.model.num]];
    [_yfProductTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_yfOrderTitle.mas_bottom).with.offset(kFit_Font6(10));
        make.left.mas_equalTo(_yfPriceTitle);
        make.height.mas_equalTo(kFit_Font6(18));
        make.right.with.offset(-kFit_Font6(10));
    }];
    
    UIView *line2 = [[UIView alloc] init];
    [_backHeader addSubview:line2];
    line2.backgroundColor = kGreyColor;
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.with.offset(KFit_W6S(20));
        make.right.with.offset(-KFit_W6S(20));
        make.top.mas_equalTo(_yfProductTitle.mas_bottom).with.offset(kFit_Font6(20));
        make.height.mas_equalTo(kFit_Font6(0.5));
    }];
    
    return self.backHeader;
}

- (void)createSurePayButton {
    self.yfSurePay = [UIButton fm_initButtonNormalTitleColor:kWhiteColor backgroundColor:kRGBColor(258, 208, 86) font:22 normalImage:nil cornerRadius:KFit_H6S(50) addToSuperView:self.view normalTitle:[NSString stringWithFormat:@"￥%.2lf 确认支付",self.model.sum]];
    [_yfSurePay addTarget:self action:@selector(surePayAction:) forControlEvents:UIControlEventTouchUpInside];
    [_yfSurePay mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(KFit_H6S(100));
        make.left.with.offset(KFit_W6S(60));
        make.right.with.offset(-KFit_W6S(60));
        make.bottom.mas_equalTo(-KFit_H6S(40));
    }];
}

- (void)surePayAction:(UIButton *)sender {
//    if (sender.tag == 1) { //支付宝
//        [FMPayRequest fm_payRequestWithModel:self.model pushVc:self isAlipay:YES needOutTickets:YES];
//    }else if (sender.tag == 2) { //微信
//        [FMPayRequest fm_payRequestWithModel:self.model pushVc:self isAlipay:NO needOutTickets:YES];
//    }
}

-(NSString*)getTimeString:(NSTimeInterval)seconds{
    
    NSInteger day = seconds/86400;
    NSInteger hour = (seconds-(day*86400))/3600;
    NSInteger minus = (seconds-(day*86400)-(hour*3600))/60;
    NSInteger second = (seconds-(day*86400)-(hour*3600)-minus*60);
    
    if (day) {
        return [NSString stringWithFormat:@"%0.3zd :%0.2zd : %0.2zd : %0.2zd", day,hour,minus,second];
    }else {
        if (hour) {
            return [NSString stringWithFormat:@"%0.2zd : %0.2zd : %0.2zd", hour,minus,second];
        }else {
            if (minus) {
                return [NSString stringWithFormat:@"%0.2zd : %0.2zd",minus,second];
            }else{
                return [NSString stringWithFormat:@"%0.2zd秒",second];
            }
        }
    }
    
    return [NSString stringWithFormat:@"%0.3zd :%0.2zd : %0.2zd : %0.2zd", day,hour,minus,second];
}

@end





