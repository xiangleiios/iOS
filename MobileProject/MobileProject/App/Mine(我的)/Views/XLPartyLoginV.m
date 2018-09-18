//
//  XLPartyLoginV.m
//  MobileProject
//
//  Created by zsgy on 17/7/24.
//  Copyright © 2017年 ZSGY. All rights reserved.
//

#import "XLPartyLoginV.h"
//#import "WeiboSDK.h"
#import "WXApi.h"
#import <TencentOpenAPI/TencentOAuth.h>
#import "FMPlatformHelper.h"
#import "FMShare.h"
#import "JPUSHService.h"
//#import "PerfectInformation.h"
#import "UIWebView+FMSetTonkenToCookie.h"

@implementation XLPartyLoginV

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self AddbuttonLayout];
        
        [self line];
        
        
        
    }
    return self;
}

- (void)line{
    UILabel *ts=[[UILabel alloc]init];
    ts.textColor=kRGBColor(222, 222, 222);
    ts.font=[UIFont systemFontOfSize:kFit_Font6(13)];
    ts.text=@"使用以下账号登录";
    ts.textAlignment=NSTextAlignmentCenter;
    [self addSubview:ts];
    [ts mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.centerX.mas_equalTo(self);
        make.height.mas_equalTo(KFit_H6P(40));
        make.width.mas_equalTo(KFit_H6S(250));
    }];
    
    UILabel *three=[[UILabel alloc]init];
    [self addSubview:three];
    three.backgroundColor=kRGBColor(222, 222, 222);
    [three mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).mas_offset(KFit_W6S(60));
        make.right.mas_equalTo(ts.mas_left).mas_equalTo(-KFit_W6P(35));
        make.centerY.mas_equalTo(ts);
        make.height.mas_equalTo(1);
    }];
    
    
    UILabel *two=[[UILabel alloc]init];
    [self addSubview:two];
    two.backgroundColor=kRGBColor(222, 222, 222);;
    [two mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self).mas_offset(-KFit_W6S(60));
        make.left.mas_equalTo(ts.mas_right).mas_equalTo(KFit_W6P(35));
        make.centerY.mas_equalTo(ts);
        make.height.mas_equalTo(1);
    }];
    
    
    
}

- (void)AddbuttonLayout{
    _logBttQQ  = [[UIButton alloc] init];
    [_logBttQQ setImage:[UIImage imageNamed:@"qq"] forState:UIControlStateNormal];
//    [_logBttQQ setTitle:@"QQ登录" forState:UIControlStateNormal];
    [_logBttQQ setTitleColor:[UIColor colorWithRed:0.325 green:0.580 blue:0.843 alpha:1.000] forState:UIControlStateNormal];
    [_logBttQQ.titleLabel setFont:[UIFont systemFontOfSize:kFit_Font6(13)]];
    [_logBttQQ addTarget:self action:@selector(logBttQQAction:) forControlEvents:UIControlEventTouchUpInside ];
    [self addSubview:_logBttQQ];
    
    _logBttWX  = [[UIButton alloc] init];
    [_logBttWX setImage:[UIImage imageNamed:@"wechat"] forState:UIControlStateNormal];
//    [_logBttWX setTitle:@"微信登录" forState:UIControlStateNormal];
    [_logBttWX setTitleColor:[UIColor colorWithRed:0.145 green:0.522 blue:0.106 alpha:1.000] forState:UIControlStateNormal];
    [_logBttWX.titleLabel setFont:[UIFont systemFontOfSize:kFit_Font6(13)]];
    [_logBttWX addTarget:self action:@selector(logBttWXAction:) forControlEvents:UIControlEventTouchUpInside ];
    [self addSubview:_logBttWX];
    
//    _logBttWB  = [[UIButton alloc] init];
//    [_logBttWB setImage:[UIImage imageNamed:@"wb"] forState:UIControlStateNormal];
////    [_logBttWB setTitle:@"微博登录" forState:UIControlStateNormal];
//    [_logBttWB setTitleColor:[UIColor colorWithRed:0.953 green:0.494 blue:0.110 alpha:1.000] forState:UIControlStateNormal];
//    [_logBttWB.titleLabel setFont:[UIFont systemFontOfSize:kFit_Font6(13)]];
//    [_logBttWB addTarget:self action:@selector(logBttSinaAction:) forControlEvents:UIControlEventTouchUpInside ];
//    [self addSubview:_logBttWB];
//    
    NSMutableArray *bttArr = [[NSMutableArray alloc] init];
    
    
//    if ([WeiboSDK isWeiboAppInstalled])    [bttArr addObject:_logBttWB];
    if ([WXApi isWXAppInstalled])          {
        
        [bttArr addObject:_logBttWX];
    }
    if ([TencentOAuth iphoneQQInstalled])  [bttArr addObject:_logBttQQ];
    
    NSArray *arr = [NSArray arrayWithArray:bttArr];
    
    if (arr.count) {
        if (arr.count == 1) {
            [arr[0] mas_makeConstraints:^(MASConstraintMaker *make) {
                make.center.equalTo(self);
                make.size.mas_equalTo(CGSizeMake(KFit_W6S(90), KFit_W6S(90)));
            }];
        } else {
            [arr mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedItemLength:KFit_W6S(90) leadSpacing:(kScreenW - bttArr.count * KFit_W6S(90))/(bttArr.count+1) tailSpacing:(kScreenW - bttArr.count * KFit_W6S(90))/(bttArr.count+1)];
            
            
            [arr mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(self);
                make.height.mas_equalTo(KFit_W6S(90));
            }];
        }
        
    }else{
        
//        labT.hidden = YES;
//        imgL.hidden = YES;
//        imgR.hidden = YES;
    }

}


#pragma mark - QQ登录
- (void)logBttQQAction:(UIButton *)sender {
    __weak typeof(self)weakSelf = self;
    if(![FMPlatformHelper installPlatAppWithType:FMSocialPlatformType_QQ])
    {
//        [weakSelf showResult:@"没有安装QQ软件,将此功能隐藏"];
        return;
    }
    
    [FMPlatformHelper getUserInfoWithPlatform:FMSocialPlatformType_QQ withCompletion:^(UMSocialUserInfoResponse *userinfo,NSString *name, NSString *iconUrl, NSString *gender, NSError *error) {
        if (error && [userinfo isKindOfClass:[NSNull class]]) {
            KKLog(@"出错了");
            return;
        }
        
        
        [self DSFloginURL:[NSString stringWithFormat:GETmembersExlogin,userinfo.uid,[userinfo.name stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],userinfo.iconurl,@"qq"] accountType:accountTypeQQ];
    }];
}

#pragma mark - 微信登录
- (void)logBttWXAction:(UIButton *)sender {
    __weak typeof(self)weakSelf = self;
    
    //
    [FMPlatformHelper getUserInfoWithPlatform:FMSocialPlatformType_WechatSession withCompletion:^(UMSocialUserInfoResponse *userinfo,NSString *name, NSString *iconUrl, NSString *gender, NSError *error) {
        if (error && [userinfo isKindOfClass:[NSNull class]]) {
            KKLog(@"出错了");
            return;
        }
        KKLog(@"%@",userinfo);
        [self DSFloginURL:[NSString stringWithFormat:GETmembersExlogin,userinfo.uid,[userinfo.name stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],userinfo.iconurl,@"wx"] accountType:accountTypeWX];
    }];
    
}

#pragma mark - 微博登录
- (void)logBttSinaAction:(UIButton *)sender {
    KKLog(@"⚠️⚠️⚠️⚠️⚠️⚠️\n %s 第%d行 \n",__func__,__LINE__);
    
    KKLog(@"新浪登录 要把程序的Bundle ID跟回调页面都对应上才可以，否则会出现弹出又马上消失的情况，可以用官网的Bundle ID测试");
    __weak typeof(self)weakSelf = self;
    
    [FMPlatformHelper getUserInfoWithPlatform:FMSocialPlatformType_Sina withCompletion:^(UMSocialUserInfoResponse *userinfo,NSString *name, NSString *iconUrl, NSString *gender, NSError *error) {
        if (error && [userinfo isKindOfClass:[NSNull class]]) {
            KKLog(@"出错了");
            return;
        }
        KKLog(@">@>>>>>>>>>>>:%@",userinfo.uid);
        
        
        [self DSFloginURL:[NSString stringWithFormat:GETmembersExlogin,[NSString stringWithFormat:@"wb%@",userinfo.uid],[userinfo.name stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],userinfo.iconurl,@"wb"] accountType:accountTypeWB];
    }];
    
}


#pragma mark-调用第三方登录接口
- (void)DSFloginURL:(NSString *)url accountType:(accountType) type{
    MBProgressHUD *hud=[MBProgressHUD showMessage:@"正在登陆" ToView:self.vc.view];
    [FMNetworkHelper fm_request_getWithUrlString:url isNeedCache:NO parameters:nil successBlock:^(id responseObject) {
        [hud hide:YES];
        if (kResponseObjectStatusCodeIsEqual(200)) {
            [MBProgressHUD showAutoMessage:@"登陆成功"];
            [UIWebView fm_setTokenToUIWebViewCookie]; //存token到域名cookie
            User *user = [User UserOb];
            user.accounttype = [NSNumber numberWithInteger:type];
            NSDictionary *dic = responseObject[@"data"];
            if ([dic[@"mobile"] isEqual:@""]) {
                
            }else{
                [user UserSave:dic];
                [self.vc.navigationController popViewControllerAnimated:YES];
            }
        }else{
            [MBProgressHUD showAutoMessage:responseObject[@"message"]];
        }
        KKLog(@"登录返回的成功信息--------->%@", responseObject);
    } failureBlock:^(NSError *error) {
        [hud hide:YES];
    } progress:nil];
    
}







@end
