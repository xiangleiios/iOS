//
//  UITableView+WFEmpty.m
//  WFEmptyTableView
//
//  Created by wanawt on 2016/11/11.
//  Copyright © 2016年 wanawt. All rights reserved.
//

#import "UITableView+WFEmpty.h"
#import <objc/runtime.h>

static char UITableViewEmptyView;

@implementation UITableView (WFEmpty)

@dynamic emptyView;

- (UIView *)emptyView
{
    return objc_getAssociatedObject(self, &UITableViewEmptyView);
}

- (void)setEmptyView:(UIView *)emptyView
{
    [self willChangeValueForKey:@"HJEmptyView"];
    objc_setAssociatedObject(self, &UITableViewEmptyView,
                             emptyView,
                             OBJC_ASSOCIATION_ASSIGN);
    [self didChangeValueForKey:@"HJEmptyView"];
}


-(void)addEmptyViewWithImageName:(NSString*)imageName title:(NSString*)title
{
    if (!self.emptyView)
    {
        CGRect frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        UIImage* image = [UIImage imageNamed:imageName];
        NSString* text = title;
        
        UIView* noMessageView = [[UIView alloc] initWithFrame:frame];
        noMessageView.backgroundColor = [UIColor clearColor];
        
        UIImageView *carImageView = [[UIImageView alloc] init];
        [carImageView setImage:image];
        [noMessageView addSubview:carImageView];
        [carImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(noMessageView);
            make.width.mas_equalTo(image.size.width);
            make.height.mas_equalTo(image.size.height);
            make.top.mas_equalTo(noMessageView).mas_offset(KFit_H6S(300));
        }];
        
        UILabel *noInfoLabel = [[UILabel alloc] init];
        noInfoLabel.textAlignment = NSTextAlignmentCenter;
        noInfoLabel.textColor = ZTColor;
        noInfoLabel.text = text;
        noInfoLabel.numberOfLines = 0;
        noInfoLabel.backgroundColor = [UIColor clearColor];
        noInfoLabel.font = [UIFont systemFontOfSize:kFit_Font6(17)];
        [noMessageView addSubview:noInfoLabel];
        [noInfoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(noMessageView);
            make.top.mas_equalTo(carImageView.mas_bottom).mas_offset(KFit_H6S(30));
//            make.height.mas_equalTo(KFit_H6S(40));
        }];
        [self addSubview:noMessageView];
        
        self.emptyView = noMessageView;
    }
    
}
-(void)addEmptyViewWithImageName:(NSString*)imageName title:(NSString*)title But:(UIButton *)but{
    if (!self.emptyView)
    {
        CGRect frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        UIImage* image = [UIImage imageNamed:imageName];
        NSString* text = title;
        
        UIView* noMessageView = [[UIView alloc] initWithFrame:frame];
        noMessageView.backgroundColor = [UIColor clearColor];
        
        UIImageView *carImageView = [[UIImageView alloc] init];
        [carImageView setImage:image];
        [noMessageView addSubview:carImageView];
        [carImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(noMessageView);
            make.width.mas_equalTo(image.size.width);
            make.height.mas_equalTo(image.size.height);
            make.top.mas_equalTo(noMessageView).mas_offset(KFit_H6S(250));
        }];
        
        UILabel *noInfoLabel = [[UILabel alloc] init];
        noInfoLabel.textAlignment = NSTextAlignmentCenter;
        noInfoLabel.textColor = ZTColor;
        noInfoLabel.text = text;
        noInfoLabel.backgroundColor = [UIColor clearColor];
        noInfoLabel.font = [UIFont systemFontOfSize:kFit_Font6(17)];
        noInfoLabel.numberOfLines = 0;
        [noMessageView addSubview:noInfoLabel];
        [noInfoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(noMessageView);
            make.top.mas_equalTo(carImageView.mas_bottom).mas_offset(KFit_H6S(40));
//            make.height.mas_equalTo(KFit_H6S(40));
        }];
        [self addSubview:noMessageView];
        
        [noMessageView addSubview:but];
        but.layer.cornerRadius = 3;
        but.layer.masksToBounds = YES;
        [but mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(noMessageView);
            make.top.mas_equalTo(noInfoLabel.mas_bottom).mas_offset(KFit_H6S(50));
            make.height.mas_equalTo(KFit_H6S(90));
            make.width.mas_equalTo(KFit_H6S(330));
        }];
        self.emptyView = noMessageView;
    }
}
@end
