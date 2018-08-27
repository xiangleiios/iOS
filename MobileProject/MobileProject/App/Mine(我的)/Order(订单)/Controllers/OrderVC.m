//
//  OrderVC.m
//  MobileProject
//
//  Created by zsgy on 2017/11/13.
//  Copyright © 2017年 ZSGY. All rights reserved.
//

#import "OrderVC.h"
#import "SegmentViewController.h"
#import "OrderListVC.h"

#define scroll_h (SCREEN_HEIGHT - KFit_H6S(90) - kNavBarH)
@interface OrderVC ()<UIScrollViewDelegate>
@property (nonatomic ,strong)SegmentViewController *segmentVC;
@property (nonatomic , strong)NSMutableArray *controlArray;

@property (nonatomic , strong)UIButton *butOne;
@property (nonatomic , strong)UIButton *butTwo;
@property (nonatomic , strong)UIButton *butThree;
@property (nonatomic , strong)UIButton *selectbut;
@property (nonatomic , strong)UIScrollView *scroll;
@property (nonatomic , strong)UIView *redViewone;
@property (nonatomic , strong)UIView *redViewtwo;
@end

@implementation OrderVC
-(NSMutableArray *)controlArray{
    if (_controlArray==nil) {
        _controlArray=[NSMutableArray array];
    }
    return _controlArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadNavigation];
    [self loadsubview];
}

- (void)loadNavigation{
    if (!self.navigationView) {
        EasyNavigationView *nav = [[EasyNavigationView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH , kNavBarH)];
        [self setNavigationView:nav];
        [self.view addSubview:nav];
    }
//    kWeakSelf(self)
    [self.navigationView setTitle:@"我的订单"];
    self.navigationView.titleLabel.textColor = [UIColor blackColor];
    //是否开启 手势侧滑返回
    self.customBackGestureEnabel = YES ;
    //侧滑距离左边最大的距离,
    self.customBackGestureEdge = SCREEN_WIDTH / 2.0 ;
}



- (void)loadsubview{
    UIView *v = [[UIView alloc] init];
    [self.view addSubview:v];
    v.layer.borderColor = kColor_N(40, 174, 104).CGColor;
    v.layer.borderWidth = 0.7;
    v.layer.cornerRadius = 15;
    v.layer.masksToBounds =YES;
    [v mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).mas_offset(KFit_H6S(25) + kNavBarH);
        make.left.mas_equalTo(self.view).mas_offset(KFit_W6S(30));
        make.right.mas_equalTo(self.view).mas_offset(-KFit_W6S(30));
        make.height.mas_equalTo(KFit_H6S(60));
    }];
    
    UIButton *buton=[[UIButton alloc]init];
    [v addSubview:buton];
    
    [buton setTitle:@"进行中" forState:UIControlStateNormal];
    [buton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [buton setTitleColor:kColor_N(40, 174, 104) forState:UIControlStateNormal];
    [buton setBackgroundImage:[XLCommonUse imageWithColor:kColor_N(40, 174, 104)] forState:UIControlStateSelected];
    [buton setBackgroundImage:[XLCommonUse imageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
    buton.titleLabel.font=[UIFont systemFontOfSize:kFit_Font6(17)];
    buton.tag=0;
    buton.selected=YES;
    self.selectbut=buton;
    self.butOne = buton;
    
    self.redViewone = [[UIView alloc] init];
    [buton addSubview:self.redViewone];
    [self.redViewone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(buton.mas_top).mas_offset(KFit_H6S(5));
        make.right.mas_equalTo(buton).mas_offset(-KFit_W6S(45));
        make.size.mas_equalTo(CGSizeMake(KFit_W6S(16), KFit_W6S(16)));
    }];
    self.redViewone.backgroundColor = [UIColor redColor];
    self.redViewone.layer.cornerRadius = KFit_W6S(8);
    self.redViewone.hidden = YES;
    
    
    
    UIButton *buttwo=[[UIButton alloc]init];
    buttwo.layer.borderColor = kColor_N(40, 174, 104).CGColor;
    buttwo.layer.borderWidth = 0.7;
    [buttwo setTitle:@"已完成" forState:UIControlStateNormal];
    [buttwo setTitleColor:kColor_N(40, 174, 104) forState:UIControlStateNormal];
    [buttwo setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [buttwo setBackgroundImage:[XLCommonUse imageWithColor:kColor_N(40, 174, 104)] forState:UIControlStateSelected];
    [buttwo setBackgroundImage:[XLCommonUse imageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
    buttwo.titleLabel.font=[UIFont systemFontOfSize:kFit_Font6(17)];
    [v addSubview:buttwo];
    self.butTwo = buttwo;
    buttwo.tag=1;
    
    UIButton *three=[[UIButton alloc]init];
    [three setTitle:@"已取消" forState:UIControlStateNormal];
    [three setTitleColor:kColor_N(40, 174, 104) forState:UIControlStateNormal];
    [three setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [three setBackgroundImage:[XLCommonUse imageWithColor:kColor_N(40, 174, 104)] forState:UIControlStateSelected];
    [three setBackgroundImage:[XLCommonUse imageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
    three.titleLabel.font=[UIFont systemFontOfSize:kFit_Font6(17)];
    [v addSubview:three];
    self.butThree = three;
    three.tag=2;
    self.redViewtwo = [[UIView alloc] init];
    [three addSubview:self.redViewtwo];
    [self.redViewtwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(three.mas_top).mas_offset(KFit_H6S(5));
        make.right.mas_equalTo(three).mas_offset(-KFit_W6S(45));
        make.size.mas_equalTo(CGSizeMake(KFit_W6S(16), KFit_W6S(16)));
    }];
    self.redViewtwo.backgroundColor = [UIColor redColor];
    self.redViewtwo.layer.cornerRadius = KFit_W6S(8);
    self.redViewtwo.hidden = YES;
    
    NSArray *arr = @[self.butOne,self.butTwo,self.butThree];
    [arr mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:0 leadSpacing:0 tailSpacing:0];
    [arr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(v);
    }];
    //按钮点击方法
    [self.butOne addTarget:self action:@selector(navigationMethod:) forControlEvents:UIControlEventTouchUpInside];
    [self.butTwo addTarget:self action:@selector(navigationMethod:) forControlEvents:UIControlEventTouchUpInside];
    [self.butThree addTarget:self action:@selector(navigationMethod:) forControlEvents:UIControlEventTouchUpInside];
    
    // *创建滚动视图
    [self addscrollview];
}
- (void)addscrollview{
    self.scroll =[[UIScrollView alloc]init];
    [self.view addSubview:self.scroll];
    [self.scroll mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).mas_offset(KFit_H6S(90) + kNavBarH);
        make.bottom.left.right.mas_equalTo(self.view);
    }];
    self.scroll.contentSize=CGSizeMake(3*SCREEN_WIDTH,0);
    self.scroll.bounces=NO;
    self.scroll.pagingEnabled=YES;
    self.scroll.delegate=self;
    [self addScrollSubview];
}

- (void)addScrollSubview{
    UIView *back = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 3*SCREEN_WIDTH, scroll_h)];
    [self.scroll addSubview:back];
    
    OrderListVC *ongoing = [[OrderListVC alloc] init];
    ongoing.orderType = OrderStatusTypeOngoing;
    ongoing.view.frame = CGRectMake(0, 0, SCREEN_WIDTH,scroll_h);
    [self addChildViewController:ongoing];
    [back addSubview:ongoing.view];
    
    OrderListVC *complete = [[OrderListVC alloc] init];
    complete.orderType = OrderStatusTypeComplete;
    complete.view.frame = CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH,scroll_h);
    [self addChildViewController:complete];
    [back addSubview:complete.view];
    
    OrderListVC *cancel = [[OrderListVC alloc] init];
    cancel.orderType = OrderStatusTypeCancel;
    cancel.view.frame = CGRectMake(2 * SCREEN_WIDTH, 0 ,SCREEN_WIDTH,scroll_h);
    [self addChildViewController:cancel];
    [back addSubview:cancel.view];
}


#pragma mark-滚动视图代理
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    int i = scrollView.contentOffset.x/SCREEN_WIDTH;
    switch (i) {
        case 0:{
            [self navigationMethod:self.butOne];
        }
            break;
        case 1:{
            [self navigationMethod:self.butTwo];
        }
            break;
        case 2:{
            [self navigationMethod:self.butThree];
        }
            break;
        default:
            break;
    }
}

- (void)navigationMethod:(UIButton *)sender{
    
    self.selectbut.selected=NO;
    sender.selected=YES;    //一二两行顺序不能换
    self.selectbut=sender;
    self.scroll.contentOffset=CGPointMake(sender.tag*SCREEN_WIDTH, 0);
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadMembersInfomation];
}

- (void)loadMembersInfomation{
    NSString *url = [NSString stringWithFormat:GETMembersInfomation,[User UserOb].token];
    [FMNetworkHelper fm_request_getWithUrlString:url isNeedCache:NO parameters:nil successBlock:^(id responseObject) {
        if (kResponseObjectStatusCodeIsEqual(200)) {
            NSDictionary *dic = responseObject[@"data"];
            if ([dic[@"order_info_ongoing_notice"]  isEqual: @1]) {
                self.redViewone.hidden = NO;
            }else{
                self.redViewone.hidden = YES;
            }
            if ([dic[@"order_info_cancel_notice"]  isEqual: @1]) {
                self.redViewtwo.hidden = NO;
            }else{
                self.redViewtwo.hidden = YES;
            }
            
        }
    } failureBlock:^(NSError *error) {
        
    } progress:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];
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
