//
//  FMPlaceholderView.m
//  MobileProject
//
//  Created by Mingo on 2017/8/9.
//  Copyright © 2017年 袁凤鸣. All rights reserved.
//

#import "FMPlaceholderView.h"
#import "UIButton+FMImagePosition.h"

#define SCREEN_WIDTH   [UIScreen mainScreen].bounds.size.width       //屏幕宽度
#define SCREEN_HEIGHT   [UIScreen mainScreen].bounds.size.height      //屏幕高度
#define kFit6(x)       (SCREEN_WIDTH*((x)/375.0))

@interface FMPlaceholderView ()

@end

@implementation FMPlaceholderView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self createUI];
    }
    return self;
}

- (void)createUI {
    self.backgroundColor = [UIColor colorWithRed:248/255.0 green:248/255.0 blue:248/255.0 alpha:1];
    
    [self addSubview:self.reloadButton];
}

- (UIButton*)reloadButton {
    if (!_reloadButton) {
        _reloadButton = [[UIButton alloc] init];
        _reloadButton.frame = CGRectMake(0, 0, kFit6(100), kFit6(100));
        _reloadButton.center = self.center;
        [_reloadButton addTarget:self action:@selector(reloadClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _reloadButton;
}

- (void)reloadClick:(UIButton*)button {
    if (self.reloadClickBlock) {
        self.reloadClickBlock();
    }
}

@end
