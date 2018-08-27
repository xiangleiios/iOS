//
//  FMOutTicketVC.m
//  MobileProject
//
//  Created by Mingo on 2017/11/3.
//  Copyright © 2017年 ZSGY. All rights reserved.
//

#import "FMOutTicketVC.h"
#import "MSSBrowseDefine.h"
#import "NSString+FMDate.h"
#import "NSString+FMExtension.h"
#import "FMPayVC.h"
#import "FMFillOrderVC.h"

#define padding KFit_W6S(39)
#define scrollHeightAndWidth  KFit_W6S(300)

@interface FMOutTicketVC ()<UIScrollViewDelegate>
@property (nonatomic , strong)UIScrollView *scroll;
/** 日期上部分主背景 */
@property (nonatomic, strong) UIView *headBack;
/** 景点封面 */
@property (nonatomic, strong) UIImageView *yfCoverIma;
/** 景点标题   */
@property (nonatomic, strong) UILabel *yfTitle;
/** 出票标题 */
@property (nonatomic, strong) UILabel *yfTicketTitle;
/** 出票时间  */
@property (nonatomic, strong) UILabel *yfTicketTime;
/** 中部二维码背景 */
@property (nonatomic, strong) UIImageView *ticketBack;
/** 分页提示 */
@property (nonatomic, strong) UILabel *ticketPage;
/** 二维码封面 */
@property (nonatomic, strong) UIImageView *ticketCover;
/** 左边看图 */
@property (nonatomic, strong) UIButton *ticketToLeft;
/** 右边看图*/
@property (nonatomic, strong) UIButton *ticketToRight;
/** 验证码 */
@property (nonatomic, strong) UILabel *ticketCode;
/** 提示标题  */
@property (nonatomic, strong) UILabel *NoteLab;
/** 提示内容 */
@property (nonatomic, strong) UILabel *NoteText;
//@property (nonatomic, strong) NSMutableArray *dataTicketCodes;
@property (nonatomic, strong) MSSBrowseNetworkViewController *bigShowPhotos;
@property (nonatomic, strong) NSMutableArray *browseItemArray;
/// 验证码（二维码）
@property (nonatomic, strong) NSMutableArray <FMMainModel *>*dataTicketCodes;
@property(nonatomic, assign) NSInteger indexTicket;
@end

@implementation FMOutTicketVC

- (NSMutableArray *)dataTicketCodes{
    if (!_dataTicketCodes) {
        _dataTicketCodes =[[NSMutableArray alloc] init];
    }
    return _dataTicketCodes;
}

- (NSMutableArray *)browseItemArray{
    if (!_browseItemArray) {
        _browseItemArray =[[NSMutableArray alloc] init];
    }
    return _browseItemArray;
}

//- (NSMutableArray *)dataTicketCodes{
//    if (!_dataTicketCodes) {
//        _dataTicketCodes =[NSMutableArray arrayWithObjects:@"http://whnn.dev.asia-cloud.com/uploads/images/2017/1105/20171105153130751.jpg",@"http://whnn.dev.asia-cloud.com/uploads/images/2017/1105/20171105153130522.jpg",@"http://whnn.dev.asia-cloud.com/uploads/images/2017/1105/20171105153130751.jpg",nil];
//
//    }
//    return _dataTicketCodes;
//}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"出票";
    self.indexTicket = 0;
    [self addHeadBackSubviews];
    [self requestOutTicketsData];
    //防止出票后又返回时又跑到支付页面
    NSArray *arr = self.navigationController.viewControllers;
    NSMutableArray *muArr = [NSMutableArray arrayWithArray:arr];
    self.navigationController.viewControllers = muArr;
    for(UIViewController *temVC in self.navigationController.viewControllers) {
        if ([temVC isKindOfClass:[FMPayVC class]]) {
//            [temVC removeFromParentViewController];
            [muArr removeObject:temVC];
        }
        if ([temVC isKindOfClass:[FMFillOrderVC class]]) {
//            [temVC removeFromParentViewController];
            [muArr removeObject:temVC];
        }
    }
    self.navigationController.viewControllers = muArr;
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (UIView *)addHeadBackSubviews {
    self.headBack = [[UIView alloc] init];
    [self.view addSubview:_headBack];
    
    self.yfCoverIma = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"lb-jiazaitu"]];
    [_yfCoverIma sd_setImageWithURL:[NSURL URLWithString:KURLIma(self.model.image_url)] placeholderImage:[UIImage imageNamed:@"lb-jiazaitu"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
    }];
    [self.view addSubview:_yfCoverIma];
    
    self.yfTitle = [UILabel fm_initUIlabelWithTextColor:kMainTitleColor backColor:nil textAlignment_Left0_Center1_Right2:0 font:16 cornerRadius:0 addToSuperView:_headBack title:self.model.summary]; //这里去景点的大标题（在填写订单页面占用summary字段）
    _yfTitle.numberOfLines = 0;
    UIView *line = [[UIView alloc] init];
    [self.view addSubview:line];
    line.backgroundColor = kGreyColor;
    
    self.yfTicketTitle = [UILabel fm_initUIlabelWithTextColor:kMainTitleColor backColor:nil textAlignment_Left0_Center1_Right2:0 font:16 cornerRadius:0 addToSuperView:_headBack title:[NSString stringWithFormat:@"%@   X%@",self.model.title,self.model.num]];
    [_yfTicketTitle fm_attributedStringWithRangeColor:kMianRed needUnderline:NO rangeString:[NSString stringWithFormat:@"X%@",self.model.num]];
    _yfTicketTitle.numberOfLines = 0;
    
    self.yfTicketTime = [UILabel fm_initUIlabelWithTextColor:kTitleColor backColor:nil textAlignment_Left0_Center1_Right2:0 font:12 cornerRadius:0 addToSuperView:_headBack title:[self.model.created_at fm_currentDateFormatStringToOtherDateFormatString:self.model.created_at timeFormat:TimeFormatyyyy_MM_dd]];
    
    
    [_headBack mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(self.view);
        make.height.mas_equalTo(KFit_H6S(370));
    }];
    
    [_yfCoverIma mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(KFit_W6S(150), KFit_W6S(150)));
        make.top.left.with.offset(padding);
    }];
    
    [_yfTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_yfCoverIma);
        make.left.mas_equalTo(_yfCoverIma.mas_right).with.offset(padding);
        make.right.with.offset(-padding);
        
    }];
    
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.with.offset(padding);
        make.top.mas_equalTo(_yfCoverIma.mas_bottom).with.offset(padding);
        make.right.with.offset(-padding);
        make.height.mas_equalTo(0.5f);
    }];
    
    [_yfTicketTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.with.offset(padding);
        make.top.mas_equalTo(line.mas_bottom).with.offset(padding);
        make.right.with.offset(-padding);
    }];
    
    [_yfTicketTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(_yfTicketTitle);
        make.top.mas_equalTo(_yfTicketTitle.mas_bottom).with.offset(padding/2);
        make.height.mas_equalTo(kFit_Font6(16));
    }];
    
    return self.headBack;
}

- (void)addTicktSubviews {
    self.ticketBack = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"lvbg"]];
    [self.view addSubview:_ticketBack];
//    _ticketBack.layer.borderColor = kGreyColor.CGColor;
//    _ticketBack.layer.borderWidth = 0.5;
    _ticketBack.userInteractionEnabled = YES;
    
    self.ticketPage = [UILabel fm_initUIlabelWithTextColor:kMainTitleColor backColor:nil textAlignment_Left0_Center1_Right2:1 font:16 cornerRadius:0 addToSuperView:_ticketBack title:[NSString stringWithFormat:@"1/%ld",self.dataTicketCodes.count]];
    
    [self.view addSubview:[self addScrollview]];
    
    self.ticketToLeft = [UIButton fm_initButtonNormalTitleColor:nil backgroundColor:nil font:0 normalImage:[UIImage imageNamed:@"leftarrow"] cornerRadius:0 addToSuperView:_ticketBack normalTitle:nil];
    [_ticketToLeft addTarget:self action:@selector(fm_ticketToRightOrLeftAction:) forControlEvents:UIControlEventTouchUpInside];
    _ticketToLeft.tag  = 1;
    
    self.ticketToRight = [UIButton fm_initButtonNormalTitleColor:nil backgroundColor:nil font:0 normalImage:[UIImage imageNamed:@"rightarrow"] cornerRadius:0 addToSuperView:_ticketBack normalTitle:nil];
    [_ticketToRight addTarget:self action:@selector(fm_ticketToRightOrLeftAction:) forControlEvents:UIControlEventTouchUpInside];
    _ticketToRight.tag = 2;
    
    self.ticketCode = [UILabel fm_initUIlabelWithTextColor:kRGBColor(221, 56, 73) backColor:nil textAlignment_Left0_Center1_Right2:1 font:16 cornerRadius:0 addToSuperView:_ticketBack title:[NSString stringWithFormat:@"验证码：%@",[NSString fm_changeBankCardNumber:[self.dataTicketCodes firstObject].code]]];
    
    [_ticketBack mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.with.offset(padding);
        make.right.with.offset(-padding);
        make.top.mas_equalTo(_yfTicketTime.mas_bottom).with.offset(padding);
        make.height.mas_equalTo(KFit_H6S(556));
    }];
    
    [_ticketPage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(_ticketBack);
        make.top.with.offset(padding);
        make.size.mas_equalTo(CGSizeMake(kFit_Font6(100), kFit_Font6(16)));
    }];
    
//    [_ticketCover mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.mas_equalTo(_ticketBack);
//        make.s
//    }];
    
    [_scroll mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(scrollHeightAndWidth, scrollHeightAndWidth));
        make.centerX.mas_equalTo(_ticketBack);
        make.top.mas_equalTo(_ticketPage.mas_bottom).with.offset(padding);
    }];
    
    [_ticketToLeft mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_scroll);
        make.left.with.offset(padding *2);
        make.size.mas_equalTo(CGSizeMake(kFit_Font6(30), kFit_Font6(45)));
    }];
    [_ticketToRight mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.width.height.mas_equalTo(_ticketToLeft);
        make.right.with.offset(-padding *2);
    }];
    
    [_ticketCode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_scroll.mas_bottom).with.offset(KFit_H6S(70));
        make.left.right.mas_equalTo(_ticketBack);
        make.height.mas_equalTo(kFit_Font6(18));
    }];
}

- (void)addBelowNotes {
    UILabel *note = [UILabel fm_initUIlabelWithTextColor:kRGBColor(221, 56, 73) backColor:nil textAlignment_Left0_Center1_Right2:0 font:20 cornerRadius:0 addToSuperView:self.view title:@"提示："];
    UILabel *tips = [UILabel fm_initUIlabelWithTextColor:kTitleColor backColor:nil textAlignment_Left0_Center1_Right2:0 font:12 cornerRadius:0 addToSuperView:self.view title:@"关闭页面后可在个人中心-我的订单中查看电子票"];
    tips.numberOfLines = 0;
    
    [note mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_ticketBack);
        make.top.mas_equalTo(_ticketBack.mas_bottom).with.offset(padding);
        make.size.mas_equalTo(CGSizeMake(kFit_Font6(100), kFit_Font6(22)));
    }];
    
    [tips mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(_ticketBack);
        make.top.mas_equalTo(note.mas_bottom).with.offset(padding/2);
        make.height.mas_equalTo(kFit_Font6(16));
    }];
}

- (UIView *)addScrollview{
    self.scroll =[[UIScrollView alloc]init];
    self.scroll.contentSize = CGSizeMake (self.dataTicketCodes.count * scrollHeightAndWidth,0);
    self.scroll.bounces = NO;
    self.scroll.pagingEnabled = YES;
    self.scroll.delegate = self;
    _scroll.userInteractionEnabled = YES;
   
    for (int i = 0; i < self.dataTicketCodes.count; i++) {
        UIImageView *ima = [[UIImageView alloc] initWithImage:[UIImage fm_createQRCodeFromString:self.dataTicketCodes[i].code]];
        [_scroll addSubview:ima];
        [ima setFrame:CGRectMake(scrollHeightAndWidth * i, 0, scrollHeightAndWidth, scrollHeightAndWidth)];
        
//        // 弹出大图浏览
//        [self addTapShowBigPhotos];
    }
    return self.scroll;
}

#pragma mark - 弹出大图浏览。暂时不用这个
- (void)addTapShowBigPhotos:(NSInteger)index {
    
    UIImageView *imageView = [[UIImageView alloc] init];;
    imageView.userInteractionEnabled = YES;
    imageView.tag = index;
    imageView.image = [UIImage fm_createQRCodeFromString:self.dataTicketCodes[index].code];
    MSSBrowseModel *browseItem = [[MSSBrowseModel alloc]init];
    //        browseItem.bigImageUrl = self.dataTicketCodes[i];// 加载网络图片大图地址
    browseItem.bigImage = [UIImage fm_createQRCodeFromString:self.dataTicketCodes[index].code];
    
    browseItem.smallImageView = imageView;// 小图
    
    [self.browseItemArray addObject:browseItem];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showBigPhotosAction:)];
    
    [_scroll addGestureRecognizer:tap];
}

#pragma mark - 弹出大图浏览。暂时不用这个
- (void)showBigPhotosAction:(UITapGestureRecognizer *)tap {
    
    self.bigShowPhotos = [[MSSBrowseNetworkViewController alloc]initWithBrowseItemArray:self.browseItemArray currentIndex:0];
    //         bvc.isEqualRatio = NO;// 大图小图不等比时需要设置这个属性（建议等比）
     [self.bigShowPhotos showBrowseViewController];
}

#pragma mark-滚动视图代理
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    CGFloat w = scrollHeightAndWidth;
    
    NSInteger index = self.scroll.contentOffset.x / (w - 1) ;
    [self.ticketPage setText:[NSString stringWithFormat:@"%d/%ld",index + 1,(unsigned long)self.dataTicketCodes.count]];
    [self.ticketCode setText:[NSString stringWithFormat:@"验证码：%@",[NSString fm_changeBankCardNumber:self.dataTicketCodes[index].code]]];
}

- (void)fm_ticketToRightOrLeftAction:(UIButton *)sender {
    NSInteger indextemp = [[[self.ticketPage.text componentsSeparatedByString:@"/"] firstObject] integerValue];
    if (sender.tag == 1) { //向左/
        if (self.indexTicket > 0) {
            self.indexTicket --;
        }
    }else{
        self.indexTicket ++;
        if (self.indexTicket > (self.dataTicketCodes.count - 1)) {
            self.indexTicket = self.dataTicketCodes.count - 1;
        }
    }
    
    self.scroll.contentOffset = CGPointMake( self.indexTicket * scrollHeightAndWidth, 0);
    [self.ticketPage setText:[NSString stringWithFormat:@"%d/%ld",_indexTicket + 1,(unsigned long)self.dataTicketCodes.count]];
    [self.ticketCode setText:[NSString stringWithFormat:@"验证码：%@",[NSString fm_changeBankCardNumber:self.dataTicketCodes[self.indexTicket].code]]];
}

#pragma mark - 支付成功后根据订单id获取验证码【二维码票】
- (void)requestOutTicketsData {
    NSString *url = [NSString stringWithFormat:GETticketsOwns,self.model.idid,[User UserOb].token];
    [FMNetworkHelper fm_request_getWithUrlString:url isNeedCache:NO parameters:nil successBlock:^(id responseObject) {
        if (kResponseObjectStatusCodeIsEqual(200)) {
            NSArray *dataArr  = responseObject[@"data"];
            for (NSDictionary *dic in dataArr) {
                FMMainModel *model = [FMMainModel mj_objectWithKeyValues:dic];
                [self.dataTicketCodes addObject:model];
            }
             // 验证码获取到后布局二维码 和 提示tips
            [self addTicktSubviews];
            [self addBelowNotes];
        }
        
    } failureBlock:^(NSError *error) {
        
    } progress:nil];
}

//// 自定义返回按钮
//- (void)customBackButton{
//    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
////    [backBtn setTitle:@"返回" forState:UIControlStateNormal];
//    [backBtn setImage:[UIImage imageNamed:@"fanhui"] forState:UIControlStateNormal];
//    [backBtn addTarget:self action:@selector(backBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
//    backBtn.frame = CGRectMake(0, 0, 40, 40);
//    [backBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -15, 0, 0)];
//    [backBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
//    self.navigationItem.leftBarButtonItem = item;
//}
//// 返回按钮按下
//- (void)backBtnClicked:(UIButton *)sender{
//    NSArray *temArray = self.navigationController.viewControllers;
//    for(UIViewController *temVC in temArray) {
//        if ([temVC isKindOfClass:[FMScenicDetailsVC class]]) {
//            [self.navigationController popToViewController:temVC animated:YES];
//            return;
//        }
//    }
//    [self.navigationController popViewControllerAnimated:YES];
//}


@end
