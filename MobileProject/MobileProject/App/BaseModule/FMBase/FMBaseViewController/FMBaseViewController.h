//
//  fmBaseViewController.h
//  MobileProject
//
//  Created by Mingoy on 16/9/14.
//  Copyright © 2016年 Mingoy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD+MP.h"
#import "RealReachability.h"

@protocol  BBBaseViewControllerDataSource<NSObject>

@optional
- (NSMutableAttributedString*)setTitle;
- (UIButton*)set_leftButton;
- (UIButton*)set_rightButton;
- (UIColor*)set_colorBackground;
- (CGFloat)set_navigationHeight;
- (UIView*)set_bottomView;
- (UIImage*)navBackgroundImage;
- (BOOL)hideNavigationBottomLine;
- (UIImage*)set_leftBarButtonItemWithImage;
- (UIImage*)set_rightBarButtonItemWithImage;
@end


@protocol BBBaseViewControllerDelegate <NSObject>

@optional
- (void)left_button_event:(UIButton*)sender;
- (void)right_button_event:(UIButton*)sender;
- (void)title_click_event:(UIView*)sender;
@end



@interface FMBaseViewController : UIViewController<BBBaseViewControllerDelegate,BBBaseViewControllerDataSource>
/// 是否可以点击
@property(nonatomic, assign) BOOL couldClick;
//页面接收参数
@property(nonatomic,strong)NSDictionary *parameterDictionary;
/** 列表page编号 */
@property(nonatomic, assign) NSInteger pageNum;
/** 列表page大小 */ 
@property(nonatomic, assign) NSInteger pageSize;

//初始化参数
- (id)initWithRouterParams:(NSDictionary *)params;
//设置NavigationBar的Y轴
- (void)changeNavigationBarTranslationY:(CGFloat)translationY;
//设置标题
- (void)set_Title:(NSMutableAttributedString *)title;
- (void)fm_backBarButtonItemClickedAnimatedNO;
- (void)fm_backBarButtonItemClickedAnimatedYES;

/** 让某个scrollView支持全局侧滑手势 【viewDidLoad方法中调用】*/
- (void)fm_letScrollViewSupportGlobalSideslipGestures:(UIScrollView *)scrollView;
- (void)headerRefresh;
@end
