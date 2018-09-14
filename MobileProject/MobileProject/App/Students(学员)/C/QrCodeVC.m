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
//@property (nonatomic , strong)UIImageView *headimg;
//@property (nonatomic , strong)UILabel *titlelb;
//@property (nonatomic , strong)UILabel *subtitle;
@property (nonatomic , strong)NSMutableArray <FMMainModel *>*dataArr;
//@property (nonatomic , strong)UIImageView *cordimg;
@property (nonatomic , strong)UIScrollView *scroll;
@end

@implementation QrCodeVC

- (NSMutableArray *)dataArr{
    if (_dataArr==nil) {
        _dataArr=[NSMutableArray array];
    }
    return _dataArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationView setTitle:@"中天驾考"];
    kWeakSelf(self)
//    [self.navigationView addRightButtonWithImage:kImage(@"share_icon") hightImage:kImage(@"share_icon_down") clickCallBack:^(UIView *view) {
//        [weakself share];
//    }];
    self.view.backgroundColor = kColor_N(240, 240, 240);
    [self loadScrollview];
    [self loadRefreshData];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadScrollview{
    self.scroll = [[UIScrollView alloc] init];
    [self.view addSubview:self.scroll];
    [self.scroll mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view).mas_offset(kNavBarH);
    }];
    
}


- (UIView *)loadSubviewWith:(FMMainModel *)model{
    UIView *backview = [[UIView alloc] init];
    backview.backgroundColor = kColor_N(240, 240, 240);
    
    
//    [_img sd_setImageWithURL:[NSURL URLWithString:_model.headImg] placeholderImage:[UIImage imageNamed:@"pacture_nor"]];
//    self.title.text = _model.schoolName;
//    self.name.text = [NSString stringWithFormat:@"%@  %@",_model.name,_model.enrollPhone];
//    self.titleSub.text = [NSString stringWithFormat:@"(%@)",_model.deptName];
    
    
    UIView *v = [[UIView alloc] init];
    [backview addSubview:v];
    v.backgroundColor = [UIColor whiteColor];
    [v mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(backview).mas_offset(KFit_H6S(60));
        make.top.mas_equalTo(backview).mas_offset(KFit_H6S(60));
        make.right.mas_equalTo(backview).mas_offset(-KFit_H6S(60));
        make.height.mas_equalTo(KFit_H6S(310));
    }];
    
    UIImageView *img = [[UIImageView alloc] init];
    [v addSubview:img];
//    [img setImage:[UIImage imageNamed:@"pacture_nor"]];
    [img sd_setImageWithURL:[NSURL URLWithString:model.headImg] placeholderImage:[UIImage imageNamed:@"pacture_nor"]];
    img.layer.cornerRadius = KFit_W6S(70);
    img.layer.masksToBounds = YES;
    [img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(v);
        make.top.mas_equalTo(v).mas_offset(KFit_H6S(30));
        make.height.width.mas_equalTo(KFit_W6S(140));
    }];
    
    UILabel *name = [[UILabel alloc] init];
    [v addSubview:name];
    name.text = model.name;
    name.font = [UIFont systemFontOfSize:kFit_Font6(19) weight:0.5];
    name.textAlignment = NSTextAlignmentCenter;
    [name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(img.mas_bottom).mas_offset(KFit_H6S(20));
        make.centerX.mas_equalTo(img);
        make.width.mas_equalTo(KFit_W6S(400));
        make.height.mas_equalTo(KFit_H6S(40));
    }];
    
    UILabel *jiaxiao = [[UILabel alloc] init];
    [v addSubview:jiaxiao];
    jiaxiao.text = [NSString stringWithFormat:@"%@ (%@)",model.schoolName,model.deptName];
    jiaxiao.font = [UIFont systemFontOfSize:kFit_Font6(15)];
    jiaxiao.textColor = kColor_N(147, 151, 163);
    jiaxiao.textAlignment = NSTextAlignmentCenter;
    [jiaxiao mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(name.mas_bottom).mas_offset(KFit_H6S(10));
        make.centerX.mas_equalTo(img);
        make.width.mas_equalTo(KFit_W6S(400));
        make.height.mas_equalTo(KFit_H6S(40));
    }];
    
    
    UIView *backv = [[UIView alloc] init];
    [backview addSubview:backv];
    backv.backgroundColor = [UIColor whiteColor];
    [backv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(v.mas_bottom).mas_offset(KFit_H6S(20));
        make.left.right.mas_equalTo(v);
        make.bottom.mas_equalTo(backview).mas_offset(-KFit_H6S(60));
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
    
    UIImageView *cordimg = [[UIImageView alloc] init];
    [backv addSubview:cordimg];

    [cordimg setImage:[UIImage getQRWithString:@"https://blog.csdn.net/yyh3663477/article/details/48579247" size:KFit_W6S(400) foreColor:[UIColor blackColor] logoImage:[UIImage imageNamed:@"erwim_ewm"] logoRadius:KFit_W6S(40)]];
    [cordimg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(backv);
        make.top.mas_equalTo(backv).mas_offset(KFit_H6S(50));
        make.width.height.mas_equalTo(KFit_W6S(400));
    }];
    
    
    return backview;
}

- (void)share{
    CodeShareV *v = [[CodeShareV alloc] init];
    [v show];
    
}

- (void)loadRefreshData{
    NSString *url = POSTEnrollInfoList;
    [FMNetworkHelper fm_setValue:[User UserOb].token forHTTPHeaderKey:@"token"];
    [FMNetworkHelper fm_setValue:@"Mobile" forHTTPHeaderKey:@"loginType"];
    [FMNetworkHelper fm_request_postWithUrlString:url isNeedCache:NO parameters:nil successBlock:^(id responseObject) {
        KKLog(@"%@",responseObject);
        NSArray *tpArray = responseObject[@"list"];
        
        if (tpArray) {
            for (NSDictionary *dic in tpArray) {
                FMMainModel *mode=[FMMainModel mj_objectWithKeyValues:dic];
                [self.dataArr addObject:mode];
            }
        }
        [self loadsub];
    } failureBlock:^(NSError *error) {
        KKLog(@"%@", error);
        
    } progress:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];
    //    POSTTeamSchoolList
}


- (void)loadsub{
    for (int i = 0; i < self.dataArr.count; i++) {
        UIView *v = [self loadSubviewWith:self.dataArr[i]];
        v.frame = CGRectMake(i *SCREEN_WIDTH, 0, SCREEN_WIDTH, self.scroll.size.height);
        [self.scroll addSubview:v];
    }
    self.scroll.contentSize = CGSizeMake(self.dataArr.count * SCREEN_WIDTH, 0);
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
