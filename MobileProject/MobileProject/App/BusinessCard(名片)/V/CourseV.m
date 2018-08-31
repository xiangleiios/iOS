//
//  CourseV.m
//  MobileProject
//
//  Created by 向蕾 on 2018/8/23.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import "CourseV.h"
#import "LicenseTayeV.h"
#import "UITextView+ZWPlaceHolder.h"
@implementation CourseV

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
- (instancetype)initWithDictionary:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        self.dic = dic;
        [self loadSubview];
    }
    return self;
}

- (void)loadSubview{
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    self.backgroundColor = kRGBAColor(0, 0, 0, 0.8);
//    self.contentSize = CGSizeMake(0, SCREEN_HEIGHT+kNavBarH);
//    UIScrollView *scr = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
//    [self addSubview:scr];
    
    UIView *bacview = [[UIView alloc] init];
    [self addSubview:bacview];
    bacview.layer.cornerRadius = 5;
    bacview.layer.masksToBounds = YES;
    bacview.backgroundColor = [UIColor whiteColor];
    [bacview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self);
        make.size.mas_equalTo(CGSizeMake(KFit_W6S(640), KFit_H6S(910)));
    }];
    
    XLInformationV *biaoTi;
    if (self.dic) {
        biaoTi = [[XLInformationV alloc] informationWithTitle:@"修改课程"];
    }else{
        biaoTi = [[XLInformationV alloc] informationWithTitle:@"创建课程"];
    }
    [bacview addSubview:biaoTi];
    [biaoTi mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(bacview);
        make.height.mas_equalTo(KFit_H6S(90));
    }];
    
    
    UIButton *down = [[UIButton alloc] init];
    [biaoTi addSubview:down];
    [down addTarget:self action:@selector(shutDown) forControlEvents:UIControlEventTouchUpInside];
    [down setImage:[UIImage imageNamed:@"deletez"] forState:UIControlStateNormal];
    [down mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(bacview).mas_offset(-KFit_W6S(40));
        make.centerY.mas_equalTo(biaoTi);
        make.size.mas_equalTo(CGSizeMake(KFit_W6S(40), KFit_W6S(40)));
    }];
    
    self.name = [[XLInformationV alloc] informationWithTitle:@"课程名称" SubTitle:@"" TSSubTitle:@"例如：普通班/VIP班" Must:YES Click:NO];
    [bacview addSubview:self.name];
    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(biaoTi.mas_bottom);
        make.left.right.mas_equalTo(bacview);
        make.height.mas_equalTo(KFit_H6S(90));
    }];
    
    LicenseTayeV *license = [[LicenseTayeV alloc] init];
    [bacview addSubview:license];
    license.textBlock = ^(NSString *text) {
        KKLog(@"%@",text);
        
    };
    [license mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.name.mas_bottom);
        make.left.right.mas_equalTo(bacview);
        make.height.mas_equalTo(KFit_H6S(225));
    }];
    
    self.price = [[XLInformationV alloc] informationWithTitle:@"课程价格" SubTitle:@"" TSSubTitle:@"请输入课程价格" Must:YES Click:NO];
    [bacview addSubview:self.price];
    [self.price mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(license.mas_bottom);
        make.left.right.mas_equalTo(bacview);
        make.height.mas_equalTo(KFit_H6S(90));
    }];
    
    UILabel *jieshao = [[UILabel alloc] init];
    jieshao.text = @"课程介绍";
    [bacview addSubview:jieshao];
    [jieshao mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.price.mas_bottom);
        make.left.mas_equalTo(bacview).mas_offset(KFit_W6S(30));
        make.height.mas_equalTo(KFit_H6S(90));
    }];
    
    
    UIImageView *box = [[UIImageView alloc] init];
    [box setImage:[UIImage imageNamed:@"box"]];
    [bacview addSubview:box];
    [box mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(jieshao.mas_bottom);
        make.left.mas_equalTo(bacview).mas_offset(KFit_W6S(30));
        make.right.mas_equalTo(bacview).mas_offset(-KFit_W6S(30));
        make.height.mas_equalTo(KFit_H6S(180));
        
    }];
    
    
    self.textView = [[UITextView alloc] init];
    self.textView.backgroundColor = [UIColor clearColor];
    self.textView.font = [UIFont systemFontOfSize:kFit_Font6(16)];
    self.textView.placeholder = @"请填写课程介绍，例如：周一至周日，随到随学";
    [bacview addSubview:self.textView];
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(box).mas_offset(KFit_W6S(20));
        make.right.bottom.mas_equalTo(box).mas_offset(-KFit_W6S(20));
    }];
    
    if (self.dic) {
        UIButton *change = [[UIButton alloc] init];
        [bacview addSubview:change];
        [change setTitle:@"修改" forState:UIControlStateNormal];
        [change setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [change addTarget:self action:@selector(toChange) forControlEvents:UIControlEventTouchUpInside];
        change.backgroundColor = kColor_N(0, 104, 215);
        change.layer.cornerRadius = 5;
        change.layer.masksToBounds = YES;
        
        UIButton *share = [[UIButton alloc] init];
        [bacview addSubview:share];
        [share setTitle:@"删除" forState:UIControlStateNormal];
        [share setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        share.backgroundColor = kColor_N(148, 160, 181);
        share.layer.cornerRadius = 5;
        share.layer.masksToBounds = YES;
        
        NSArray *arr = @[change,share];
        [arr mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:KFit_W6S(30) leadSpacing:KFit_W6S(30) tailSpacing:KFit_W6S(30)];
        [arr mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(bacview).mas_offset(-KFit_H6S(30));
            make.height.mas_equalTo(KFit_H6S(90));
        }];
    }else{
        UIButton *next = [[UIButton alloc] init];
        [bacview addSubview:next];
        [next setTitle:@"创建" forState:UIControlStateNormal];
        [next addTarget:self action:@selector(create) forControlEvents:UIControlEventTouchUpInside];
        next.backgroundColor = kColor_N(0, 112, 234);
        [next setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        next.layer.cornerRadius = 5;
        next.layer.masksToBounds = YES;
        [next mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(bacview).mas_offset(KFit_W6S(30));
            make.right.mas_equalTo(bacview).mas_offset(-KFit_W6S(30));
            make.bottom.mas_equalTo(bacview).mas_offset(-KFit_W6S(30));
            make.height.mas_equalTo(KFit_H6S(90));
        }];
    }
    
}

#pragma mark - 删除
- (void)deleteCoures{
    
}

#pragma mark - 修改
- (void)toChange{
    
}
#pragma mark - 创建
- (void)create{
    
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
