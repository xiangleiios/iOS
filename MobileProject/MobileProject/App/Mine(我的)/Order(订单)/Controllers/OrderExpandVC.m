//
//  OrderExpandVC.m
//  MobileProject
//
//  Created by zsgy on 2018/8/1.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import "OrderExpandVC.h"
#import "PayVc.h"
#import "CGXPickerView.h"

#import "UITextField+MicrometerLevelFormat.h"

@interface OrderExpandVC ()<UITextFieldDelegate>
@property (nonatomic , strong)UITextField *electricityOne;
@property (nonatomic , strong)UITextField *electricityTwo;
@property (nonatomic , strong)UITextField *industry;
@property (nonatomic , strong)UITextField *region;
@property (nonatomic , strong)UISwitch *switc;

@property (nonatomic , strong)UILabel *time;
@property (nonatomic , strong)UILabel *address;
@end

@implementation OrderExpandVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationView setTitle:@"补充用电方拓展信息"];
    self.navigationView.titleLabel.textColor = [UIColor blackColor];
    [self.navigationView.navigationBackButton removeFromSuperview];
    [self laodSubview];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)laodSubview{
    UILabel *img = [[UILabel alloc] initWithFrame:CGRectMake(KFit_H6S(20), kNavBarH + KFit_H6S(25), KFit_W6S(20), KFit_W6S(20))];
    [self.view addSubview:img];
    img.text = @"*";
    img.textColor = kColor_N(247, 141, 70);
    img.font = [UIFont systemFontOfSize:kFit_Font6(13)];
    
    UILabel *one = [[UILabel alloc] initWithFrame:CGRectMake(KFit_H6S(40), kNavBarH + KFit_H6S(20), KFit_W6S(300), KFit_W6S(20))];
    [self.view addSubview:one];
    one.text = @"前年用电总量(万度)";
    one.font = [UIFont systemFontOfSize:kFit_Font6(16)];
    
    
    self.electricityOne = [[UITextField alloc] init];
    self.electricityOne.delegate = self;
    self.electricityOne.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    self.electricityOne.font = [UIFont systemFontOfSize:kFit_Font6(20)];
    [self.view addSubview:self.electricityOne];
    [self.electricityOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).mas_offset(KFit_W6S(KFit_W6S(25)));
        make.right.mas_equalTo(self.view).mas_offset(KFit_W6S(-KFit_W6S(25)));
        make.top.mas_equalTo(one.mas_bottom).mas_offset(KFit_H6S(35));
        make.height.mas_equalTo(KFit_H6S(60));
    }];
    
    UILabel *lbone = [[UILabel alloc] init];
    [self.view addSubview:lbone];
    [lbone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.electricityOne);
        make.top.mas_equalTo(self.electricityOne.mas_bottom).mas_offset(KFit_H6S(20));
        make.height.mas_equalTo(1);
    }];
    lbone.backgroundColor = [UIColor colorWithWhite:240/255.0 alpha:1];
    
    UILabel  *imgtwo = [[UILabel alloc] init];
    [self.view addSubview:imgtwo];
    imgtwo.text = @"*";
    imgtwo.textColor = kColor_N(247, 141, 70);
    imgtwo.font = [UIFont systemFontOfSize:kFit_Font6(13)];
    [imgtwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).mas_offset(KFit_W6S(20));
        make.top.mas_equalTo(lbone).mas_offset(KFit_H6S(30));
        make.size.mas_equalTo(CGSizeMake(KFit_W6S(20), KFit_H6S(20)));
    }];
    
    UILabel *two = [[UILabel alloc] init];
    [self.view addSubview:two];
    [two mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(imgtwo.mas_right);
        make.centerY.mas_equalTo(imgtwo);
        make.size.mas_equalTo(CGSizeMake(KFit_W6S(300), KFit_H6S(20)));
    }];
    two.text = @"去年用电总量(万度)";
    two.font = [UIFont systemFontOfSize:kFit_Font6(16)];
    
    self.electricityTwo = [[UITextField alloc] init];
    self.electricityTwo.delegate = self;
    self.electricityTwo.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    self.electricityTwo.font = [UIFont systemFontOfSize:kFit_Font6(20)];
    [self.view addSubview:self.electricityTwo];
    [self.electricityTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).mas_offset(KFit_W6S(KFit_W6S(25)));
        make.right.mas_equalTo(self.view).mas_offset(KFit_W6S(-KFit_W6S(25)));
        make.top.mas_equalTo(two.mas_bottom).mas_offset(KFit_H6S(35));
        make.height.mas_equalTo(KFit_H6S(60));
    }];
    
    UILabel *lbtwo = [[UILabel alloc] init];
    [self.view addSubview:lbtwo];
    [lbtwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.electricityTwo);
        make.top.mas_equalTo(self.electricityTwo.mas_bottom).mas_offset(KFit_H6S(20));
        make.height.mas_equalTo(1);
    }];
    lbtwo.backgroundColor = [UIColor colorWithWhite:240/255.0 alpha:1];
    
    
    UILabel *imgthree = [[UILabel alloc] init];
    [self.view addSubview:imgthree];
    imgthree.text = @"*";
    imgthree.textColor = kColor_N(247, 141, 70);
    imgthree.font = [UIFont systemFontOfSize:kFit_Font6(13)];
    [imgthree mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).mas_offset(KFit_W6S(20));
        make.top.mas_equalTo(lbtwo).mas_offset(KFit_H6S(40));
        make.size.mas_equalTo(CGSizeMake(KFit_W6S(20), KFit_H6S(20)));
    }];
    
    UILabel *three = [[UILabel alloc] init];
    [self.view addSubview:three];
    [three mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(imgthree.mas_right);
        make.centerY.mas_equalTo(imgthree);
        make.size.mas_equalTo(CGSizeMake(KFit_W6S(300), KFit_H6S(20)));
    }];
    three.text = @"是否准入";
    three.font = [UIFont systemFontOfSize:kFit_Font6(16)];
    
    self.switc = [[UISwitch alloc] init];
    [self.view addSubview:self.switc];
    self.switc.on = YES;
    [self.switc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.view).mas_offset(-KFit_W6S(25));
        make.centerY.mas_equalTo(imgthree);
        make.size.mas_equalTo(CGSizeMake(KFit_W6S(100), KFit_H6S(50)));
        
    }];
    
    UILabel *ts = [[UILabel alloc] init];
    [self.view addSubview:ts];
    [ts mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).mas_offset(KFit_H6S(40));
        make.right.mas_equalTo(self.view).mas_offset(-KFit_H6S(40));
        make.top.mas_equalTo(three.mas_bottom).mas_offset(KFit_H6S(40));
    }];
    ts.numberOfLines = 0;
    ts.text = @"用户须确保自身在当地电力主管部门的准入名单内，并承诺提供的信息真实有效。若对准入情况或所填信息有疑问，可以拨打咨询电话010-68999830问询。";
    ts.font = [UIFont systemFontOfSize:kFit_Font6(13)];
    ts.textColor = kColor_N(247, 141, 70);
    
    UILabel *lbtree = [[UILabel alloc] init];
    [self.view addSubview:lbtree];
    [lbtree mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.electricityTwo);
        make.top.mas_equalTo(ts.mas_bottom).mas_offset(KFit_H6S(20));
        make.height.mas_equalTo(1);
    }];
    lbtree.backgroundColor = [UIColor colorWithWhite:240/255.0 alpha:1];
    
    
    UILabel *four = [[UILabel alloc] init];
    [self.view addSubview:four];
    [four mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).mas_offset(KFit_W6S(30));
        make.top.mas_equalTo(lbtree).mas_offset(KFit_H6S(30));
        make.size.mas_equalTo(CGSizeMake(KFit_W6S(300), KFit_H6S(20)));
    }];
    four.text = @"所属行业";
    four.font = [UIFont systemFontOfSize:kFit_Font6(16)];
    
    
    self.industry = [[UITextField alloc] init];
    self.industry.delegate = self;
    self.industry.font = [UIFont systemFontOfSize:kFit_Font6(20)];
    [self.view addSubview:self.industry];
    [self.industry mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).mas_offset(KFit_W6S(KFit_W6S(25)));
        make.right.mas_equalTo(self.view).mas_offset(KFit_W6S(-KFit_W6S(25)));
        make.top.mas_equalTo(four.mas_bottom).mas_offset(KFit_H6S(35));
        make.height.mas_equalTo(KFit_H6S(60));
    }];
    
    UILabel *lbfour = [[UILabel alloc] init];
    [self.view addSubview:lbfour];
    [lbfour mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.electricityTwo);
        make.top.mas_equalTo(self.industry.mas_bottom).mas_offset(KFit_H6S(20));
        make.height.mas_equalTo(1);
    }];
    lbfour.backgroundColor = [UIColor colorWithWhite:240/255.0 alpha:1];
    
    
    UILabel *five = [[UILabel alloc] init];
    [self.view addSubview:five];
    [five mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).mas_offset(KFit_W6S(30));
        make.top.mas_equalTo(lbfour).mas_offset(KFit_H6S(30));
        make.size.mas_equalTo(CGSizeMake(KFit_W6S(300), KFit_H6S(20)));
    }];
    five.text = @"所属行政区";
    five.font = [UIFont systemFontOfSize:kFit_Font6(16)];
    
    
    self.address = [[UILabel alloc] init];
    [self.view addSubview:self.address];
    [self.address mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.view).mas_offset(-KFit_W6S(40));
        make.top.mas_equalTo(lbfour).mas_offset(KFit_H6S(30));
        make.size.mas_equalTo(CGSizeMake(KFit_W6S(300), KFit_H6S(20)));
    }];
    self.address.textAlignment = NSTextAlignmentRight;
    self.address.text = self.province;
    self.address.font = [UIFont systemFontOfSize:kFit_Font6(14)];
    
    self.region = [[UITextField alloc] init];
    self.region.delegate = self;
    self.region.font = [UIFont systemFontOfSize:kFit_Font6(20)];
    [self.view addSubview:self.region];
    [self.region mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).mas_offset(KFit_W6S(KFit_W6S(25)));
        make.right.mas_equalTo(self.view).mas_offset(KFit_W6S(-KFit_W6S(25)));
        make.top.mas_equalTo(five.mas_bottom).mas_offset(KFit_H6S(35));
        make.height.mas_equalTo(KFit_H6S(60));
    }];
    
    UILabel *lbfive = [[UILabel alloc] init];
    [self.view addSubview:lbfive];
    [lbfive mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.electricityTwo);
        make.top.mas_equalTo(self.region.mas_bottom).mas_offset(KFit_H6S(20));
        make.height.mas_equalTo(1);
    }];
    lbfive.backgroundColor = [UIColor colorWithWhite:240/255.0 alpha:1];
    
    
    UILabel *sex = [[UILabel alloc] init];
    [self.view addSubview:sex];
    [sex mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).mas_offset(KFit_W6S(30));
        make.top.mas_equalTo(lbfive).mas_offset(KFit_H6S(30));
        make.size.mas_equalTo(CGSizeMake(KFit_W6S(300), KFit_H6S(20)));
    }];
    sex.text = @"生产时段";
    sex.font = [UIFont systemFontOfSize:kFit_Font6(16)];
    
    UIImageView *imgxz = [[UIImageView alloc] init];
    [self.view addSubview:imgxz];
    [imgxz setImage:[UIImage imageNamed:@"ret"]];
    [imgxz mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(sex);
        make.right.mas_equalTo(self.view).mas_offset(-KFit_W6S(30));
        make.size.mas_equalTo(CGSizeMake(KFit_W6S(14), KFit_W6S(26)));
    }];
    
    self.time = [[UILabel alloc] init];
    [self.view addSubview:self.time];
    [self.time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(imgxz.mas_left).mas_offset(-KFit_W6S(20));
        make.centerY.mas_equalTo(sex);
        make.size.mas_equalTo(CGSizeMake(KFit_W6S(300), KFit_H6S(30)));
    }];
    self.time.textAlignment = NSTextAlignmentRight;
    
    self.time.font = [UIFont systemFontOfSize:kFit_Font6(14)];
    
    
    UIButton *timeChoose = [[UIButton alloc] init];
    [self.view addSubview:timeChoose];
    [timeChoose addTarget:self action:@selector(timeToChoose) forControlEvents:UIControlEventTouchUpInside];
    [timeChoose mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.electricityTwo);
        make.top.mas_equalTo(lbfive).mas_offset(KFit_H6S(10));
        make.height.mas_equalTo(KFit_H6S(50));
    }];
    
    UILabel *lbsix = [[UILabel alloc] init];
    [self.view addSubview:lbsix];
    [lbsix mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.electricityTwo);
        make.top.mas_equalTo(sex.mas_bottom).mas_offset(KFit_H6S(30));
        make.height.mas_equalTo(1);
    }];
    lbsix.backgroundColor = [UIColor colorWithWhite:240/255.0 alpha:1];
    
    UILabel *lbseven = [[UILabel alloc] init];
    [self.view addSubview:lbseven];
    lbseven.text = @"*为必填项";
    lbseven.textColor = kColor_N(247, 141, 70);
    lbseven.font = [UIFont systemFontOfSize:kFit_Font6(13)];
    [lbseven mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.electricityTwo);
        make.top.mas_equalTo(lbsix.mas_bottom).mas_offset(KFit_H6S(20));
        make.height.mas_equalTo(KFit_H6S(20));
    }];
    
    
    
    UIButton *but = [[UIButton alloc] init];
    [but setTitle:@"保存并提交订单" forState:UIControlStateNormal];
    [but setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    but.backgroundColor = kColor_N(40, 174, 104);
    but.titleLabel.font = [UIFont systemFontOfSize:kFit_Font6(17)];
    but.layer.cornerRadius = 5;
    [but addTarget:self action:@selector(toPay) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:but];
    [but mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).mas_offset(KFit_W6S(KFit_W6S(40)));
        make.right.mas_equalTo(self.view).mas_offset(KFit_W6S(-KFit_W6S(40)));
        make.top.mas_equalTo(lbseven.mas_bottom).mas_offset(KFit_H6S(35));
        make.height.mas_equalTo(KFit_H6S(80));
    }];
    
}

- (void)toPay{
    NSString *yesteryear_total = [self.electricityTwo.text stringByReplacingOccurrencesOfString:@"," withString:@""];
    NSString *before_last_total = [self.electricityOne.text stringByReplacingOccurrencesOfString:@"," withString:@""];
    NSString *time = [self.time.text stringByReplacingOccurrencesOfString:@"~" withString:@","];
    if (yesteryear_total.length < 1) {
        [MBProgressHUD showAutoMessage:@"请输入去年用电量！"];
        return;
    }
    if ([yesteryear_total intValue] < 1) {
        [MBProgressHUD showAutoMessage:@"去年用电量不能小于1万度！"];
        return;
    }
    if ([yesteryear_total intValue] > 100000) {
        [MBProgressHUD showAutoMessage:@"去年用电量不能大于100,000万度！"];
        return;
    }
    if (before_last_total.length < 1) {
        [MBProgressHUD showAutoMessage:@"请输入前年用电量！"];
        return;
    }
    if ([before_last_total intValue] < 1) {
        [MBProgressHUD showAutoMessage:@"前年用电量不能小于1万度！"];
        return;
    }
    if ([before_last_total intValue] > 100000) {
        [MBProgressHUD showAutoMessage:@"前年用电量不能大于100,000万度！"];
        return;
    }
    
    if (self.industry.text.length > 10) {
        [MBProgressHUD showAutoMessage:@"所属行业不得大于10个汉字"];
        return;
    }
    if (!self.switc.on) {
        XLAlertView *alert = [[XLAlertView alloc] initWithTitle:@"提示" message:@"您未获得市场准入。如确实未获得准入，则不允许提交订单，请取消订单，否则请修改" sureBtn:@"取消订单" cancleBtn:@"修改选择"];
        [alert showXLAlertView];
        alert.resultIndex = ^(NSInteger index) {
            if (index == 2) {
                [self.navigationController popViewControllerAnimated:YES];
            }
        };
        return;
    }
    
    User *user = [User UserOb];
    // /api/orders/create?title=%@&num=%@&voltage=%@&max_price=%@&province=%@&start_date=%@&end_date=%@&yesteryear_total=%@&before_last_total=%@&industry=%@&area=%@&time_slot=%@&allow=1&token=%@
    
    NSString *url = [NSString stringWithFormat:POSTOrdersCreate,@"创建",self.num,self.voltage,self.max_price,self.province,self.start_date,self.end_date,yesteryear_total,before_last_total,self.industry.text,self.region.text,time,user.token];
    [MBProgressHUD showLoadingHUD:@"正在提交订单"];
    [FMNetworkHelper fm_request_postWithUrlString:[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] isNeedCache:NO parameters:nil successBlock:^(id responseObject) {
        [MBProgressHUD hideLoadingHUD];
        if (kResponseObjectStatusCodeIsEqual(200)) {
            FMMainModel *model = [FMMainModel mj_objectWithKeyValues:responseObject[@"data"]];
            PayVc *vc = [[PayVc alloc] init];
            vc.model = model;
            vc.ordersItemType = OrdersItemsTypeDeposit;
            [self.navigationController pushViewController:vc animated:YES];
            [self removeSelf];
        }
    } failureBlock:^(NSError *error) {
        [MBProgressHUD hideLoadingHUD];
    } progress:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];
    
}
-(void)removeSelf {
    NSMutableArray *marr = [[NSMutableArray alloc]initWithArray:self.navigationController.viewControllers]; for (UIViewController *vc in marr) {
        if (vc == self) {
            [marr removeObject:vc];
            break;
        }
        
    }
    
    self.navigationController.viewControllers = marr;
    [self.navigationController setViewControllers:marr animated:YES];
}
    
    

- (void)timeToChoose{
    [CGXPickerView showStringPickerWithTitle:@"生产时段" DataSource:@[@[@"00:00",@"01:00",@"02:00",@"03:00",@"04:00",@"05:00",@"06:00",@"07:00",@"08:00",@"09:00",@"10:00",@"11:00",@"12:00",@"13:00",@"14:00",@"15:00",@"16:00",@"17:00",@"18:00",@"19:00",@"20:00",@"21:00",@"22:00",@"23:00",@"24:00"],@[@"00:00",@"01:00",@"02:00",@"03:00",@"04:00",@"05:00",@"06:00",@"07:00",@"08:00",@"09:00",@"10:00",@"11:00",@"12:00",@"13:00",@"14:00",@"15:00",@"16:00",@"17:00",@"18:00",@"19:00",@"20:00",@"21:00",@"22:00",@"23:00",@"24:00"]] DefaultSelValue:nil IsAutoSelect:NO ResultBlock:^(id selectValue, id selectRow) {
        NSLog(@"%@   %@",selectValue,selectRow);
        self.time.text = [NSString stringWithFormat:@"%@~%@",[selectValue firstObject],[selectValue lastObject]];
    }];
}



- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (textField == self.electricityOne || textField == _electricityTwo) {
        [textField openMicrometerLevelFormat];
    }
    return YES;
}



-(void)textFieldDidBeginEditing:(UITextField *)textField
{
//    NSLog(@"2");// 准备开始输入  文本字段将成为第一响应者
    if (textField == self.industry || textField == self.region) {
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(transformView:) name:UIKeyboardWillChangeFrameNotification object:nil];
    }
   
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField == self.industry || textField == self.region) {
        [[NSNotificationCenter defaultCenter] removeObserver:self];
    }
//    NSLog(@"3");//文本彻底结束编辑时调用
}



-(void)transformView:(NSNotification *)aNSNotification
{
    //获取键盘弹出前的Rect
    NSValue *keyBoardBeginBounds=[[aNSNotification userInfo]objectForKey:UIKeyboardFrameBeginUserInfoKey];
    CGRect beginRect=[keyBoardBeginBounds CGRectValue];
    
    //获取键盘弹出后的Rect
    NSValue *keyBoardEndBounds=[[aNSNotification userInfo]objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect  endRect=[keyBoardEndBounds CGRectValue];
    
    //获取键盘位置变化前后纵坐标Y的变化值
    CGFloat deltaY=(endRect.origin.y-beginRect.origin.y)/2.0;
    NSLog(@"看看这个变化的Y值:%f",deltaY);
    
    //在0.25s内完成self.view的Frame的变化，等于是给self.view添加一个向上移动deltaY的动画
    [UIView animateWithDuration:0.25f animations:^{
        [self.view setFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y+deltaY, self.view.frame.size.width, self.view.frame.size.height)];
    }];
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
