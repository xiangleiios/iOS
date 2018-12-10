//
//  ScreeningV.m
//  MobileProject
//
//  Created by 向蕾 on 2018/10/11.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import "ScreeningV.h"

@implementation ScreeningV

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
        [self loadSub];
    }
    return self;
}

- (void)loadSub{
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    UIView *back = [[UIView alloc] initWithFrame:CGRectMake(0, (kNavBarH + KFit_H6S(300)), SCREEN_WIDTH, SCREEN_HEIGHT - (kNavBarH + KFit_H6S(300)))];
    self.backview = back;
    [self addSubview:back];
    self.scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - (kNavBarH + KFit_H6S(300)))];
    [self.backview  addSubview:self.scroll];
    
    back.backgroundColor = kRGBAColor(0, 0, 0, 0.8);
}

- (void)setDataArr:(NSArray *)dataArr{
    _dataArr = dataArr;
    NSMutableArray *arr = [NSMutableArray array];
    XLView *back = [[XLView alloc] init];
    [self.scroll addSubview:back];
    [back mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self);
        make.top.mas_equalTo(self.scroll);
        make.height.mas_equalTo(dataArr.count * KFit_H6S(90));
    }];
    if (dataArr.count == 1) {
        UIButton *but = [[UIButton alloc] init];
        [but setTitle:dataArr[0] forState:UIControlStateNormal];
        [but setTitleColor:kColor_N(64, 78, 108) forState:UIControlStateNormal];
        [but setTitleColor:kColor_N(0, 109, 234) forState:UIControlStateSelected];
        but.backgroundColor = [UIColor whiteColor];
        but.titleLabel.font = [UIFont systemFontOfSize:kFit_Font6(16)];
        but.tag = 0;
        but.layer.borderWidth = 0.3;
        but.layer.borderColor = kColor_N(235, 235, 235).CGColor;
        [back addSubview:but];
        [but addTarget:self action:@selector(selectionState:) forControlEvents:UIControlEventTouchUpInside];
        
        self.selectBut = but;
        but.selected = YES;
        [but mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.bottom.mas_equalTo(back);
        }];
    }else{
        for (int i = 0 ; i < dataArr.count; i++) {
            UIButton *but = [[UIButton alloc] init];
            [but setTitle:dataArr[i] forState:UIControlStateNormal];
            [but setTitleColor:kColor_N(64, 78, 108) forState:UIControlStateNormal];
            [but setTitleColor:kColor_N(0, 109, 234) forState:UIControlStateSelected];
            but.backgroundColor = [UIColor whiteColor];
            but.titleLabel.font = [UIFont systemFontOfSize:kFit_Font6(16)];
            but.tag = i;
            but.layer.borderWidth = 0.3;
            but.layer.borderColor = kColor_N(235, 235, 235).CGColor;
            [back addSubview:but];
            [but addTarget:self action:@selector(selectionState:) forControlEvents:UIControlEventTouchUpInside];
            if (i == 0) {
                self.selectBut = but;
                but.selected = YES;
            }
            [arr addObject:but];
        }
        [arr mas_distributeViewsAlongAxis:MASAxisTypeVertical withFixedSpacing:0.1 leadSpacing:0.1 tailSpacing:0.1];
        [arr mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(back);
        }];
    }
    
    self.scroll.contentSize = CGSizeMake(0, dataArr.count * KFit_H6S(90));
    
}


- (void)selectionState:(UIButton *)senter{
    self.selectBut.selected = NO;
    senter.selected = YES;
    self.selectBut = senter;
    [self.delegate ScreeningVDelegat:self Index:senter.tag];
    [self removeFromSuperview];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self removeFromSuperview];
}

#pragma mark - 弹出
- (void)show{
    UIWindow *rootWindow = [UIApplication sharedApplication].keyWindow;
    [rootWindow addSubview:self];
    //    [self creatShowAnimation];
}
#pragma mark - 退出
- (void)shutDown{
    [self removeFromSuperview];
}

@end
