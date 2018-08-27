//
//  FMPayCell.m
//  MobileProject
//
//  Created by Mingo on 2017/11/3.
//  Copyright © 2017年 ZSGY. All rights reserved.
//

#import "FMPayCell.h"
#define padding KFit_W6S(20)

@implementation FMPayCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    self.back = [[UIView alloc] init];
    [self.contentView addSubview:_back];
    
    self.yfCoverIma = [[UIButton alloc] init];
    [_back addSubview:_yfCoverIma];
    
    self.yfTitle = [UILabel fm_initUIlabelWithTextColor:kBlackColor backColor:nil textAlignment_Left0_Center1_Right2:0 font:kFit_Font6(16) cornerRadius:0 addToSuperView:_back title:@""];
    self.yfSeletImg = [[UIImageView alloc] init];
    [_back addSubview:self.yfSeletImg];
    
    UILabel *lb = [[UILabel alloc] init];
    lb.backgroundColor = appcoloer_line;
    [self.contentView addSubview:lb];
    [lb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.contentView);
        make.bottom.mas_equalTo(self.contentView);
        make.height.mas_equalTo(kFit_Font6(1));
    }];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [_back mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.contentView);
    }];
    [_yfCoverIma mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_back).mas_offset(padding);
        make.centerY.mas_equalTo(_back);
        make.size.mas_equalTo(CGSizeMake(KFit_W6S(40), KFit_W6S(40)));
    }];
    [_yfTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_yfCoverIma.mas_right).with.offset(padding);
        make.top.bottom.mas_equalTo(_yfCoverIma);
        make.width.mas_equalTo(kFit_Font6(150));
    }];
    
    [_yfSeletImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.with.offset(-padding);
        make.centerY.mas_equalTo(_yfCoverIma);
        make.size.mas_equalTo(CGSizeMake(KFit_W6S(38), KFit_W6S(38)));
    }];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

-(void)setModel:(FMMainModel *)model {
    _model = model;
    [self.yfCoverIma setImage:[UIImage imageNamed:model.video_url] forState:UIControlStateNormal];
    [self.yfCoverIma setImage:[UIImage imageNamed:model.image_url] forState:UIControlStateSelected];
    if (self.yfCoverIma.selected) {
        [self.yfSeletImg setImage:[UIImage imageNamed:@"Selected"]];
    }else{
        [self.yfSeletImg setImage:[UIImage imageNamed:@"Unselected"]];
    }
    [self.yfTitle setText:model.name];
}
@end
