//
//  FMAskZhengView.h
//  MobileProject
//
//  Created by Mingo on 2017/8/1.
//  Copyright © 2017年 ZSGY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScrollInfinite.h"
@class FMAskZhengView;
@protocol FMAskZhengViewDelegate <NSObject>

- (void)askZhengView:(FMAskZhengView *)askZhengView tagIndex:(NSInteger)index;

@end
@interface FMAskZhengView : UIView<FMAskZhengScrollInfiniteDelegate>
- (instancetype)initWithFrame:(CGRect)frame;

@property (nonatomic, weak) id <FMAskZhengViewDelegate>delegate;
/** <#name#> */
@property (nonatomic, strong) UIView *back;
/** 问政头条图片 */
@property (nonatomic, strong) UIImageView *yfAskZhengHeadlinesIma;

@property (nonatomic, strong)NSArray *dataArr;

@property (nonatomic, strong)ScrollInfinite *scroll;
@end
