//
//  FMDataUrl.h
//  EatBeauty
//
//  Created by Mingo on 16/7/4.
//  Copyright © 2016年 袁凤鸣. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Single.h"


@interface FMSingle : NSObject

@property (nonatomic, copy)     NSString *yfQrCode;
@property (nonatomic, assign)   BOOL  isSandbox;
//// 需要刷新web
@property(nonatomic, assign) BOOL needReloadWeb;
@property (nonatomic, assign)   NSInteger is1ShowNilGuaideIma;
/// 返回到指定VC时要赋值，返回后并置空
@property (nonatomic, strong) UIViewController *popToViewController;
/// 看了又看
+ (NSString *)moduleTypeLive;
/// 惠民演出
+ (NSString *)moduleTypeShow;
/// 社区
+ (NSString *)moduleTypeTopic;
/// 活动
+ (NSString *)moduleTypeActivity;
/// 景点
+ (NSString *)moduleTypeScenic;
/// 文章
+ (NSString *)moduleTypeArticle;
/// 剧目
+ (NSString *)moduleTypeFilm;
/// 页面
+ (NSString *)moduleTypePage;
/// 商品
+ (NSString *)moduleTypeProduct;
///剧场
+ (NSString *)moduleTypeTheatre;
/// 网址
+ (NSString *)linkTypeChineseWangZi;
/// 问政
+ (NSString *)linkTypeChineseWenZhang;
/// 页面
+ (NSString *)linkTypeChineseYeMian;
/// 景点
+ (NSString *)linkTypeChineseJingDian;
/// 话题
+ (NSString *)linkTypeChineseHuaTi;
/// 活动
+ (NSString *)linkTypeChineseHuoDong;
/// 剧目
+ (NSString *)linkTypeChineseJuMu;
/// 商品
+ (NSString *)linkTypeChineseShangPin;

singleDot_H(Single);
@end
