//
//  SheetView.h
//  AllTest
//
//  Created by 菜鸟 on 15/5/22.
//  Copyright (c) 2015年 菜鸟. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SheetView : UIView
@property (nonatomic, strong) UILabel * titleLabel;
@property (nonatomic, strong) UILabel * pageLabel;
@property (nonatomic, strong) UILabel * contentLabel;
@property (nonatomic, strong) UIButton * dropBtn;
@property (nonatomic, strong) UIScrollView * scrollView;
@property (nonatomic, strong) UIColor * backColor;
+(SheetView *)showSheet;

@end
