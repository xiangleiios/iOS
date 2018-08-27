//
//  UITableView+FMPlaceholder.h
//  MobileProject
//
//  Created by Mingo on 2017/8/9.
//  Copyright © 2017年 袁凤鸣. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (FMPlaceholder)
/** 是否需要空列表占位图 */
@property (nonatomic, assign) BOOL needPlaceholderView;
/** 占位图点击刷新Block */
@property (nonatomic,   copy) void(^reloadBlock)(void);
- (void)reloadButtonIconName:(NSString *)iconName cornerRadius:(CGFloat)radius buttonSize:(CGSize)btnSize fullPlaceholderBackgroundColor:(UIColor *)backgroundColor;

@end
