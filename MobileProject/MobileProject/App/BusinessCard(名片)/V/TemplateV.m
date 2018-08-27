//
//  TemplateV.m
//  MobileProject
//
//  Created by 向蕾 on 2018/8/24.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import "TemplateV.h"
#import "XLInformationV.h"
@implementation TemplateV

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
    self.frame = [UIScreen mainScreen].bounds;
    self.backgroundColor = kRGBAColor(0, 0, 0, 0.8);
    
    UIView *bacview = [[UIView alloc] init];
    [self addSubview:bacview];
    bacview.layer.cornerRadius = 5;
    bacview.layer.masksToBounds = YES;
    bacview.backgroundColor = [UIColor whiteColor];
    [bacview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self);
        make.size.mas_equalTo(CGSizeMake(KFit_W6S(640), KFit_H6S(910)));
    }];
    
    XLInformationV *biaoTi = [[XLInformationV alloc] informationWithTitle:@"模板一"];;
    [bacview addSubview:biaoTi];
    [biaoTi mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(bacview);
        make.height.mas_equalTo(KFit_H6S(90));
    }];
    
    
    UIButton *down = [[UIButton alloc] init];
    [biaoTi addSubview:down];
    [down addTarget:self action:@selector(changeTemplate) forControlEvents:UIControlEventTouchUpInside];
    [down setImage:[UIImage imageNamed:@"refresh"] forState:UIControlStateNormal];
    [down setTitle:@"换一个" forState:UIControlStateNormal];
    [down setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    down.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    down.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, KFit_W6S(1));
    down.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, KFit_W6S(10));
    [down mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(bacview).mas_offset(-KFit_W6S(40));
        make.centerY.mas_equalTo(biaoTi);
        make.size.mas_equalTo(CGSizeMake(KFit_W6S(180), KFit_W6S(50)));
    }];
    
    UIImageView *box = [[UIImageView alloc] init];
    [box setImage:[UIImage imageNamed:@"big_box"]];
    [bacview addSubview:box];
    [box mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(biaoTi.mas_bottom).mas_offset(KFit_H6S(30));
        make.left.mas_equalTo(bacview).mas_offset(KFit_W6S(30));
        make.right.mas_equalTo(bacview).mas_offset(-KFit_W6S(30));
        make.height.mas_equalTo(KFit_H6S(640));
        
    }];
    
    self.textView = [[UITextView alloc] init];
    self.textView.backgroundColor = [UIColor clearColor];
    [bacview addSubview:self.textView];
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(box).mas_offset(KFit_W6S(20));
        make.right.bottom.mas_equalTo(box).mas_offset(-KFit_W6S(20));
    }];
    
    UIButton *quxiao = [[UIButton alloc] init];
    [bacview addSubview:quxiao];
    [quxiao setTitle:@"取消" forState:UIControlStateNormal];
    [quxiao setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [quxiao addTarget:self action:@selector(shutDown) forControlEvents:UIControlEventTouchUpInside];
    quxiao.backgroundColor = kColor_N(148, 160, 181);
    quxiao.layer.cornerRadius = 5;
    quxiao.layer.masksToBounds = YES;
    
    UIButton *change = [[UIButton alloc] init];
    [bacview addSubview:change];
    [change setTitle:@"选择" forState:UIControlStateNormal];
    [change setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [change addTarget:self action:@selector(toChange) forControlEvents:UIControlEventTouchUpInside];
    change.backgroundColor = kColor_N(0, 104, 215);
    change.layer.cornerRadius = 5;
    change.layer.masksToBounds = YES;
    
    
    
    NSArray *arr = @[quxiao,change];
    [arr mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:KFit_W6S(30) leadSpacing:KFit_W6S(30) tailSpacing:KFit_W6S(30)];
    [arr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(bacview).mas_offset(-KFit_H6S(30));
        make.height.mas_equalTo(KFit_H6S(90));
    }];
}

- (void)changeTemplate{
    
}


#pragma mark - 退出
- (void)shutDown{
    [self removeFromSuperview];
}
#pragma mark - 弹出
- (void)show{
    UIWindow *rootWindow = [UIApplication sharedApplication].keyWindow;
    [rootWindow addSubview:self];
    //    [self creatShowAnimation];
}
@end
