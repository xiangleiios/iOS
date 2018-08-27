//
//  PictureDetailViewController.h
//  NNHeadline
//
//  Created by 菜鸟 on 15/5/22.
//  Copyright (c) 2015年 菜鸟. All rights reserved.
//

#import "FMBaseViewController.h"

@interface PictureDetailViewController : FMBaseViewController<UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView * scrollView;
@property (nonatomic, strong) NSMutableArray * dataArray;
@property (nonatomic, strong) NSMutableArray * imgArray;
@property (nonatomic, strong)FMMainModel *model;
@end
