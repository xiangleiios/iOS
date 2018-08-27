//
//  MyCouponVC.m
//  MobileProject
//
//  Created by zsgy on 2018/6/27.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import "MyCouponVC.h"

@interface MyCouponVC ()
@property (nonatomic , strong)UILabel *money;
@property (nonatomic , strong)NSDictionary *dic;
@end

@implementation MyCouponVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationView setTitle:@"我的优惠劵"];
    [self loadSubview];
    [self loadData];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)loadSubview{
    UILabel *one = [[UILabel alloc] init];
    [self.view addSubview:one];
    one.text = @"当前优惠券：";
    one.font = [UIFont systemFontOfSize:kFit_Font6(17)];
    [one mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).mas_offset(KFit_W6S(30));
        make.top.mas_equalTo(self.view).mas_offset(kNavBarH + KFit_H6S(25));
        make.size.mas_equalTo(CGSizeMake(KFit_W6S(300), KFit_H6S(35)));
    }];
    
    self.money = [[UILabel alloc] init];
    [self.view addSubview:self.money];
    self.money.textAlignment = NSTextAlignmentRight;
    self.money.font = [UIFont systemFontOfSize:kFit_Font6(20)];
    self.money.textColor = kColor_N(238, 36, 43);
    [self.money mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(one.mas_centerY);
        make.right.mas_equalTo(self.view).mas_offset(-KFit_W6S(30));
        make.size.mas_equalTo(CGSizeMake(KFit_W6S(250), KFit_H6S(35)));
    }];
    
    UILabel *ts = [[UILabel alloc] init];
    [self.view addSubview:ts];
    ts.numberOfLines = 0;
    ts.textColor = kColor_N(248, 151, 84);
    ts.font = [UIFont systemFontOfSize:kFit_Font6(16)];
    ts.text = @"优惠券可以在支付订单服务费首付款时抵用；只能在平台消费，不可提现。";
    [ts mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).mas_offset(KFit_W6S(30));
        make.right.mas_equalTo(self.view).mas_offset(-KFit_W6S(30));
        make.top.mas_equalTo(one.mas_bottom).mas_offset(KFit_W6S(25));
    }];
    
    
                  
}

- (void)loadDetail{
    UILabel *lb;
    lb = [[UILabel alloc] init];
    lb.backgroundColor = appcoloer_line;
    [self.view addSubview:lb];
    [lb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).mas_offset(KFit_W6S(30));
        make.right.mas_equalTo(self.view).mas_offset(-KFit_W6S(30));
        make.top.mas_equalTo(_money.mas_bottom).mas_offset(KFit_H6S(120));
        make.height.mas_equalTo(kFit_Font6(1));
    }];
    for (NSDictionary *dic in self.dic[@"list"]) {
        UILabel *titlt = [[UILabel alloc] init];
        titlt.textColor = kColor_N(172, 172, 172);
        [self.view addSubview:titlt];
        titlt.text = [NSString stringWithFormat:@"%@ %@",dic[@"content"],[XLCommonUse TimeToIntercept:dic[@"time"]]];
        [titlt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.view).mas_offset(KFit_W6S(30));
            make.width.mas_equalTo(KFit_W6S(500));
            make.top.mas_equalTo(lb.mas_bottom).mas_offset(KFit_H6S(20));
            make.height.mas_equalTo(KFit_H6S(30));
        }];
        UILabel *num = [[UILabel alloc] init];
        num.textColor = kColor_N(172, 172, 172);
        num.textAlignment = NSTextAlignmentRight;
        if ([dic[@"type"]  isEqual: @3]) {
            num.text = [NSString stringWithFormat:@"-%@元",dic[@"money"]];
        }else{
            num.text = [NSString stringWithFormat:@"%@元",dic[@"money"]];
        }
        
        [self.view addSubview:num];
        [num mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.view).mas_offset(KFit_W6S(30));
            make.right.mas_equalTo(self.view).mas_offset(-KFit_W6S(30));
            make.top.mas_equalTo(lb.mas_bottom).mas_offset(KFit_H6S(20));
            make.height.mas_equalTo(KFit_H6S(30));
        }];
        
        lb = [[UILabel alloc] init];
        [self.view addSubview:lb];
        [lb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.view).mas_offset(KFit_W6S(30));
            make.right.mas_equalTo(self.view).mas_offset(-KFit_W6S(30));
            make.top.mas_equalTo(titlt.mas_bottom).mas_offset(KFit_H6S(10));
            make.height.mas_equalTo(kFit_Font6(1));
        }];
    }
}
//"data": {
//    "money_sum": "string,当前总钱数",
//    "list": [
//             {
//                 "content": "string,内容",
//                 "money": "string,钱数",
//                 "time": "string,时间"
//             }
//             ]
//}
- (void)loadData{
    NSString *url = [NSString stringWithFormat:GETmMembersPoint,[User UserOb].token];
    [FMNetworkHelper fm_request_getWithUrlString:url isNeedCache:NO parameters:nil successBlock:^(id responseObject) {
        if (kResponseObjectStatusCodeIsEqual(200)) {
            self.dic = responseObject[@"data"];
            self.money.text = [NSString stringWithFormat:@"%@元",self.dic[@"money_sum"]];
            [self loadDetail];
        }
    } failureBlock:^(NSError *error) {
        KKLog(@"%@", error);
        
    } progress:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
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
