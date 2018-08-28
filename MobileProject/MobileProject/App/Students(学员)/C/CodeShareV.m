//
//  CodeShareV.m
//  MobileProject
//
//  Created by 向蕾 on 2018/8/28.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import "CodeShareV.h"

@interface CodeShareV ()<PagingButtonViewDelegate>

@end

@implementation CodeShareV

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


- (void)loadSubview{
    self.frame = [UIScreen mainScreen].bounds;
    self.backgroundColor = kRGBAColor(0, 0, 0, 0.8);
    
    UIView *bacview = [[UIView alloc] init];
    [self addSubview:bacview];
    bacview.layer.cornerRadius = 5;
    bacview.layer.masksToBounds = YES;
    bacview.backgroundColor = [UIColor whiteColor];
    [bacview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.top.mas_equalTo(self).mas_offset(KFit_H6S(240));
        make.size.mas_equalTo(CGSizeMake(KFit_W6S(540), KFit_H6S(790)));
    }];
    UIImageView *img = [[UIImageView alloc] init];
    [bacview addSubview:img];
    [img setImage:[UIImage imageNamed:@"erweima"]];
    [img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(bacview);
        make.top.mas_equalTo(bacview).mas_offset(KFit_H6S(60));
        make.width.height.mas_equalTo(KFit_W6S(158));
    }];
    
    UILabel *lb = [[UILabel alloc] init];
    [bacview addSubview:lb];
    lb.text = @"分享报名二维码";
    lb.textColor = kColor_N(73, 85, 114);
    lb.textAlignment = NSTextAlignmentCenter;
    [lb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(bacview);
        make.top.mas_equalTo(img.mas_bottom).mas_offset(KFit_H6S(30));
        make.height.mas_equalTo(KFit_H6S(30));
    }];
    
    UILabel *lbt = [[UILabel alloc] init];
    [bacview addSubview:lbt];
    lbt.backgroundColor = kColor_N(240, 240, 240);
    [lbt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(bacview);
        make.top.mas_equalTo(lb.mas_bottom).mas_offset(KFit_H6S(50));
        make.height.mas_equalTo(1);
    }];
    
    
    NSArray *imgarr = @[@"enjoy_pengyouq",@"enjoy_weixin",@"enjoy_kongq",@"enjoy_qq",@"enjoy_weib"];
    NSArray *titlearr = @[@"朋友圈",@"微信好友",@"QQ空间",@"QQ好友",@"微博"];
    self.pagingScr = [[PagingButtonView alloc] init];
    _pagingScr.pageControlStyle = PageControlStyleHiden;
    _pagingScr.pagingRow = 2; //设置行，不设置默认2行
    _pagingScr.pagingColumn = 3; //设置列 不设置默认4列
    [_pagingScr yfm_createPagingButtonViewWithFrame:CGRectMake(0, KFit_H6S(360),KFit_W6S(540),KFit_H6S(370))  showToSuperView:bacview delegate:self iconUrlsOrNamesArr:imgarr buttonTextColorArrOrOneColor:nil buttonTitleArray:titlearr];
    
    UIButton *but = [[UIButton alloc] init];
    [self addSubview:but];
    [but setImage:[UIImage imageNamed:@"delete_icon"] forState:UIControlStateNormal];
    [but addTarget:self action:@selector(shutDown) forControlEvents:UIControlEventTouchUpInside];
    [but mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(bacview.mas_bottom).mas_offset(KFit_H6S(30));
        make.centerX.mas_equalTo(self);
        make.width.height.mas_equalTo(KFit_W6S(114));
    }];
}
- (void)PagingButtonView:(PagingButtonView *)actionView clickButtonWithIndex:(NSInteger)index {
    XLshare *share = [[XLshare alloc]init];
    share.title = @"淘电宝，您身边的售电专家";
    share.image_url = @"http://tdb.asia-cloud.com/uploads/images/2018/0702/20180702105337108.png";
    share.subTitle = @"邀请您使用淘电宝APP，欢迎下载使用，注册有礼哦~~";
    share.url = [NSString stringWithFormat:URLMemberInviteUID,[User UserOb].idid];

    switch (index) {
        case 0:{
            //朋友圈
            [share shareWebPageToPlatformType:UMSocialPlatformType_WechatTimeLine];
            [self shutDown];
            return;
        }
            break;
        case 1:{
            [share shareWebPageToPlatformType:UMSocialPlatformType_WechatSession];
            [self shutDown];
            return;
        }
            break;
        case 2:{
            [share shareWebPageToPlatformType:UMSocialPlatformType_Qzone];
            [self shutDown];
            return;
        }
            break;
        case 3:{
            [share shareWebPageToPlatformType:UMSocialPlatformType_QQ];
            [self shutDown];
            return;
        }
            break;
            
        default:
            break;
    }
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
