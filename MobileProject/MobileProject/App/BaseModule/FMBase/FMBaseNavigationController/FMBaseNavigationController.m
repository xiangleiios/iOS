//
//  FMBaseNavigationController.m
//  MobileProject
//
//  Created by Mingo on 2017/7/5.
//  Copyright © 2017年 ZSGY. All rights reserved.
//

#import "FMBaseNavigationController.h"
#import "UIImage+FMExtension.h"


@interface FMBaseNavigationController ()<UIGestureRecognizerDelegate>

@end


@implementation FMBaseNavigationController

- (id)initWithRootViewController:(UIViewController *)rootViewController {
    self = [super initWithRootViewController:rootViewController];
    if (self) {
        [self initialMyNavigationController];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.interactivePopGestureRecognizer.delegate = self;
    
//    [self popPanGesture];
    /** // 一行代码搞定导航栏显示图片
     [self wr_setNavBarBackgroundImage:[UIImage imageNamed:@"millcolorGrad"]];
     // 一行代码搞定导航栏颜色
     [self wr_setNavBarBarTintColor:[UIColor whiteColor]];
     // 一行代码搞定导航栏透明度
     [self wr_setNavBarBackgroundAlpha:alpha];
     // 一行代码搞定导航栏两边按钮颜色
     [self wr_setNavBarTintColor:[UIColor whiteColor]];
     // 一行代码搞定导航栏上标题颜色
     [self wr_setNavBarTitleColor:[UIColor whiteColor]];
     // 一行代码搞定状态栏是 default 还是 lightContent
     [self wr_setStatusBarStyle:UIStatusBarStyleLightContent];
     // 一行代码搞定导航栏底部分割线是否隐藏
     [self wr_setNavBarShadowImageHidden:YES];
     
     // 设置导航栏默认的背景颜色
     [UIColor wr_setDefaultNavBarBarTintColor:MainNavBarColor];
     // 设置导航栏所有按钮的默认颜色
     [UIColor wr_setDefaultNavBarTintColor:[UIColor whiteColor]];
     // 设置导航栏标题默认颜色
     [UIColor wr_setDefaultNavBarTitleColor:[UIColor whiteColor]];
     // 统一设置状态栏样式
     [UIColor wr_setDefaultStatusBarStyle:UIStatusBarStyleLightContent];
     // 如果需要设置导航栏底部分割线隐藏，可以在这里统一设置
     [UIColor wr_setDefaultNavBarShadowImageHidden:YES];
     
     */
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

#pragma mark -  通过拦截push方法来设置每个push进来的控制器的返回按钮
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.childViewControllers.count > 0) { // 如果push进来的不是第一个控制器
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@"" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
        [btn setImage:[UIImage imageNamed:@"fanhui"] forState:UIControlStateNormal];
//        [btn setImage:[UIImage imageNamed:@"navigationButtonReturnClick"] forState:UIControlStateHighlighted];
//        [btn sizeToFit];
        [btn setFrame:CGRectMake(0, 0, 40, 40)];
        // 让按钮内部的所有内容左对齐
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        
        //设置内边距，让按钮靠近屏幕边缘
//        btn.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
        [btn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
        viewController.hidesBottomBarWhenPushed = YES; // 隐藏底部的工具条
    }

    // 一旦调用super的pushViewController方法,就会创建子控制器viewController的view并调用viewController的viewDidLoad方法。可以在viewDidLoad方法中重新设置自己想要的左上角按钮样式
    [super pushViewController:viewController animated:animated];
    
}

- (void)back {
    if ([FMSingle shareSingle].popToViewController) {
        [self popToViewController:[FMSingle shareSingle].popToViewController animated:YES];
        [FMSingle shareSingle].popToViewController = nil;
    }else{
        [self popViewControllerAnimated:YES];
    }
}

// pop的全屏手势
- (void)popPanGesture{
    
    // 创建一个全屏手势覆盖系统的方法
    UIPanGestureRecognizer *popPanGesture = [[UIPanGestureRecognizer alloc]initWithTarget:self.interactivePopGestureRecognizer.delegate action:@selector(back)];
    
    // 控制手势的触发,在代理方法中实现
    popPanGesture.delegate = self;
    
    // 把手势添加到self.view
    [self.view addGestureRecognizer:popPanGesture];
    
    // 关掉系统的边缘返回手势
    self.interactivePopGestureRecognizer.enabled = NO;
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    BOOL flag = self.childViewControllers.count != 1;
    return flag;
}

//- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
//    
//    BOOL ok = YES; // 默认为支持右滑反回
//    
//    if ([self.topViewController isKindOfClass:[FMBaseViewController class]]) {
//        
//        if ([self.topViewController respondsToSelector:@selector(gestureRecognizerShouldBegin)]) {
//            
//            FMBaseViewController *vc = (FMBaseViewController *)self.topViewController;
//            
//            ok = [vc gestureRecognizerShouldBegin];
//            
//        } 
//        
//    } 
//    
//    return ok; 
//    
//}

#pragma mark-统一对导航进行设置
- (void)initialMyNavigationController {

    
    //set NavigationBar 背景颜色&title 颜色
//        [self.navigationBar setBarTintColor:kNavBarColor];
//        [self.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:[UIColor whiteColor]}];
//        [self.navigationBar setTintColor:[UIColor whiteColor]];
//    // 设置导航栏默认的背景颜色
//        [WRNavigationBar wr_setDefaultNavBarBarTintColor:[UIColor clearColor]];
    // 设置导航栏标题默认颜色
//        [WRNavigationBar wr_setDefaultNavBarTitleColor:[UIColor whiteColor]];
    // 一行代码搞定导航栏两边按钮颜色
//    [self wr_setNavBarTintColor:[UIColor whiteColor]];
    
    
//    //设置导航字体大小和颜色
//    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
//    [attributes setValue:[UIColor blackColor] forKey:NSForegroundColorAttributeName];
//    [attributes setValue:[UIFont boldSystemFontOfSize:17] forKey:NSFontAttributeName];
//    self.navigationBar.titleTextAttributes = attributes;
    
//    UINavigationBar *navigationBar = self.navigationController.navigationBar;
//    //设置透明的背景图，便于识别底部线条有没有被隐藏
    
    //导航颜色
//    self.navigationBar.barTintColor = kNavBarColor;
//    
//    //导航返回按钮颜色
//    self.navigationBar.tintColor = [UIColor whiteColor];
    
//    [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"icon_nav_bar"] forBarMetrics:UIBarMetricsDefault];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
