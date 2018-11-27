//
//  InvitationCoachVC.m
//  MobileProject
//
//  Created by 向蕾 on 2018/11/16.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import "InvitationCoachVC.h"
#import "InvitedRecordList.h"
#import "CGXPickerView.h"
@interface InvitationCoachVC ()
@property (nonatomic , strong)UIWebView *webview;
@property (nonatomic , strong)UILabel *school;
@property (nonatomic , strong)UIButton *but;
@property (nonatomic , strong)NSString *schoolID;
@property (nonatomic , strong)NSString *teamSchoolID;
@property (nonatomic , strong)XLshare *share;
@end

@implementation InvitationCoachVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kColor_N(240, 240, 240);
    [self.navigationView setTitle:@"邀请教练"];
    _share = [[XLshare alloc]init];
    kWeakSelf(self)
    UIButton *but = [self.navigationView addRightButtonWithTitle:@"邀请记录" clickCallBack:^(UIView *view) {
        InvitedRecordList *vc = [[InvitedRecordList alloc] init];
        [weakself.navigationController pushViewController:vc animated:YES];
    }];
    [but setTitleColor:kColor_N(12, 118, 235) forState:UIControlStateNormal];
    
    UIImageView *img = [[UIImageView alloc] init];
    [self.view addSubview:img];
    [img setImage:[UIImage imageNamed:@"bdhb"]];
    [img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).mas_offset(kNavBarH);
        make.left.mas_equalTo(self.view);
        make.right.mas_equalTo(self.view);
        make.height.mas_equalTo(KFit_H6S(910));
    }];
    
    if (USERFZR) {
        NSUserDefaults *defaults  =  [NSUserDefaults standardUserDefaults];
        NSArray *arrname = (NSArray *)[defaults objectForKey:SchoolList];
        self.school = [[UILabel alloc] init];
        self.school.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:self.school];
        self.school.font = [UIFont systemFontOfSize:kFit_Font6(16) weight:0.5];
        self.school.text = [NSString stringWithFormat:@"  %@ (%@)",arrname[0][@"schoolName"],arrname[0][@"teamName"]];
        self.schoolID = arrname[0][@"schoolDeptId"];
        self.teamSchoolID = arrname[0][@"teamSchoolDeptId"];
        [self.school mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.view).mas_offset(KFit_W6S(100));
            make.right.mas_equalTo(self.view).mas_offset(-KFit_W6S(100));
            make.bottom.mas_equalTo(img).mas_offset(-KFit_H6S(50));
            make.height.mas_equalTo(KFit_H6S(60));
        }];
        
        self.but = [[UIButton alloc] init];
        [self.view addSubview:self.but];
        [self.but addTarget:self action:@selector(change) forControlEvents:UIControlEventTouchUpInside];
        [self.but mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.bottom.mas_equalTo(self.school);
            make.width.mas_equalTo(KFit_H6S(60));
        }];
        
        
    }
    
    
    XLxqbut *butone = [[XLxqbut alloc] init];
    [self.view addSubview:butone];
    butone.tag = 1;
    [butone setTitle:@"微信" forState:UIControlStateNormal];
    [butone setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [butone setImage:[UIImage imageNamed:@"enjoy_weixin"] forState:UIControlStateNormal];
    [butone addTarget:self action:@selector(toSave:) forControlEvents:UIControlEventTouchUpInside];
    
    XLxqbut *buttwo = [[XLxqbut alloc] init];
    [self.view addSubview:buttwo];
    buttwo.tag = 2;
    [buttwo setTitle:@"朋友圈" forState:UIControlStateNormal];
    [buttwo setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [buttwo setImage:[UIImage imageNamed:@"enjoy_pengyouq"] forState:UIControlStateNormal];
    [buttwo addTarget:self action:@selector(toSave:) forControlEvents:UIControlEventTouchUpInside];
    
    XLxqbut *butthree = [[XLxqbut alloc] init];
    [self.view addSubview:butthree];
    butthree.tag = 3;
    [butthree setTitle:@"QQ好友" forState:UIControlStateNormal];
    [butthree setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [butthree setImage:[UIImage imageNamed:@"enjoy_qq"] forState:UIControlStateNormal];
    [butthree addTarget:self action:@selector(toSave:) forControlEvents:UIControlEventTouchUpInside];
    
    XLxqbut *butfour = [[XLxqbut alloc] init];
    [self.view addSubview:butfour];
    butfour.tag = 4;
    [butfour setTitle:@"QQ空间" forState:UIControlStateNormal];
    [butfour setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [butfour setImage:[UIImage imageNamed:@"enjoy_kongq"] forState:UIControlStateNormal];
    [butfour addTarget:self action:@selector(toSave:) forControlEvents:UIControlEventTouchUpInside];
    
    
    NSArray *arr = @[butone,buttwo,butthree,butfour];
    
    [arr mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedItemLength:KFit_W6S(120) leadSpacing:KFit_W6S(40) tailSpacing:KFit_W6S(40)];
    [arr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.view).mas_offset(-KFit_H6S(60));
//        make.top.mas_equalTo(img.mas_bottom).mas_offset(30);;
        make.height.mas_equalTo(KFit_H6S(160));
    }];
    // Do any additional setup after loading the view.
}

- (void)change{
//    kWeakSelf(self)
    NSUserDefaults *defaults  =  [NSUserDefaults standardUserDefaults];
    NSArray *arrname = (NSArray *)[defaults objectForKey:SchoolList];
    XLCache *cache = [XLCache singleton];
    [CGXPickerView showStringPickerWithTitle:@"总校" DataSource:cache.teamCode_title DefaultSelValue:nil IsAutoSelect:NO ResultBlock:^(id selectValue, id selectRow) {
        NSLog(@"%@",selectValue);
        int i = [selectRow intValue];
        self.school.text = [NSString stringWithFormat:@"  %@ (%@)",selectValue,arrname[i][@"teamName"]];
        self.schoolID = arrname[i][@"schoolDeptId"];
        self.teamSchoolID = arrname[i][@"teamSchoolDeptId"];
        NSLog(@"%@ , %@   ",selectValue , arrname[i][@"teamName"]);
        
    }];
}

- (void)toSave:(UIButton *)senter{
    XLSingleton *sing = [XLSingleton singleton];
    sing.type = 0;
//    sing.shareId = self.model.idid;
    if (USERFZR) {
        self.share.url = [NSString stringWithFormat:HTMLInvitationCoach,self.schoolID,self.teamSchoolID,@"",2];
        self.share.title = [NSString stringWithFormat:@"%@邀您瓜分30000元年会红包",self.school.text];
    }else{
        self.share.url = [NSString stringWithFormat:HTMLInvitationCoach,self.schoolID,self.teamSchoolID,[User UserOb].userId,1];
        self.share.title = [NSString stringWithFormat:@"中天驾考邀您瓜分30000元年会红包"];
    }
    
    self.share.subTitle = @"30000元年会现金红包助力首届“优秀驾校”评选，参与教练越多奖池红包越高，奖金将会在总校年会上以现金红包发放哦！";
    switch (senter.tag) {
        case 1:
            [self.share shareWebPageToPlatformType:UMSocialPlatformType_WechatSession];
            break;
        case 2:
            [self.share shareWebPageToPlatformType:UMSocialPlatformType_WechatTimeLine];
            break;
        case 3:
            [self.share shareWebPageToPlatformType:UMSocialPlatformType_QQ];
            break;
        case 4:
            [self.share shareWebPageToPlatformType:UMSocialPlatformType_Qzone];
            break;
            
        default:
            break;
    }
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
