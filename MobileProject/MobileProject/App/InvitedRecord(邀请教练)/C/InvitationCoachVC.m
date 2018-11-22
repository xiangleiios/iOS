//
//  InvitationCoachVC.m
//  MobileProject
//
//  Created by 向蕾 on 2018/11/16.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import "InvitationCoachVC.h"
#import "InvitedRecordList.h"
@interface InvitationCoachVC ()

@end

@implementation InvitationCoachVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationView setTitle:@"邀请教练"];
    kWeakSelf(self)
    UIButton *but = [self.navigationView addRightButtonWithTitle:@"邀请记录" clickCallBack:^(UIView *view) {
        InvitedRecordList *vc = [[InvitedRecordList alloc] init];
        [weakself.navigationController pushViewController:vc animated:YES];
    }];
    [but setTitleColor:kColor_N(12, 118, 235) forState:UIControlStateNormal];
    
    UIImageView *img = [[UIImageView alloc] init];
    [self.view addSubview:img];
    [img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).mas_offset(kNavBarH + KFit_W6S(30));
        make.left.mas_equalTo(self.view).mas_offset(KFit_W6S(30));
        make.right.mas_equalTo(self.view).mas_offset(-KFit_W6S(30));
        make.bottom.mas_equalTo(self.view).mas_offset(-KFit_H6S(240));
    }];
    
    XLxqbut *butone = [[XLxqbut alloc] init];
    [self.view addSubview:butone];
    butone.tag = 1;
    [butone setTitle:@"微信好友" forState:UIControlStateNormal];
    [butone setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [butone setImage:[UIImage imageNamed:@"enjoy_weixin"] forState:UIControlStateNormal];
    
    XLxqbut *buttwo = [[XLxqbut alloc] init];
    [self.view addSubview:buttwo];
    buttwo.tag = 2;
    [buttwo setTitle:@"朋友圈" forState:UIControlStateNormal];
    [buttwo setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [buttwo setImage:[UIImage imageNamed:@"enjoy_pengyouq"] forState:UIControlStateNormal];
    
    XLxqbut *butthree = [[XLxqbut alloc] init];
    [self.view addSubview:butthree];
    butthree.tag = 3;
    [butthree setTitle:@"QQ好友" forState:UIControlStateNormal];
    [butthree setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [butthree setImage:[UIImage imageNamed:@"enjoy_qq"] forState:UIControlStateNormal];
    
    XLxqbut *butfour = [[XLxqbut alloc] init];
    [self.view addSubview:butfour];
    butfour.tag = 4;
    [butfour setTitle:@"QQ空间" forState:UIControlStateNormal];
    [butfour setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [butfour setImage:[UIImage imageNamed:@"enjoy_kongq"] forState:UIControlStateNormal];
    
    
    NSArray *arr = @[butone,buttwo,butthree,butfour];
    
    [arr mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedItemLength:KFit_W6S(120) leadSpacing:KFit_W6S(40) tailSpacing:KFit_W6S(40)];
    [arr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.view).mas_offset(-KFit_H6S(60));
//        make.top.mas_equalTo(img.mas_bottom).mas_offset(30);;
        make.height.mas_equalTo(KFit_H6S(160));
    }];
    // Do any additional setup after loading the view.
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
