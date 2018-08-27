//
//  OrderDetailsV.m
//  MobileProject
//
//  Created by zsgy on 2018/6/13.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import "OrderDetailsV.h"
#import "OrderView.h"
#import "CredentialsV.h"
#import "OrderInformationV.h"
#import "PayInforV.h"
#import "HWebVc.h"
#import "OrederExpandV.h"
@implementation OrderDetailsV
{
    OrderView *_orderview;
    
    UIScrollView *_scroll;
    
    XLView *_back;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self loadSubview];
    }
    return self;
}


-(void)setModel:(FMMainModel *)model{
    _model = model;
    _orderview.model = self.model;
    [self loadOrderInformation];
}

- (void)loadSubview{
    _scroll = [[UIScrollView alloc] init];
    [self addSubview:_scroll];
    [_scroll mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.mas_equalTo(self);
    }];
    
    _back = [[XLView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width,self.frame.size.height)];
    [_scroll addSubview:_back];
    
    _orderview = [[OrderView alloc] init];
    [_back addSubview:_orderview];
    [_orderview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(_back);
        make.height.mas_equalTo(KFit_H6S(295));
    }];
    
    
}


- (void)loadOrderInformation{
    UILabel *lbtwo;
    lbtwo = [[UILabel alloc] init];
    [_back addSubview:lbtwo];
    [lbtwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_orderview.mas_bottom);
        make.left.right.mas_equalTo(_back);
        make.height.mas_equalTo(1);
    }];
    if (_model.state > 3) {
        self.LookContract = [[UIButton alloc] init];
        [_back addSubview:_LookContract];
        self.LookContract.layer.borderWidth = 0.7;
        self.LookContract.layer.borderColor = appcoloer_line.CGColor;
        [self.LookContract setTitle:@" 《电力云服务委托合同》查看" forState:UIControlStateNormal];
        [self.LookContract setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.LookContract addTarget:self action:@selector(toHetong) forControlEvents:UIControlEventTouchUpInside];
        self.LookContract.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [self.LookContract mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(_back);
            make.top.mas_equalTo(_orderview.mas_bottom);
            make.height.mas_equalTo(KFit_H6S(90));
        }];
        lbtwo = [[UILabel alloc] init];
        [_back addSubview:lbtwo];
        [lbtwo mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.LookContract.mas_bottom);
            make.left.right.mas_equalTo(_back);
            make.height.mas_equalTo(1);
        }];
    }
    
    for (FMSubmodel *model in self.model.items) {
        if ([model.payed_at  isEqual: @""]||model.type == 1) {
            continue;
        }
        
        PayInforV *v=[[PayInforV alloc] init];
        v.model = model;
        [_back addSubview:v];
        [v mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.mas_equalTo(lbtwo);
            make.height.mas_equalTo(KFit_H6S(120));
        }];
        lbtwo = [[UILabel alloc] init];
        [_back addSubview:lbtwo];
        lbtwo.backgroundColor = appcoloer_line;
        [lbtwo mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(v.mas_bottom);
            make.left.right.mas_equalTo(_back);
            make.height.mas_equalTo(1);
        }];
    }
    OrederExpandV *expand = [[OrederExpandV alloc] init];
    expand.dic = [_model.more_info firstObject];
    [_back addSubview:expand];
    [expand mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(lbtwo);
        make.right.mas_equalTo(lbtwo).mas_offset(-KFit_W6S(60));
        make.height.mas_equalTo(KFit_H6S(470));
    }];
    _back.frame = CGRectMake(0, 0, SCREEN_WIDTH, [_back getLayoutCellHeight]);
    _scroll.contentSize = CGSizeMake(0, [_back getLayoutCellHeight]);
    
}

- (void)toHetong{
    HWebVc *vc= [[HWebVc alloc] init];
    vc.title = @"电力云信息服务合同";
    vc.url = [NSString stringWithFormat:HTMLContract,self.model.idid,[User UserOb].token];
    [self.vc.navigationController pushViewController:vc animated:YES];
}

@end
