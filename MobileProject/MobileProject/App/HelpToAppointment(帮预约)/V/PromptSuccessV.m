//
//  PromptSuccessV.m
//  MobileProject
//
//  Created by 向蕾 on 2018/10/29.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import "PromptSuccessV.h"
#import <MessageUI/MessageUI.h>
#import "PracticeCarVC.h"
@interface PromptSuccessV ()<MFMessageComposeViewControllerDelegate>


@end

@implementation PromptSuccessV
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self loadSubview];
    }
    return self;
}

- (void)loadSubview{
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    self.backgroundColor = kRGBAColor(0, 0, 0, 0.8);
    
    self.backview = [[UIView alloc] init];
    [self addSubview:self.backview];
    [self.backview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self);
        make.size.mas_equalTo(CGSizeMake(KFit_W6S(600), KFit_H6S(850)));
    }];
    self.backview.backgroundColor = kColor_N(0, 112, 234);
    self.backview.layer.cornerRadius = 5;
    self.backview.layer.masksToBounds = YES;
    
    UIButton *but = [[UIButton alloc] init];
    [self.backview addSubview:but];
    [but mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.backview).mas_offset(KFit_H6S(60));
        make.centerX.mas_equalTo(self.backview);
        make.size.mas_equalTo(CGSizeMake(KFit_W6S(300), KFit_H6S(50)));
    }];
    but.titleLabel.font = [UIFont systemFontOfSize:kFit_Font6(16)];
    [but setTitle:@"约课成功！" forState:UIControlStateNormal];
    [but setImage:[UIImage imageNamed:@"gouxuan_norcopy"] forState:UIControlStateNormal];
    
    UILabel *lbone = [[UILabel alloc] init];
    [self.backview addSubview:lbone];
    [lbone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.backview);
        make.top.mas_equalTo(but.mas_bottom).mas_offset(KFit_H6S(15));
        make.size.mas_equalTo(CGSizeMake(KFit_W6S(530), KFit_H6S(30)));
    }];
    lbone.textColor = [UIColor whiteColor];
    lbone.font = [UIFont systemFontOfSize:kFit_Font6(15)];
    lbone.text = @"已通过中天驾考，给学员发送约课通知";
    
    UIView *backone = [[UIView alloc] init];
    [self.backview addSubview:backone];
    backone.layer.cornerRadius = 5;
    backone.layer.masksToBounds = YES;
    backone.backgroundColor = [UIColor whiteColor];
    [backone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.backview);
        make.top.mas_equalTo(lbone.mas_bottom).mas_offset(KFit_H6S(30));
        make.left.mas_equalTo(self.backview).mas_offset(KFit_W6S(40));
        make.height.mas_equalTo(KFit_H6S(480));
    }];
    
    UILabel *lbtwo = [[UILabel alloc] init];
    [backone addSubview:lbtwo];
    lbtwo.text = @"您也可以直接给您的学员发短信";
    lbtwo.textColor = ZTColor;
    lbtwo.font = [UIFont systemFontOfSize:kFit_Font6(15)];
    [lbtwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(backone).mas_offset(KFit_H6S(35));
        make.left.mas_equalTo(backone).mas_offset(KFit_W6S(30));
        make.right.mas_equalTo(backone).mas_offset(-KFit_W6S(30));
    }];
    
    UIView *backtwo = [[UIView alloc] init];
    [self.backview addSubview:backtwo];
    backtwo.backgroundColor = kColor_N(235, 238, 243);
    backtwo.layer.cornerRadius = 5;
    backtwo.layer.masksToBounds = YES;
    [backtwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lbtwo.mas_bottom).mas_offset(KFit_H6S(20));
        make.left.mas_equalTo(backone).mas_offset(KFit_W6S(30));
        make.right.mas_equalTo(backone).mas_offset(-KFit_W6S(30));
        make.bottom.mas_equalTo(backone).mas_offset(-KFit_W6S(30));
    }];
    
    self.centent = [[UITextView alloc] init];
    [backtwo addSubview:self.centent];
    self.centent.backgroundColor = [UIColor clearColor];
    self.centent.editable = NO;
    
    self.centent.font = [UIFont systemFontOfSize:kFit_Font6(15)];
    [self.centent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(backtwo).mas_offset(KFit_H6S(30));
        make.bottom.mas_equalTo(backtwo).mas_offset(-KFit_H6S(30));
        make.left.mas_equalTo(backtwo).mas_offset(KFit_H6S(20));
        make.right.mas_equalTo(backtwo).mas_offset(-KFit_H6S(20));
    }];
    
    UIButton *tj = [[UIButton alloc] init];
    [self.backview addSubview:tj];
    [tj addTarget:self action:@selector(fasongduanxin) forControlEvents:UIControlEventTouchUpInside];
    tj.layer.cornerRadius = 5;
    tj.layer.masksToBounds = YES;
    [tj setTitle:@"去给学员发短信" forState:UIControlStateNormal];
    [tj setTitleColor:kColor_N(0, 112, 234) forState:UIControlStateNormal];
    [tj setBackgroundColor:[UIColor whiteColor]];
    [tj mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(backone.mas_bottom).mas_offset(KFit_H6S(30));
        make.left.mas_equalTo(self.backview).mas_offset(KFit_W6S(40));
        make.right.mas_equalTo(self.backview).mas_offset(-KFit_W6S(40));
        make.height.mas_equalTo(KFit_H6S(90));
    }];
    
    UIButton *down = [[UIButton alloc] init];
    [self addSubview:down];
    [down addTarget:self action:@selector(shutDown) forControlEvents:UIControlEventTouchUpInside];
    [down setImage:[UIImage imageNamed:@"delete_icon"] forState:UIControlStateNormal];
    [down mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.backview);
        make.bottom.mas_equalTo(self.backview.mas_top).mas_offset(-KFit_H6S(30));
        make.size.mas_equalTo(CGSizeMake(KFit_W6S(40), KFit_W6S(40)));
    }];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
#pragma mark - 退出
- (void)shutDown{
    self.vc.navigationView.hidden = NO;
    [self removeFromSuperview];
    NSArray *arr = self.vc.navigationController.viewControllers;
    for (UIViewController *vc in arr) {
        if ([vc isKindOfClass:[PracticeCarVC class]]) {
            [self.vc.navigationController popToViewController:vc animated:NO];
            break;
            
        }
    }
}
#pragma mark - 弹出
- (void)show{
    self.centent.text = [NSString stringWithFormat:@"学员您好，您已成功预约练车，训练场:%@（%@）,时间:%@,地址:%@,请准时练车",self.groundName,self.teamSchoolName,[self.tiemArr componentsJoinedByString:@","],self.groundAddress];
//    UIWindow *rootWindow = [UIApplication sharedApplication].keyWindow;
//    [rootWindow addSubview:self];
    self.vc.navigationView.hidden = YES;
    [self.vc.view addSubview:self];
    //    [self creatShowAnimation];
}


- (void)fasongduanxin{
    MFMessageComposeViewController * controller = [[MFMessageComposeViewController alloc] init];
    controller.recipients = self.studentPhoneArr;//发送短信的号码，数组形式入参
    controller.navigationBar.tintColor = [UIColor redColor];
    controller.body = self.centent.text; //此处的body就是短信将要发生的内容
    controller.messageComposeDelegate = self;
    [self.vc presentViewController:controller animated:YES completion:nil];
    [[[[controller viewControllers] lastObject] navigationItem] setTitle:@"短信"];//修改短信界面标题
}

-(void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result {
    [self.vc dismissViewControllerAnimated:YES completion:nil];
    switch (result) {
        case MessageComposeResultSent:
            //信息传送成功
            break;
        case MessageComposeResultFailed:
            //信息传送失败
            break;
        case MessageComposeResultCancelled:
            //信息被用户取消传送
            break;
        default:
            break;
    }
    
}
@end
