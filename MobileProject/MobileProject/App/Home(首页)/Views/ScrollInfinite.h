//
//  ScrollInfinite.h
//  XLProject
//
//  Created by zsgy on 17/8/21.
//  Copyright © 2017年 zsgy. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FMAskZhengScrollInfiniteDelegate <NSObject>

- (void)ScrollInfiniteButten:(UIButton *)sender tagIndex:(NSInteger)index;

@end


@interface ScrollInfinite : UIView<UIScrollViewDelegate>
@property (nonatomic, retain)NSTimer* rotateTimer;  //让视图自动切换
@property (nonatomic, retain)UIPageControl *myPageControl;
@property (nonatomic , strong)NSArray *titleArr;
@property (nonatomic , strong)UIScrollView *scroll;
@property (nonatomic , strong)NSMutableArray *subViewArr;
@property (nonatomic , strong)id <FMAskZhengScrollInfiniteDelegate>delegate;
@end
