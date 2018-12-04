//
//  TemplateV.m
//  MobileProject
//
//  Created by 向蕾 on 2018/8/24.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import "TemplateV.h"

@implementation TemplateV

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
        self.index = 0;
        
    }
    return self;
}


- (NSMutableArray *)dataArr{
    if (_dataArr == nil) {
        _dataArr = [[NSMutableArray alloc] init];
        [_dataArr addObjectsFromArray:@[@"很多人说考驾照太难了，其实考驾照是个愉快又轻松的过程。本人教学认真负责、和蔼可亲，跟学员相处如同朋友一般，没有任何不良习惯，从无接到任何投诉。如果您想拿证就上路，我是您最明智的选择。",@"我坚信，作为一名汽车教练不仅要帮学员培养高水平的应试技能，还要帮他们形成良好的文明驾驶习惯，做一个真正合格的驾驶人！通过多年一线教学经验积累，我已经形成了一套独家高水平的训练方法，现已成功培养出上千名合格驾驶员！跟我学车，绝对是你的明智之选！",@"快乐学车是我从教多年来一直遵循的宗旨。我力图让每个来学车的学员都能感受到轻松愉快的学车氛围！我对所有学员都一视同仁，绝对禁止任何“吃拿卡要”行为。同时严格规范教学，和学员多沟通多交流，及时了解学员需求，不断改进训练方法。让学车过程更快乐轻松！",@"从教多年，我所带领的学员通过率一直名列前茅！我会在训练中不断改进教学方法，并根据每位学员的特点，给他们定制不同的学车模式。学员学车遇到困难，我会尽最大努力第一时间帮他们解决，保证学员学车顺利无忧。欢迎各位学员选择我成为你的教练！",@"我喜欢用真诚的态度和每一位学员成为朋友。我坚信要成为一名合格的教练，必须投入100%的心血在自己的本职工作上，用心工作，用心教学。我会和学员一起解决学车中遇到的每一个困难，一起学习一起成长，让所有学员满载而归"]];
    }
    return _dataArr;
}

- (void)loadSubview{
    self.frame = [UIScreen mainScreen].bounds;
    self.backgroundColor = kRGBAColor(0, 0, 0, 0.8);
    
    UIView *bacview = [[UIView alloc] init];
    [self addSubview:bacview];
    bacview.layer.cornerRadius = 5;
    bacview.layer.masksToBounds = YES;
    bacview.backgroundColor = [UIColor whiteColor];
    [bacview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self);
        make.size.mas_equalTo(CGSizeMake(KFit_W6S(640), KFit_H6S(910)));
    }];
    
    _biaoTi = [[XLInformationV alloc] informationWithTitle:[NSString stringWithFormat:@"模板【1/%ld】",self.dataArr.count]];
    [bacview addSubview:_biaoTi];
    [_biaoTi mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(bacview);
        make.height.mas_equalTo(KFit_H6S(90));
    }];
    
    
    UIButton *down = [[UIButton alloc] init];
    [_biaoTi addSubview:down];
    [down addTarget:self action:@selector(changeTemplate) forControlEvents:UIControlEventTouchUpInside];
    [down setImage:[UIImage imageNamed:@"refresh"] forState:UIControlStateNormal];
    [down setTitle:@"换一个" forState:UIControlStateNormal];
    down.titleLabel.font = [UIFont systemFontOfSize:kFit_Font6(16)];
    [down setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    down.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    down.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, KFit_W6S(1));
    down.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, KFit_W6S(10));
    [down mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(bacview).mas_offset(-KFit_W6S(40));
        make.centerY.mas_equalTo(_biaoTi);
        make.size.mas_equalTo(CGSizeMake(KFit_W6S(180), KFit_W6S(50)));
    }];
    
    UIImageView *box = [[UIImageView alloc] init];
    [box setImage:[UIImage imageNamed:@"big_box"]];
    [bacview addSubview:box];
    [box mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_biaoTi.mas_bottom).mas_offset(KFit_H6S(30));
        make.left.mas_equalTo(bacview).mas_offset(KFit_W6S(30));
        make.right.mas_equalTo(bacview).mas_offset(-KFit_W6S(30));
        make.height.mas_equalTo(KFit_H6S(640));
        
    }];
    
    self.textView = [[UITextView alloc] init];
    self.textView.backgroundColor = [UIColor clearColor];
    [bacview addSubview:self.textView];
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(box).mas_offset(KFit_W6S(20));
        make.right.bottom.mas_equalTo(box).mas_offset(-KFit_W6S(20));
    }];
    self.textView.text = self.dataArr[0];
    self.textView.font = [UIFont systemFontOfSize:kFit_Font6(15)];
    
    UIButton *quxiao = [[UIButton alloc] init];
    [bacview addSubview:quxiao];
    [quxiao setTitle:@"取消" forState:UIControlStateNormal];
    [quxiao setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [quxiao addTarget:self action:@selector(shutDown) forControlEvents:UIControlEventTouchUpInside];
    quxiao.backgroundColor = kColor_N(148, 160, 181);
    quxiao.layer.cornerRadius = 5;
    quxiao.layer.masksToBounds = YES;
    
    UIButton *change = [[UIButton alloc] init];
    [bacview addSubview:change];
    [change setTitle:@"选择" forState:UIControlStateNormal];
    [change setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [change addTarget:self action:@selector(toChange) forControlEvents:UIControlEventTouchUpInside];
    change.backgroundColor = kColor_N(0, 104, 215);
    change.layer.cornerRadius = 5;
    change.layer.masksToBounds = YES;
    
    
    
    NSArray *arr = @[quxiao,change];
    [arr mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:KFit_W6S(30) leadSpacing:KFit_W6S(30) tailSpacing:KFit_W6S(30)];
    [arr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(bacview).mas_offset(-KFit_H6S(30));
        make.height.mas_equalTo(KFit_H6S(90));
    }];
}

- (void)changeTemplate{
    if (self.index >= 4) {
        self.index = 0;
    }else{
      self.index++;
    }
    
    self.biaoTi.titlelb.text = [NSString stringWithFormat:@"模板【%d/%ld】",self.index+1,self.dataArr.count];
    self.textView.text = self.dataArr[self.index];
    
}

- (void)toChange{
    self.vc.textView.text = self.textView.text;
    [self removeFromSuperview];
}

#pragma mark - 退出
- (void)shutDown{
    [self removeFromSuperview];
}
#pragma mark - 弹出
- (void)show{
    UIWindow *rootWindow = [UIApplication sharedApplication].keyWindow;
    [rootWindow addSubview:self];
    //    [self creatShowAnimation];
}
@end
