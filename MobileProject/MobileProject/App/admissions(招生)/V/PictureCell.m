//
//  PictureCell.m
//  MobileProject
//
//  Created by 向蕾 on 2018/10/8.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import "PictureCell.h"
#import "MSSBrowseNetworkViewController.h"
@implementation PictureCell


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self layoutUI];
    }
    return self;
}


-(NSMutableArray *)browseItemArray{
    if (_browseItemArray==nil) {
        _browseItemArray=[NSMutableArray array];
    }
    return _browseItemArray;
}


- (void)layoutUI{
    self.head = [[UIImageView alloc] init];
    [self.head setImage:[UIImage imageNamed:@"head_nor"]];
    [self.contentView addSubview:self.head];
    [self.head mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView).mas_offset(KFit_H6S(20));
        make.left.mas_equalTo(self.contentView).mas_offset(KFit_W6S(30));
        make.width.height.mas_equalTo(KFit_W6S(80));
    }];
    
    self.name = [[UILabel alloc] init];
    self.name.text = @"招生小助手";
    self.name.font = [UIFont systemFontOfSize:kFit_Font6(17)];
    [self.contentView addSubview:self.name];
    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.head);
        make.left.mas_equalTo(self.head.mas_right).mas_offset(KFit_W6S(20));
        make.height.mas_equalTo(KFit_W6S(30));
    }];
    
    self.typeImg = [[UIImageView alloc] init];
    [self.contentView addSubview:self.typeImg];
    [self.typeImg setImage:[UIImage imageNamed:@"label_new"]];
    [self.typeImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.name);
        make.left.mas_equalTo(self.name.mas_right).mas_offset(KFit_W6S(20));
        make.width.height.mas_equalTo(KFit_W6S(30));
    }];
    
    self.frome = [[UILabel alloc] init];
    self.frome.text = @"官网频道";
    self.frome.font = [UIFont systemFontOfSize:kFit_Font6(13)];
    self.frome.textColor = kColor_N(175, 183, 193);
    [self.contentView addSubview:self.frome];
    [self.frome mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.head);
        make.left.mas_equalTo(self.head.mas_right).mas_offset(KFit_W6S(20));
        make.height.mas_equalTo(KFit_W6S(30));
    }];
    
    UILabel *lbone = [[UILabel alloc] init];
    [self.contentView addSubview:lbone];
    lbone.backgroundColor = kColor_N(0, 112, 234);
    lbone.text = @"立即制作";
    lbone.textAlignment = NSTextAlignmentCenter;
    lbone.font = [UIFont systemFontOfSize:kFit_Font6(15)];
    lbone.textColor = [UIColor whiteColor];
    [lbone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.head);
        make.right.mas_equalTo(self.contentView).mas_offset(-KFit_W6S(30));
        make.height.mas_equalTo(KFit_W6S(50));
        make.width.mas_equalTo(KFit_W6S(150));
    }];
    
    
    self.content = [[UILabel alloc] init];
    [self.contentView addSubview:self.content];
    self.content.font = [UIFont systemFontOfSize:kFit_Font6(16)];
    self.content.lineBreakMode = NSLineBreakByWordWrapping;
    self.content.numberOfLines = 6;

}


- (void)showbut{
    self.show.selected = !self.show.selected;
    
    
    // 记录当前按钮的选中状态，并传递给Controller
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:[NSNumber numberWithInteger:_cellIndexPath.row] forKey:@"row"];
    [dic setObject:[NSNumber numberWithBool:self.show.selected] forKey:@"isShow"];
    
    
    // 协议回调，改变Controller中存放Cell展开收起状态的字典
    if (self.delegate && [self.delegate respondsToSelector:@selector(remarksCellShowContrntWithDic:andCellIndexPath:)]) {
        [self.delegate remarksCellShowContrntWithDic:dic andCellIndexPath:_cellIndexPath];
    }
}

- (void)setCellContent:(NSString *)contentStr andIsShow:(BOOL)isShow andCellIndexPath:(NSIndexPath *)indexPath
{
    self.content.text = contentStr;
    _cellIndexPath = indexPath;
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
    NSDictionary * attributes = @{ NSFontAttributeName:[UIFont systemFontOfSize:kFit_Font6(16)], NSParagraphStyleAttributeName: paragraphStyle };
    CGSize textRect = CGSizeMake(SCREEN_WIDTH - KFit_W6S(60), MAXFLOAT);
    CGFloat textHeight = [self.content.text boundingRectWithSize: textRect options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:attributes context:nil].size.height;
    if (textHeight > KFit_H6S(240)) {
        
        if (isShow) {
            self.content.numberOfLines = 0;
            
            [self.content mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(self.contentView).mas_offset(KFit_W6S(30));
                make.right.mas_equalTo(self.contentView).mas_offset(-KFit_W6S(30));
                make.top.mas_equalTo(self.head.mas_bottom).mas_offset(KFit_H6S(20));
                make.height.mas_equalTo(textHeight+1);
            }];
        }else{
            self.content.numberOfLines = 6;
            [self.content mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(self.contentView).mas_offset(KFit_W6S(30));
                make.right.mas_equalTo(self.contentView).mas_offset(-KFit_W6S(30));
                make.top.mas_equalTo(self.head.mas_bottom).mas_offset(KFit_H6S(20));
                make.height.mas_equalTo(KFit_H6S(240));
            }];
        }
        self.show = [[UIButton alloc] init];
        [self.contentView addSubview:self.show];
        [self.show setTitle:@"全文" forState:UIControlStateNormal];
        [self.show setTitle:@"收起" forState:UIControlStateSelected];
        [self.show addTarget:self action:@selector(showbut) forControlEvents:UIControlEventTouchUpInside];
        self.show.titleLabel.font = [UIFont systemFontOfSize:kFit_Font6(18)];
        [self.show setTitleColor:kColor_N(0, 112, 234) forState:UIControlStateNormal];
        self.show.selected = isShow;
        [self.show mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.head);
            make.top.mas_equalTo(self.content.mas_bottom).mas_offset(KFit_H6S(20));
            make.size.mas_equalTo(CGSizeMake(KFit_W6S(80), KFit_H6S(40)));
        }];
        
        self.lb = [[UILabel alloc] init];
        [self.contentView addSubview:self.lb];
        [self.lb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(self.contentView);
            make.top.mas_equalTo(self.show.mas_bottom).mas_offset(KFit_H6S(20));
            make.height.mas_equalTo(KFit_H6S(1));
        }];
        
    }else{
        self.content.numberOfLines = 0;
        [self.content mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).mas_offset(KFit_W6S(30));
            make.right.mas_equalTo(self.contentView).mas_offset(-KFit_W6S(30));
            make.top.mas_equalTo(self.head.mas_bottom).mas_offset(KFit_H6S(20));
            make.height.mas_equalTo(textHeight+1);
        }];
        self.lb = [[UILabel alloc] init];
        [self.contentView addSubview:self.lb];
        [self.lb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(self.contentView);
            make.top.mas_equalTo(self.content.mas_bottom).mas_offset(KFit_H6S(20));
            make.height.mas_equalTo(KFit_H6S(1));
        }];
        
    }
    
    self.imgbavk = [[XLView alloc] init];
    [self.contentView addSubview:self.imgbavk];
    [self.imgbavk mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.contentView);
        make.top.mas_equalTo(self.lb.mas_bottom);
        make.height.mas_equalTo(KFit_H6S(5));
    }];
    
    self.num = [[UILabel alloc] init];
    [self.contentView addSubview:self.num];
    self.num.textAlignment = NSTextAlignmentRight;
    self.num.font = [UIFont systemFontOfSize:kFit_Font6(13)];
    self.num.textColor = kColor_N(175, 183, 193);
    self.num.text = @"0人制作";
    [self.num mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.imgbavk.mas_bottom).mas_offset(KFit_H6S(20));
        make.right.mas_equalTo(self.contentView).mas_offset(-KFit_W6S(30));
        make.size.mas_equalTo(CGSizeMake(KFit_W6S(280), KFit_H6S(45)));
    }];
    
    UILabel *lb = [[UILabel alloc] init];
    [self.contentView addSubview:lb];
    lb.backgroundColor = kColor_N(240, 240, 240);
    [lb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.num.mas_bottom).mas_offset(KFit_H6S(30));
        make.right.left.mas_equalTo(self.contentView);
        make.height.mas_equalTo(1);
    }];
}

- (void)setModel:(FMMainModel *)model{
    _model = model;
    self.num.text = [NSString stringWithFormat:@"%d人制作",model.useNum];
    NSArray  *array = [model.imgUrl componentsSeparatedByString:@","];
    for (int i = 0; i < array.count; i++) {
        float w = KFit_W6S(150);
        if (i >= 9) {
            return;
        }
        UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(KFit_W6S(30) + i%3*(w +KFit_W6S(30)), i/3*(w +KFit_W6S(30)), w, w)];
        [self.imgbavk addSubview:img];
//        [img sd_setImageWithURL:[NSURL URLWithString:KURLIma(array[i])]];
        [img sd_setImageWithURL:[NSURL URLWithString:KURLIma(array[i])] placeholderImage:[UIImage imageNamed:@"photo_nor"]];
        img.tag = i;
        img.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapView:)];
        [img addGestureRecognizer:tap];
        
        UIImageView *imageView = [self.contentView viewWithTag:i + 100];
        MSSBrowseModel *browseItem = [[MSSBrowseModel alloc]init];
        browseItem.bigImageUrl = KURLIma(array[i]);// 加载网络图片大图地址
        browseItem.smallImageView = imageView;// 小图
        [self.browseItemArray addObject:browseItem];
        
//        KKLog(@"%@",KURLIma(array[i]));
    }
    [self.imgbavk mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.contentView);
        make.top.mas_equalTo(self.lb.mas_bottom);
        make.height.mas_equalTo([self.imgbavk getLayoutCellHeight]);
    }];
    NSArray *arr = [model.tags componentsSeparatedByString:@","];
    if (arr.count == 1) {
        UILabel *lbtwo = [[UILabel alloc] init];
        [self.contentView addSubview:lbtwo];
        
        lbtwo.text = [NSString stringWithFormat:@"%@     ",[arr firstObject]];
        lbtwo.textColor = kColor_N(0, 112, 234);
        lbtwo.layer.borderWidth = 0.5;
        lbtwo.layer.borderColor = kColor_N(0, 112, 234).CGColor;
        lbtwo.textAlignment = NSTextAlignmentCenter;
        lbtwo.font = [UIFont systemFontOfSize:kFit_Font6(13)];
        [lbtwo mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.imgbavk.mas_bottom).mas_offset(KFit_H6S(20));
            make.left.mas_equalTo(self.contentView).mas_offset(KFit_W6S(30));
            make.height.mas_equalTo(KFit_H6S(45));
        }];
    }else if (arr.count > 1){
        UILabel *lbone = [[UILabel alloc] init];
        [self.contentView addSubview:lbone];
        lbone.text = [NSString stringWithFormat:@"%@     ",[arr firstObject]];
        lbone.textColor = kColor_N(0, 112, 234);
        lbone.layer.borderWidth = 0.5;
        lbone.layer.borderColor = kColor_N(0, 112, 234).CGColor;
        lbone.textAlignment = NSTextAlignmentCenter;
        lbone.font = [UIFont systemFontOfSize:kFit_Font6(13)];
        [lbone mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.imgbavk.mas_bottom).mas_offset(KFit_H6S(20));
            make.left.mas_equalTo(self.contentView).mas_offset(KFit_W6S(30));
            make.height.mas_equalTo(KFit_H6S(45));
        }];
        
        UILabel *lbtwo = [[UILabel alloc] init];
        [self.contentView addSubview:lbtwo];
        lbtwo.text = [NSString stringWithFormat:@"%@     ",arr[1]];
        lbtwo.textColor = kColor_N(0, 112, 234);
        lbtwo.layer.borderWidth = 0.5;
        lbtwo.layer.borderColor = kColor_N(0, 112, 234).CGColor;
        lbtwo.textAlignment = NSTextAlignmentCenter;
        lbtwo.font = [UIFont systemFontOfSize:kFit_Font6(13)];
        [lbtwo mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.imgbavk.mas_bottom).mas_offset(KFit_H6S(20));
            make.left.mas_equalTo(lbone.mas_right).mas_offset(KFit_W6S(30));
            make.height.mas_equalTo(KFit_H6S(45));
        }];
    }
    
}



-(void)tapView:(UITapGestureRecognizer *)sender{
    UIImageView *img=(UIImageView *)sender.view;
    MSSBrowseNetworkViewController *bvc = [[MSSBrowseNetworkViewController alloc]initWithBrowseItemArray:self.browseItemArray currentIndex:img.tag];
    
    //             bvc.isEqualRatio = NO;// 大图小图不等比时需要设置这个属性（建议等比）
    //    [bvc.navigationController fm_setStatusBarBackgroundColor:[UIColor clearColor]];
    [bvc showBrowseViewController];
}










@end
