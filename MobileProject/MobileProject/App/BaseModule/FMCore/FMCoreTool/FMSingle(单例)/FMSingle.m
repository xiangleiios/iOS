//
//  FMDataUrl.m
//  EatBeauty
//
//  Created by Mingo on 16/7/4.
//  Copyright © 2016年 袁凤鸣. All rights reserved.
//

#import "FMSingle.h"

@implementation FMSingle
singleDot_M(Single);
/// 看了又看
+ (NSString *)moduleTypeLive {
    return @"live";
}
/// 惠民演出
+ (NSString *)moduleTypeShow {
    return @"show";
}
/// 社区
+ (NSString *)moduleTypeTopic {
    return @"topic";
}
/// 活动
+ (NSString *)moduleTypeActivity {
    return @"activity";
}
/// 景点
+ (NSString *)moduleTypeScenic {
    return @"scenic";
}
/// 文章
+ (NSString *)moduleTypeArticle {
    return @"article";
}
/// 剧目
+ (NSString *)moduleTypeFilm {
    return @"film";
}
/// 页面
+ (NSString *)moduleTypePage {
    return @"page";
}
/// 商品
+ (NSString *)moduleTypeProduct {
    return @"product";
}
///剧场
+ (NSString *)moduleTypeTheatre {
    return @"theatre";
}

+ (NSString *)linkTypeChineseWangZi {
    return @"网址";
}
+ (NSString *)linkTypeChineseWenZhang {
    return @"文章";
}
+ (NSString *)linkTypeChineseYeMian {
    return @"页面";
}
+ (NSString *)linkTypeChineseJingDian {
    return @"景点";
}
+ (NSString *)linkTypeChineseHuaTi {
    return @"话题";
}
+ (NSString *)linkTypeChineseHuoDong {
    return @"活动";
}
+ (NSString *)linkTypeChineseJuMu {
    return @"剧目";
}
+ (NSString *)linkTypeChineseShangPin {
    return @"商品";
}
@end
