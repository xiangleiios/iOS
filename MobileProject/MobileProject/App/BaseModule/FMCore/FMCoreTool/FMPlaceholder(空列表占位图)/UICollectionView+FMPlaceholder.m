//
//  UICollectionView+FMPlaceholder.m
//  MobileProject
//
//  Created by Mingo on 2017/8/9.
//  Copyright © 2017年 袁凤鸣. All rights reserved.
//

#import "UICollectionView+FMPlaceholder.h"
#import "NSObject+Swizzling.h"
#import "FMPlaceholderView.h"

@interface UICollectionView ()

/** UICollectionView 创建完毕会第一次调用 reloadData 。
 firstReloadNoCheck 默认为NO，故table创建完的第一次 reloadData 刷新不会检测 checkEmpty 是否空数据。
 【第二次 reloadData 是网络请求有结果后 刷新。此次会检测 checkEmpty。空数据就显示占位图】*/
@property (nonatomic, assign) BOOL firstReloadNoCheck;
@property (nonatomic, strong) FMPlaceholderView *placeholderView;

@end

@implementation UICollectionView (FMPlaceholder)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self methodSwizzlingWithOriginalSelector:@selector(reloadData)
                               bySwizzledSelector:@selector(sure_reloadData)];
    });
}

- (void)sure_reloadData {
    
    if (self.firstReloadNoCheck) { //非首次刷新检测是否为空 解决数据加载未完成显示占位图情况
        [self checkEmpty];
    }
    self.firstReloadNoCheck = YES ;
    [self sure_reloadData];
}

- (void)checkEmpty {
    BOOL isEmpty = YES;
    
    id <UICollectionViewDataSource> dataSource = self.dataSource;
    NSInteger sections = 1;
    if ([dataSource respondsToSelector:@selector(numberOfSectionsInCollectionView:)]) {
        sections = [dataSource numberOfSectionsInCollectionView:self] - 1;
    }
    
    for (NSInteger i = 0; i <= sections; i++) {
        NSInteger rows = [dataSource collectionView:self numberOfItemsInSection:i];
        if (rows) {
            isEmpty = NO;
        }
    }
    
    if (isEmpty) {//若为空，加载占位图
        //默认占位图
        if (!self.placeholderView) {
            [self makeDefaultPlaceholderView];
        }
        
        if (!self.needPlaceholderView) {
            self.placeholderView.hidden = YES;
            self.needPlaceholderView = NO;
        }else {
            self.placeholderView.hidden = NO;
        }
        
    } else {//不为空，移除占位图
        self.placeholderView.hidden = YES;
    }
}

- (void)makeDefaultPlaceholderView {
    self.placeholderView = [[FMPlaceholderView alloc]initWithFrame:CGRectMake(0, 0, self.size.width, self.size.height)];
    __weak typeof(self) weakSelf = self;
    [self.placeholderView setReloadClickBlock:^{
        if (weakSelf.reloadBlock) {
            weakSelf.reloadBlock();
        }
    }];
    self.placeholderView = self.placeholderView;
    self.placeholderView.hidden = YES;

    if (self.placeholderView.reloadButton.imageView.image == nil) {
        [self.placeholderView.reloadButton setImage:[UIImage imageNamed:@"placeholder"] forState:UIControlStateNormal];
    }
    [self addSubview:self.placeholderView];
}

- (void)reloadButtonIconName:(NSString *)iconName cornerRadius:(CGFloat)radius buttonSize:(CGSize)btnSize fullPlaceholderBackgroundColor:(UIColor *)backgroundColor{
    
    if (!self.placeholderView) {
        [self makeDefaultPlaceholderView];
    }
    if (iconName.length) {
        [self.placeholderView.reloadButton setImage:nil forState:UIControlStateNormal];
        [self.placeholderView.reloadButton setImage:[UIImage imageNamed:iconName] forState:UIControlStateNormal];
    }
    if (radius > 0) {
        [self.placeholderView.reloadButton.layer setCornerRadius:radius];
        self.placeholderView.reloadButton.clipsToBounds = YES;
    }
    
    if (btnSize.width > 0 && btnSize.height > 0) {
        [self.placeholderView.reloadButton setSize:btnSize];
    }
    
    if (backgroundColor) {
        [self.placeholderView setBackgroundColor:backgroundColor];
    }
    
    self.placeholderView.reloadButton.center = self.placeholderView.center;
}

- (UIView *)placeholderView {
    return objc_getAssociatedObject(self, @selector(placeholderView));
}

- (void)setPlaceholderView:(UIView *)placeholderView {
    objc_setAssociatedObject(self, @selector(placeholderView), placeholderView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)firstReloadNoCheck {
    return [objc_getAssociatedObject(self, @selector(firstReloadNoCheck)) boolValue];
}

- (void)setFirstReloadNoCheck:(BOOL)firstReloadNoCheck {
    objc_setAssociatedObject(self, @selector(firstReloadNoCheck), @(firstReloadNoCheck), OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)needPlaceholderView {
    return [objc_getAssociatedObject(self, @selector(needPlaceholderView)) boolValue];
}

- (void)setNeedPlaceholderView:(BOOL)needPlaceholderView {
    objc_setAssociatedObject(self, @selector(needPlaceholderView), @(needPlaceholderView), OBJC_ASSOCIATION_ASSIGN);
}

- (void (^)(void))reloadBlock {
    return objc_getAssociatedObject(self, @selector(reloadBlock));
}

- (void)setReloadBlock:(void (^)(void))reloadBlock {
    objc_setAssociatedObject(self, @selector(reloadBlock), reloadBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

@end
