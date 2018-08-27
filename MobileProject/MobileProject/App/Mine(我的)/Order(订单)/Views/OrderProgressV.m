//
//  OrderProgressV.m
//  MobileProject
//
//  Created by zsgy on 2018/6/13.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import "OrderProgressV.h"

@implementation OrderProgressV
{
    UIScrollView *_scroll;
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
        
    }
    return self;
}
-(void)setData:(NSArray<FMSubmodel *> *)data{
    _data = data;
    [_scroll removeFromSuperview];
    [self loadSubview];
}
- (void)loadSubview{
    _scroll = [[UIScrollView alloc] init];
    [self addSubview:_scroll];
    [_scroll mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.mas_equalTo(self);
    }];
    
    XLView *back = [[XLView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width,self.frame.size.height)];
    [_scroll addSubview:back];
    UILabel *lb;
    lb = [[UILabel alloc] initWithFrame:CGRectMake(0, KFit_H6S(25), self.frame.size.width, 1)];
    [back addSubview:lb];
    for (int i = 0; i < self.data.count; i++) {
        FMSubmodel *model = self.data[i];
        UILabel *title = [[UILabel alloc] init];
        if (model.order_state < 0) {
            title.text = [XLSingleton singleton].typeArr[0];
        }else{
            if (model.order_state < [XLSingleton singleton].typeArr.count) {
                title.text = [XLSingleton singleton].typeArr[model.order_state];
            }
        }
//        title.text = [XLSingleton singleton].typeArr[model.order_state];
        [back addSubview:title];
        
        [title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(lb);
            make.left.mas_equalTo(self).mas_offset(KFit_W6S(45));
            make.right.mas_equalTo(self);
        }];
        
        UIImageView *img = [[UIImageView alloc] init];
        [back addSubview:img];
        [img mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).mas_offset(KFit_W6S(10));
            make.centerY.mas_equalTo(title);
            make.size.mas_equalTo(CGSizeMake(KFit_W6S(18), KFit_W6S(18)));
        }];
        if (i == 0 ) {
            title.textColor = kColor_N(36, 156, 211);
            [img setImage:[UIImage imageNamed:@"current"]];
            if (model.order_state == 10) {
                title.textColor = kColor_N(247, 116, 0);
            }
        }else{
            title.textColor = kColor_N(101, 101, 101);
            [img setImage:[UIImage imageNamed:@"Previous"]];
        }
        UILabel *subtitle = [[UILabel alloc] init];
        subtitle.textColor = kColor_N(101, 101, 101);
        subtitle.numberOfLines = 0;
        subtitle.text = model.content;
        [back addSubview:subtitle];
        [subtitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(title.mas_bottom).mas_offset(KFit_H6S(20));
            make.left.mas_equalTo(self).mas_offset(KFit_W6S(45));
            make.right.mas_equalTo(self);
        }];
        
        UILabel *lbone = [[UILabel alloc] init];
        [back addSubview:lbone];
        lbone.backgroundColor = appcoloer_line;
        [lbone mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(subtitle.mas_bottom).mas_offset(KFit_H6S(25));
            make.left.mas_equalTo(self).mas_offset(KFit_W6S(45));
            make.right.mas_equalTo(self);
            make.height.mas_equalTo(1);
        }];
        
        UILabel *time = [[UILabel alloc] init];
        time.textColor = kColor_N(101, 101, 101);
        time.text = model.created_at;
        [back addSubview:time];
        [time mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(lbone).mas_offset(KFit_H6S(25));
            make.left.mas_equalTo(self).mas_offset(KFit_W6S(45));
            make.right.mas_equalTo(self);
        }];
        
        if (i == (self.data.count - 1)) {
            UILabel *lbteo = [[UILabel alloc] init];
            [back addSubview:lbteo];
            lbteo.backgroundColor = appcoloer_line;
            [lbteo mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(lb);
                make.centerX.mas_equalTo(img);
                make.width.mas_equalTo(1);
                make.bottom.mas_equalTo(img.mas_top);
            }];
        }
        
        lb = [[UILabel alloc] init];
        [back addSubview:lb];
        [lb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(time.mas_bottom).mas_offset(KFit_H6S(40));
            make.left.mas_equalTo(self).mas_offset(KFit_W6S(45));
            make.right.mas_equalTo(self);
            make.height.mas_equalTo(1);
        }];
        
        if (i != (self.data.count - 1)) {
            UILabel *lbteo = [[UILabel alloc] init];
            [back addSubview:lbteo];
            lbteo.backgroundColor = appcoloer_line;
            [lbteo mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(img.mas_bottom);
                make.centerX.mas_equalTo(img);
                make.width.mas_equalTo(1);
                make.bottom.mas_equalTo(lb);
            }];
        }
        
    }
    back.frame = CGRectMake(0, 0, SCREEN_WIDTH, [back getLayoutCellHeight]);
    _scroll.contentSize = CGSizeMake(0, [back getLayoutCellHeight]);
    
}
@end
