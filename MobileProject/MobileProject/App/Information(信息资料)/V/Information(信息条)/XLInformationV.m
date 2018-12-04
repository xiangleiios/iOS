//
//  XLInformationV.m
//  MobileProject
//
//  Created by 向蕾 on 2018/8/17.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import "XLInformationV.h"
#define FONT kFit_Font6(16)
@implementation XLInformationV

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/






-(instancetype)informationWithTitle:(NSString *)title SubTitle:(NSString *)subtitle TSSubTitle:(NSString *)tssubtitle Must:(BOOL)must Click:(BOOL)click{
    if(self == [super init]){
        UILabel *titleLable = [[UILabel alloc] init];
        [self addSubview:titleLable];
        titleLable.text = title;
        titleLable.font = [UIFont systemFontOfSize:FONT];
        if (must) {
            UILabel *redlb = [[UILabel alloc] init];
            [self addSubview:redlb];
            self.red = redlb;
            redlb.text = @"*";
            redlb.textColor = [UIColor redColor];
            [redlb mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(self).mas_offset(KFit_W6S(30));
                make.centerY.mas_equalTo(self);
                make.width.mas_equalTo(KFit_W6S(20));
                make.height.mas_equalTo(KFit_H6S(25));
            }];
            
            [titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(redlb.mas_right).mas_offset(KFit_W6S(10));
                make.centerY.mas_equalTo(self);
                make.height.mas_equalTo(KFit_H6S(50));
                make.width.mas_equalTo(KFit_W6S(200));
            }];
        }else{
            [titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(self).mas_offset(KFit_W6S(30));
                make.centerY.mas_equalTo(self);
                make.height.mas_equalTo(KFit_H6S(50));
                make.width.mas_equalTo(KFit_W6S(200));
            }];
        }
        
        
        self.subfield = [[UITextField alloc] init];
        [self addSubview:self.subfield];
        self.subfield.placeholder = tssubtitle;
        self.subfield.textAlignment = NSTextAlignmentRight;
        self.subfield.font = [UIFont systemFontOfSize:FONT];
        self.subfield.text = subtitle;
        
        if (click) {
            UIImageView *imgtwo = [[UIImageView alloc] init];
            [self addSubview:imgtwo];
            [imgtwo setImage:[UIImage imageNamed:@"arrows_right_icon"]];
            [imgtwo mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(self).mas_offset(-KFit_W6S(20));
                make.centerY.mas_equalTo(self);
                make.width.mas_equalTo(KFit_H6S(40));
                make.height.mas_equalTo(KFit_H6S(40));
            }];
            
            [self.subfield mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(imgtwo.mas_left).mas_offset(-KFit_W6S(20));
                make.centerY.mas_equalTo(self);
                make.height.mas_equalTo(self);
                make.left.mas_equalTo(titleLable.mas_right).mas_offset(KFit_W6S(20));
            }];
            self.subfield.enabled = NO;
            UIButton *but = [[UIButton alloc] init];
            [self addSubview:but];
            [but mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.left.right.bottom.mas_equalTo(self);
            }];
            [but addTarget:self action:@selector(butblock:) forControlEvents:UIControlEventTouchUpInside];
        }else{
            [self.subfield mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(self).mas_offset(-KFit_W6S(30));
                make.centerY.mas_equalTo(self);
                make.height.mas_equalTo(self);
                make.left.mas_equalTo(titleLable.mas_right).mas_offset(KFit_W6S(20));
            }];
        }
        
        UILabel *lb = [[UILabel alloc] init];
        [self addSubview:lb];
        lb.backgroundColor = kColor_N(240, 240, 240);
        [lb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.left.right.mas_equalTo(self);
            make.height.mas_equalTo(1);
        }];
        
    }
    return self;
}

-(instancetype)informationWithTitle:(NSString *)title SubTitle:(NSString *)subtitle{
    if(self == [super init]){
        UILabel *titleLable = [[UILabel alloc] init];
        [self addSubview:titleLable];
        titleLable.text = title;
        titleLable.font = [UIFont systemFontOfSize:FONT];
        [titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).mas_offset(KFit_W6S(30));
            make.centerY.mas_equalTo(self);
            make.height.mas_equalTo(KFit_H6S(50));
            make.width.mas_equalTo(KFit_W6S(230));
        }];
        
        UILabel *subLable = [[UILabel alloc] init];
        self.titlelb = subLable;
        [self addSubview:subLable];
        subLable.text = subtitle;
        subLable.textColor = kColor_N(143, 155, 178);
        subLable.textAlignment = NSTextAlignmentRight;
        subLable.font = [UIFont systemFontOfSize:FONT];
        [subLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self).mas_offset(-KFit_W6S(30));
            make.centerY.mas_equalTo(self);
            make.height.mas_equalTo(self);
            make.left.mas_equalTo(titleLable.mas_right).mas_offset(KFit_W6S(10));
        }];
        
        UILabel *lb = [[UILabel alloc] init];
        [self addSubview:lb];
        lb.backgroundColor = kColor_N(240, 240, 240);
        [lb mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(subLable.mas_bottom).mas_offset(KFit_H6S(30));
            make.bottom.left.right.mas_equalTo(self);
            make.height.mas_equalTo(1);
        }];
        
    }
    return self;
}

-(instancetype)informationHeightWithTitle:(NSString *)title SubTitle:(NSString *)subtitle{
    if(self == [super init]){
        UILabel *titleLable = [[UILabel alloc] init];
        [self addSubview:titleLable];
        titleLable.text = title;
        titleLable.font = [UIFont systemFontOfSize:FONT];
        [titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).mas_offset(KFit_W6S(30));
            make.top.mas_equalTo(self).mas_offset(KFit_H6S(25));
            make.height.mas_equalTo(KFit_H6S(40));
            make.width.mas_equalTo(KFit_W6S(280));
        }];
        
        UILabel *subLable = [[UILabel alloc] init];
        [self addSubview:subLable];
        subLable.text = subtitle;
        subLable.textColor = kColor_N(143, 155, 178);
        subLable.textAlignment = NSTextAlignmentRight;
        subLable.font = [UIFont systemFontOfSize:FONT];
        subLable.numberOfLines = 0;
        [subLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self).mas_offset(-KFit_W6S(30));
            make.top.mas_equalTo(titleLable);
//            make.height.mas_equalTo(self);
            make.left.mas_equalTo(titleLable.mas_right).mas_offset(KFit_W6S(20));
        }];
        
        UILabel *lb = [[UILabel alloc] init];
        [self addSubview:lb];
        lb.backgroundColor = kColor_N(240, 240, 240);
        [lb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(self);
            make.top.mas_equalTo(subLable.mas_bottom).mas_offset(KFit_H6S(25));
            make.height.mas_equalTo(1);
        }];
        
    }
    return self;
    
}


-(instancetype)informationWithTitle:(NSString *)title SubTitle:(NSString *)subtitle ImageName:(NSString *)img{
    
    if(self == [super init]){
        UIImageView *imgone = [[UIImageView alloc] init];
        [self addSubview:imgone];
        [imgone setImage:[UIImage imageNamed:img]];
        [imgone mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).mas_offset(KFit_W6S(20));
            make.centerY.mas_equalTo(self);
            make.height.width.mas_equalTo(KFit_H6S(90));
        }];
        
        UIImageView *imgtwo = [[UIImageView alloc] init];
        [self addSubview:imgtwo];
        [imgtwo setImage:[UIImage imageNamed:@"arrows_right_icon"]];
        [imgtwo mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self).mas_offset(-KFit_W6S(20));
            make.centerY.mas_equalTo(self);
            make.width.mas_equalTo(KFit_H6S(40));
            make.height.mas_equalTo(KFit_H6S(40));
        }];
        
        UILabel *titleLable = [[UILabel alloc] init];
        [self addSubview:titleLable];
        titleLable.text = title;
        [titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(imgone.mas_right).mas_offset(KFit_W6S(30));
            make.centerY.mas_equalTo(self).mas_offset(-KFit_H6S(25));
            make.height.mas_equalTo(KFit_H6S(40));
            make.right.mas_equalTo(imgtwo.mas_left).mas_offset(-KFit_W6S(20));
        }];
        
        UILabel *subtitleLable = [[UILabel alloc] init];
        [self addSubview:subtitleLable];
        subtitleLable.text = subtitle;
        subtitleLable.font = [UIFont systemFontOfSize:kFit_Font6(14)];
        subtitleLable.textColor = kColor_N(183, 190, 205);
        [subtitleLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(imgone.mas_right).mas_offset(KFit_W6S(30));
            make.centerY.mas_equalTo(self).mas_offset(KFit_H6S(25));;
            make.height.mas_equalTo(KFit_H6S(40));
            make.right.mas_equalTo(imgtwo.mas_left).mas_offset(-KFit_W6S(20));
        }];
        
        UILabel *lb = [[UILabel alloc] init];
        [self addSubview:lb];
        lb.backgroundColor = kColor_N(240, 240, 240);
        [lb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self);
            make.left.mas_equalTo(self).mas_offset(KFit_W6S(20));
            make.right.mas_equalTo(self).mas_offset(-KFit_W6S(20));
            make.height.mas_equalTo(1);
        }];
        
        UIButton *but = [[UIButton alloc] init];
        [self addSubview:but];
        [but mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.bottom.mas_equalTo(self);
        }];
        [but addTarget:self action:@selector(butblock:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}


-(instancetype)informationLevelWithTitle:(NSString *)title SubTitle:(NSString *)subtitle ImageName:(NSString *)img{
    
    if(self == [super init]){
        UIImageView *imgone = [[UIImageView alloc] init];
        [self addSubview:imgone];
        [imgone setImage:[UIImage imageNamed:img]];
        [imgone mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).mas_offset(KFit_W6S(20));
            make.centerY.mas_equalTo(self);
            make.height.width.mas_equalTo(KFit_H6S(100));
        }];
        
        UIImageView *imgtwo = [[UIImageView alloc] init];
        [self addSubview:imgtwo];
        [imgtwo setImage:[UIImage imageNamed:@"arrows_right_icon"]];
        [imgtwo mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self).mas_offset(-KFit_W6S(20));
            make.centerY.mas_equalTo(self);
            make.width.mas_equalTo(KFit_H6S(40));
            make.height.mas_equalTo(KFit_H6S(40));
        }];
        
        UILabel *titleLable = [[UILabel alloc] init];
        [self addSubview:titleLable];
        titleLable.text = title;
        titleLable.font = [UIFont systemFontOfSize:FONT];
        [titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(imgone.mas_right).mas_offset(KFit_W6S(30));
            make.centerY.mas_equalTo(self);
            make.height.mas_equalTo(KFit_H6S(40));
            make.right.mas_equalTo(imgtwo.mas_left).mas_offset(-KFit_W6S(20));
        }];
        
        UILabel *subtitleLable = [[UILabel alloc] init];
        [self addSubview:subtitleLable];
        subtitleLable.text = subtitle;
        subtitleLable.font = [UIFont systemFontOfSize:FONT];
//        subtitleLable.textColor = kColor_N(183, 190, 205);
        subtitleLable.textAlignment = NSTextAlignmentRight;
        [subtitleLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(imgtwo.mas_left).mas_offset(-KFit_W6S(20));
            make.centerY.mas_equalTo(self);
            make.height.mas_equalTo(KFit_H6S(40));
            make.right.mas_equalTo(imgtwo.mas_left).mas_offset(-KFit_W6S(20));
        }];
        
//        UILabel *lb = [[UILabel alloc] init];
//        [self addSubview:lb];
//        lb.backgroundColor = kColor_N(240, 240, 240);
//        [lb mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.bottom.mas_equalTo(self);
//            make.left.mas_equalTo(self).mas_offset(KFit_W6S(20));
//            make.right.mas_equalTo(self).mas_offset(-KFit_W6S(20));
//            make.height.mas_equalTo(1);
//        }];
        
        UIButton *but = [[UIButton alloc] init];
        [self addSubview:but];
        [but mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.bottom.mas_equalTo(self);
        }];
        [but addTarget:self action:@selector(butblock:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
    
}


-(instancetype)informationWithTitle:(NSString *)title{
    if(self == [super init]){
        self.backgroundColor = kColor_N(240, 240, 240);
        UILabel *lb = [[UILabel alloc] init];
        self.titlelb = lb;
        [self addSubview:lb];
        [lb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_equalTo(self).mas_offset(KFit_W6S(30));
            make.height.mas_equalTo(KFit_H6S(40));
            make.right.mas_equalTo(self);
        }];
        lb.text = title;
        lb.textColor = kColor_N(149, 160, 182);
    }
    return self;
}


-(instancetype)informationWithTitle:(NSString *)title ButTile:(NSString *)butTitle ButImg:(NSString *)img{
    if(self == [super init]){
        self.backgroundColor = [UIColor whiteColor];
        UILabel *yanse = [[UILabel alloc] init];
        [self addSubview:yanse];
        yanse.backgroundColor = kColor_N(0, 104, 234);
        [yanse mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.centerY.mas_equalTo(self);
            make.size.mas_equalTo(CGSizeMake(KFit_W6S(10), KFit_H6S(20)));
        }];
        UILabel *red = [[UILabel alloc] init];
        [self addSubview:red];
        red.text = @"*";
        red.textColor = [UIColor redColor];
        [red mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.mas_equalTo(self);
            make.left.mas_equalTo(self).mas_offset(KFit_W6S(30));
            make.width.mas_equalTo(KFit_W6S(25));
        }];
        
        UILabel *titlelb = [[UILabel alloc] init];
        [self addSubview:titlelb];
        titlelb.text = title;
        [titlelb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.mas_equalTo(self);
            make.left.mas_equalTo(red.mas_right).mas_offset(KFit_W6S(1));
            make.width.mas_equalTo(KFit_W6S(200));
        }];
        if (butTitle) {
            UIButton *but = [[UIButton alloc] init];
            [self addSubview:but];
            [but setTitle:butTitle forState:UIControlStateNormal];
            [but setTitleColor:kColor_N(0, 104, 234) forState:UIControlStateNormal];
            [but addTarget:self action:@selector(butblock:) forControlEvents:UIControlEventTouchUpInside];
            but.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
            but.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, KFit_W6S(1));
            if (img) {
                [but setImage:[UIImage imageNamed:img] forState:UIControlStateNormal];
                but.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, KFit_W6S(10));
            }
            
            [but mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.bottom.mas_equalTo(self);
                make.right.mas_equalTo(self).mas_offset(-KFit_W6S(30));
                make.width.mas_equalTo(KFit_W6S(220));
            }];
            
        }
        UILabel *lbthree = [[UILabel alloc] init];
        [self addSubview:lbthree];
        lbthree.backgroundColor = kColor_N(240, 240, 240);
        [lbthree mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(self);
            make.height.mas_equalTo(1);
        }];
    }
    return self;
}



-(instancetype)informationWithTitle:(NSString *)title CarType:(NSString *)cartype SubTitle:(NSString *)subtitle Price:(NSString *)price{
    if(self == [super init]){
        self.backgroundColor = [UIColor whiteColor];
        UILabel *titlelb = [[UILabel alloc] init];
        [self addSubview:titlelb];
        titlelb.text = title;
        [titlelb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self).mas_offset(-KFit_H6S(25));
            make.left.mas_equalTo(self).mas_offset(KFit_W6S(30));
            make.height.mas_equalTo(KFit_H6S(40));
        }];
        
        UILabel *pricelb = [[UILabel alloc] init];
        pricelb.text = [NSString stringWithFormat:@"¥%@",price];
        pricelb.textColor = kColor_N(0, 104, 234);
        [self addSubview:pricelb];
        [pricelb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.height.mas_equalTo(titlelb);
            make.left.mas_equalTo(titlelb.mas_right).mas_offset(KFit_W6S(20));
            make.width.mas_equalTo(KFit_W6S(200));
        }];
        
        UILabel *sublb = [[UILabel alloc] init];
        [self addSubview:sublb];
        sublb.textColor = kColor_N(149, 160, 182);
        sublb.font = [UIFont systemFontOfSize:kFit_Font6(14)];
        sublb.text = [NSString stringWithFormat:@"%@|%@",cartype,subtitle];
        [sublb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self).mas_offset(KFit_H6S(25));
            make.left.mas_equalTo(self).mas_offset(KFit_W6S(30));
            make.right.mas_equalTo(self).mas_offset(-KFit_W6S(80));
            make.height.mas_equalTo(KFit_H6S(40));
        }];
        
        UIImageView *imgtwo = [[UIImageView alloc] init];
        [self addSubview:imgtwo];
        [imgtwo setImage:[UIImage imageNamed:@"arrows_right_icon"]];
        [imgtwo mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self).mas_offset(-KFit_W6S(30));
            make.centerY.mas_equalTo(self);
            make.width.mas_equalTo(KFit_H6S(40));
            make.height.mas_equalTo(KFit_H6S(40));
        }];
        
        
        UILabel *lb = [[UILabel alloc] init];
        [self addSubview:lb];
        lb.backgroundColor = kColor_N(240, 240, 240);
        [lb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.right.left.mas_equalTo(self);
            make.height.mas_equalTo(1);
        }];
        
        
        UIButton *but = [[UIButton alloc] init];
        [self addSubview:but];
        [but mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.bottom.mas_equalTo(self);
        }];
        [but addTarget:self action:@selector(butblock:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (instancetype)informationStudentsWithTitle:(NSString *)title{
    if(self == [super init]){
        UILabel *lbone = [[UILabel alloc] init];
        [self addSubview:lbone];
        lbone.backgroundColor = kColor_N(0, 113, 235);
        [lbone mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self);
            make.left.mas_equalTo(self);
            make.size.mas_equalTo(CGSizeMake(KFit_W6S(10), KFit_H6S(25)));
        }];
        
        UILabel *lbtwo = [[UILabel alloc] init];
        [self addSubview:lbtwo];
        lbtwo.textColor = kColor_N(109, 118, 141);
        lbtwo.text = title;
        lbtwo.font = [UIFont systemFontOfSize:kFit_Font6(16)];
        [lbtwo mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(lbone);
            make.left.mas_equalTo(self).mas_offset(KFit_W6S(30));
            make.height.mas_equalTo(KFit_H6S(30));
        }];
        
        UILabel *lbthree = [[UILabel alloc] init];
        [self addSubview:lbthree];
        lbthree.backgroundColor = kColor_N(240, 240, 240);
        [lbthree mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(self);
            make.height.mas_equalTo(1);
        }];
    }
    return self;
    
}

-(instancetype)informationWithTitle:(NSString *)title Subtitle:(NSString *)subtitle Must:(BOOL)must{
    if(self == [super init]){
        self.backgroundColor = [UIColor whiteColor];
        UILabel *yanse = [[UILabel alloc] init];
        [self addSubview:yanse];
        yanse.backgroundColor = kColor_N(0, 104, 234);
        [yanse mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.centerY.mas_equalTo(self);
            make.size.mas_equalTo(CGSizeMake(KFit_W6S(10), KFit_H6S(20)));
        }];
        UILabel *red = [[UILabel alloc] init];
        [self addSubview:red];
        if (must) {
            red.text = @"*";
            red.textColor = [UIColor redColor];
            [red mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.bottom.mas_equalTo(self);
                make.left.mas_equalTo(self).mas_offset(KFit_W6S(30));
                make.width.mas_equalTo(KFit_W6S(25));
            }];
        }else{
            [red mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.bottom.mas_equalTo(self);
                make.left.mas_equalTo(self).mas_offset(KFit_W6S(28));
                make.width.mas_equalTo(KFit_W6S(1));
            }];
        }
        UILabel *titlelb = [[UILabel alloc] init];
        titlelb.font = [UIFont systemFontOfSize:FONT];
        [self addSubview:titlelb];
        titlelb.text = title;
        [titlelb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.mas_equalTo(self);
            make.left.mas_equalTo(red.mas_right).mas_offset(KFit_W6S(1));
            make.width.mas_equalTo(KFit_W6S(200));
        }];
        
        UILabel *sub = [[UILabel alloc] init];
        [self addSubview:sub];
        sub.text = subtitle;
        sub.textAlignment = NSTextAlignmentRight;
        sub.textColor = kColor_N(175, 183, 199);
        sub.font = [UIFont systemFontOfSize:FONT];
        [sub mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.mas_equalTo(self);
            make.right.mas_equalTo(self).mas_offset(-KFit_W6S(30));
            make.width.mas_equalTo(KFit_W6S(300));
        }];
        
        UILabel *lbthree = [[UILabel alloc] init];
        [self addSubview:lbthree];
        lbthree.backgroundColor = kColor_N(240, 240, 240);
        [lbthree mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(self);
            make.height.mas_equalTo(1);
        }];
        
    }
    return self;
}

- (void)butblock:(UIButton *)senter{
    
    self.senterBlock();
}

@end
