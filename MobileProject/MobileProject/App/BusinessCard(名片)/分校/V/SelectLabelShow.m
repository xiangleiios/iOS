//
//  SelectLabelShow.m
//  MobileProject
//
//  Created by 向蕾 on 2018/11/2.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import "SelectLabelShow.h"

@implementation SelectLabelShow
- (NSMutableArray *)butArr{
    if (_butArr == nil) {
        _butArr = [NSMutableArray array];
    }
    return _butArr;
}

- (NSMutableArray *)SelectButArr{
    if (_SelectButArr == nil) {
        _SelectButArr = [NSMutableArray array];
    }
    return _SelectButArr;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.dataArr = @[@"blue",@"green",@"orange",@"parper"];
        self.titleArr = @[@"包接送      班车或教练接送",@"约课方便   支持线上约课",@"自有考场   自己有考试场地",@"收费透明   明码标价无隐形收费"];
        [self loadSubview];
    }
    return self;
}


- (void)loadSubview{
    self.frame = [UIScreen mainScreen].bounds;
    self.backgroundColor = kRGBAColor(0, 0, 0, 0.8);
    self.backview = [[XLView alloc] init];
    [self addSubview:self.backview];
    [self.backview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self);
        make.width.mas_equalTo(KFit_W6S(600));
        make.height.mas_equalTo(KFit_H6S(420));
    }];
    
    self.backview.backgroundColor = [UIColor whiteColor];
    self.backview.layer.cornerRadius = 5;
    self.backview.layer.masksToBounds = YES;
    
    UILabel *lab = [[UILabel alloc] init];
    [self.backview addSubview:lab];
    lab.text = @"选择标签";
    lab.textAlignment = NSTextAlignmentCenter;
    lab.backgroundColor = kColor_N(235, 238, 243);
    lab.font = [UIFont systemFontOfSize:kFit_Font6(19)];
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(self.backview);
        make.height.mas_equalTo(KFit_H6S(100));
    }];
    
    
    UIView *view = [[UIView alloc] init];
    [self.backview addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.backview);
        make.top.mas_equalTo(lab.mas_bottom);
        make.height.mas_equalTo(KFit_H6S(360));
    }];
    NSMutableArray *arr = [NSMutableArray array];
    for (int i = 0; i < _dataArr.count; i++) {
        UIView *v = [self loadViewWithIndex:i];
        [view addSubview:v];
        [arr addObject:v];
    }
    [arr mas_distributeViewsAlongAxis:MASAxisTypeVertical withFixedSpacing:0.1 leadSpacing:0.1 tailSpacing:0.1];
    [arr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(view);
    }];

    
    UILabel *lbo = [[UILabel alloc] init];
    [self.backview addSubview:lbo];
    lbo.backgroundColor = kColor_N(240, 240, 240);
    [lbo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.backview);
        make.top.mas_equalTo(view.mas_bottom);
        make.height.mas_equalTo(1);
    }];
    
    
    
    
    UIButton *quxiao = [[UIButton alloc] init];
    [self.backview addSubview:quxiao];
    [quxiao setTitle:@"取消" forState:UIControlStateNormal];
    [quxiao setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [quxiao addTarget:self action:@selector(shutDown) forControlEvents:UIControlEventTouchUpInside];
    [quxiao mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.backview);
        make.top.mas_equalTo(lbo.mas_bottom);
        make.height.mas_equalTo(KFit_H6S(100));
        make.width.mas_equalTo(KFit_W6S(300));
    }];
    
    
    UIButton *queding = [[UIButton alloc] init];
    [self.backview addSubview:queding];
    [queding setTitle:@"确定" forState:UIControlStateNormal];
    [queding setTitleColor:kColor_N(0, 98, 233) forState:UIControlStateNormal];
    [queding addTarget:self action:@selector(queding) forControlEvents:UIControlEventTouchUpInside];
    [queding mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.backview);
        make.top.mas_equalTo(lbo.mas_bottom);
        make.height.mas_equalTo(KFit_H6S(100));
        make.width.mas_equalTo(KFit_W6S(300));
    }];
    
    
    [self.backview mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self);
        make.width.mas_equalTo(KFit_W6S(560));
        make.height.mas_equalTo([self.backview getLayoutCellHeight]);
    }];
}

- (UIView *)loadViewWithIndex:(NSInteger)index{
    UIView *v = [[UIView alloc] init];
    
    UIButton *but = [[UIButton alloc] init];
    [v addSubview:but];
    [but mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(v).mas_offset(KFit_W6S(20));
        make.centerY.mas_equalTo(v);
        make.width.height.mas_equalTo(KFit_W6S(56));
    }];
    but.tag = index;
    [but setImage:[UIImage imageNamed:@"nor_button"] forState:UIControlStateNormal];
    [but setImage:[UIImage imageNamed:@"down_button"] forState:UIControlStateSelected];
    [but addTarget:self action:@selector(selectBut:) forControlEvents:UIControlEventTouchUpInside];
    [self.butArr addObject:but];
    
    UIImageView *img = [[UIImageView alloc] init];
    [img setImage:[UIImage imageNamed:self.dataArr[index]]];
    [v addSubview:img];
    [img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(v);
        make.left.mas_equalTo(but.mas_right).mas_offset(KFit_W6S(10));
        make.width.height.mas_equalTo(KFit_W6S(36));
    }];
    
    UILabel *lb = [[UILabel alloc] init];
    [v addSubview:lb];
    lb.text = self.titleArr[index];
    lb.font = [UIFont systemFontOfSize:kFit_Font6(14)];
    [lb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(img.mas_right).mas_offset(KFit_W6S(10));
        make.right.mas_equalTo(v).mas_offset(-KFit_W6S(20));
        make.top.bottom.mas_equalTo(v);
    }];
    return v;
}

- (void)selectBut:(UIButton *)senter{
    senter.selected = !senter.selected;
}
- (void)setDataArr:(NSArray *)dataArr{
    _dataArr = dataArr;
    for (NSString *str in dataArr) {
        NSInteger i = [str integerValue];
        i--;
        UIButton *but = self.butArr[i];
        but.selected = YES;
    }
}
- (void)queding{
    for (UIButton *but in self.butArr) {
        if (but.selected) {
            [self.SelectButArr addObject:[NSString stringWithFormat:@"%ld",(but.tag + 1)]];
        }
    }
    self.schoollb.dataArr = self.SelectButArr;
    [self removeFromSuperview];
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
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
