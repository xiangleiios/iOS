//
//  CourseV.m
//  MobileProject
//
//  Created by 向蕾 on 2018/8/23.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import "CourseV.h"
#import "LicenseTayeV.h"
#import "UITextView+ZWPlaceHolder.h"



@implementation CourseV

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self loadSubview];
    }
    return self;
}
- (instancetype)initWithDictionary:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        self.dic = dic;
        [self loadSubview];
    }
    return self;
}

- (void)loadSubview{
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    self.backgroundColor = kRGBAColor(0, 0, 0, 0.8);
//    self.contentSize = CGSizeMake(0, SCREEN_HEIGHT+kNavBarH);
//    UIScrollView *scr = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
//    [self addSubview:scr];
    
    _backview = [[UIView alloc] init];
    [self addSubview:_backview];
    _backview.layer.cornerRadius = 5;
    _backview.layer.masksToBounds = YES;
    _backview.backgroundColor = [UIColor whiteColor];
    [_backview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self);
        make.size.mas_equalTo(CGSizeMake(KFit_W6S(640), KFit_H6S(910)));
    }];
    
    XLInformationV *biaoTi;
    if (self.dic) {
        biaoTi = [[XLInformationV alloc] informationWithTitle:@"修改课程"];
    }else{
        biaoTi = [[XLInformationV alloc] informationWithTitle:@"创建课程"];
    }
    [_backview addSubview:biaoTi];
    [biaoTi mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(_backview);
        make.height.mas_equalTo(KFit_H6S(90));
    }];
    
    
    UIButton *down = [[UIButton alloc] init];
    [biaoTi addSubview:down];
    [down addTarget:self action:@selector(shutDown) forControlEvents:UIControlEventTouchUpInside];
    [down setImage:[UIImage imageNamed:@"deletez"] forState:UIControlStateNormal];
    [down mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(_backview).mas_offset(-KFit_W6S(40));
        make.centerY.mas_equalTo(biaoTi);
        make.size.mas_equalTo(CGSizeMake(KFit_W6S(40), KFit_W6S(40)));
    }];
    KKLog(@"%@",self.dic[@"courseName"]);
    
    self.name = [[XLInformationV alloc] informationWithTitle:@"课程名称" SubTitle:[NSString stringWithFormat:@"%@",self.dic[@"courseName"]?self.dic[@"courseName"]:@""] TSSubTitle:@"例如：普通班/VIP班" Must:YES Click:NO];
    [_backview addSubview:self.name];
    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(biaoTi.mas_bottom);
        make.left.right.mas_equalTo(_backview);
        make.height.mas_equalTo(KFit_H6S(90));
    }];
    
    LicenseTayeV *license = [[LicenseTayeV alloc] init];
    [_backview addSubview:license];
    
    kWeakSelf(self)
    license.textBlock = ^(NSString *text) {
        KKLog(@"%@",text);
        weakself.type = text;
    };
    license.dic = self.dic;
    [license mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.name.mas_bottom);
        make.left.right.mas_equalTo(_backview);
        make.height.mas_equalTo(KFit_H6S(225));
    }];
    
    self.price = [[XLInformationV alloc] informationWithTitle:@"课程价格" SubTitle:[NSString stringWithFormat:@"%@",self.dic[@"coursePrice"]?self.dic[@"coursePrice"]:@""] TSSubTitle:@"请输入课程价格" Must:YES Click:NO];
    [_backview addSubview:self.price];
    [self.price mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(license.mas_bottom);
        make.left.right.mas_equalTo(_backview);
        make.height.mas_equalTo(KFit_H6S(90));
    }];
    
    UILabel *jieshao = [[UILabel alloc] init];
    jieshao.text = @"课程介绍";
    [_backview addSubview:jieshao];
    [jieshao mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.price.mas_bottom);
        make.left.mas_equalTo(_backview).mas_offset(KFit_W6S(30));
        make.height.mas_equalTo(KFit_H6S(90));
    }];
    
    
    UIImageView *box = [[UIImageView alloc] init];
    [box setImage:[UIImage imageNamed:@"box"]];
    [_backview addSubview:box];
    [box mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(jieshao.mas_bottom);
        make.left.mas_equalTo(_backview).mas_offset(KFit_W6S(30));
        make.right.mas_equalTo(_backview).mas_offset(-KFit_W6S(30));
        make.height.mas_equalTo(KFit_H6S(180));
        
    }];
    
    
    self.textView = [[UITextView alloc] init];
    self.textView.delegate = self;
    self.textView.backgroundColor = [UIColor clearColor];
    self.textView.font = [UIFont systemFontOfSize:kFit_Font6(16)];
    self.textView.placeholder = @"请填写课程介绍，例如：周一至周日，随到随学";
    self.textView.text = _dic[@"courseIntroduce"];
    [_backview addSubview:self.textView];
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(box).mas_offset(KFit_W6S(20));
        make.right.bottom.mas_equalTo(box).mas_offset(-KFit_W6S(20));
    }];
    
    if (self.dic) {
        UIButton *change = [[UIButton alloc] init];
        [_backview addSubview:change];
        [change setTitle:@"修改" forState:UIControlStateNormal];
        [change setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [change addTarget:self action:@selector(toChange) forControlEvents:UIControlEventTouchUpInside];
        change.backgroundColor = kColor_N(0, 104, 215);
        change.layer.cornerRadius = 5;
        change.layer.masksToBounds = YES;
        
        UIButton *share = [[UIButton alloc] init];
        [_backview addSubview:share];
        [share setTitle:@"删除" forState:UIControlStateNormal];
        [share setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [share addTarget:self action:@selector(deleteCoures) forControlEvents:UIControlEventTouchUpInside];
        share.backgroundColor = kColor_N(148, 160, 181);
        share.layer.cornerRadius = 5;
        share.layer.masksToBounds = YES;
        
        NSArray *arr = @[change,share];
        [arr mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:KFit_W6S(30) leadSpacing:KFit_W6S(30) tailSpacing:KFit_W6S(30)];
        [arr mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(_backview).mas_offset(-KFit_H6S(30));
            make.height.mas_equalTo(KFit_H6S(90));
        }];
    }else{
        UIButton *next = [[UIButton alloc] init];
        [_backview addSubview:next];
        [next setTitle:@"创建" forState:UIControlStateNormal];
        [next addTarget:self action:@selector(create) forControlEvents:UIControlEventTouchUpInside];
        next.backgroundColor = kColor_N(0, 112, 234);
        [next setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        next.layer.cornerRadius = 5;
        next.layer.masksToBounds = YES;
        [next mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_backview).mas_offset(KFit_W6S(30));
            make.right.mas_equalTo(_backview).mas_offset(-KFit_W6S(30));
            make.bottom.mas_equalTo(_backview).mas_offset(-KFit_W6S(30));
            make.height.mas_equalTo(KFit_H6S(90));
        }];
    }
    
}

#pragma mark - 删除
- (void)deleteCoures{
    [MBProgressHUD showLoadingHUD:@"正在删除"];
//    NSString *url = POSTClassTypeRemove;
    NSString *url1 = [NSString stringWithFormat:@"%@?ids=%@",POSTClassTypeRemove,self.dic[@"id"]];
    [FMNetworkHelper fm_request_getWithUrlString:url1 isNeedCache:NO parameters:nil successBlock:^(id responseObject) {
        KKLog(@"11111%@",responseObject);
        [MBProgressHUD hideLoadingHUD];
        if ([responseObject[@"code"] intValue] == 200) {
            XLAlertView *alert = [[XLAlertView alloc] initWithMessage:@"课程删除成功"];
            [alert showPrompt];
            [self.vc refreshData];
            [self shutDown];
        }else{
            [MBProgressHUD showMsgHUD:responseObject[@"message"]];
        }
    } failureBlock:^(NSError *error) {
        [MBProgressHUD hideLoadingHUD];
        KKLog(@"%@", error);
    } progress:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];
    
}

#pragma mark - 修改
- (void)toChange{
    if (self.name.subfield.text.length <= 0) {
        [MBProgressHUD showMsgHUD:@"请输入课程名"];
        return;
    }
    if (self.price.subfield.text.length <= 0) {
        [MBProgressHUD showMsgHUD:@"请输入课程价格"];
        return;
    }
    if (self.type.length <= 0) {
        [MBProgressHUD showMsgHUD:@"请选择驾照类型"];
        return;
    }
    if (![XLCommonUse isPureNum:self.price.subfield.text]) {
        [MBProgressHUD showMsgHUD:@"课程价格必须为数字"];
        return;
    }
    if (self.price.subfield.text.length > 10) {
        [MBProgressHUD showMsgHUD:@"课程价格不能超过10位字符"];
        return;
    }
    [MBProgressHUD showLoadingHUD:@"正在修改"];
    NSString *url = POSTClassTypeEdit;
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:self.dic[@"id"] forKey:@"id"];
    [dic setObject:self.idid forKey:@"enrollId"];
    [dic setObject:self.name.subfield.text forKey:@"courseName"];
    [dic setObject:self.type forKey:@"licenseType"];
    [dic setObject:self.price.subfield.text forKey:@"coursePrice"];
    [dic setObject:self.textView.text forKey:@"courseIntroduce"];
    [FMNetworkHelper fm_request_postWithUrlString:url isNeedCache:NO parameters:dic successBlock:^(id responseObject) {
        KKLog(@"11111%@",responseObject);
        [MBProgressHUD hideLoadingHUD];
        if ([responseObject[@"code"] intValue] == 200) {
            XLAlertView *alert = [[XLAlertView alloc] initWithMessage:@"课程修改成功"];
            [alert showPrompt];
            [self.vc refreshData];
            [self shutDown];
        }else{
            [MBProgressHUD showMsgHUD:responseObject[@"message"]];
        }
    } failureBlock:^(NSError *error) {
        [MBProgressHUD hideLoadingHUD];
        KKLog(@"%@", error);
        
    } progress:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];
}
#pragma mark - 创建
- (void)create{
    if (self.name.subfield.text.length <= 0) {
        [MBProgressHUD showMsgHUD:@"请输入课程名"];
        return;
    }
    if (self.name.subfield.text.length >= 11) {
        [MBProgressHUD showMsgHUD:@"课程名最多不能超过10个"];
        return;
    }
    if (self.price.subfield.text.length <= 0) {
        [MBProgressHUD showMsgHUD:@"请输入课程价格"];
        return;
    }
    if (![XLCommonUse isPureNum:self.price.subfield.text]) {
        [MBProgressHUD showMsgHUD:@"课程价格必须为数字"];
        return;
    }
    if (self.price.subfield.text.length > 10) {
        [MBProgressHUD showMsgHUD:@"课程价格不能超过10位字符"];
        return;
    }
    if (self.type.length <= 0) {
        [MBProgressHUD showMsgHUD:@"请选择驾照类型"];
        return;
    }
    [MBProgressHUD showLoadingHUD:@"正在创建课程"];
    NSString *url = POSTClassTypeAdd;
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
//    [dic setObject:self.dic[@"id"] forKey:@"id"];
    [dic setObject:self.idid forKey:@"enrollId"];
    [dic setObject:self.name.subfield.text forKey:@"courseName"];
    [dic setObject:self.type forKey:@"licenseType"];
    [dic setObject:self.price.subfield.text forKey:@"coursePrice"];
    [dic setObject:self.textView.text forKey:@"courseIntroduce"];
    [FMNetworkHelper fm_request_postWithUrlString:url isNeedCache:NO parameters:dic successBlock:^(id responseObject) {
        KKLog(@"11111%@",responseObject);
        [MBProgressHUD hideLoadingHUD];
        if ([responseObject[@"code"] intValue] == 200) {
            XLAlertView *alert = [[XLAlertView alloc] initWithMessage:@"课程创建成功"];
            [alert showPrompt];
            [self.vc refreshData];
            [self shutDown];
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

- (void)textViewDidBeginEditing:(UITextView *)textView{
    [UIView animateWithDuration:0.5 animations:^{
        [_backview mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self);
            make.centerY.mas_equalTo(self).mas_offset(-KFit_H6S(260));
            make.size.mas_equalTo(CGSizeMake(KFit_W6S(640), KFit_H6S(910)));
        }];
    }];
    
    
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    [UIView animateWithDuration:0.5 animations:^{
        [_backview mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(self);
            make.size.mas_equalTo(CGSizeMake(KFit_W6S(640), KFit_H6S(910)));
        }];
    }];
}
@end
