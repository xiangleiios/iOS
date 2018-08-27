//
//  HomeVC.m
//  MobileProject
//
//  Created by zsgy on 2018/5/23.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import "HomeVC.h"
#import "UIViewController+PDNavigationBar.h"
#import "PDSlideViewController.h"
#import "PickerViewOne.h"
#import "HomeChooseCell.h"
#import "CGXPickerView.h"
#import "HomeControlsV.h"
#import "WZSwitch.h"
#import "PayVc.h"
#import "OrdersItems.h"
#import "RegistrationPoliteVC.h"
#import "HWebVc.h"

#import "OrderExpandVC.h"

@interface HomeVC ()<PickerViewOneDelegate,UITableViewDelegate,UITableViewDataSource>

//省份选择器
@property (strong, nonatomic)PickerViewOne * PickerOne;
@property (strong, nonatomic)NSMutableArray *ProvinceArr;
@property (strong, nonatomic) NSDictionary *pickerDic;
//
@property (nonatomic , strong)UITableView *table;
@property (nonatomic , strong)NSMutableArray *dataArr;
@property (nonatomic , strong)WZSwitch *mySwitch;

@property (nonatomic , strong)UILabel *time;
@property (nonatomic , strong)UILabel *total;//总量
@property (nonatomic , strong)HomeControlsV *one;
@property (nonatomic , strong)HomeControlsV *two;
@property (nonatomic , strong)HomeControlsV *three;

//订单数据
@property (nonatomic , strong)NSString *num;//购电量
@property (nonatomic , strong)NSString *voltage;//电压等级
@property (nonatomic , strong)NSString *max_price;//最高可承受价格
@property (nonatomic , strong)NSString *province;//省份
@property (nonatomic , strong)NSString *start_date;
@property (nonatomic , strong)NSString *end_date;
//首页数据
@property (nonatomic , strong)NSString *homeAddress;
@property (nonatomic , assign)NSInteger homeAddressIndex;
@property (nonatomic , strong)HomeModel *model;
@property (nonatomic , assign)BOOL stat; //滑动按钮状态
@property (nonatomic , strong)NSMutableAttributedString *noteStr;


@property (nonatomic , assign)BOOL agreed;
@property (nonatomic , strong)UIImageView *redImg;
@end


@implementation HomeVC

- (NSMutableAttributedString *)noteStr{
//    if (_noteStr == nil) {
        // 创建Attributed
        _noteStr = [[NSMutableAttributedString alloc] initWithString:self.total.text];
        // 需要改变的第一个文字的位置
        NSUInteger firstLoc = [[_noteStr string] rangeOfString:@"前"].location + 1;
        // 需要改变的最后一个文字的位置
        NSUInteger secondLoc = [[_noteStr string] rangeOfString:@"亿"].location;
        // 需要改变的区间
        NSRange range = NSMakeRange(firstLoc, secondLoc - firstLoc);
        // 改变颜色
        //    [noteStr addAttribute:NSForegroundColorAttributeName value:[UIColor greenColor] range:range];
        // 改变字体大小及类型
        [_noteStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:27] range:range];
        // 为label添加Attributed
//    }
    return _noteStr;
}

//写入数据
- (NSMutableArray *)dataArr{
    if (_dataArr == nil) {
        _dataArr = [NSMutableArray array];
        MineModel *model;
        model = [[MineModel alloc] init];
        model.title = @"用电开始时间";
        model.img = @"Starting_time";
        model.subtitle = @"";
        [_dataArr addObject:model];
        model = [[MineModel alloc] init];
        model.title = @"用电结束时间";
        model.img = @"End_Time";
        model.subtitle = @"";
        [_dataArr addObject:model];
        model = [[MineModel alloc] init];
        model.title = @"所在城市";
        model.img = @"position";
        model.subtitle = @"";
        [_dataArr addObject:model];
        model = [[MineModel alloc] init];
        model.title = @"电压等级 (kV)";
        model.img = @"voltage";
        model.subtitle = @"";
        [_dataArr addObject:model];
        model = [[MineModel alloc] init];
        model.title = @"购电量(万度)";
        model.img = @"buy";
        model.subtitle = @"";
        [_dataArr addObject:model];
        model = [[MineModel alloc] init];
        model.title = @"最高可承受价格(元/度)";
        model.img = @"price";
        model.subtitle = @"";
        [_dataArr addObject:model];
    }
    return _dataArr;
}
- (NSMutableArray *)ProvinceArr{
    if (_ProvinceArr == nil) {
        _ProvinceArr = [NSMutableArray array];
    }
    return _ProvinceArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    //加载导航
    [self laodNavigation];
    
    [self loadtable];
    
//    [self loadProvinceSelectorView];
    
    
    
    // Do any additional setup after loading the view.
    
}
#pragma mark - 导航相关
- (void)laodNavigation{
    kWeakSelf(self)
//    [self.navigationView setTitle:@"淘电宝"];
    UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KFit_W6S(121), KFit_H6S(39))];
    [img  setImage:[UIImage imageNamed:@"index"]];
    [self.navigationView addTitleView:img];
    //添加一个带图片的按钮，如果这个按钮只有点击事件，可以这样写，更加简洁。
    [self.navigationView addRightButtonWithImage:kImage(@"gift") hightImage:kImage(@"wo-guayuwomen") clickCallBack:^(UIView *view) {
        RegistrationPoliteVC *vc = [[RegistrationPoliteVC alloc] init];
        [weakself.navigationController pushViewController:vc animated:YES];
    }];
    
    self.mineBut = [self.navigationView addLeftButtonWithImage:kImage(@"mine") hightImage:kImage(@"wo-guayuwomen") clickCallBack:^(UIView *view) {
        [[PDSlideViewController slideVC] showLeftVC];
    }];
    
    self.redImg = [[UIImageView alloc] init];
    [self.mineBut addSubview:self.redImg];
    self.redImg.backgroundColor = [UIColor redColor];
    self.redImg.layer.cornerRadius = KFit_W6S(7);
    self.redImg.layer.masksToBounds = YES;
    self.redImg.hidden = YES;
    [self.redImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mineBut).mas_offset(KFit_H6S(10));
        make.right.mas_equalTo(self.mineBut).mas_offset(-KFit_W6S(5));
        make.size.mas_equalTo(CGSizeMake(KFit_W6S(14), KFit_W6S(14)));
    }];
    
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
     [self loadHomeDataWithAddress:self.homeAddress];
    if ([User UserOb].UserLogin) {
        [self.mineBut setImage:[UIImage imageNamed:@"mine-log"] forState:UIControlStateNormal];
    }else{
        [self.mineBut setImage:[UIImage imageNamed:@"mine"] forState:UIControlStateNormal];
    }
}

#pragma mark - table
- (void)loadtable{
    self.table = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.view addSubview:self.table];
    self.table.delegate = self;
    self.table.dataSource = self;
    self.table.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.table.tableHeaderView = [self tableHeadView];
    self.table.tableFooterView = [self tableFootview];
    [self.table mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view).mas_offset(kNavBarH);
    }];
}
#pragma mark - 头视图
- (UIView *)tableHeadView{
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, KFit_H6S(414))];
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"Address" ofType:@"plist"];
//    self.pickerDic = [[NSDictionary alloc] initWithContentsOfFile:path];
//    [self.ProvinceArr  addObjectsFromArray:[self.pickerDic allKeys]];
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"CGXAddressCity" ofType:@"plist"];
    NSArray *arrData = [NSMutableArray arrayWithContentsOfFile:filePath];
    for (NSDictionary *dict in arrData) {
        [self.ProvinceArr addObject:dict[@"v"]];
    }
    /**
     创建有一列的选择器
     */
    self.PickerOne = [[PickerViewOne alloc] initWithFrame:CGRectMake(KFit_W6S(30),KFit_H6S(30), KFit_W6S(173), KFit_H6S(228)) midArry:self.ProvinceArr];
    self.PickerOne.delegate = self;
    self.PickerOne.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Wheel"]];
    [self.PickerOne setHidden:NO];
    [headView addSubview:self.PickerOne ];
    
    /*
     *选择按钮
     */
    self.mySwitch = [[WZSwitch alloc]initWithFrame:CGRectMake(KFit_W6S(315), KFit_H6S(25), KFit_W6S(300), KFit_H6S(60))];
    self.mySwitch.selectColor = appcoloer;
    [self.mySwitch setSwitchState:NO animation:YES];
    [self.mySwitch setTextFont:[UIFont fontWithName:@"Helvetica-Bold" size:15]];
    self.mySwitch.block = ^(BOOL state) {
        
        self.stat = state;
        [self reloadData];
        
    };
    [headView addSubview:_mySwitch];
    
    self.total = [[UILabel alloc] init];
    self.total.textAlignment = NSTextAlignmentCenter;
    self.total.textColor = kColor_N(238, 65, 68);
//    self.total.text = @"当前55.88亿度可购";
    [headView addSubview:self.total];
    [self.total mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mySwitch);
        make.top.mas_equalTo(self.mySwitch.mas_bottom).mas_offset(KFit_H6S(40));
        make.size.mas_equalTo(CGSizeMake(KFit_W6S(460), KFit_H6S(50)));
    }];
    
    
    self.time = [[UILabel alloc] init];
    
    self.time.font = [UIFont systemFontOfSize:kFit_Font6(12)];
    self.time.textColor = kColor_N(135, 135, 135);
    self.time.textAlignment = NSTextAlignmentCenter;
    [headView addSubview:self.time];
    [self.time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mySwitch);
        make.top.mas_equalTo(self.total.mas_bottom).mas_offset(KFit_H6S(40));
        make.size.mas_equalTo(CGSizeMake(KFit_W6S(460), KFit_H6S(30)));
    }];
    
    _one = [[HomeControlsV alloc] init];
    _one.title.text = @"累计成交电量";
    _one.subtitle.text = @"0.00亿度";
    [headView addSubview:_one];
    
    _two = [[HomeControlsV alloc] init];
    _two.title.text = @"30天新增需求";
    _two.subtitle.text = @"0.00亿度";
    [headView addSubview:_two];
    
    _three = [[HomeControlsV alloc] init];
    _three.title.text = @"30天新增供电";
    _three.subtitle.text = @"0.00亿度";
    [headView addSubview:_three];
    
    NSArray *arr = @[_one,_two,_three];
    
    [arr mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:kFit_Font6(1) leadSpacing:KFit_W6S(30) tailSpacing:KFit_W6S(30)];
    [arr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(headView).mas_offset(-KFit_H6S(20));
        make.height.mas_equalTo(KFit_W6S(120));
    }];
    self.homeAddress = @"安徽";
    self.homeAddressIndex = 0;
    [self loadHomeDataWithAddress:@"安徽"];
    
    UILabel *lbone = [[UILabel alloc] init];
    lbone.backgroundColor = [UIColor colorWithWhite:240/255.0 alpha:1];
    [headView addSubview:lbone];
    [lbone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(_one);
        make.left.mas_equalTo(_one.mas_right);
        make.width.mas_offset(kFit_Font6(1));
    }];
    
    UILabel *lbtwo = [[UILabel alloc] init];
    lbtwo.backgroundColor = [UIColor colorWithWhite:240/255.0 alpha:1];
    [headView addSubview:lbtwo];
    [lbtwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(_one);
        make.left.mas_equalTo(_two.mas_right);
        make.width.mas_offset(kFit_Font6(1));
    }];
    
    
    
    UILabel *lbBot = [[UILabel alloc] init];
    lbBot.backgroundColor = [UIColor colorWithWhite:240/255.0 alpha:1];
    [headView addSubview:lbBot];
    [lbBot mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(headView);
        make.height.mas_offset(KFit_H6S(10));
    }];
    
    return headView;
}
#pragma mark - 尾视图
- (UIView *)tableFootview{
    UIView *footview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, KFit_H6S(170))];
    
    UIButton *selectBut = [[UIButton alloc] init];
    selectBut.selected = YES;
    [footview addSubview:selectBut];
    [selectBut setImage:[UIImage imageNamed:@"notselect"] forState:UIControlStateNormal];
    [selectBut setImage:[UIImage imageNamed:@"select"] forState:UIControlStateSelected];
    [selectBut addTarget:self action:@selector(agreementSelecetBut:) forControlEvents:UIControlEventTouchUpInside];
    [selectBut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(footview).mas_offset(KFit_H6S(25));
        make.left.mas_equalTo(footview).mas_offset(KFit_W6S(40));
        make.size.mas_equalTo(CGSizeMake(KFit_W6S(22), KFit_W6S(22)));
    }];
    UILabel *ts = [[UILabel alloc] init];
    ts.font = [UIFont systemFontOfSize:kFit_Font6(11)];
    ts.text = @"我已仔细阅读并遵守";
    [footview addSubview:ts];
    [ts mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.height.mas_equalTo(selectBut);
        make.left.mas_equalTo(selectBut.mas_right).mas_offset(KFit_W6S(10));
    }];
    self.agreed = YES;
    
    UIButton *butone = [[UIButton alloc] init];
    [footview addSubview:butone];
    butone.titleLabel.font = [UIFont systemFontOfSize:kFit_Font6(11)];
    [butone setTitleColor:kColor_N(0, 154, 201) forState:UIControlStateNormal];
    [butone setTitle:@"《淘电宝信息服务协议》" forState:UIControlStateNormal];
    [butone addTarget:self action:@selector(checkTheAgreement) forControlEvents:UIControlEventTouchUpInside];
    
    NSMutableAttributedString* tncString = [[NSMutableAttributedString alloc] initWithString:@"《淘电宝信息服务协议》"];
    
    //设置下划线...
    /*
     NSUnderlineStyleNone                                    = 0x00, 无下划线
     NSUnderlineStyleSingle                                  = 0x01, 单行下划线
     NSUnderlineStyleThick NS_ENUM_AVAILABLE(10_0, 7_0)      = 0x02, 粗的下划线
     NSUnderlineStyleDouble NS_ENUM_AVAILABLE(10_0, 7_0)     = 0x09, 双下划线
     */
    [tncString addAttribute:NSUnderlineStyleAttributeName
                      value:@(NSUnderlineStyleSingle)
                      range:(NSRange){0,[tncString length]}];
    //此时如果设置字体颜色要这样
    [tncString addAttribute:NSForegroundColorAttributeName value:kColor_N(0, 154, 201)  range:NSMakeRange(0,[tncString length])];
    
    //设置下划线颜色...
    [tncString addAttribute:NSUnderlineColorAttributeName value:kColor_N(0, 154, 201) range:(NSRange){0,[tncString length]}];
    [butone setAttributedTitle:tncString forState:UIControlStateNormal];
    
    [butone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(ts.mas_right);
        make.width.mas_equalTo(KFit_W6S(250));
        make.centerY.height.mas_equalTo(ts);
    }];
    
    
    UIButton *but = [[UIButton alloc] init];
    [footview addSubview:but];
    [but setTitle:@"提交订单" forState:UIControlStateNormal];
    [but addTarget:self action:@selector(toPayVc) forControlEvents:UIControlEventTouchUpInside];
    but.layer.cornerRadius = 5;
    but.backgroundColor = kColor_N(40, 174, 104);
    [but mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(footview).mas_offset(KFit_W6S(40));
        make.right.mas_equalTo(footview).mas_offset(-KFit_W6S(40));
        make.bottom.mas_equalTo(footview);
        make.height.mas_equalTo(KFit_H6S(80));
    }];
    
    return footview;
}
- (void)agreementSelecetBut:(UIButton *)senter{
    senter.selected = !senter.selected;
    self.agreed = !self.agreed;
}
#pragma mark-tableview代理
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HomeChooseCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeChooseCell"];
    if (cell == nil) {
        cell = [[HomeChooseCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"XLMineCell"];
    }
    cell.model = self.dataArr[indexPath.row];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return KFit_H6S(90);
}
/**
 *  显示时间选择器
 *
 *  @param title            标题
 *  @param type             类型（时间、日期、日期和时间、倒计时）
 *  @param defaultSelValue  默认选中的时间（为空，默认选中现在的时间）
 *  @param minDateStr       最小时间（如：2015-08-28 00:00:00），可为空
 *  @param maxDateStr       最大时间（如：2018-05-05 00:00:00），可为空
 *  @param isAutoSelect     是否自动选择，即选择完(滚动完)执行结果回调，传选择的结果值
 *  @param resultBlock      选择结果的回调
 *
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    MineModel *model = self.dataArr[indexPath.row];
    __weak typeof(self) weakSelf = self;
    
    NSDate *date = [NSDate date];
    NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"YYYY"];
    NSString *time1 = [formatter stringFromDate:date];
    [formatter setDateFormat:@"MM"];
    NSString *time2 = [formatter stringFromDate:date];
    NSArray *arr =@[time1,time2];
    XLSingleton *single = [XLSingleton singleton];
    if ([model.title isEqualToString:@"用电开始时间"]) {
        NSArray *defaultArr;
        if ([self.start_date  isEqual: @""]|| self.start_date == nil) {
            defaultArr = arr;
        }else{
            NSArray  *array = [self.start_date componentsSeparatedByString:@"-"];
            if (array.count == 3) {
                defaultArr = @[array[0],array[1]];
            }
        }
        [CGXPickerView showStringPickerWithTitle:@"选择开始时间" DataSource:single.dateArr DefaultSelValue:defaultArr IsAutoSelect:NO ResultBlock:^(id selectValue, id selectRow) {
            NSLog(@"%@   %@",selectValue,selectRow); ;
            NSString *date = [XLCommonUse dateWithArr:selectValue EachOrFirstMonth:YES];
             model.subtitle = date;
            self.start_date = date;
            [weakSelf.table reloadData];
        }];
        

    }else if ([model.title isEqualToString:@"用电结束时间"]){
        NSArray *defaultArr;
        if ([self.end_date  isEqual: @""]|| self.end_date == nil) {
            defaultArr = arr;
        }else{
            NSArray  *array = [self.end_date componentsSeparatedByString:@"-"];
            if (array.count == 3) {
                defaultArr = @[array[0],array[1]];
            }
        }
        [CGXPickerView showStringPickerWithTitle:@"选择结束时间" DataSource:single.dateArr DefaultSelValue:defaultArr IsAutoSelect:NO ResultBlock:^(id selectValue, id selectRow) {
            NSLog(@"%@   %@",selectValue,selectRow); ;
            NSString *date = [XLCommonUse dateWithArr:selectValue EachOrFirstMonth:NO];
            model.subtitle = date;
            self.end_date = date;
            [weakSelf.table reloadData];
        }];


    }else if ([model.title isEqualToString:@"所在城市"]){
        [CGXPickerView showAddressPickerWithTitle:@"选择城市" DefaultSelected:@[[NSNumber numberWithInteger:self.homeAddressIndex],@0] IsAutoSelect:YES Manager:nil ResultBlock:^(NSArray *selectAddressArr, NSArray *selectAddressRow) {
            NSLog(@"%@-%@",selectAddressArr,selectAddressRow);
            if (selectAddressArr.count >1 ) {
                model.subtitle = selectAddressArr[1];
                self.province = [NSString stringWithFormat:@"%@ %@",selectAddressArr[0],selectAddressArr[1]];
                [weakSelf.table reloadData];
            }
        }];
    }else if ([model.title isEqualToString:@"电压等级 (kV)"]){
        [CGXPickerView showStringPickerWithTitle:@"电压等级 (kV)" DataSource:@[@"10kV",@"20kV",@"35kV",@"66kV",@"110kV",@"220kV"] DefaultSelValue:@"110kV" IsAutoSelect:NO ResultBlock:^(id selectValue, id selectRow) {
            NSLog(@"%@",selectValue);
            model.subtitle = selectValue;
            [weakSelf.table reloadData];
            self.voltage = [selectValue stringByReplacingOccurrencesOfString:@"kV" withString:@""];;
            KKLog(@"%@",selectValue);
        }];
    }else if ([model.title isEqualToString:@"购电量(万度)"]){
        XLAlertView *alert =  [[ XLAlertView alloc] initWithInputboxTitle:@"购电量(万度)"];
        alert.input.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
        [alert showXLAlertView];
        alert.inputText = ^(NSString *text) {
            if (![XLCommonUse isPureFloat:text]) {
                [MBProgressHUD showAutoMessage:@"请输入数字！"];
                return ;
            }
            model.subtitle = [XLCommonUse separatedDigitStringWithStr:text];
            self.num = text;
            [weakSelf.table reloadData];
            KKLog(@"%@",text);
        };
    }else if ([model.title isEqualToString:@"最高可承受价格(元/度)"]){
        XLAlertView *alert =  [[ XLAlertView alloc] initWithInputboxTitle:@"最高可承受价格(元/度)"];
        alert.input.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
        [alert showXLAlertView];
        alert.inputText = ^(NSString *text) {
            if (![XLCommonUse isPureFloat:text]) {
                [MBProgressHUD showAutoMessage:@"请输入数字！"];
                return ;
            }
            model.subtitle = text;
            self.max_price = text;
            [weakSelf.table reloadData];
            KKLog(@"%@",text);
        };
    }
}


- (void)toPayVc{

    User *user = [User UserOb];
    if (!user.UserLogin) {
        [XLCommonUse promptingLogin:self];
        return;
    }
    if (!self.agreed) {
        [MBProgressHUD showAutoMessage:@"需阅读并遵守协议！"];
        return;
    }
    if (self.max_price.length < 1) {
        [MBProgressHUD showAutoMessage:@"请输入最高价格！"];
        return;
    }
    if ([self.max_price floatValue] >1) {
        [MBProgressHUD showAutoMessage:@"最高价格不能大于1元！"];
        return;
    }
    if ([self.max_price floatValue] < 0.1) {
        [MBProgressHUD showAutoMessage:@"最高价格不能小于0.1元！"];
        return;
    }
    if (self.start_date.length < 1) {
        [MBProgressHUD showAutoMessage:@"请选择开始时间！"];
        return;
    }
    if (self.end_date.length < 1) {
        [MBProgressHUD showAutoMessage:@"请选择结束时间！"];
        return;
    }
    if (self.voltage.length < 1) {
        [MBProgressHUD showAutoMessage:@"请输入电压等级！"];
        return;
    }
    if (self.num.length < 1) {
        [MBProgressHUD showAutoMessage:@"请输入购电量！"];
        return;
    }
    if ([self.num floatValue] > 1000000) {
        [MBProgressHUD showAutoMessage:@"购电量不能大于1亿度！"];
        return;
    }
    if ([self.num floatValue] < 100) {
        [MBProgressHUD showAutoMessage:@"购电量不能小于100万度！"];
        return;
    }
    if ([self.num floatValue] <= 0) {
        [MBProgressHUD showAutoMessage:@"购电量不能低于0度！"];
        return;
    }
    if (self.province.length < 1) {
        [MBProgressHUD showAutoMessage:@"请选择所在城市！"];
        return;
    }
    OrderExpandVC * vc = [[OrderExpandVC alloc] init];
    vc.num = self.num;
    vc.voltage = self.voltage;
    vc.max_price = self.max_price;
    vc.province = self.province;
    vc.start_date = self.start_date;
    vc.end_date = self.end_date;
    [self.navigationController pushViewController:vc animated:YES];
//    [MBProgressHUD showLoadingHUD:@"正在提交订单"];
//    NSString *url = [NSString stringWithFormat:POSTOrdersCreate,@"创建",self.num,self.voltage,self.max_price,self.province,self.start_date,self.end_date,user.token];
//    [FMNetworkHelper fm_request_postWithUrlString:[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] isNeedCache:NO parameters:nil successBlock:^(id responseObject) {
//        [MBProgressHUD hideLoadingHUD];
//        if (kResponseObjectStatusCodeIsEqual(200)) {
//            FMMainModel *model = [FMMainModel mj_objectWithKeyValues:responseObject[@"data"]];
//
//
//            OrderExpandVC * vc = [[OrderExpandVC alloc] init];
//            vc.model = model;
//            [self.navigationController pushViewController:vc animated:YES];
//            [self DeleteData];
//        }
//    } failureBlock:^(NSError *error) {
//        [MBProgressHUD hideLoadingHUD];
//    } progress:^(int64_t bytesProgress, int64_t totalBytesProgress) {
//
//    }];
    
    
}

#pragma mark - 创建成功之后清空数据
- (void)DeleteData{
    for (int i = 0; i < self.dataArr.count; i++) {
        if (!(i == 2 || i ==3)) {
            MineModel *model = self.dataArr[i];
            model.subtitle = @"";
        }
    }
    self.start_date = @"";
    self.end_date = @"";
    self.num = @"";
    self.max_price = @"";
    [self.table reloadData];
}
- (void)loadProvinceSelectorView{
    
}
#pragma mark pickerViewOneDelegate
-(void)PickerViewOneDelegateOncleck:(NSInteger)index Text:(NSString *)text{
    self.homeAddress = text;
    self.homeAddressIndex = index;
    [self loadHomeDataWithAddress:text];
    KKLog(@"%ld----%@",(long)index ,text);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadHomeDataWithAddress:(NSString *)address{
    NSString *url;
    if ([User UserOb].UserLogin) {
        url =[NSString stringWithFormat:GETMembersIndexInfoLOGIN,address,[User UserOb].token];
       
    }else{
       url =[NSString stringWithFormat:GETMembersIndexInfo,address];
    }
    [FMNetworkHelper fm_request_getWithUrlString:url isNeedCache:NO parameters:nil successBlock:^(id responseObject) {
        if (kResponseObjectStatusCodeIsEqual(200)) {
                HomeModel *model = [HomeModel mj_objectWithKeyValues:responseObject[@"data"]];
                self.model = model;
            _one.subtitle.text = [NSString stringWithFormat:@"%@亿度",model.history_sum];
            _two.subtitle.text = [NSString stringWithFormat:@"%@亿度",model.buyer_later];
            _three.subtitle.text = [NSString stringWithFormat:@"%@亿度",model.seller_later];
            self.time.text = [NSString stringWithFormat:@"电力云平台电力统计 %@",[XLCommonUse TimeToInterceptYYYYMMddHHmm:model.time]];
            if (model.info_notice == 1) {
                self.redImg.hidden = NO;
            }else{
                self.redImg.hidden = YES;
            }
            }
        
            [self reloadData];
    } failureBlock:^(NSError *error) {
        KKLog(@"%@", error);
        
    } progress:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];
}
#pragma mark - 跟新数据
- (void)reloadData{
    if (self.stat) {
        //明年
        
        self.total.text = [NSString stringWithFormat:@"当前 %@ 亿度可购",self.model.next_electric_sum];
        KKLog(@"%@ %@",self.model.next_electric_sum , self.total.text);
    }else{
        //今年
        KKLog(@"%@",self.model.this_electric_sum);
        self.total.text = [NSString stringWithFormat:@"当前 %@ 亿度可购",self.model.this_electric_sum];
        KKLog(@"%@ %@",self.model.this_electric_sum,self.total.text);
    }
    
    [self.total setAttributedText:self.noteStr];
}
- (void)checkTheAgreement{
    HWebVc *vc= [[HWebVc alloc] init];
    vc.title = @"淘电宝信息服务协议";
    vc.url = HTMLTDBAgreement;
    [self.navigationController pushViewController:vc animated:YES];
}




- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
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
