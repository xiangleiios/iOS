//
//  BillCell.m
//  MobileProject
//
//  Created by zsgy on 2018/6/22.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import "BillCell.h"

@implementation BillCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setModel:(AccountModel *)model{
    _model = model;
    UILabel *title = [[UILabel alloc] init];
    [self.contentView addSubview:title];
    title.font = [UIFont systemFontOfSize:kFit_Font6(17)];
    title.text = model.action_name;
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView).mas_offset(KFit_W6S(25));
        make.top.mas_equalTo(self.contentView).mas_offset(KFit_H6S(20));
        make.height.mas_equalTo(KFit_H6S(40));
        make.width.mas_equalTo(KFit_W6S(380));
    }];
    
    UILabel *money = [[UILabel alloc] init];
    [self.contentView addSubview:money];
    money.font = [UIFont systemFontOfSize:kFit_Font6(17)];
    money.textAlignment = NSTextAlignmentRight;
    [money mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView).mas_offset(-KFit_W6S(25));
        make.top.mas_equalTo(self.contentView).mas_offset(KFit_H6S(20));
        make.height.mas_equalTo(KFit_H6S(40));
        make.left.mas_equalTo(title.mas_right);
    }];
    NSString *moneynum = [XLCommonUse separatedDigitStringWithStr:[NSString stringWithFormat:@"%.0lf",model.money]];
    if ([model.action integerValue] == 0 || [model.action integerValue] == 2) {
        
        money.text = [NSString stringWithFormat:@"+%@优能币",moneynum];
        money.textColor = kColor_N(246, 107, 0);
    }else if ([model.action integerValue] == 1 || [model.action integerValue] == 3){
        
    }else{
        money.text = [NSString stringWithFormat:@"-%@优能币",moneynum];
    }
    
    UILabel *time = [[UILabel alloc] init];
    [self.contentView addSubview:time];
    time.font = [UIFont systemFontOfSize:kFit_Font6(17)];
    time.textColor = kColor_N(105, 105, 105);
    [time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView).mas_offset(KFit_W6S(25));
        make.top.mas_equalTo(title.mas_bottom).mas_offset(KFit_H6S(35));
        make.height.mas_equalTo(KFit_H6S(40));
        make.width.mas_equalTo(KFit_W6S(480));
    }];
    
    
    
    if (model.pay_type == PayTypeOffline) {
        time.text = model.datetime;
        UIImageView *img = [[UIImageView alloc] init];
        [self.contentView addSubview:img];
        [img sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:[UIImage imageNamed:@"lb-jiazaitu"]];
        [img mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(title);
            make.top.mas_equalTo(time.mas_bottom).mas_offset(KFit_H6S(20));
            make.size.mas_equalTo(CGSizeMake(KFit_W6S(160), KFit_W6S(160)));
        }];
        
        UILabel *upload_time = [[UILabel alloc] init];
        [self.contentView addSubview:upload_time];
        upload_time.font = [UIFont systemFontOfSize:kFit_Font6(17)];
        upload_time.text = [NSString stringWithFormat:@"上传时间：%@",model.upload_time];
        upload_time.textColor = kColor_N(105, 105, 105);
        [upload_time mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.contentView).mas_offset(-KFit_W6S(25));
            make.centerY.mas_equalTo(img).mas_offset(-KFit_H6S(30));
            make.height.mas_equalTo(KFit_H6S(40));
            make.left.mas_equalTo(img.mas_right).mas_offset(KFit_W6S(20));
        }];
        
        UILabel *option = [[UILabel alloc] init];
        [self.contentView addSubview:option];
        option.font = [UIFont systemFontOfSize:kFit_Font6(17)];
        option.text = [NSString stringWithFormat:@"审核意见：%@",model.option];
        option.textColor = kColor_N(105, 105, 105);
        [option mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.contentView).mas_offset(-KFit_W6S(25));
            make.centerY.mas_equalTo(img).mas_offset(KFit_H6S(30));
            make.height.mas_equalTo(KFit_H6S(40));
            make.left.mas_equalTo(img.mas_right).mas_offset(KFit_W6S(20));
        }];
        
        UILabel *lb = [[UILabel alloc] init];
        [self.contentView addSubview:lb];
        lb.backgroundColor = appcoloer_line;
        [lb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(self.contentView);
            make.top.mas_equalTo(img.mas_bottom).mas_offset(KFit_H6S(20));
            make.height.mas_equalTo(1);
            
        }];
        
    }else{
        if (model.pay_type == PayTypeWX) {
            title.text = @"微信支付成功";
        }else if (model.pay_type == PayTypeAli){
            title.text = @"支付宝支付成功";
        }else if (model.pay_type == PayTypeYL){
            title.text = @"银联支付成功";
        }
        time.text = model.pay_time;
        
        UILabel *order_num = [[UILabel alloc] init];
        [self.contentView addSubview:order_num];
        order_num.font = [UIFont systemFontOfSize:kFit_Font6(17)];
        order_num.textColor = kColor_N(105, 105, 105);
        [order_num mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).mas_offset(KFit_W6S(25));
            make.top.mas_equalTo(time.mas_bottom).mas_offset(KFit_H6S(25));
            make.right.mas_equalTo(self.contentView).mas_offset(-KFit_W6S(25));
            make.height.mas_equalTo(KFit_H6S(40));
        }];
        
        UILabel *datetime = [[UILabel alloc] init];
        [self.contentView addSubview:datetime];
        datetime.font = [UIFont systemFontOfSize:kFit_Font6(17)];
        datetime.textColor = kColor_N(105, 105, 105);
        datetime.text = model.datetime;
        [datetime mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).mas_offset(KFit_W6S(25));
            make.top.mas_equalTo(order_num.mas_bottom).mas_offset(KFit_H6S(25));
            make.height.mas_equalTo(KFit_H6S(40));
            make.width.mas_equalTo(KFit_W6S(380));
        }];
        order_num.text = [NSString stringWithFormat:@"订单号：%@",model.order_num];
//        if (model.pay_type == PayTypeWX) {
//            order_num.text = [NSString stringWithFormat:@"微信交易号：%@",model.order_num];
//        }else if (model.pay_type == PayTypeAli){
//            order_num.text = [NSString stringWithFormat:@"支付宝交易号：%@",model.order_num];
//        }else{
//            order_num.text = [NSString stringWithFormat:@"银联交易号：%@",model.order_num];
//        }
        UILabel *lb = [[UILabel alloc] init];
        [self.contentView addSubview:lb];
        lb.backgroundColor = appcoloer_line;
        [lb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(self.contentView);
            make.top.mas_equalTo(datetime.mas_bottom).mas_offset(KFit_H6S(20));
            make.height.mas_equalTo(1);
        }];
    }
    
}
@end
