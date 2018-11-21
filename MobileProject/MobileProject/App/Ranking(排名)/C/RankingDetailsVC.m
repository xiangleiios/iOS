//
//  RankingDetailsVC.m
//  MobileProject
//
//  Created by 向蕾 on 2018/11/21.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import "RankingDetailsVC.h"
#import "TaskV.h"
@interface RankingDetailsVC ()
@property (nonatomic , strong)UIScrollView *scroll;
@property (nonatomic , strong)XLView *backView;
@end

@implementation RankingDetailsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationView setTitle:@"排名"];
    [self loadSubview];
    // Do any additional setup after loading the view.
}

- (void)loadSubview{
    self.scroll = [[UIScrollView alloc] init];
    [self.view addSubview:self.scroll];
    [self.scroll mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view).mas_offset(kNavBarH);
    }];
    
    self.backView = [[XLView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [self.scroll addSubview:self.backView];
    
    UIImageView *img = [[UIImageView alloc] init];
    [self.backView addSubview:img];
    [img setImage:[UIImage imageNamed:@"nor_fenxiao_photo"]];
    [img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.backView).mas_offset(KFit_H6S(40));
        make.left.mas_equalTo(self.backView).mas_offset(KFit_H6S(30));
        make.size.mas_equalTo(CGSizeMake(KFit_W6S(150), KFit_H6S(120)));
    }];
    
    UILabel *title = [[UILabel alloc] init];
    title.text = [NSString stringWithFormat:@"%@ (%@)",_model.deptFatherName,_model.name];
    [self.backView addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(img).mas_offset(KFit_H6S(10));
        make.left.mas_equalTo(img.mas_right).mas_offset(KFit_W6S(30));
        make.height.mas_equalTo(KFit_H6S(40));
        make.width.mas_equalTo(KFit_W6S(400));
    }];
    
    UILabel *lb = [[UILabel alloc] init];
    [self.backView addSubview:lb];
    lb.text = [NSString stringWithFormat:@"排名:武汉市排名第"];
    lb.textColor = ZTColor;
    lb.font = [UIFont systemFontOfSize:kFit_Font6(16)];
    [lb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(img).mas_offset(-KFit_H6S(10));
        make.height.mas_equalTo(KFit_H6S(40));
        make.left.mas_equalTo(img.mas_right).mas_offset(KFit_W6S(30));
        make.right.mas_equalTo(self.backView);
    }];
    UILabel *line = [[UILabel alloc] init];
    [self.backView addSubview:line];
    line.backgroundColor = kColor_N(240, 240, 240);
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.mas_equalTo(self.backView);
        make.top.mas_equalTo(img.mas_bottom).mas_offset(KFit_H6S(40));
        make.height.mas_equalTo(1);
    }];
    
    UILabel *fen = [[UILabel alloc] init];
    [self.backView addSubview:fen];
    fen.textColor = kColor_N(0, 100, 233);
    fen.text = @"57分";
    fen.font = [UIFont systemFontOfSize:kFit_Font6(20)];
    [fen mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.backView).mas_offset(KFit_W6S(30));
        make.height.mas_equalTo(KFit_H6S(90));
        make.top.mas_equalTo(line.mas_bottom);
        make.width.mas_equalTo(KFit_W6S(200));
    }];
    
    UIButton *but = [[UIButton alloc] init];
    [self.backView addSubview:but];
    [but setTitle:@"积分明细 >" forState:UIControlStateNormal];
    [but setTitleColor:ZTColor forState:UIControlStateNormal];
    but.titleLabel.font = [UIFont systemFontOfSize:kFit_Font6(16)];
    [but mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.backView).mas_offset(-KFit_W6S(30));
        make.centerY.mas_equalTo(fen);
        make.height.mas_equalTo(KFit_H6S(90));
        make.width.mas_equalTo(KFit_W6S(200));
    }];
    
    XLView *bgtwo = [[XLView alloc] init];
    [self.backView addSubview:bgtwo];
    bgtwo.backgroundColor = kColor_N(240, 240, 240);
    [bgtwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.backView);
        make.top.mas_equalTo(fen.mas_bottom);
        make.height.mas_equalTo(KFit_H6S(1300));
    }];
    self.backView.frame = CGRectMake(0, 0, SCREEN_WIDTH, [self.backView getLayoutCellHeight]);
    self.scroll.contentSize = CGSizeMake(0, [self.backView getLayoutCellHeight]);
    
    XLView *bgthree = [[XLView alloc] init];
    [bgtwo addSubview:bgthree];
    bgthree.backgroundColor = [UIColor whiteColor];
    bgthree.layer.cornerRadius = 5;
    
    [bgthree mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(bgtwo).mas_offset(KFit_W6S(30));
        make.right.mas_equalTo(bgtwo).mas_offset(-KFit_W6S(30));
        make.top.mas_equalTo(bgtwo).mas_offset(KFit_W6S(40));
        make.bottom.mas_equalTo(bgtwo).mas_offset(-KFit_W6S(40));
    }];
    
    UILabel *ts = [[UILabel alloc] init];
    [bgthree addSubview:ts];
    ts.backgroundColor = kColor_N(230, 241, 252);
    ts.layer.cornerRadius = 3;
    ts.textColor = kColor_N(0, 100, 233);
    ts.textAlignment = NSTextAlignmentCenter;
    ts.text = @"做以下任务，获得积分，快速提升自己排名";
    ts.font = [UIFont systemFontOfSize:kFit_Font6(13)];
    [ts mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(bgthree).mas_offset(KFit_W6S(30));
        make.top.mas_equalTo(bgthree).mas_offset(KFit_W6S(20));
        make.right.mas_equalTo(bgthree).mas_offset(-KFit_W6S(30));
        make.height.mas_equalTo(KFit_H6S(60));
    }];
    
    UIView *view = [[UIView alloc] init];
    [bgthree addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(bgthree).mas_offset(KFit_W6S(30));
        make.right.mas_equalTo(bgthree).mas_offset(-KFit_W6S(30));
        make.top.mas_equalTo(ts.mas_bottom).mas_offset(KFit_W6S(30));
        make.height.mas_equalTo(KFit_H6S(1120));
    }];
    
    TaskV *v1 = [[TaskV alloc] init];
    v1.title.text = @"完善招生名片";
    v1.subtitle.text = @"制作分校招生名片，学员主动找到您";
    v1.fen.text = @"10积分";
    [v1.but setImage:[UIImage imageNamed:@"perfect"] forState:UIControlStateNormal];
    v1.but.tag = 1;
    [v1.but addTarget:self action:@selector(toranwu:) forControlEvents:UIControlEventTouchUpInside];
    
    TaskV *v2 = [[TaskV alloc] init];
    v2.title.text = @"分享招生名片";
    v2.subtitle.text = @"每日上限1次";
    v2.fen.text = @"2分";
    [v2.but setImage:[UIImage imageNamed:@"share"] forState:UIControlStateNormal];
    v2.but.tag = 2;
    [v2.but addTarget:self action:@selector(toranwu:) forControlEvents:UIControlEventTouchUpInside];
    
    TaskV *v3 = [[TaskV alloc] init];
    v3.title.text = @"分享图片海报";
    v3.subtitle.text = @"每日上限1次";
    v3.fen.text = @"2分";
    [v3.but setImage:[UIImage imageNamed:@"share"] forState:UIControlStateNormal];
    v3.but.tag = 3;
    [v3.but addTarget:self action:@selector(toranwu:) forControlEvents:UIControlEventTouchUpInside];
    
    TaskV *v4 = [[TaskV alloc] init];
    v4.title.text = @"分享图文海报";
    v4.subtitle.text = @"每日上限1次";
    v4.fen.text = @"2分";
    [v4.but setImage:[UIImage imageNamed:@"share"] forState:UIControlStateNormal];
    v4.but.tag = 4;
    [v4.but addTarget:self action:@selector(toranwu:) forControlEvents:UIControlEventTouchUpInside];
    
    
    TaskV *v5 = [[TaskV alloc] init];
    v5.title.text = @"邀请教练";
    v5.subtitle.text = @"邀请教练成功入驻APP";
    v5.fen.text = @"5积分";
    [v5.but setImage:[UIImage imageNamed:@"Invitation"] forState:UIControlStateNormal];
    v5.but.tag = 5;
    [v5.but addTarget:self action:@selector(toranwu:) forControlEvents:UIControlEventTouchUpInside];
    
    TaskV *v6 = [[TaskV alloc] init];
    v6.title.text = @"提交学员资料";
    v6.subtitle.text = @"成功提交学员资料至总校";
    v6.fen.text = @"5积分";
    [v6.but setImage:[UIImage imageNamed:@"submit"] forState:UIControlStateNormal];
    v6.but.tag = 6;
    [v6.but addTarget:self action:@selector(toranwu:) forControlEvents:UIControlEventTouchUpInside];
    
    TaskV *v7 = [[TaskV alloc] init];
    v7.title.text = @"预约练车";
    v7.subtitle.text = @"预约练车:+2/人，取消预约:-2/人，每日上限一次";
    v7.fen.text = @"2积分";
    [v7.but setImage:[UIImage imageNamed:@"appointment"] forState:UIControlStateNormal];
    v7.but.tag = 7;
    [v7.but addTarget:self action:@selector(toranwu:) forControlEvents:UIControlEventTouchUpInside];
    
    TaskV *v8 = [[TaskV alloc] init];
    v8.title.text = @"每日签到";
    v8.subtitle.text = @"每日APP签到";
    v8.fen.text = @"1积分";
    [v8.but setImage:[UIImage imageNamed:@"register"] forState:UIControlStateNormal];
    v8.but.tag = 8;
    [v8.but addTarget:self action:@selector(toranwu:) forControlEvents:UIControlEventTouchUpInside];
    
    [view addSubview:v1];
    [view addSubview:v2];
    [view addSubview:v3];
    [view addSubview:v4];
    [view addSubview:v5];
    [view addSubview:v6];
    [view addSubview:v7];
    [view addSubview:v8];
    
    NSArray *arr = @[v1,v2,v3,v4,v5,v6,v7,v8];
    [arr mas_distributeViewsAlongAxis:MASAxisTypeVertical withFixedSpacing:0.1 leadSpacing:0.1 tailSpacing:0.1];
    [arr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(view);
    }];
}

- (void)toranwu:(UIButton *)senter{
    switch (senter.tag) {
        case 1:
            
            break;
        case 2:
            
            break;
        case 3:
            
            break;
        case 4:
            
            break;
        case 5:
            
            break;
        case 6:
            
            break;
        case 7:
            
            break;
        case 8:
            
            break;
        default:
            break;
    }
}
/*[view addSubview:v1];
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
