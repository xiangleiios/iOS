//
//  BusinessShowV.m
//  MobileProject
//
//  Created by 向蕾 on 2018/9/12.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import "BusinessShowV.h"

@implementation BusinessShowV

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (NSMutableArray *)butArr{
    if (_butArr == nil) {
        _butArr = [NSMutableArray array];
    }
    return _butArr;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self loadSubview];
    }
    return self;
}


- (void)loadSubview{
    self.frame = [UIScreen mainScreen].bounds;
    self.backgroundColor = kRGBAColor(0, 0, 0, 0.8);
 
}


- (void)setDataArr:(NSArray *)dataArr{
    _dataArr = dataArr;
    [self.backview removeFromSuperview];
    self.backview = [[XLView alloc] init];
    [self addSubview:self.backview];
    [self.backview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self);
        make.width.mas_equalTo(KFit_W6S(560));
        make.height.mas_equalTo(KFit_H6S(420));
    }];
    
    self.backview.backgroundColor = [UIColor whiteColor];
    self.backview.layer.cornerRadius = 5;
    self.backview.layer.masksToBounds = YES;
    
    UILabel *lab = [[UILabel alloc] init];
    [self.backview addSubview:lab];
    lab.text = @"驾校选择";
    lab.textAlignment = NSTextAlignmentCenter;
    lab.backgroundColor = kColor_N(235, 238, 243);
    lab.font = [UIFont systemFontOfSize:kFit_Font6(19)];
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(self.backview);
        make.height.mas_equalTo(KFit_H6S(100));
    }];
    
    
    UIView *view;
    for (int i = 0; i < _dataArr.count; i++) {
        UIView *v = [self laodWithModel:_dataArr[i]];
        v.frame =CGRectMake(0,KFit_H6S(100) + KFit_H6S(90) * i, KFit_W6S(560), KFit_H6S(90));
        [self.backview addSubview:v];
        view = v;
    }
    UILabel *ts = [[UILabel alloc] init];
    [self.backview addSubview:ts];
    ts.text = @"勾选的校区\n在中天驾考学员端展示推广，为您轻松招生";
    ts.numberOfLines = 2;
    [ts mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(view.mas_bottom).mas_offset(KFit_H6S(30));
        make.centerX.mas_equalTo(self.backview);
        make.size.mas_equalTo(CGSizeMake(KFit_W6S(500), KFit_H6S(60)));
    }];
    
    ts.textColor = kColor_N(128, 133, 150);
    ts.textAlignment = NSTextAlignmentCenter;
    ts.font = [UIFont systemFontOfSize:kFit_Font6(12)];
    
    UILabel *lbo = [[UILabel alloc] init];
    [self.backview addSubview:lbo];
    lbo.backgroundColor = kColor_N(240, 240, 240);
    [lbo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.backview);
        make.top.mas_equalTo(ts.mas_bottom).mas_offset(KFit_H6S(30));
        make.height.mas_equalTo(1);
    }];
    
    
    
    
    UIButton *quxiao = [[UIButton alloc] init];
    [self.backview addSubview:quxiao];
    [quxiao setTitle:@"取消" forState:UIControlStateNormal];
    [quxiao setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [quxiao addTarget:self action:@selector(shutDown) forControlEvents:UIControlEventTouchUpInside];
    [quxiao mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.backview);
        make.top.mas_equalTo(lbo.mas_bottom);
        make.height.mas_equalTo(KFit_H6S(100));
        make.width.mas_equalTo(KFit_W6S(280));
    }];
    
    
    UIButton *queding = [[UIButton alloc] init];
    [self.backview addSubview:queding];
    [queding setTitle:@"确定" forState:UIControlStateNormal];
    [queding setTitleColor:kColor_N(0, 98, 233) forState:UIControlStateNormal];
    [queding addTarget:self action:@selector(queding) forControlEvents:UIControlEventTouchUpInside];
    [queding mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.backview);
        make.top.mas_equalTo(lbo.mas_bottom);
        make.height.mas_equalTo(KFit_H6S(100));
        make.width.mas_equalTo(KFit_W6S(280));
    }];
    
    
    [self.backview mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self);
        make.width.mas_equalTo(KFit_W6S(560));
        make.height.mas_equalTo([self.backview getLayoutCellHeight]);
    }];
    
    
    
    
}





- (UIView *)laodWithModel:(FMMainModel *)model{
    UIView *view = [[UIView alloc] init];
    UIButton *but = [[UIButton alloc] init];
    [view addSubview:but];
    [but mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(view).mas_offset(KFit_W6S(28));
        make.centerY.mas_equalTo(view);
        make.width.height.mas_equalTo(KFit_W6S(56));
    }];
    [but setImage:[UIImage imageNamed:@"nor_button"] forState:UIControlStateNormal];
    [but setImage:[UIImage imageNamed:@"down_button"] forState:UIControlStateSelected];
    [but addTarget:self action:@selector(selectBut:) forControlEvents:UIControlEventTouchUpInside];
    if ([model.isShow intValue] == 1) {
        //        是否展示（2：默认展示 1：不展示）"
        but.selected = NO;
    }else{
        but.selected = YES;
    }
    but.tag = [model.idid intValue];
    [self.butArr addObject:but];
    
    UILabel *title = [[UILabel alloc] init];
    [view addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.height.mas_equalTo(view);
        make.left.mas_equalTo(but.mas_right).mas_offset(KFit_W6S(15));
        make.width.mas_equalTo(KFit_W6S(400));
    }];
    title.text = [NSString stringWithFormat:@"%@  (%@)",model.schoolName,model.deptName];
    
    UILabel *lb = [[UILabel alloc] init];
    [view addSubview:lb];
    lb.backgroundColor = kColor_N(240, 240, 240);
    [lb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(view);
        make.height.mas_equalTo(1);
    }];
    
    return view;
}

- (void)selectBut:(UIButton *)senter{
    senter.selected = !senter.selected;
}

- (void)queding{
    int i = 0;
    for (UIButton *but in self.butArr) {
        if (but.selected) {
            i = 1;
        }
    }
    if (self.type == 0) {
        
    if (!i) {
        [MBProgressHUD showMsgHUD:@"请选择驾校名称在中天驾考学员端展示"];
        return;
    }
    }
    
    for (int i = 0; i <self.butArr.count; i++) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        UIButton *but = self.butArr[i];
        FMMainModel *model = self.dataArr[i];
//        if (but.selected) {
//            if (!model.perfectStatus) {
//                [MBProgressHUD showMsgHUD:@"只能推广信息已完善的名片"];
//                return;
//            }
//        }
        [dic setObject:model.idid forKey:@"id"];
        [dic setObject:but.selected?@"2":@"1" forKey:@"isShow"];
        [self updatawithdic:dic];
    }
    
    [_vc headerRefresh];
    [self shutDown];
}

- (void)updatawithdic:(NSDictionary *)dic{
    NSString *url;
    if (self.type == 1) {
        url = POSTEnrollInfoExtension;
    }else{
        url = POSTEnrollInfoEdit;
    }
    [MBProgressHUD showLoadingHUD:@"正在提交"];
    [FMNetworkHelper fm_request_postWithUrlString:url isNeedCache:NO parameters:dic successBlock:^(id responseObject) {
        KKLog(@"11111%@",responseObject);
        [MBProgressHUD hideLoadingHUD];
        if ([responseObject[@"code"] intValue] == 200) {
//            XLAlertView *alert = [[XLAlertView alloc] initWithMessage:@"保存成功" SuccessOrFailure:YES];
//            [alert showPrompt];
        }else{
            [MBProgressHUD showMsgHUD:responseObject[@"message"]];
        }
    } failureBlock:^(NSError *error) {
        [MBProgressHUD hideLoadingHUD];
        KKLog(@"%@", error);
        
    } progress:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];
    
}

#pragma mark - 退出
- (void)shutDown{
    [self removeFromSuperview];
}
#pragma mark - 弹出
- (void)show{
    UIWindow *rootWindow = [UIApplication sharedApplication].keyWindow;
    [rootWindow addSubview:self];
    //    [self creatShowAnimation];
}
@end
