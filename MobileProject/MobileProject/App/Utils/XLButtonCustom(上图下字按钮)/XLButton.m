//
//  XLButton.m
//  MobileProject
//
//  Created by 向蕾 on 2018/8/21.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import "XLButton.h"

@implementation XLButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithTitle:(NSString *)title SubTitle:(NSString *)subtitle BackgroundImg:(NSString *)img highlightedImg:(NSString *)hightImg{
    if (self = [super init]) {
//        UIImageView *backimg = [[UIImageView alloc]init];
//        self.butimg = backimg;
//        backimg.userInteractionEnabled = YES;
//
//        [self addSubview:backimg];
//        [backimg setImage:[UIImage imageNamed:img]];
//        backimg.highlightedImage = [UIImage imageNamed:hightImg];
//        [backimg mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.left.right.bottom.mas_equalTo(self);
//        }];
//        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(butblock)];
//
//        [backimg addGestureRecognizer:singleTap];
//        UILabel *titleLB = [[UILabel alloc] init];
//        [self addSubview:titleLB];
//        titleLB.text = title;
//        titleLB.font = [UIFont systemFontOfSize:kFit_Font6(14)];
//        titleLB.textColor = [UIColor whiteColor];
//        [titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.mas_equalTo(self).mas_offset(KFit_W6S(30));
//            make.right.mas_equalTo(self).mas_offset(-KFit_W6S(130));
//            make.height.mas_equalTo(KFit_H6S(30));
//            make.centerY.mas_equalTo(self).mas_offset(-KFit_H6S(22));
//        }];
//
//
//        UILabel *subtitleLB = [[UILabel alloc] init];
//        [self addSubview:subtitleLB];
//        subtitleLB.text = subtitle;
//        subtitleLB.textColor = [UIColor whiteColor];
//        subtitleLB.font = [UIFont systemFontOfSize:kFit_Font6(10)];
//        [subtitleLB mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.mas_equalTo(self).mas_offset(KFit_W6S(30));
//            make.right.mas_equalTo(self).mas_offset(-KFit_W6S(130));
//            make.height.mas_equalTo(KFit_H6S(30));
//            make.centerY.mas_equalTo(self).mas_offset(KFit_H6S(22));
//        }];
        
        
        
        
        UIButton *but = [[UIButton alloc] init];
        [but setImage:[UIImage imageNamed:img] forState:UIControlStateNormal];
        [but setImage:[UIImage imageNamed:hightImg] forState:UIControlStateHighlighted];
        [self addSubview:but];
        [but mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.bottom.mas_equalTo(self);
        }];
        [but addTarget:self action:@selector(butblock) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}


- (void)butblock{
    self.senterBlock();
}
@end
