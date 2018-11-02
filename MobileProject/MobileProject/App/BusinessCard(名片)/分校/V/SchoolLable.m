//
//  SchoolLable.m
//  MobileProject
//
//  Created by 向蕾 on 2018/10/31.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import "SchoolLable.h"
#import "SelectLabelShow.h"
@implementation SchoolLable

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
        self.imgArr = @[@"blue",@"green",@"orange",@"parper"];
        self.titleArr = @[@" 包接送",@" 约课方便",@" 自有考场",@" 收费透明"];
        [self loadSubview];
    }
    return self;
}

- (void)loadSubview{
    self.backgroundColor = [UIColor whiteColor];
    kWeakSelf(self)
    _name = [[XLInformationV alloc] informationWithTitle:@"展示标签" ButTile:@"选择标签" ButImg:nil];
    _name.senterBlock = ^{
        SelectLabelShow *v = [[SelectLabelShow alloc] init];
        v.dataArr = weakself.dataArr;
        v.schoollb = weakself;
        [v show];
    };
    [self addSubview:_name];
    [_name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(self);
        make.height.mas_equalTo(KFit_H6S(90));
    }];
    
    self.backview = [[UIScrollView alloc] init];
    [self addSubview:self.backview];
    [_backview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self);
        make.top.mas_equalTo(_name.mas_bottom);
    }];
    
    self.tslb = [[UILabel alloc] init];
    [self addSubview:self.tslb];
    self.tslb.text = @"无数据";
    self.tslb.textAlignment = NSTextAlignmentCenter;
    self.tslb.font = [UIFont systemFontOfSize:kFit_Font6(15)];
    self.tslb.textColor = kColor_N(166, 175, 193);
    [self.tslb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.top.mas_equalTo(self.backview);
    }];
}

- (void)setDataArr:(NSArray *)dataArr{
    _dataArr = dataArr;
    [[self.backview subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    float w = KFit_W6S(190);
    float h = KFit_H6S(50);
    if (dataArr.count > 0) {
        self.tslb.hidden = YES;
        for (int i = 0; i < dataArr.count; i++) {
            UIButton *but = [[UIButton alloc] initWithFrame:CGRectMake(KFit_W6S(20) + i * w, KFit_H6S(20), w, h)];
            NSString *str = dataArr[i];
            int j = [str intValue] - 1;
            but.titleLabel.font = [UIFont systemFontOfSize:kFit_Font6(14)];
            [but setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [but setImage:[UIImage imageNamed:self.imgArr[j]] forState:UIControlStateNormal];
            [but setTitle:self.titleArr[j] forState:UIControlStateNormal];
            but.userInteractionEnabled = NO;
            [self.backview addSubview:but];
            
        }
    }else{
        self.tslb.hidden = NO;
    }
    self.backview.contentSize = CGSizeMake(KFit_W6S(20) + dataArr.count * w, 0);
}
@end
