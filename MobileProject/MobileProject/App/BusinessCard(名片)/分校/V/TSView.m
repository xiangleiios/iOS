//
//  TSView.m
//  MobileProject
//
//  Created by 向蕾 on 2018/11/30.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import "TSView.h"

@implementation TSView

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
        self.backgroundColor = [UIColor whiteColor];
        self.tslb = [[UILabel alloc] init];
        [self addSubview:self.tslb];
        self.tslb.textColor = kColor_N(185, 192, 205);
        self.tslb.font = [UIFont systemFontOfSize:kFit_Font6(15)];
        [self.tslb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).mas_offset(KFit_W6S(30));
            make.right.mas_equalTo(self).mas_offset(-KFit_W6S(30));
            make.top.mas_equalTo(self);
            make.height.mas_equalTo(KFit_H6S(40));
        }];
    }
    return self;
}
@end
