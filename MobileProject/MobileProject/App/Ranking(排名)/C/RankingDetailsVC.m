//
//  RankingDetailsVC.m
//  MobileProject
//
//  Created by 向蕾 on 2018/11/21.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import "RankingDetailsVC.h"
#import "TaskV.h"
#import "IntegralListVC.h"
#import "RuleDescriptionVC.h"
#import "BusinessCardVC.h"
#import "MyAdmissionsVC.h"
#import "InvitationCoachVC.h"
#import "PracticeCarListVC.h"
#import "StudentsVC.h"
#import "BranchSchoolListVC.h"
@interface RankingDetailsVC ()
@property (nonatomic , strong)UIScrollView *scroll;
@property (nonatomic , strong)XLView *backView;
@property (nonatomic , strong)TaskV *v1;
@property (nonatomic , strong)TaskV *v2;
@property (nonatomic , strong)TaskV *v3;
@property (nonatomic , strong)TaskV *v4;
@property (nonatomic , strong)TaskV *v5;
@property (nonatomic , strong)TaskV *v6;
@property (nonatomic , strong)TaskV *v7;
@property (nonatomic , strong)TaskV *v8;
@property (nonatomic , strong)UILabel *jifen;
@end

@implementation RankingDetailsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationView setTitle:@"排名"];
    kWeakSelf(self)
    UIButton *but = [self.navigationView addRightButtonWithTitle:@"规则说明" clickCallBack:^(UIView *view) {
        RuleDescriptionVC *vc = [[RuleDescriptionVC alloc] init];
        [weakself.navigationController pushViewController:vc animated:YES];
    }];
    [but setTitleColor:kColor_N(12, 118, 235) forState:UIControlStateNormal];
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
//    [img setImage:[UIImage imageNamed:@"nor_fenxiao_photo"]];
    [img sd_setImageWithURL:[NSURL URLWithString:KURLIma(_model.headImg)] placeholderImage:[UIImage imageNamed:@"nor_fenxiao_photo"]];
    [img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.backView).mas_offset(KFit_H6S(40));
        make.left.mas_equalTo(self.backView).mas_offset(KFit_H6S(30));
        make.size.mas_equalTo(CGSizeMake(KFit_W6S(150), KFit_H6S(120)));
    }];
    
    UILabel *title = [[UILabel alloc] init];
    if (USERFZR) {
        
        title.text = [NSString stringWithFormat:@"%@ (%@)",_model.deptFatherName,_model.name];
    }else{
        title.text = [NSString stringWithFormat:@"%@",_model.coachName];
    }
    [self.backView addSubview:title];
    title.font = [UIFont systemFontOfSize:kFit_Font6(17)];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(img).mas_offset(KFit_H6S(10));
        make.left.mas_equalTo(img.mas_right).mas_offset(KFit_W6S(30));
        make.height.mas_equalTo(KFit_H6S(40));
        make.width.mas_equalTo(KFit_W6S(430));
    }];
    
    YYLabel *lb = [[YYLabel alloc] init];
    [self.backView addSubview:lb];
    NSString *str;
    if (USERFZR) {
        
        str = [NSString stringWithFormat:@"排名:%@排名第%@,%@排名%@",_model.city?_model.city:@"",_model.schoolrankingCount,_model.deptFatherName,_model.teamSchoolrankingCount];
    }else{
//        NSString *team = [[XLCache singleton].teamCode_title firstObject];
        str = [NSString stringWithFormat:@"排名:%@排名第%@,%@排名%@",_model.city?_model.city:@"",_model.schoolrankingCount,_model.originalDeptName,_model.teamSchoolrankingCount];
    }
    
    NSMutableAttributedString *attri_str = [[NSMutableAttributedString alloc] initWithString:str];
    attri_str.yy_font = [UIFont systemFontOfSize:kFit_Font6(13)];
    attri_str.yy_color = ZTColor;
    [attri_str yy_setFont:[UIFont boldSystemFontOfSize:kFit_Font6(16)] range:[str rangeOfString:_model.schoolrankingCount]];
    [attri_str yy_setFont:[UIFont boldSystemFontOfSize:kFit_Font6(16)] range:[str rangeOfString:_model.teamSchoolrankingCount]];
    [attri_str yy_setColor:kColor_N(0, 100, 233) range:[str rangeOfString:_model.schoolrankingCount]];
    [attri_str yy_setColor:kColor_N(0, 100, 233) range:[str rangeOfString:_model.teamSchoolrankingCount]];
    
    lb.attributedText = attri_str;
    
  
//    lb.text = [NSString stringWithFormat:@""];
//    lb.textColor = ZTColor;
//    lb.font = [UIFont systemFontOfSize:kFit_Font6(13)];
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
    self.jifen = fen;
    [self.backView addSubview:fen];
    fen.textColor = kColor_N(0, 100, 233);
    fen.text = [NSString stringWithFormat:@"%@积分",_model.compScore];
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
    [but addTarget:self action:@selector(toIntegralListVC) forControlEvents:UIControlEventTouchUpInside];
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
    
//    SCORE_1
    _v1 = [[TaskV alloc] init];
    _v1.title.text = @"完善招生名片";
    _v1.subtitle.text = @"制作分校招生名片，学员主动找到您";
    _v1.fen.text = @"10积分";
    [_v1.but setImage:[UIImage imageNamed:@"perfect"] forState:UIControlStateNormal];
    [_v1.but setImage:[UIImage imageNamed:@"perfect_copy"] forState:UIControlStateSelected];
    _v1.but.tag = 1;
    [_v1.but addTarget:self action:@selector(toranwu:) forControlEvents:UIControlEventTouchUpInside];
    
    
    _v2 = [[TaskV alloc] init];
    _v2.title.text = @"分享招生名片";
    _v2.subtitle.text = @"每日上限1次";
    _v2.fen.text = @"2分";
    [_v2.but setImage:[UIImage imageNamed:@"share"] forState:UIControlStateNormal];
    [_v2.but setImage:[UIImage imageNamed:@"share_copy"] forState:UIControlStateSelected];
    _v2.but.tag = 2;
    [_v2.but addTarget:self action:@selector(toranwu:) forControlEvents:UIControlEventTouchUpInside];
    
    _v3 = [[TaskV alloc] init];
    _v3.title.text = @"分享图片海报";
    _v3.subtitle.text = @"每日上限1次";
    _v3.fen.text = @"2分";
    [_v3.but setImage:[UIImage imageNamed:@"share"] forState:UIControlStateNormal];
    [_v3.but setImage:[UIImage imageNamed:@"share_copy"] forState:UIControlStateSelected];
    _v3.but.tag = 3;
    [_v3.but addTarget:self action:@selector(toranwu:) forControlEvents:UIControlEventTouchUpInside];
    
    _v4 = [[TaskV alloc] init];
    _v4.title.text = @"分享图文海报";
    _v4.subtitle.text = @"每日上限1次";
    _v4.fen.text = @"2分";
    [_v4.but setImage:[UIImage imageNamed:@"share"] forState:UIControlStateNormal];
    [_v4.but setImage:[UIImage imageNamed:@"share_copy"] forState:UIControlStateSelected];
    _v4.but.tag = 4;
    [_v4.but addTarget:self action:@selector(toranwu:) forControlEvents:UIControlEventTouchUpInside];
    
    
    _v5 = [[TaskV alloc] init];
    _v5.title.text = @"邀请教练";
    _v5.subtitle.text = @"邀请教练成功入驻APP";
    _v5.fen.text = @"5积分";
    [_v5.but setImage:[UIImage imageNamed:@"Invitation"] forState:UIControlStateNormal];
//    [v1.but setImage:[UIImage imageNamed:@""] forState:UIControlStateSelected];
    _v5.but.tag = 5;
    [_v5.but addTarget:self action:@selector(toranwu:) forControlEvents:UIControlEventTouchUpInside];
    
    _v6 = [[TaskV alloc] init];
    _v6.title.text = @"提交学员资料";
    _v6.subtitle.text = @"成功提交学员资料至总校";
    _v6.fen.text = @"5积分";
    [_v6.but setImage:[UIImage imageNamed:@"submit"] forState:UIControlStateNormal];
//    [v6.but setImage:[UIImage imageNamed:@""] forState:UIControlStateSelected];
    _v6.but.tag = 6;
    [_v6.but addTarget:self action:@selector(toranwu:) forControlEvents:UIControlEventTouchUpInside];
    
    _v7 = [[TaskV alloc] init];
    _v7.title.text = @"预约练车";
    _v7.subtitle.text = @"预约练车:+2/人，取消预约:-2/人，每日上限一次";
    _v7.fen.text = @"2积分";
    [_v7.but setImage:[UIImage imageNamed:@"appointment"] forState:UIControlStateNormal];
    [_v7.but setImage:[UIImage imageNamed:@"share_copy_2"] forState:UIControlStateSelected];
    _v7.but.tag = 7;
    [_v7.but addTarget:self action:@selector(toranwu:) forControlEvents:UIControlEventTouchUpInside];
    
    _v8 = [[TaskV alloc] init];
    _v8.title.text = @"每日签到";
    _v8.subtitle.text = @"每日APP签到";
    _v8.fen.text = @"1积分";
    [_v8.but setImage:[UIImage imageNamed:@"register"] forState:UIControlStateNormal];
    [_v8.but setImage:[UIImage imageNamed:@"share_copy_2"] forState:UIControlStateSelected];
    _v8.but.tag = 8;
    [_v8.but addTarget:self action:@selector(toranwu:) forControlEvents:UIControlEventTouchUpInside];
    
    [view addSubview:_v1];
    [view addSubview:_v2];
    [view addSubview:_v3];
    [view addSubview:_v4];
    [view addSubview:_v5];
    [view addSubview:_v6];
    [view addSubview:_v7];
    [view addSubview:_v8];
    
    NSArray *arr = @[_v1,_v2,_v3,_v4,_v5,_v6,_v7,_v8];
    [arr mas_distributeViewsAlongAxis:MASAxisTypeVertical withFixedSpacing:0.1 leadSpacing:0.1 tailSpacing:0.1];
    [arr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(view);
    }];
    
    //    SCORE_1
    
    
    
}

- (void)toranwu:(UIButton *)senter{
    switch (senter.tag) {
        case 1:
            if (!self.v1.but.selected) {
                if (USERFZR) {
                    BranchSchoolListVC *vc = [[BranchSchoolListVC alloc] init];
                    [self.navigationController pushViewController:vc animated:YES];
                }else{
                    [self loadCoachInfoToVC];
                }
            }
            break;
        case 2:
            if (!self.v2.but.selected) {
                if (USERFZR) {
                    BranchSchoolListVC *vc = [[BranchSchoolListVC alloc] init];
                    [self.navigationController pushViewController:vc animated:YES];
                }else{
                    [self loadCoachInfoToVC];
                }
            }
            break;
        case 3:
            if (!self.v3.but.selected) {
                MyAdmissionsVC *vc = [[MyAdmissionsVC alloc] init];
                [self.navigationController pushViewController:vc animated:YES];
            }
            break;
        case 4:
            if (!self.v4.but.selected) {
                MyAdmissionsVC *vc = [[MyAdmissionsVC alloc] init];
                [self.navigationController pushViewController:vc animated:YES];
            }
            break;
        case 5:{
            InvitationCoachVC *vc = [[InvitationCoachVC alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 6:{
            StudentsVC * vc = [[StudentsVC alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            
            break;
        case 7:
            if (!self.v7.but.selected) {
                PracticeCarListVC *vc = [[PracticeCarListVC alloc] init];
                [self.navigationController pushViewController:vc animated:YES];
            }
            break;
        case 8:
            if (!self.v8.but.selected) {
                [self qiandao];
            }
            break;
        default:
            break;
    }
}

- (void)toIntegralListVC{
    IntegralListVC *vc = [[IntegralListVC alloc] init];
    vc.model = self.model;
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)qiandao{
    NSString *url;
    NSDictionary *dic;
    if (USERFZR) {
        url = POSTRankingSignBoardSchool;
        dic = @{@"userId":_model.deptId};
    }else{
        url = POSTRankingSignBoardCoach;
        dic = @{@"userId":[User UserOb].userId};
    }
    
    [FMNetworkHelper fm_request_postWithUrlString:url isNeedCache:NO parameters:dic successBlock:^(id responseObject) {
        KKLog(@"%@",responseObject);
        if (kResponseObjectStatusCodeIsEqual(200)) {
            [MBProgressHUD showMsgHUD:@"签到成功"];
            self.v8.but.selected = YES;
            [self reloadData];
        }
    } failureBlock:^(NSError *error) {
        KKLog(@"%@", error);
        
    } progress:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];
}

- (void)loadCoachInfoToVC{
    User *uer = [User UserOb];
    KKLog(@"%@",uer.userId);
    NSString *url = [NSString stringWithFormat:POSTCoachEnrollInfo,[User UserOb].userId];
    [FMNetworkHelper fm_request_postWithUrlString:url isNeedCache:NO parameters:nil successBlock:^(id responseObject) {
        KKLog(@"%@",responseObject);
        if (kResponseObjectStatusCodeIsEqual(200)) {
            FMMainModel *model = [FMMainModel mj_objectWithKeyValues:responseObject[@"data"]];
            BusinessCardVC *vc = [[BusinessCardVC alloc] init];
            vc.model = model;
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            [MBProgressHUD showMsgHUD:responseObject[@"message"]];
        }
        
    } failureBlock:^(NSError *error) {
        KKLog(@"%@", error);
        
    } progress:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];
}
/*[view addSubview:v1];
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self reloadData];
}

- (void)setModel:(FMMainModel *)model{
    _model = model;
    self.jifen.text = [NSString stringWithFormat:@"%@积分",_model.compScore];
    _v1.but.selected = [self.model.rankingMap[@"SCORE_1"] boolValue];
    _v2.but.selected = [self.model.rankingMap[@"SCORE_2"] boolValue];
    _v3.but.selected = [self.model.rankingMap[@"SCORE_3"] boolValue];
    _v4.but.selected = [self.model.rankingMap[@"SCORE_4"] boolValue];
    _v5.but.selected = [self.model.rankingMap[@"SCORE_5"] boolValue];
    _v6.but.selected = [self.model.rankingMap[@"SCORE_6"] boolValue];
    _v7.but.selected = [self.model.rankingMap[@"SCORE_7"] boolValue];
    _v8.but.selected = [self.model.rankingMap[@"SCORE_9"] boolValue];
    
    
}

- (void)reloadData{
    NSString *url;
    if (USERFZR) {
        url = [NSString stringWithFormat:POSTRankingTeamSchoolRankingDetails,self.deptId];
    }else{
        url = POSTRankingCoachRankings;
    }
    [FMNetworkHelper fm_request_postWithUrlString:url isNeedCache:NO parameters:nil successBlock:^(id responseObject) {
        KKLog(@"%@",responseObject);
        if (USERFZR) {
            self.model=[FMMainModel mj_objectWithKeyValues:responseObject[@"data"]];
        }else{
            self.model=[FMMainModel mj_objectWithKeyValues:responseObject[@"list"]];
        }
        
    } failureBlock:^(NSError *error) {
        KKLog(@"%@", error);
        
    } progress:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];
}

@end
