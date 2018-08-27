//
//  OrderCell.m
//  MobileProject
//
//  Created by zsgy on 2017/11/13.
//  Copyright © 2017年 ZSGY. All rights reserved.
//

#import "OrderCell.h"
#import "OrderView.h"

@implementation OrderCell
{
    OrderView *_orderview;
    UILabel *_orderState;
    UIView *_redView;
    UIView *_back;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self loadSubview];
    }
    return self;
}


- (void)setModel:(FMMainModel *)model{
    _model=model;
    _orderview.model = model;
    if (model.state < 0) {
        _orderState.text = [XLSingleton singleton].typeArr[0];
    }else{
        if (model.state < [XLSingleton singleton].typeArr.count) {
            _orderState.text = [XLSingleton singleton].typeArr[model.state];
        }

        
    }
    [_orderState mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(_back);
        make.left.mas_equalTo(_back).mas_offset(KFit_W6S(20));
        make.top.mas_equalTo(_orderview.mas_bottom);
    }];
    if (model.read == 1) {
        _redView.hidden = YES;
    }else{
        _redView.hidden = NO;
    }
}



- (void)loadSubview{
    
    UIView *back = [[UIView alloc] init];
    _back = back;
    [self.contentView addSubview:back];
    back.layer.borderColor = appcoloer_line.CGColor;
    back.layer.borderWidth = 0.7;
    back.layer.cornerRadius = 10;
    back.layer.masksToBounds = YES;
    [back mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView).mas_offset(KFit_W6S(20));
        make.left.mas_equalTo(self.contentView).mas_offset(KFit_W6S(20));
        make.right.mas_equalTo(self.contentView).mas_offset(-KFit_W6S(20));
        make.bottom.mas_equalTo(self.contentView).mas_offset(-KFit_H6S(20));
    }];
    
    _orderview = [[OrderView alloc] initWithstyle:NO];
    [back addSubview:_orderview];
    [_orderview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(back);
        make.bottom.mas_equalTo(back).mas_offset(-KFit_H6S(90));
    }];
    
    _orderState = [[UILabel alloc] init];
    [back addSubview:_orderState];
    [_orderState mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(back);
        make.left.mas_equalTo(back).mas_offset(KFit_W6S(20));
        make.top.mas_equalTo(_orderview.mas_bottom);
        make.right.mas_equalTo(back).mas_offset(-KFit_W6S(70));
    }];
    
    
    _redView = [[UIView alloc] init];
    [_orderState addSubview:_redView];
    [_redView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_orderState.mas_top).mas_offset(KFit_H6S(20));
        make.right.mas_equalTo(_orderState).mas_offset(KFit_W6S(10));
        make.size.mas_equalTo(CGSizeMake(KFit_W6S(16), KFit_W6S(16)));
    }];
    _redView.backgroundColor = [UIColor redColor];
    _redView.layer.cornerRadius = KFit_W6S(8);
    _redView.hidden = YES;
    
    UIImageView *img = [[UIImageView alloc] init];
    [back addSubview:img];
    [img setImage:[UIImage imageNamed:@"ret"]];
    [img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_orderState);
        make.right.mas_equalTo(back).mas_offset(-KFit_W6S(10));
        make.size.mas_equalTo(CGSizeMake(KFit_W6S(14), KFit_H6S(26)));
    }];
    
}

@end
