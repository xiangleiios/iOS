//
//  ReplyV.m
//  MobileProject
//
//  Created by 向蕾 on 2018/11/6.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import "ReplyV.h"

@implementation ReplyV

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
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    self.backgroundColor = kRGBAColor(0, 0, 0, 0.8);
    
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - KFit_H6S(300), SCREEN_WIDTH, KFit_H6S(300))];
    self.backview = v;
    [self addSubview:v];
    v.backgroundColor = [UIColor whiteColor];
    
    self.textview = [[UITextView alloc] initWithFrame:CGRectMake(KFit_W6S(30), KFit_H6S(90), SCREEN_WIDTH - KFit_W6S(60), KFit_H6S(180))];
    [self.backview addSubview:self.textview];
    self.textview.layer.cornerRadius = 5;
    self.textview.layer.borderWidth = 0.5;
    self.textview.layer.borderColor = [UIColor lightGrayColor].CGColor;

    UIButton *fasong = [[UIButton alloc] init];
    [self.backview addSubview:fasong];
    [fasong setTitle:@"发送" forState:UIControlStateNormal];
    [fasong addTarget:self action:@selector(toreply) forControlEvents:UIControlEventTouchUpInside];
    fasong.titleLabel.font = [UIFont systemFontOfSize:kFit_Font6(15)];
    fasong.backgroundColor = kColor_N(15, 115, 238);
    fasong.layer.cornerRadius = 3;
    [fasong mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.textview);
        make.top.mas_equalTo(self.backview).mas_offset(KFit_H6S(20));
        make.size.mas_equalTo(CGSizeMake(KFit_W6S(120), KFit_H6S(50)));
    }];
    
    // 添加通知监听见键盘弹出/退出
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
}
#pragma mark - 退出
- (void)shutDown{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self removeFromSuperview];
}
#pragma mark - 弹出
- (void)show{
    UIWindow *rootWindow = [UIApplication sharedApplication].keyWindow;
    [rootWindow addSubview:self];
    
    
    //    [self creatShowAnimation];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self endEditing:YES];
    [self shutDown];
}

- (void)keyboardChange:(NSNotification *)note{
    NSDictionary * dic = [note userInfo];//userInfo是当前监测键盘的信息
    NSNumber * time = dic[UIKeyboardAnimationDurationUserInfoKey];
    NSNumber * animation = dic[UIKeyboardAnimationCurveUserInfoKey];
    NSValue * began = dic[UIKeyboardFrameBeginUserInfoKey];
    NSValue * end = dic[UIKeyboardFrameEndUserInfoKey];
    CGFloat keyboardH = [began CGRectValue].origin.y - [end CGRectValue].origin.y;
    KKLog(@"+++++++++++++%lf",keyboardH);
    [UIView animateWithDuration:[time doubleValue] animations:^{
        CGRect frame = self.backview.frame;
        frame.origin.y = frame.origin.y-keyboardH;
        self.backview.frame = frame;
    }];
    
    
}

- (void)toreply{
    NSString *url = POSTReplyAdd;
    if (self.textview.text.length < 1) {
        [MBProgressHUD showMsgHUD:@"请填写回复内容"];
        return;
    }
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:self.idid forKey:@"appraiseId"];
    [dic setObject:self.textview.text forKey:@"content"];
    [FMNetworkHelper fm_request_postWithUrlString:url isNeedCache:NO parameters:dic successBlock:^(id responseObject) {
        KKLog(@"%@",responseObject);
        if (kResponseObjectStatusCodeIsEqual(200)) {
            
            [self shutDown];
            [self.vc headerRefresh];
            [MBProgressHUD showMsgHUD:@"回复成功"];
        }else{
            [MBProgressHUD showMsgHUD:responseObject[@"message"]];
        }
    } failureBlock:^(NSError *error) {
        KKLog(@"%@", error);
        
    } progress:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];
}
@end
