//
//  XLColumnsV.m
//  MobileProject
//
//  Created by 向蕾 on 2018/8/17.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import "XLColumnsV.h"

@implementation XLColumnsV

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
  
}

- (instancetype)initWithTitle:(NSString *)title Color:(UIColor *)color{
    self = [super init];
    if (self) {
    
        self.title = [[UILabel alloc] init];
        [self addSubview:self.title];
        self.title.text = title;
        self.title.font = [UIFont systemFontOfSize:kFit_Font6(18) weight:0.5];
//        self.title.textColor = kColor_N(135, 135, 135);
        [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.top.bottom.mas_equalTo(self);
            make.left.mas_equalTo(self).mas_offset(KFit_W6S(30));
        }];
    }
    return self;
}

- (instancetype)initWithTitle:(NSString *)title IMG:(NSString *)img{
    self = [super init];
    if (self) {
        self.img = [[UIImageView alloc] init];
        [self addSubview:_img];
        [_img mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.centerY.mas_equalTo(self);
            make.width.height.mas_equalTo(KFit_H6S(60));
        }];
        
        self.title = [[UILabel alloc] init];
        [self addSubview:self.title];
        self.title.text = title;
        self.title.font = [UIFont systemFontOfSize:kFit_Font6(14)];
//        self.title.textColor = kColor_N(135, 135, 135);
        [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.top.bottom.mas_equalTo(self);
            make.left.mas_equalTo(self.img.mas_right).mas_offset(KFit_W6S(30));
        }];
    }
    return self;
}
@end
