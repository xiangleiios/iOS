//
//  FMFillOrderVC.m
//  MobileProject
//
//  Created by Mingo on 2017/11/2.
//  Copyright © 2017年 ZSGY. All rights reserved.
//

#import "FMFillOrderVC.h"
#import "PPNumberButton.h"
#import "FMFillOrdeCell.h"
#import "HcdDateTimePickerView.h"
#import "NSString+FMDate.h"
#import "FMPayVC.h"
#import "FMBaseNavigationController.h"
#import "FMOutTicketVC.h"

#define mainBackColor kRGBColor(239, 239, 244)
#define padding KFit_W6S(20)

@interface FMFillOrderVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UIView *backHeader;
@property (nonatomic, strong) UIView *backFooter;
@property (nonatomic, strong) UITableView *table;
/// 顶部封面图
@property (nonatomic, strong) UIImageView *yfCoverIma;
/// 顶部标题
@property (nonatomic, strong) UILabel *yfTitle;
/// 订单模型（被选中的模型）
@property (nonatomic, strong) FMSubmodel *orderModel;
/// 订单数量
@property(nonatomic, assign) NSInteger orderNum;
/// 订单数量加减按钮
@property (nonatomic, strong) PPNumberButton *orderNumBtn;
/// 选中的日期
@property (nonatomic, strong) UIButton *orderTime;
/// 价格说明的内容
@property (nonatomic, strong) UILabel *priceSummary;
@property (nonatomic, strong) HcdDateTimePickerView *dateTimePickerView;
/// 生成订单按钮
@property (nonatomic, strong) UIButton *createOrderBtn;
/// 总价钱（包含文字）
@property (nonatomic, strong) UILabel  *allPriceLab;
/// 总价钱(纯数字)
@property (nonatomic, assign) CGFloat  *allPriceNum;

@end

@implementation FMFillOrderVC

- (NSMutableArray *)dataTable{
    if (!_dataTable) {
        _dataTable =[[NSMutableArray alloc] init];
    }
    return _dataTable;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kBgGreyColor;
    self.title = @"填写订单";
    //底部创建订单按钮
    [self createOrderView];
    [self addTableView];
   
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




- (void)addTableView{
    self.table =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH - kNavBarH - KFit_H6S(100)) style:UITableViewStylePlain];
    self.table.delegate= self;
    self.table.dataSource=self;
    self.table.separatorStyle=UITableViewCellSeparatorStyleNone;
//    self.table.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefresh)];
//    self.table.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefresh)];
    self.table.tableHeaderView = [self creatTabelHeaderView];
    self.table.tableFooterView = [self creatTabelFooterView];
    self.table.tableHeaderView.userInteractionEnabled = YES;
    self.table.tableFooterView.userInteractionEnabled = YES;
//    [self.table.mj_header beginRefreshing];
    [self headerRefresh];
    [self.view addSubview:self.table];
}

- (void)headerRefresh {
    self.pageNum = 1;
//    [self requestTicketData];
}

- (void)footerRefresh {
    self.pageNum ++;
//    [self requestTicketData];
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
    
    static NSString *cellIdentifier = @"FMFillOrdeCell";

    FMFillOrdeCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[FMFillOrdeCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    cell.model = self.dataTable[indexPath.row];
    return cell;
}

#pragma mark - table点击
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //    AskZhengDetails *vc = [[AskZhengDetails alloc]init];
    //    vc.model = self.dataTable[indexPath.row];
    //    kPushToVC(vc);
    
    self.orderModel = self.dataTable[indexPath.row];
    [self.allPriceLab setText:[NSString stringWithFormat:@"合计：￥%.2lf",(self.orderModel.price * self.orderNum)]];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - creatTabelHeaderView
- (UIView *)creatTabelHeaderView {
    
    self.backHeader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, KFit_H6S(210))];
    _backHeader.backgroundColor = kWhiteColor;
    _backHeader.userInteractionEnabled = YES;
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = kGreyColor;
    [_backHeader addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(_backHeader);
        make.left.with.offset(padding);
        make.right.with.offset(-padding);
        make.height.mas_equalTo(0.5);
    }];
    
    self.yfCoverIma = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"lb-jiazaitu"]];
    [_backHeader addSubview:_yfCoverIma];
    [self.yfCoverIma sd_setImageWithURL:[NSURL URLWithString:KURLIma(self.model.image_url)] placeholderImage:[UIImage imageNamed:@"lb-jiazaitu"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
    }];
    
    [_yfCoverIma mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.with.offset(padding);
        make.top.with.offset(padding *2);
        make.size.mas_equalTo(CGSizeMake(KFit_W6S(150), KFit_W6S(150)));
    }];
    
    self.yfTitle = [UILabel fm_initUIlabelWithTextColor:kMainTitleColor backColor:nil textAlignment_Left0_Center1_Right2:0 font:kFit_Font6(18) cornerRadius:0 addToSuperView:_backHeader title:self.model.title];
    _yfTitle.numberOfLines = 0;
    [_yfTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_yfCoverIma.mas_right).with.offset(padding);
        make.top.mas_equalTo(_yfCoverIma);
        make.right.mas_equalTo(-padding);
    }];
    return self.backHeader;
}

- (UIView *)creatTabelFooterView {
    __weak __typeof(self)weakSelf = self;
    self.backFooter = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, KFit_H6S(350))];
    _backFooter.userInteractionEnabled = YES;
    UILabel *priceNote = [UILabel fm_initUIlabelWithTextColor:kMianRed backColor:nil textAlignment_Left0_Center1_Right2:1 font:kFit_Font6(18) cornerRadius:0 addToSuperView:_backFooter title:@"价格说明"];
    [priceNote mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.with.offset(padding);
        make.size.mas_equalTo(CGSizeMake(kFit_Font6(80), kFit_Font6(18)));
    }];
    
    self.priceSummary = [UILabel fm_initUIlabelWithTextColor:kTitleColor backColor:nil textAlignment_Left0_Center1_Right2:0 font:12 cornerRadius:0 addToSuperView:_backFooter title:@"此产品价格包含景区门票，以及内部的XX门票为通票请放心浏览"];
    _priceSummary.numberOfLines = 0;
    
    [_priceSummary mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(priceNote.mas_right).with.offset(padding);
        make.right.with.offset(-padding);
        make.top.mas_equalTo(priceNote);
    }];
    
    
    UIView *line1 = [[UIView alloc] init];
    line1.backgroundColor = kGreyColor;
    [_backFooter addSubview:line1];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_priceSummary.mas_bottom).with.offset(padding );
        make.left.with.offset(padding);
        make.right.with.offset(-padding);
        make.height.mas_equalTo(0.5);
    }];
    
    //日期
    UILabel *date = [UILabel fm_initUIlabelWithTextColor:kMainTitleColor backColor:nil textAlignment_Left0_Center1_Right2:1 font:kFit_Font6(16) cornerRadius:0 addToSuperView:_backFooter title:@"日期"];
    [date mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(line1.mas_bottom).with.offset(padding*2);
        make.left.mas_equalTo(priceNote);
        make.size.mas_equalTo(CGSizeMake(kFit_Font6(40), kFit_Font6(18)));
    }];
    
    self.orderTime = [UIButton fm_initButtonNormalTitleColor:kTitleColor backgroundColor:nil font:kFit_Font6(16) normalImage:nil cornerRadius:0 addToSuperView:_backFooter normalTitle:[NSString stringWithFormat:@"%@>",[NSString fm_creatrTimeStrCurrentWithDay]]];
     _orderTime.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    
    [_orderTime addTarget:self action:@selector(selectDate:) forControlEvents:UIControlEventTouchUpInside];
    [_orderTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(date);
        make.right.with.offset(-padding*2);
        make.size.mas_equalTo(CGSizeMake(kFit_Font6(190), kFit_Font6(18)));
    }];
    
    UIView *line2 = [[UIView alloc] init];
    line2.backgroundColor = kGreyColor;
    [_backFooter addSubview:line2];
    
    
    /// 判断类型为景点 或者演出
    if (self.type == 1) {
        date.hidden = YES;
        self.orderTime.hidden = YES;
        self.priceSummary.text=@"此产品不支持在线选座，请前往场馆具体进行了解";
        [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_priceSummary.mas_bottom).with.offset(padding );
            make.left.with.offset(padding);
            make.right.with.offset(-padding);
            make.height.mas_equalTo(0.5);
        }];
    }else{
        date.hidden = NO;
        self.orderTime.hidden = NO;
        self.priceSummary.text=@"此产品价格包含景区门票，以及内部的XX门票为通票请放心浏览";
        [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_orderTime.mas_bottom).with.offset(padding *2);
            make.left.with.offset(padding*1.7);
            make.right.with.offset(-padding*1.7);
            make.height.mas_equalTo(0.5);
        }];
    }
    
    
    
    //数量
    UILabel *quantity = [UILabel fm_initUIlabelWithTextColor:kMainTitleColor backColor:nil textAlignment_Left0_Center1_Right2:1 font:kFit_Font6(16) cornerRadius:0 addToSuperView:_backFooter title:@"数量"];
    [quantity mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(line2.mas_bottom).with.offset(padding*2);
        make.left.mas_equalTo(priceNote);
        make.size.mas_equalTo(CGSizeMake(kFit_Font6(40), kFit_Font6(18)));
    }];
    
    self.orderNumBtn = [[PPNumberButton alloc] init];
    _orderNumBtn.shakeAnimation = YES;
    _orderNumBtn.editing = NO;
    _orderNum = _orderNumBtn.currentNumber;
    _orderNumBtn.inputFieldFont = kFit_Font6(16);
    _orderNumBtn.increaseImage = [UIImage imageNamed:@"increase"];
    _orderNumBtn.decreaseImage = [UIImage imageNamed:@"decrease"];
    _orderNumBtn.resultBlock = ^(NSInteger num ,BOOL increaseStatus){
        NSLog(@"%ld",(long)num);
        weakSelf.orderNum = num;
        if (!weakSelf.orderModel) {
            kALERT(@"请先选票哦！")
        }
        [weakSelf.allPriceLab setText:[NSString stringWithFormat:@"合计：￥%.2f",(weakSelf.orderModel.price * num)]];
    };
    
    [_backFooter addSubview:_orderNumBtn];
    [_orderNumBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(quantity);
        make.right.with.offset(-padding*2);
        make.size.mas_equalTo(CGSizeMake(kFit_Font6(100), kFit_Font6(35)));
    }];
    
    
    
    
    UIView *line3 = [[UIView alloc] init];
    line3.backgroundColor = kGreyColor;
    [_backFooter addSubview:line3];
    [line3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_orderNumBtn.mas_bottom).with.offset(padding );
        make.left.with.offset(padding);
        make.right.with.offset(-padding);
        make.height.mas_equalTo(0.5);
    }];
    return self.backFooter;
}

- (void)selectDate:(UIButton *)sender {
    __weak __typeof(self)weakSelf = self;
    self.dateTimePickerView = [[HcdDateTimePickerView alloc] initWithDatePickerMode:DatePickerDateMode defaultDateTime:[[NSDate alloc]initWithTimeIntervalSinceNow:1000]];
    [self.dateTimePickerView setMinYear:1990];
    [self.dateTimePickerView setMaxYear:2035];
    
    self.dateTimePickerView.title = @"日期";
    _dateTimePickerView.topViewColor = kWhiteColor;
    self. dateTimePickerView.titleColor = kBlackColor;//kRGBColor(252, 205, 210)
    self. dateTimePickerView.buttonTitleColor = kRGBColor(253, 208, 86);
    
    self.dateTimePickerView.clickedOkBtn = ^(NSString * datetimeStr){
        NSLog(@"%@", datetimeStr);
        [weakSelf.orderTime setTitle:[NSString stringWithFormat:@"%@>",datetimeStr] forState:UIControlStateNormal];
    };
    [self.table addSubview:_dateTimePickerView];
    [_dateTimePickerView showHcdDateTimePicker];
}

- (UIView *)createOrderView {
    UIView *view = [[UIView alloc] init];
    [self.view addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.mas_equalTo(self.view);
        make.height.mas_equalTo(KFit_H6S(100));
    }];
    
    UIView *line1 = [[UIView alloc] init];
    line1.backgroundColor = kGreyColor;
    [view addSubview:line1];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.left.mas_equalTo(view);
        make.height.mas_equalTo(0.5);
    }];
    
    self.allPriceLab = [UILabel fm_initUIlabelWithTextColor:kMianRed backColor:nil textAlignment_Left0_Center1_Right2:0 font:24 cornerRadius:0 addToSuperView:view title:[NSString stringWithFormat:@"合计：￥%.2lf",(self.orderModel.price * self.orderNum)]];
    [_allPriceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(view);
        make.top.mas_equalTo(line1.mas_bottom);
        make.width.mas_equalTo(KFit_W6S(520));
        make.left.with.offset(padding);
    }];
    
    self.createOrderBtn = [UIButton fm_initButtonNormalTitleColor:kWhiteColor backgroundColor:kRGBColor(250, 109, 87) font:19 normalImage:nil cornerRadius:0 addToSuperView:view normalTitle:@"提交订单"];
    [_createOrderBtn addTarget:self action:@selector(createOrderBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [_createOrderBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.mas_equalTo(view);
        make.top.mas_equalTo(line1.mas_bottom);
        make.left.mas_equalTo(_allPriceLab.mas_right);
    }];
    
    return view;
}

- (void)createOrderBtnAction:(UIButton *)sender {
    kAfterOnceTimer(4);
    if (!(self.orderModel.name.length)) {
        kALERT(@"请先选票哦！")
        return;
    }
    if ([User UserOb].UserLogin) {
        [self requestOrderTicketAction];
    }else{
        [FMHelper fm_showLoginAlertWithController:self tipsStringIfNilShowDefault:nil];
    }
}

#pragma mark - 门票下单请求
- (void)requestOrderTicketAction {
    NSString *dateStr = [self.orderTime.titleLabel.text substringToIndex:self.orderTime.titleLabel.text.length - 1];
    NSString *url;
    if (self.type == 1) {
        url = [NSString stringWithFormat:POSTtheatersessionsOrdersCreate,self.model.idid,self.orderModel.idid,self.orderNum,[User UserOb].token];
    }else{
        url = [NSString stringWithFormat:POSTcenicsOrdersCreate,self.model.idid,self.orderModel.idid,dateStr,self.orderNum,[User UserOb].token];
    }
    [FMNetworkHelper fm_request_postWithUrlString:url isNeedCache:NO parameters:nil successBlock:^(id responseObject) {
        if (kResponseObjectStatusCodeIsEqual(200)) {
            NSDictionary *dataDic = responseObject[@"data"];
            FMMainModel *model = [FMMainModel mj_objectWithKeyValues:dataDic];
            model.summary = self.model.title; //把景点的大标题传到出票页面
            model.image_url = self.model.image_url; //把景点的封面图传到出票页面
            if (model.sum == 0) {
                FMOutTicketVC *vc = kAllocInit(FMOutTicketVC);
                vc.model = model;
                vc.model.created_at = [NSString stringWithFormat:@"%@ 00:00:00",dateStr];
                kPushToVC(vc);
            }else{
                FMPayVC *vc = kAllocInit(FMPayVC);
                vc.model = model;
                kPushToVC(vc);
            }
            
        }else{
            kALERT(kResponseObjectMessage);
        }
    } failureBlock:^(NSError *error) {
        
    } progress:nil];
}

@end




