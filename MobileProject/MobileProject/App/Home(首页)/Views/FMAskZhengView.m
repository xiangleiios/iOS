//
//  FMAskZhengView.m
//  MobileProject
//
//  Created by Mingo on 2017/8/1.
//  Copyright © 2017年 ZSGY. All rights reserved.
//

#import "FMAskZhengView.h"

#define padding KFit_W6S(20)

@implementation FMAskZhengView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.back = [[UIView alloc] init];
        [self addSubview:_back];
        _back.backgroundColor = kWhiteColor;

        [_back mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.mas_equalTo(self);
        }];
        
        self.yfAskZhengHeadlinesIma = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"news_blue"]];
        [_back addSubview:_yfAskZhengHeadlinesIma];
        [_yfAskZhengHeadlinesIma mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(KFit_W6S(28), KFit_W6S(28)));
            make.centerY.mas_equalTo(_back);
            make.left.mas_equalTo(_back);
        }];
        
    }
    return self;
}

- (void)setDataArr:(NSArray *)dataArr{
    _dataArr=dataArr;
    

    
    [self loadScroll];
}


- (void)buttonAction:(UIButton *)sender {

    if (self.delegate && [self.delegate respondsToSelector:@selector(askZhengView:tagIndex:)]) {
        [self.delegate askZhengView:self tagIndex:sender.tag];
    }
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
}

- (void)loadScroll{
    ScrollInfinite *scroll=[[ScrollInfinite alloc]initWithFrame:CGRectMake(KFit_W6S(48), 0, self.frame.size.width - KFit_W6S(48), self.frame.size.height)];
    [_back addSubview:scroll];
    scroll.titleArr=self.dataArr;
    scroll.delegate=self;
    
}
- (void)ScrollInfiniteButten:(UIButton *)sender tagIndex:(NSInteger)index{
    if (self.delegate && [self.delegate respondsToSelector:@selector(askZhengView:tagIndex:)]) {
        [self.delegate askZhengView:self tagIndex:index];
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
