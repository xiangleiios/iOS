//
//  UIImageView+FMExtension.m
//  MingoKit
//
//  Created by Mingo on 16/10/16.
//  Copyright © 2016年 袁凤鸣. All rights reserved.
//

#import "UIImageView+FMExtension.h"
#import "UIImage+FMExtension.h"
#import <UIImageView+WebCache.h>
#import <Masonry.h>

@implementation UIImageView (FMExtension)

#pragma mark - 快速创建UIImageView
+ (UIImageView *)fm_initUIImageViewWithUrlOrName:(NSString *)urlOrName ifHasPlaceholderImageName:(NSString *)placeholderImageName cornerRadius:(CGFloat)radius addTapGestureRecognizer:(id)object tapSel:(SEL)tapSel addToSuperView:(UIView *)superView {

    UIImageView *objView = [[UIImageView alloc] init];
    
    
    UIImage *placeholderImage;
    if (placeholderImageName) {
        placeholderImage = [UIImage imageNamed:placeholderImageName];
    }else {
        placeholderImage = nil;
    }
    if ([urlOrName hasPrefix:@"http"]) {
        [objView sd_setImageWithURL:[NSURL URLWithString:urlOrName] placeholderImage:placeholderImage completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            
        }];
    }else {
        [objView setImage:[UIImage imageNamed:urlOrName]];
    }
    
//    if (radius > 1.0) [objView setImage:[objView.image fm_imageWithCornerRadius:radius]]  ; //高效设置圆角 ，但和setContentMode冲突
    
    if (radius > 1.0)  objView.layer.cornerRadius = radius;
    [objView setContentMode:UIViewContentModeScaleAspectFill];
    objView.clipsToBounds = YES;
     
    //添加一个点击手势
    if (object && tapSel) {
        objView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:object action:tapSel];
        [objView addGestureRecognizer:tapGesture];
    }
 
    if (superView) [superView addSubview:objView];
 
    return objView;
    
}


#pragma mark - 创建imageView
+ (UIImageView *)fm_createImageView:(CGRect)frame addToSuperView:(UIView *)superView imageName:(NSString *)imageName{

    UIImageView *imageView = [[UIImageView alloc]initWithFrame:frame];
    imageView.image = [UIImage imageNamed:imageName];
    [superView addSubview:imageView];
    return imageView;
}






#pragma mark - 默认为圆形头像
/** 默认为圆形头像 */
- (void)fm_setHeader:(NSString *)url
{
    [self fm_setCircleHeader:url];
}

#pragma mark - 设置圆形头像
/** 设置圆形头像 */
- (void)fm_setCircleHeader:(NSString *)url
{
    // 将占位图片也转化为圆形 其实占位图片本来就是圆形
    UIImage *placeholder = [UIImage fm_circleImageNamed:kDefaultUserIcon];
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:placeholder completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        // 如果image为空则返回占位图片
        if (image == nil) return;
        self.image = [UIImage fm_circleImage:image];
    }];
}

#pragma mark - 设置方形头像
/** 设置方形头像 */
- (void)fm_setRectHeader:(NSString *)url
{
    UIImage *placeholder = [UIImage imageNamed:kDefaultUserIcon];
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:placeholder];
}

@end
