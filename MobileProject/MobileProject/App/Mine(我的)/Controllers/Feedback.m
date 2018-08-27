//
//  Feedback.m
//  MobileProject
//
//  Created by zsgy on 17/8/3.
//  Copyright © 2017年 ZSGY. All rights reserved.
//

#import "Feedback.h"
@interface Feedback ()<UITextViewDelegate>
@property (nonatomic , strong)UITextField *pho;
@property (nonatomic , strong)UITextField *name;
@property (nonatomic , strong)UITextView *feed;
@property (nonatomic , strong)UIImageView *tjts;
@end

@implementation Feedback

- (void)viewDidLoad {
    [super viewDidLoad];
    kWeakSelf(self)
    [self.navigationView setTitle:@"意见反馈"];
    self.navigationView.titleLabel.textColor = [UIColor blackColor];
    [self.navigationView addRightButtonWithTitle:@"提交意见" clickCallBack:^(UIView *view) {
        [weakself submitFeedback];
    }];
    
    [self loadpho];
//    [self loadfunctionbut];
}

- (void)loadpho{
    UIView *v=[[UIView alloc]init];
    [self.view addSubview:v];
    [v mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view.mas_top).mas_offset(kNavBarH);
    }];
    self.pho=[[UITextField alloc]init];
    [v addSubview:self.pho];
    [self.pho mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).mas_offset(KFit_W6S(30));
        make.right.mas_equalTo(self.view).mas_offset(-KFit_W6S(30));
        make.top.mas_equalTo(v).mas_offset(KFit_W6S(20));
        make.height.mas_equalTo(KFit_H6S(60));
    }];
    self.pho.clipsToBounds = YES;
    self.pho.placeholder=@"请输入您的实际电话";
    
    UILabel *lbone = [[UILabel alloc] init];
    [v addSubview:lbone];
    lbone.backgroundColor = appcoloer_line;
    [lbone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).mas_offset(KFit_W6S(30));
        make.right.mas_equalTo(self.view).mas_offset(-KFit_W6S(30));
        make.top.mas_equalTo(self.pho.mas_bottom).mas_offset(KFit_W6S(10));
        make.height.mas_equalTo(kFit_Font6(1));
    }];
    
    self.name=[[UITextField alloc]init];
    [v addSubview:self.name];
    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).mas_offset(KFit_W6S(30));
        make.right.mas_equalTo(self.view).mas_offset(-KFit_W6S(30));
        make.top.mas_equalTo(self.pho.mas_bottom).mas_offset(KFit_W6S(20));
        make.height.mas_equalTo(KFit_H6S(60));
    }];
    self.name.clipsToBounds = YES;
    self.name.placeholder=@"对您的称呼";
    UILabel *lbtwo = [[UILabel alloc] init];
    [v addSubview:lbtwo];
    lbtwo.backgroundColor = appcoloer_line;
    [lbtwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).mas_offset(KFit_W6S(30));
        make.right.mas_equalTo(self.view).mas_offset(-KFit_W6S(30));
        make.top.mas_equalTo(self.name.mas_bottom).mas_offset(KFit_W6S(10));
        make.height.mas_equalTo(kFit_Font6(1));
    }];
    
    self.feed=[[UITextView alloc]init];
    [self.view addSubview:self.feed];
//    self.feed.backgroundColor=kRGBColor(239, 239, 246);
    [self.feed mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.name);
        make.top.mas_equalTo(self.name.mas_bottom).mas_equalTo(KFit_H6S(40));
        make.height.mas_equalTo(KFit_H6S(800));
    }];
    self.feed.layer.cornerRadius=5;
    self.feed.delegate=self;
    self.feed.font=[UIFont systemFontOfSize:kFit_Font6(15)];
    self.feed.layer.borderColor = appcoloer_line.CGColor;
    self.feed.layer.borderWidth = 0.7;
    
    
    self.tjts=[[UIImageView alloc]init];
    [self.feed addSubview:self.tjts];
    [self.tjts mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.feed);
        make.top.mas_equalTo(self.feed).mas_offset(KFit_H6S(20));
        make.height.mas_equalTo(KFit_H6S(36));
        make.width.mas_equalTo(KFit_W6S(160));
    }];
    [self.tjts setImage:[UIImage imageNamed:@"your-advice"]];
    
//    XLSingle *single=[XLSingle single];
//    self.pho.text=single.FeedbackPho;
//    self.feed.text=single.FeedbackCentent;
    [self textViewDidEndEditing:self.feed];
//    [self textViewDidChange:self.feed];
    
}



- (void)loadfunctionbut{
    UIButton *but=[[UIButton alloc]init];
    [self.view addSubview:but];
    [but mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(self.feed.mas_bottom).mas_offset(KFit_H6S(170));
        make.width.mas_equalTo(KFit_W6S(530));
        make.height.mas_equalTo(KFit_H6S(80));
    }];
    but.layer.cornerRadius=KFit_H6S(40);
    but.backgroundColor=kRGBColor(251, 189, 44);
    [but setTitle:@"提交反馈" forState:UIControlStateNormal];
    [but addTarget:self action:@selector(submitFeedback) forControlEvents:UIControlEventTouchUpInside];
}

- (void)submitFeedback{
    NSString* phone = [self.pho.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString* feedback=[self.feed.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    if( phone.length < 1 )
    {
        [MBProgressHUD showAutoMessage:@"请输入手机号！"];
        return;
    }
    if( ![FMRegExpTool fm_checkingMobile:phone] )
    {
        [MBProgressHUD showAutoMessage:@"请输入正确的手机号！"];
        return;
    }
    if (self.name.text.length < 1) {
        [MBProgressHUD showAutoMessage:@"请输入称呼！"];
        return;
    }
    if (self.name.text.length > 8) {
        [MBProgressHUD showAutoMessage:@"称呼不能超过8个字符"];
        return;
    }
    if (feedback.length < 2) {
        [MBProgressHUD showAutoMessage:@"反馈内容不能少于2个汉字！"];
        return;
    }
    if (feedback.length > 200) {
        [MBProgressHUD showAutoMessage:@"反馈内容不能大于200个汉字！"];
        return;
    }
    NSString *url=[NSString stringWithFormat:POSTSubmitFeedback,phone,feedback,[User UserOb].token];
    [FMNetworkHelper fm_request_postWithUrlString:url isNeedCache:NO parameters:nil successBlock:^(id responseObject) {
        if (kResponseObjectStatusCodeIsEqual(200)) {
            [MBProgressHUD showAutoMessage:@"提交成功"];
            self.pho.text=@"";
            self.feed.text=@"";
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [MBProgressHUD showAutoMessage:responseObject[@"message"]];
        }
    } failureBlock:^(NSError *error) {
        
    } progress:nil];
    
}


- (void)textViewDidBeginEditing:(UITextView *)textView{
    [self.tjts setHidden:YES];
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    
    if (!textView.text.length){
        [self.tjts setHidden:NO];
    }else{
        [self.tjts setHidden:YES];
    };
    
    
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -视图消失
- (void)viewDidDisappear:(BOOL)animated{
//    XLSingle *single=[XLSingle single];
//    single.FeedbackPho=self.pho.text;
//    single.FeedbackCentent=self.feed.text;
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
