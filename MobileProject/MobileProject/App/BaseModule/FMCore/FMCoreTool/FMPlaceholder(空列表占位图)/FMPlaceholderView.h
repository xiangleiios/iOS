//
//  FMPlaceholderView.h
//  MobileProject
//
//  Created by Mingo on 2017/8/9.
//  Copyright © 2017年 袁凤鸣. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FMPlaceholderView : UIView

@property (nonatomic, copy) void(^reloadClickBlock)(void);
@property (nonatomic, strong) UIButton *reloadButton;
@end
