//
//  CommentsCell.m
//  MobileProject
//
//  Created by 向蕾 on 2018/11/5.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import "CommentsCell.h"
#import "ReplyV.h"
@implementation CommentsCell

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

- (void)loadSubview{
    self.head = [[UIImageView alloc] init];
    [self.contentView addSubview:self.head];
    self.head.layer.cornerRadius = KFit_W6S(25);
    self.head.layer.masksToBounds = YES;
    [self.head mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(self.contentView).mas_offset(KFit_W6S(30));
        make.width.height.mas_equalTo(KFit_W6S(50));
    }];
    
    self.name = [[UILabel alloc] init];
    [self.contentView addSubview:self.name];
    self.name.font = [UIFont systemFontOfSize:kFit_Font6(15)];
    self.name.textColor = ZTColor;
    self.name.text = @"匿名";
    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.head.mas_right).mas_offset(KFit_W6S(20));
        make.top.mas_equalTo(self.head);
        make.height.mas_equalTo(KFit_H6S(25));
    }];
    
    self.fen = [[UILabel alloc] init];
    [self.contentView addSubview:self.fen];
    self.fen.textColor =  ZTColor;
    self.fen.textAlignment = NSTextAlignmentRight;
    self.fen.font = [UIFont systemFontOfSize:kFit_Font6(15)];
    [self.fen mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView).mas_offset(-KFit_W6S(30));
        make.centerY.mas_equalTo(self.name);
        make.size.mas_equalTo(CGSizeMake(KFit_W6S(70), KFit_H6S(30)));
    }];
    
    UIImageView *img = [[UIImageView alloc] init];
    [self.contentView addSubview:img];
    img.contentMode = UIViewContentModeLeft;
    [img setImage:[UIImage imageNamed:@"star_o_k"]];
    [img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.fen.mas_left).mas_offset(-KFit_W6S(20));
        make.centerY.mas_equalTo(self.name);
        make.size.mas_equalTo(CGSizeMake(KFit_W6S(120), KFit_H6S(20)));
    }];
    
    
    self.xinImg = [[UIImageView alloc] init];
    [self.contentView addSubview:self.xinImg];
    [self.xinImg setImage:[UIImage imageNamed:@"star_o_"]];
    self.xinImg.contentMode = UIViewContentModeLeft;
    self.xinImg.clipsToBounds = YES;
    [self.xinImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.mas_equalTo(img);
        make.width.mas_equalTo(KFit_W6S(120));
    }];
    
    
    self.title = [[UILabel alloc] init];
    [self.contentView addSubview:self.title];
    self.title.text = @"安静地怕大家奥克兰的骄傲了肯德基啊";
    self.title.numberOfLines = 0;
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.name);
        make.top.mas_equalTo(self.name.mas_bottom).mas_offset(KFit_H6S(30));
        make.right.mas_equalTo(self.contentView).mas_offset(-KFit_W6S(30));
    }];
    
    self.time = [[UILabel alloc] init];
    [self.contentView addSubview:self.time];
    self.time.font = [UIFont systemFontOfSize:kFit_Font6(13)];
    self.time.textColor = kColor_N(189, 196, 208);
    [self.time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.name);
        make.top.mas_equalTo(self.title.mas_bottom).mas_offset(KFit_H6S(30));
        make.width.mas_equalTo(KFit_W6S(300));
        make.height.mas_equalTo(KFit_H6S(25));
    }];
    
    self.like = [[UIButton alloc] init];
    [self.contentView addSubview:self.like];
    [self.like addTarget:self action:@selector(giveLike:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.like setTitleColor:kColor_N(177, 177, 177) forState:UIControlStateNormal];
    [self.like setTitleColor:kColor_N(255, 103, 111) forState:UIControlStateSelected];
    self.like.titleLabel.font = [UIFont systemFontOfSize:kFit_Font6(15)];
    [self.like setImage:[UIImage imageNamed:@"good_nor"] forState:UIControlStateNormal];
    [self.like setImage:[UIImage imageNamed:@"good_down"] forState:UIControlStateSelected];
    [self.like mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView).mas_offset(-KFit_W6S(30));
        make.centerY.mas_equalTo(self.time);
        make.size.mas_equalTo(CGSizeMake(KFit_W6S(110), KFit_H6S(60)));
    }];
    
}

- (void)setModel:(FMMainModel *)model{
    _model = model;
    [self.head sd_setImageWithURL:[NSURL URLWithString:model.stuHead] placeholderImage:[UIImage imageNamed:@"head_nor"]];
    self.fen.text = [NSString stringWithFormat:@"%@分",[XLCommonUse removeFloatAllZeroByString:model.appraiseScore]];
//    model.appraiseScore
    float w = ( model.appraiseScore/ 5.0) * KFit_W6S(120);
    [self.xinImg mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(w);
    }];
    KKLog(@"%d",model.hasStart);
    if (model.hasStart) {
        self.like.selected = YES;
    }else{
        self.like.selected = NO;
    }
    
    self.title.text = model.content;
    self.time.text = model.createTime;
    [self.like setTitle:model.praiseNum forState:UIControlStateNormal];
    UILabel *lb = [[UILabel alloc] init];
    [self.contentView addSubview:lb];
    if (_model.url1&& ![_model.url1  isEqual: @""] ) {
        [self loadImg];
        [lb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.contentView);
            make.top.mas_equalTo(self.imgOne.mas_bottom).mas_offset(KFit_H6S(30));
            make.left.mas_equalTo(self.contentView).mas_offset(KFit_W6S(30));
            make.height.mas_equalTo(1);
        }];
    }else{
        [lb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.contentView);
            make.top.mas_equalTo(self.time.mas_bottom).mas_offset(KFit_H6S(30));
            make.left.mas_equalTo(self.contentView).mas_offset(KFit_W6S(30));
            make.height.mas_equalTo(1);
        }];
        
    }
    
    if (self.type == 1) {
        self.coachReply = [[CoachReplyV alloc] init];
        self.coachReply.model = model;
        [self.contentView addSubview:self.coachReply];
        [self.coachReply mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(self.contentView);
            make.top.mas_equalTo(lb.mas_bottom).mas_offset(KFit_H6S(30));
            make.height.mas_equalTo([self.coachReply getLayoutCellHeightWithFlex:KFit_H6S(30)]);
        }];
        UILabel *lbtwo = [[UILabel alloc] init];
        [self.contentView addSubview:lbtwo];
        lbtwo.backgroundColor = kColor_N(240, 240, 240);
        [lbtwo mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(self.contentView);
            make.top.mas_equalTo(self.coachReply.mas_bottom);
            make.height.mas_equalTo(KFit_H6S(20));
        }];
    }else{
        self.reply = [[UIButton alloc] init];
        [self.contentView addSubview:self.reply];
        [self.reply setTitle:@"回复" forState:UIControlStateNormal];
        [self.reply addTarget:self action:@selector(toReplyV) forControlEvents:UIControlEventTouchUpInside];
        self.reply.layer.cornerRadius = kFit_Font6(3);
        self.reply.layer.masksToBounds = YES;
        self.reply.titleLabel.font = [UIFont systemFontOfSize:kFit_Font6(15)];
        [self.reply setBackgroundImage:[UIImage imageWithColor:kColor_N(0, 112, 234)] forState:UIControlStateNormal];
        [self.reply mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.contentView).mas_offset(-KFit_W6S(30));
            make.top.mas_equalTo(lb.mas_bottom).mas_offset(KFit_H6S(20));
            make.size.mas_equalTo(CGSizeMake(KFit_H6S(120), KFit_W6S(50)));
        }];
        UILabel *lbtwo = [[UILabel alloc] init];
        [self.contentView addSubview:lbtwo];
        lbtwo.backgroundColor = kColor_N(240, 240, 240);
        [lbtwo mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(self.contentView);
            make.top.mas_equalTo(self.reply.mas_bottom).mas_offset(KFit_H6S(20));
            make.height.mas_equalTo(KFit_H6S(20));
        }];
    }
    
    
}

- (void)loadImg{
    self.imgOne = [[UIImageView alloc] init];
    [self.imgOne sd_setImageWithURL:[NSURL URLWithString:self.model.url1]];
    self.imgTwo = [[UIImageView alloc] init];
    [self.imgTwo sd_setImageWithURL:[NSURL URLWithString:self.model.url2]];
    self.imgThree = [[UIImageView alloc] init];
    [self.imgThree sd_setImageWithURL:[NSURL URLWithString:self.model.url3]];
    
    [self.contentView addSubview:self.imgOne];
    [self.contentView addSubview:self.imgTwo];
    [self.contentView addSubview:self.imgThree];
    
    NSArray *arr = @[self.imgOne,self.imgTwo,self.imgThree];
    [arr mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedItemLength:KFit_W6S(150) leadSpacing:KFit_W6S(100) tailSpacing:KFit_W6S(100)];
    [arr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.time.mas_bottom).mas_offset(KFit_W6S(30));
        make.height.mas_equalTo(KFit_H6S(150));
    }];
}


- (void)giveLike:(UIButton *)senter{
    senter.userInteractionEnabled = NO;
    NSString *url = POSTTeamSchoolDoPraise;
    KKLog(@"%@",self.model.appraiseId);
    NSDictionary *dic = @{@"appraiseId":self.model.idid,@"openId":self.model.deptId};
    KKLog(@"%@",dic);
    [FMNetworkHelper fm_request_postWithUrlString:url isNeedCache:NO parameters:dic successBlock:^(id responseObject) {
        KKLog(@"%@",responseObject);
        NSString *str = senter.titleLabel.text;
        int i = [str intValue];
        if (senter.selected) {
            [senter setTitle:[NSString stringWithFormat:@"%d",(i-1)] forState:UIControlStateNormal];
        }else{
            [senter setTitle:[NSString stringWithFormat:@"%d",(i+1)] forState:UIControlStateNormal];
        }
        senter.selected = !senter.selected;
        senter.userInteractionEnabled = YES;
        
    } failureBlock:^(NSError *error) {
        KKLog(@"%@", error);
        senter.userInteractionEnabled = YES;
    } progress:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];
    
}

- (void)toReplyV{
    ReplyV *v = [[ReplyV alloc] init];
    v.vc = self.vc;
    v.idid = self.model.idid;
    [v show];
}
@end
