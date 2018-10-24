//
//  XLAlertView.m
//  MobileProject
//
//  Created by zsgy on 2017/12/13.
//  Copyright © 2017年 ZSGY. All rights reserved.
//

#import "XLAlertView.h"

///alertView  宽
#define AlertW KFit_W6S(560)
///各个栏目之间的距离
#define XLSpace KFit_W6S(20)

@interface XLAlertView()

//弹窗
@property (nonatomic,retain) UIView *alertView;
//title
@property (nonatomic,retain) UILabel *titleLbl;
//内容
@property (nonatomic,retain) UILabel *msgLbl;
//确认按钮
@property (nonatomic,retain) UIButton *sureBtn;
//取消按钮
@property (nonatomic,retain) UIButton *cancleBtn;
//横线线
@property (nonatomic,retain) UIView *lineView;
//竖线
@property (nonatomic,retain) UIView *verLineView;

@end

@implementation XLAlertView

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message sureBtn:(NSString *)sureTitle cancleBtn:(NSString *)cancleTitle
{
    if (self == [super init]) {
        
        self.frame = [UIScreen mainScreen].bounds;
        
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
        self.alertView = [[UIView alloc] init];
        self.alertView.backgroundColor = [UIColor whiteColor];
        self.alertView.layer.cornerRadius = 10.0;
        self.alertView.layer.masksToBounds = YES;
        self.alertView.frame = CGRectMake(0, 0, AlertW, 100);
        self.alertView.layer.position = self.center;
        
        if (title) {
            
            self.titleLbl = [self GetAdaptiveLable:CGRectMake(2*XLSpace, 2*XLSpace, AlertW-4*XLSpace, 20) AndText:title andIsTitle:YES];
            self.titleLbl.textAlignment = NSTextAlignmentCenter;
            
            [self.alertView addSubview:self.titleLbl];
            
            CGFloat titleW = self.titleLbl.bounds.size.width;
            CGFloat titleH = self.titleLbl.bounds.size.height;
            
            self.titleLbl.frame = CGRectMake((AlertW-titleW)/2, 2*XLSpace, titleW, titleH);
            
        }
        if (message) {
            
            self.msgLbl = [self GetAdaptiveLable:CGRectMake(XLSpace, CGRectGetMaxY(self.titleLbl.frame)+XLSpace, AlertW-2*XLSpace, 20) AndText:message andIsTitle:NO];
            self.msgLbl.textAlignment = NSTextAlignmentCenter;
            
            [self.alertView addSubview:self.msgLbl];
            
            CGFloat msgW = self.msgLbl.bounds.size.width;
            CGFloat msgH = self.msgLbl.bounds.size.height;
            
            self.msgLbl.frame = self.titleLbl?CGRectMake((AlertW-msgW)/2, CGRectGetMaxY(self.titleLbl.frame)+XLSpace, msgW, msgH):CGRectMake((AlertW-msgW)/2, 2*XLSpace, msgW, msgH);
            
        }
        
        self.lineView = [[UIView alloc] init];
        self.lineView.frame = self.msgLbl?CGRectMake(0, CGRectGetMaxY(self.msgLbl.frame)+2*XLSpace, AlertW, 1):CGRectMake(0, CGRectGetMaxY(self.titleLbl.frame)+2*XLSpace, AlertW, 1);
        self.lineView.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.6];
        [self.alertView addSubview:self.lineView];
        
        //两个按钮
        if (cancleTitle && sureTitle) {
            
            self.cancleBtn = [[UIButton alloc] init];
            [self.cancleBtn setTitleColor:kColor_N(9, 9, 9) forState:UIControlStateNormal];
            self.cancleBtn.frame = CGRectMake(0, CGRectGetMaxY(self.lineView.frame), (AlertW-1)/2, 40);
            [self.cancleBtn setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.2]] forState:UIControlStateNormal];
            [self.cancleBtn setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.2]] forState:UIControlStateSelected];
            [self.cancleBtn setTitle:cancleTitle forState:UIControlStateNormal];
            //[self.cancleBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            self.cancleBtn.tag = 1;
            [self.cancleBtn addTarget:self action:@selector(buttonEvent:) forControlEvents:UIControlEventTouchUpInside];
            
            UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.cancleBtn.bounds byRoundingCorners:UIRectCornerBottomLeft cornerRadii:CGSizeMake(5.0, 5.0)];
            CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
            maskLayer.frame = self.cancleBtn.bounds;
            maskLayer.path = maskPath.CGPath;
            self.cancleBtn.layer.mask = maskLayer;
            
            [self.alertView addSubview:self.cancleBtn];
        }
        
        if (cancleTitle && sureTitle) {
            self.verLineView = [[UIView alloc] init];
            self.verLineView.frame = CGRectMake(CGRectGetMaxX(self.cancleBtn.frame), CGRectGetMaxY(self.lineView.frame), 1, 40);
            self.verLineView.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.6];
            [self.alertView addSubview:self.verLineView];
        }
        
        if(sureTitle && cancleTitle){
            
            self.sureBtn = [[UIButton alloc] init];
            [self.sureBtn setTitleColor:kColor_N(33, 130, 237) forState:UIControlStateNormal];
            self.sureBtn.frame = CGRectMake(CGRectGetMaxX(self.verLineView.frame), CGRectGetMaxY(self.lineView.frame), (AlertW-1)/2+1, 40);
            [self.sureBtn setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.2]] forState:UIControlStateNormal];
            [self.sureBtn setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.2]] forState:UIControlStateSelected];
            [self.sureBtn setTitle:sureTitle forState:UIControlStateNormal];
            //[self.sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            self.sureBtn.tag = 2;
            [self.sureBtn addTarget:self action:@selector(buttonEvent:) forControlEvents:UIControlEventTouchUpInside];
            
            UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.sureBtn.bounds byRoundingCorners:UIRectCornerBottomRight cornerRadii:CGSizeMake(5.0, 5.0)];
            CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
            maskLayer.frame = self.sureBtn.bounds;
            maskLayer.path = maskPath.CGPath;
            self.sureBtn.layer.mask = maskLayer;
            
            [self.alertView addSubview:self.sureBtn];
            
        }
        
        //只有取消按钮
        if (cancleTitle && !sureTitle) {
            
            self.cancleBtn = [UIButton buttonWithType:UIButtonTypeSystem];
            self.cancleBtn.frame = CGRectMake(0, CGRectGetMaxY(self.lineView.frame), AlertW, 40);
            [self.cancleBtn setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.2]] forState:UIControlStateNormal];
            [self.cancleBtn setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.2]] forState:UIControlStateSelected];
            [self.cancleBtn setTitle:cancleTitle forState:UIControlStateNormal];
            //[self.cancleBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            self.cancleBtn.tag = 1;
            [self.cancleBtn addTarget:self action:@selector(buttonEvent:) forControlEvents:UIControlEventTouchUpInside];
            
            UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.cancleBtn.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(5.0, 5.0)];
            CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
            maskLayer.frame = self.cancleBtn.bounds;
            maskLayer.path = maskPath.CGPath;
            self.cancleBtn.layer.mask = maskLayer;
            
            [self.alertView addSubview:self.cancleBtn];
        }
        
        //只有确定按钮
        if(sureTitle && !cancleTitle){
            
            self.sureBtn = [UIButton buttonWithType:UIButtonTypeSystem];
            self.sureBtn.frame = CGRectMake(0, CGRectGetMaxY(self.lineView.frame), AlertW, 40);
            [self.sureBtn setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.2]] forState:UIControlStateNormal];
            [self.sureBtn setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.2]] forState:UIControlStateSelected];
            [self.sureBtn setTitle:sureTitle forState:UIControlStateNormal];
            //[self.sureBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            self.sureBtn.tag = 2;
            [self.sureBtn addTarget:self action:@selector(buttonEvent:) forControlEvents:UIControlEventTouchUpInside];
            
            UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.sureBtn.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(5.0, 5.0)];
            CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
            maskLayer.frame = self.sureBtn.bounds;
            maskLayer.path = maskPath.CGPath;
            self.sureBtn.layer.mask = maskLayer;
            
            [self.alertView addSubview:self.sureBtn];
            
        }
        
        //计算高度
        CGFloat alertHeight = cancleTitle?CGRectGetMaxY(self.cancleBtn.frame):CGRectGetMaxY(self.sureBtn.frame);
        self.alertView.frame = CGRectMake(0, 0, AlertW, alertHeight);
        self.alertView.layer.position = self.center;
        
        [self addSubview:self.alertView];
    }
    
    return self;
}

- (instancetype)initWithButTitle:(NSString *)titleOne ButImg:(NSString *)imgOne titleTwo:(NSString *)titleTwo ButimgTwo:(NSString *)imgTwo{
    if (self == [super init]) {
        self.frame = [UIScreen mainScreen].bounds;
        self.backgroundColor = kRGBAColor(5, 5, 5, 0.8);
        self.alertView = [[UIView alloc] init];
        self.alertView.backgroundColor = [UIColor whiteColor];
        self.alertView.layer.cornerRadius = 5.0;
        self.alertView.frame = CGRectMake(0, SCREEN_HEIGHT-KFit_H6S(250), SCREEN_WIDTH, KFit_H6S(250));
        
        XLxqbut *butone = [[XLxqbut alloc] init];
        [self.alertView addSubview:butone];
        [butone mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.alertView);
            make.centerX.mas_equalTo(self.alertView).mas_offset(-SCREEN_WIDTH/4.0);
            make.width.height.mas_equalTo(KFit_H6S(200));
        }];
        [butone setTitle:titleOne forState:UIControlStateNormal];
        [butone setImage:[UIImage imageNamed:imgOne] forState:UIControlStateNormal];
        butone.tag = 0;
        [butone addTarget:self action:@selector(buttonEvent:) forControlEvents:UIControlEventTouchUpInside];
        [butone setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        XLxqbut *buttwo = [[XLxqbut alloc] init];
        [self.alertView addSubview:buttwo];
        [buttwo mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.alertView);
            make.centerX.mas_equalTo(self.alertView).mas_offset(SCREEN_WIDTH/4.0);
            make.width.height.mas_equalTo(KFit_H6S(200));
        }];
        [buttwo setTitle:titleTwo forState:UIControlStateNormal];
        [buttwo setImage:[UIImage imageNamed:imgTwo] forState:UIControlStateNormal];
        buttwo.tag = 1;
        [buttwo addTarget:self action:@selector(buttonEvent:) forControlEvents:UIControlEventTouchUpInside];
        [buttwo setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self addSubview:self.alertView];
        
        
        UITapGestureRecognizer *dianji=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(quit)];
        [self addGestureRecognizer:dianji];
    }
    return self;
}
- (instancetype)initWithMessage:(NSString *)message SuccessOrFailure:(BOOL)bol{
    if (self == [super init]) {
        self.frame = [UIScreen mainScreen].bounds;
        self.backgroundColor = kRGBAColor(5, 5, 5, 0.6);
        self.alertView = [[UIView alloc] init];
        self.alertView.backgroundColor = [UIColor whiteColor];
        self.alertView.layer.cornerRadius = 20;
        [self addSubview:self.alertView];
        [self.alertView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(self);
            make.size.mas_equalTo(CGSizeMake(KFit_W6S(350), KFit_H6S(300)));
        }];
        
        UIImageView *img = [[UIImageView alloc] init];
        [self.alertView addSubview:img];
        [img mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.alertView);
            make.top.mas_equalTo(self.alertView).mas_offset(KFit_H6S(45));
            make.size.mas_equalTo(CGSizeMake(KFit_W6S(100), KFit_H6S(100)));
        }];
        if (bol) {
            [img setImage:[UIImage imageNamed:@"ts_success"]];
        }else{
            [img setImage:[UIImage imageNamed:@"ts_failure"]];
        }
        
        UILabel *ts = [[UILabel alloc] init];
        ts.numberOfLines = 0;
        ts.font = [UIFont systemFontOfSize:kFit_Font6(17)];
        ts.textAlignment = NSTextAlignmentCenter;
        ts.text = message;
        [self.alertView addSubview:ts];
        [ts mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.alertView).mas_offset(KFit_W6S(25));
            make.right.mas_equalTo(self.alertView).mas_offset(-KFit_W6S(25));
            make.top.mas_equalTo(img.mas_bottom).mas_offset(KFit_H6S(20));
            make.bottom.mas_equalTo(self.alertView).mas_offset(-KFit_H6S(20));
        }];
        
//        UITapGestureRecognizer *dianji=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(quit)];
//        [self addGestureRecognizer:dianji];
    }
    return self;
}
- (instancetype)initWithInputboxTitle:(NSString *)title{
    if (self == [super init]) {
        self.frame = [UIScreen mainScreen].bounds;
        self.backgroundColor = kRGBAColor(5, 5, 5, 0.6);
        self.alertView = [[UIView alloc] init];
        self.alertView.backgroundColor = [UIColor whiteColor];
        self.alertView.layer.cornerRadius = 10;
        self.alertView.layer.masksToBounds = YES;
        [self addSubview:self.alertView];
        [self.alertView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self);
            make.centerY.mas_equalTo(self).mas_offset(-KFit_H6S(100));
            make.size.mas_equalTo(CGSizeMake(KFit_W6S(560), KFit_H6S(330)));
        }];
        
        
        
        UILabel *ts = [[UILabel alloc] init];
        ts.numberOfLines = 0;
        ts.font = [UIFont systemFontOfSize:kFit_Font6(17)];
        ts.textAlignment = NSTextAlignmentCenter;
        ts.text = title;
        [self.alertView addSubview:ts];
        [ts mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.alertView).mas_offset(KFit_W6S(25));
            make.right.mas_equalTo(self.alertView).mas_offset(-KFit_W6S(25));
            make.top.mas_equalTo(self.alertView).mas_offset(KFit_H6S(50));
            
        }];
        
        UITextField *field = [[UITextField alloc] init];
        [self.alertView addSubview:field];
        field.backgroundColor = kColor_N(243, 247, 244);
        field.layer.cornerRadius = 5;
        [field mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.alertView);
            make.top.mas_equalTo(ts.mas_bottom).mas_offset(KFit_H6S(35));
            make.size.mas_equalTo(CGSizeMake(KFit_W6S(450), KFit_H6S(60)));
        }];
        self.input = field;
        
        UIButton *qx = [[UIButton alloc] init];
        [self.alertView addSubview:qx];
        qx.layer.borderColor = appcoloer_line.CGColor;
        qx.layer.borderWidth = 0.7;
        [qx setTitle:@"取消" forState:UIControlStateNormal];
        [qx setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [qx addTarget:self action:@selector(quit) forControlEvents:UIControlEventTouchUpInside];
        [qx mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.mas_equalTo(self.alertView);
            make.size.mas_equalTo(CGSizeMake(KFit_W6S(280), KFit_H6S(90)));
        }];
        
        UIButton *qd = [[UIButton alloc] init];
        [self.alertView addSubview:qd];
        [qd setTitle:@"保存" forState:UIControlStateNormal];
        [qd setTitleColor:kColor_N(0, 120, 237) forState:UIControlStateNormal];
        [qd addTarget:self action:@selector(determineInput) forControlEvents:UIControlEventTouchUpInside];
        qd.layer.borderColor = appcoloer_line.CGColor;
        qd.layer.borderWidth = 0.7;
        [qd mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.bottom.mas_equalTo(self.alertView);
            make.size.mas_equalTo(CGSizeMake(KFit_W6S(280), KFit_H6S(90)));
        }];
    }
    return self;
    
}



- (instancetype)initWithMessage:(NSString *)message{
    if (self == [super init]) {
        self.frame = [UIScreen mainScreen].bounds;
        self.backgroundColor = kRGBAColor(5, 5, 5, 0.6);
        self.alertView = [[UIView alloc] init];
        self.alertView.backgroundColor = [UIColor whiteColor];
        self.alertView.layer.cornerRadius = 8;
        [self addSubview:self.alertView];
        [self.alertView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(self);
            make.size.mas_equalTo(CGSizeMake(KFit_W6S(560), KFit_H6S(220)));
        }];
        
        UILabel *title = [[UILabel alloc] init];
        [self.alertView addSubview:title];
        title.font = [UIFont systemFontOfSize:kFit_Font6(18)];
        title.textAlignment = NSTextAlignmentCenter;
        title.textColor = kColor_N(148, 160, 182);
        title.text = @"提示";
        [title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.alertView).mas_offset(KFit_W6S(25));
            make.right.mas_equalTo(self.alertView).mas_offset(-KFit_W6S(25));
            make.top.mas_equalTo(self.alertView).mas_offset(KFit_H6S(60));
            make.height.mas_equalTo(KFit_H6S(40));
        }];
        
        
        UILabel *ts = [[UILabel alloc] init];
//        ts.numberOfLines = 0;
        ts.font = [UIFont systemFontOfSize:kFit_Font6(15)];
        ts.textAlignment = NSTextAlignmentCenter;
        ts.text = message;
        ts.numberOfLines = 2;
        [self.alertView addSubview:ts];
        [ts mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.alertView).mas_offset(KFit_W6S(25));
            make.right.mas_equalTo(self.alertView).mas_offset(-KFit_W6S(25));
            make.top.mas_equalTo(title.mas_bottom).mas_offset(KFit_H6S(20));
            make.height.mas_equalTo(KFit_H6S(80));
        }];
        
        //        UITapGestureRecognizer *dianji=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(quit)];
        //        [self addGestureRecognizer:dianji];
    }
    return self;
}


-(void)quit{
    [self removeFromSuperview];
}
#pragma mark - 输入框确定回调
- (void)determineInput{
    self.inputText(self.input.text);
    [self removeFromSuperview];
}
#pragma mark - 弹出 -
- (void)showXLAlertView
{
    UIWindow *rootWindow = [UIApplication sharedApplication].keyWindow;
    [rootWindow addSubview:self];
//    [self creatShowAnimation];
}

- (void)showPrompt{
    UIWindow *rootWindow = [UIApplication sharedApplication].keyWindow;
    [rootWindow addSubview:self];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self removeFromSuperview];
        
    });
}

- (void)creatShowAnimation
{
    self.alertView.layer.position = self.center;
    self.alertView.transform = CGAffineTransformMakeScale(0.90, 0.90);
    [UIView animateWithDuration:0.25 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:1 options:UIViewAnimationOptionCurveLinear animations:^{
        self.alertView.transform = CGAffineTransformMakeScale(1.0, 1.0);
    } completion:^(BOOL finished) {
    }];
}

#pragma mark - 回调 -设置只有2  -- > 确定才回调
- (void)buttonEvent:(UIButton *)sender
{
//    if (sender.tag == 2) {
        if (self.resultIndex) {
            self.resultIndex(sender.tag);
        }
//    }
    [self removeFromSuperview];
}

-(UILabel *)GetAdaptiveLable:(CGRect)rect AndText:(NSString *)contentStr andIsTitle:(BOOL)isTitle
{
    UILabel *contentLbl = [[UILabel alloc] initWithFrame:rect];
    contentLbl.numberOfLines = 0;
    contentLbl.text = contentStr;
    contentLbl.textAlignment = NSTextAlignmentCenter;
    if (isTitle) {
        contentLbl.font = [UIFont boldSystemFontOfSize:16.0];
    }else{
        contentLbl.font = [UIFont systemFontOfSize:14.0];
    }
    
    NSMutableAttributedString *mAttrStr = [[NSMutableAttributedString alloc] initWithString:contentStr];
    NSMutableParagraphStyle *mParaStyle = [[NSMutableParagraphStyle alloc] init];
    mParaStyle.lineBreakMode = NSLineBreakByCharWrapping;
    [mParaStyle setLineSpacing:3.0];
    [mAttrStr addAttribute:NSParagraphStyleAttributeName value:mParaStyle range:NSMakeRange(0,[contentStr length])];
    [contentLbl setAttributedText:mAttrStr];
    [contentLbl sizeToFit];
    
    return contentLbl;
}

-(UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

@end

