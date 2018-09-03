//
//  QrCodeVC.m
//  MobileProject
//
//  Created by 向蕾 on 2018/8/28.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import "QrCodeVC.h"
#import "CodeShareV.h"
#import "UIImage+FMQrcodeBarcode.h"
@interface QrCodeVC ()
@property (nonatomic , strong)UIImageView *headimg;
@property (nonatomic , strong)UILabel *titlelb;
@property (nonatomic , strong)UILabel *subtitle;

@property (nonatomic , strong)UIImageView *cordimg;
@end

@implementation QrCodeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationView setTitle:@"中天驾考"];
    kWeakSelf(self)
    [self.navigationView addRightButtonWithImage:kImage(@"share_icon") hightImage:kImage(@"share_icon_down") clickCallBack:^(UIView *view) {
        [weakself share];
    }];
    self.view.backgroundColor = kColor_N(240, 240, 240);
    
    [self loadSubview];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadSubview{
    UIView *v = [[UIView alloc] init];
    [self.view addSubview:v];
    v.backgroundColor = [UIColor whiteColor];
    [v mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).mas_offset(KFit_H6S(60));
        make.top.mas_equalTo(self.view).mas_offset(KFit_H6S(60)+kNavBarH);
        make.right.mas_equalTo(self.view).mas_offset(-KFit_H6S(60));
        make.height.mas_equalTo(KFit_H6S(310));
    }];
    
    self.headimg = [[UIImageView alloc] init];
    [v addSubview:self.headimg];
    [self.headimg setImage:[UIImage imageNamed:@"pacture_nor"]];
    self.headimg.layer.cornerRadius = KFit_W6S(70);
    self.headimg.layer.masksToBounds = YES;
    [self.headimg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(v);
        make.top.mas_equalTo(v).mas_offset(KFit_H6S(30));
        make.height.width.mas_equalTo(KFit_W6S(140));
    }];
    
    self.titlelb = [[UILabel alloc] init];
    [v addSubview:self.titlelb];
    self.titlelb.text = @"向蕾";
    self.titlelb.font = [UIFont systemFontOfSize:kFit_Font6(19) weight:0.5];
    self.titlelb.textAlignment = NSTextAlignmentCenter;
    [self.titlelb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.headimg.mas_bottom).mas_offset(KFit_H6S(20));
        make.centerX.mas_equalTo(self.headimg);
        make.width.mas_equalTo(KFit_W6S(400));
        make.height.mas_equalTo(KFit_H6S(40));
    }];
    
    self.subtitle = [[UILabel alloc] init];
    [v addSubview:self.subtitle];
    self.subtitle.text = @"明安驾校（光谷校区）";
    self.subtitle.font = [UIFont systemFontOfSize:kFit_Font6(15)];
    self.subtitle.textColor = kColor_N(147, 151, 163);
    self.subtitle.textAlignment = NSTextAlignmentCenter;
    [self.subtitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titlelb.mas_bottom).mas_offset(KFit_H6S(10));
        make.centerX.mas_equalTo(self.headimg);
        make.width.mas_equalTo(KFit_W6S(400));
        make.height.mas_equalTo(KFit_H6S(40));
    }];
    
    
    UIView *backv = [[UIView alloc] init];
    [self.view addSubview:backv];
    backv.backgroundColor = [UIColor whiteColor];
    [backv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(v.mas_bottom).mas_offset(KFit_H6S(20));
        make.left.right.mas_equalTo(v);
        make.bottom.mas_equalTo(self.view).mas_offset(-KFit_H6S(60));
    }];
    
    UILabel *ts = [[UILabel alloc] init];
    [backv addSubview:ts];
    ts.numberOfLines = 0;
    ts.font = [UIFont systemFontOfSize:kFit_Font6(15)];
    ts.textColor = kColor_N(147, 151, 163);
    ts.text = @"1、学员打开微信\n2、点击右上角“+”号，打开“扫一扫\n3、扫描二维码即可自行添加成为您的学员”";
    [ts mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(backv).mas_offset(KFit_W6S(30));
        make.right.bottom.mas_equalTo(backv).mas_offset(-KFit_W6S(30));
        
    }];
    
    self.cordimg = [[UIImageView alloc] init];
    [backv addSubview:self.cordimg];

    [self.cordimg setImage:[UIImage getQRWithString:@"https://blog.csdn.net/yyh3663477/article/details/48579247" size:KFit_W6S(400) foreColor:[UIColor blackColor] logoImage:[UIImage imageNamed:@"erwim_ewm"] logoRadius:KFit_W6S(40)]];
    [self.cordimg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(backv);
        make.top.mas_equalTo(backv).mas_offset(KFit_H6S(50));
        make.width.height.mas_equalTo(KFit_W6S(400));
    }];
    
}

- (void)share{
    
    CodeShareV *v = [[CodeShareV alloc] init];
    [v show];
    
//    XLshare *share = [[XLshare alloc]init];
//    share.title = @"淘电宝，您身边的售电专家";
//    share.image_url = @"http://tdb.asia-cloud.com/uploads/images/2018/0702/20180702105337108.png";
//    share.subTitle = @"邀请您使用淘电宝APP，欢迎下载使用，注册有礼哦~~";
//    if ([User UserOb].UserLogin) {
//        share.url = [NSString stringWithFormat:URLMemberInviteUID,[User UserOb].idid];
//    }else{
//        share.url = URLMemberInvite;
//    }
//    
//    [share umengShare:self.view];
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
