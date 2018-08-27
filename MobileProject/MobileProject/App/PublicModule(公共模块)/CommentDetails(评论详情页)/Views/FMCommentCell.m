//
//  FMCommentCell.m
//  MobileProject
//
//  Created by Mingo on 2017/8/8.
//  Copyright © 2017年 ZSGY. All rights reserved.
//

#import "FMCommentCell.h"

#import "NSString+FMDate.h"
#import "UILabel+FMExtension.h"
#import "NSString+FMExtension.h"
#import "FMBool.h"
#import "XLThumbUp.h"
#define headIcon_WH KFit_W6S(80)
#define padding KFit_W6S(20)

@implementation FMCommentCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.yfHeadIcon = [UIImageView fm_initUIImageViewWithUrlOrName:@"wo-txw" ifHasPlaceholderImageName:@"wo-txw" cornerRadius:headIcon_WH/2 addTapGestureRecognizer:nil tapSel:nil addToSuperView:self.contentView];
        
        self.yfNikeName = [UILabel fm_initUIlabelWithTextColor:kMainTitleColor backColor:nil textAlignment_Left0_Center1_Right2:0 font:16 cornerRadius:0 addToSuperView:self.contentView title:@"回家找个吕盆友"];

        self.yfTime = [UILabel fm_initUIlabelWithTextColor:kTitleColor backColor:nil textAlignment_Left0_Center1_Right2:2 font:kFit_Font6(14) cornerRadius:0 addToSuperView:self.contentView title:@"12-12"];
        
        self.yfText = [UILabel fm_initUIlabelWithTextColor:kTitleColor backColor:kWhiteColor textAlignment_Left0_Center1_Right2:0 font:12 cornerRadius:0 addToSuperView:self.contentView title:@""];
        self.yfText.numberOfLines = 0;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [_yfHeadIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.with.offset(padding );
        make.left.with.offset(padding );
        make.size.mas_equalTo(CGSizeMake(headIcon_WH, headIcon_WH));
    }];
    
    [_yfNikeName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_yfHeadIcon);
        make.left.mas_equalTo(_yfHeadIcon.mas_right).with.offset(padding);
        make.height.mas_equalTo(kFit_Font6(20));
        make.right.with.offset(-kFit_Font6(80));
    }];
    
    [_yfTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.with.offset(-padding);
        make.centerY.mas_equalTo(_yfNikeName);;
        make.size.mas_equalTo(CGSizeMake(kFit_Font6(80), kFit_Font6(15)));
    }];
    
    [_yfText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_yfNikeName);
        make.top.mas_equalTo(_yfNikeName.mas_bottom).with.offset(padding/2);
        make.right.with.offset(-padding);
        //        make.bottom.with.offset(- padding );
    }];
    
//    if (self.commentsType == commentsTypeVoteQA) {
//
//       
//    }
    
}

- (void)setModel:(FMMainModel *)model {
    _model = model;
    
    [_yfHeadIcon sd_setImageWithURL:[NSURL URLWithString:model.avatar_url] placeholderImage:[UIImage imageNamed:@"wo-txw"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
    }];
    NSString *nikeName = [ FMBool fm_valiMobile:model.nick_name] ? ([NSString fm_hiddenMiddleNumOfPhoneNum:model.nick_name]) : (model.nick_name);
    if (!nikeName.length) {
       nikeName = [FMBool fm_valiMobile:model.username] ? ([NSString fm_hiddenMiddleNumOfPhoneNum:model.username]) : (model.username);
    }
    
    [_yfNikeName setText:[nikeName  stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    [_yfTime setText:[model.time fm_currentDateFormatStringToOtherDateFormatString:model.time timeFormat:TimeFormatMM_dd]];
    [_yfText setText:model.content];
    /*
    if (self.commentsType == commentsTypeVoteQA) {//投票里面的评论
        
        self.yfDianZan = [UIButton fm_initButtonNormalTitleColor:kTitleColor backgroundColor:nil font:kFit_Font6(12) normalImage:[UIImage imageNamed:@"wz-zan"] cornerRadius:0 addToSuperView:self.contentView normalTitle:@"12"];
        self.yfDianZan.tag = model.idid;
        [XLThumbUp thumbUpButton:self.yfDianZan idid:model.idid];
        
        [_yfDianZan setImage:[UIImage imageNamed:@"wz-zan-a"] forState:UIControlStateSelected];
        [self.yfDianZan setImageEdgeInsets:UIEdgeInsetsMake(0, -kFit_Font6(10), 0,  kFit_Font6(10))];
        [self.yfDianZan addTarget:self action:@selector(actionDianZan:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.yfDianZan setTitle:[NSString stringWithFormat:@"%ld",(long)model.likes] forState:UIControlStateNormal];
        
        if (([[User UserOb] UserLogin]) && (model.member_id == [[User UserOb].idid integerValue])) {
            //是自己的评论
            
//            self.yfDianZan.hidden = YES;
            [_yfDianZan removeFromSuperview];

            
            self.yfDelete = [UIButton fm_initButtonNormalTitleColor:kTitleColor backgroundColor:nil font:kFit_Font6(12) normalImage:[UIImage imageNamed:@"search_history_clear"] cornerRadius:0 addToSuperView:self.contentView normalTitle:nil];
            [self.yfDelete addTarget:self action:@selector(actionDelete:) forControlEvents:UIControlEventTouchUpInside];
            
            [_yfDelete mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(_yfText);
                make.top.mas_equalTo(_yfText.mas_bottom).with.offset(padding);
                make.size.mas_equalTo(CGSizeMake(kFit_Font6(50), kFit_Font6(20)));
            }];
        }else{
//            self.yfDelete.hidden = YES;
//            self.yfDianZan.hidden = NO;
            [_yfDianZan mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(_yfText);
                make.top.mas_equalTo(_yfText.mas_bottom).with.offset(padding);
                make.size.mas_equalTo(CGSizeMake(kFit_Font6(50), kFit_Font6(20)));
            }];
            [_yfDelete removeFromSuperview];
        }
    }
    */
    
}

#pragma mark - 点赞和取消点赞
- (void)actionDianZan:(UIButton *)sender {
    
    if (![[User UserOb] UserLogin]) {
        [FMHelper fm_showLoginAlertWithController:self.pushVC tipsStringIfNilShowDefault:nil];
        return;
    }
    [XLThumbUp thumbUpButton:sender thumbUpType:ThumbUpComments idid:self.model.idid model:self.model];
}

- (void)actionDelete:(UIButton *)sender {

    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"您确定要删除您的评论吗！" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {}]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {

        NSString *url = @"";
        
        [FMNetworkHelper fm_request_getWithUrlString:url isNeedCache:NO parameters:nil successBlock:^(id responseObject) {
            
            if (kResponseObjectStatusCodeIsEqual(200)) {
                [MBProgressHUD showAutoMessage:@"删除成功！"];
                if (self.voteCommentDelete) {
                    self.voteCommentDelete(YES);
                }
            }else{
                kHudShowResponseObjectMessage;
            }
        } failureBlock:^(NSError *error) {
            
        } progress:nil];
    
    }]];
    [self.pushVC presentViewController:alert animated:YES completion:nil];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
