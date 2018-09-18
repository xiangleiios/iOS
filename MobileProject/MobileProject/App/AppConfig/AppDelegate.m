//
//  AppDelegate.m
//  MobileProject
//
//  Created by Mingoy on 16/9/13.
//  Copyright © 2016年 Mingoy. All rights reserved.
//

#import "AppDelegate.h"
#import "AppDelegate+ShareIntent.h"
#import "FMDesignerConfigManager.h"
#import "FMAnalytics.h"
#import "FMShare.h"
#import "FMCheckVersion.h"
#import "ThirdPartKeys.h"
#import "UIViewController+FMExtenion.h"
#import "UIViewController+Swizzled.h"
#import "FMBaseNavigationController.h"
#import "CYLTabBarControllerConfig.h"
#import <UMSocialCore/UMSocialCore.h>
#import "DHGuidePageHUD.h"
#import "JPUSHService.h"    // JPush功能所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h> // iOS10注册APNs所需头 件
#endif

//#import "FLPayManager.h" //支付封装
//首页
#import "PDNavigationController.h"



#import "BaiduMapHeader.h"

#import "GuideView.h"

//#import "XLUPPay.h"

#import "LoginVC.h"
#import <IQKeyboardManager/IQKeyboardManager.h>
// 如果需要使 idfa功能所需要引 的头 件(可选) #import <AdSupport/AdSupport.h>
@interface AppDelegate ()<JPUSHRegisterDelegate,UITabBarControllerDelegate, CYLTabBarControllerDelegate>
//@property (nonatomic, strong)BMKMapManager* mapManager;
@property (nonatomic , strong)CYLTabBarControllerConfig *tab;
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    [self initBaseDataFrist];
    [self initJPushAfterFinishLaunchingWithOptions:launchOptions];
    [self initTabbar]; // TabBar初始化
    
    ///百度地图取消
//    [self initBaiduMapSDK];
    
    
    [AppDelegate registeredUMSocialSDKtoApp];
//    [FLPAYMANAGER fl_registerApp];  //支付配置
    [FMCheckVersion fm_getAppsInfoAndCheckUpdata]; //版本跟新
    [self setKeyboardManager];

//    [self getGuideFigure]; //添加广告图
    //    [[BaiduMobStat defaultStat] startWithAppId:@"e957421397"]; //百度统计
    
    return YES;
}
- (void)setKeyboardManager{
    IQKeyboardManager *keyboardManager = [IQKeyboardManager sharedManager]; // 获取类库的单例变量
    keyboardManager.enable = YES; // 控制整个功能是否启用
    keyboardManager.shouldResignOnTouchOutside = YES; // 控制点击背景是否收起键盘
    keyboardManager.shouldToolbarUsesTextFieldTintColor = YES; // 控制键盘上的工具条文字颜色是否用户自定义
    keyboardManager.toolbarManageBehaviour = IQAutoToolbarBySubviews; // 有多个输入框时，可以通过点击Toolbar 上的“前一个”“后一个”按钮来实现移动到不同的输入框
    keyboardManager.enableAutoToolbar = YES; // 控制是否显示键盘上的工具条
    keyboardManager.shouldShowTextFieldPlaceholder = YES; // 是否显示占位文字
    keyboardManager.placeholderFont = [UIFont boldSystemFontOfSize:kFit_Font6(17)]; // 设置占位文字的字体
    keyboardManager.keyboardDistanceFromTextField = 10.0f; // 输入框距离键盘的距离
    
}
- (void)initTabbar {
//    CYLTabBarControllerConfig * TabBarControllerConfig = [[CYLTabBarControllerConfig alloc] init];
//    self.tab = TabBarControllerConfig;
    //（2）(可省略)改变一些导航条的全局设置，但是如果省略的就会默认使用其单例里面的设置信息
    EasyNavigationOptions *options = [EasyNavigationOptions shareInstance];
    options.titleColor = [UIColor blackColor]; // 统一设置导航标题颜色
    options.buttonTitleFont = [UIFont systemFontOfSize:kFit_Font6(15)];
    options.buttonTitleColor = appcoloer;
    // 设置系统返回按钮为样式
    options.navigationBackButtonImage = [UIImage imageNamed:@"arrows_left_icon"];
    
    

    if ([User UserOb].UserLogin) {
        CYLTabBarControllerConfig * TabBarControllerConfig = [[CYLTabBarControllerConfig alloc] init];
        self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        self.window.rootViewController  = TabBarControllerConfig.tabBarController ;
    }else{
        LoginVC *Loginvc = [[LoginVC alloc] init];
        self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        self.window.rootViewController  = Loginvc ;
    }
    
    



//    TabBarControllerConfig.tabBarController.delegate=self;
    self.window.backgroundColor=[UIColor whiteColor];
    [self.window makeKeyAndVisible];
    /** App判断第一次启动的方法 */
    NSString *key = @"isFirst";
    BOOL isFirst = [[NSUserDefaults standardUserDefaults] boolForKey:key];
    if (!isFirst) {
        [[NSUserDefaults standardUserDefaults] setBool:@1 forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [[GuideViewManager sharedInstance] showGuideViewWithGuideImages:@[@"1",@"2",@"3"] withSkipButtonTitle:@"" withExperienceButtonImage:[UIImage imageNamed:@"experienceImage"]];
       
    }
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    
}

- (void)tagsAliasCallback:(int)iResCode tags:(NSSet*)tags alias:(NSString*)alias {
    NSLog(@"rescode: %d, \ntags: %@, \nalias: %@\n", iResCode, tags , alias);
}

- (void)applicationWillResignActive:(UIApplication *)application {

}

- (void)applicationDidEnterBackground:(UIApplication *)application {

}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
}

- (void)applicationWillTerminate:(UIApplication *)application {
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    [application setApplicationIconBadgeNumber:0];
    [application cancelAllLocalNotifications];
}

#pragma mark - iOS10收到推送
- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler
{
    NSDictionary *userInfo=[[NSDictionary alloc]init];
    userInfo=notification.request.content.userInfo;
    [self yfAlertPush:userInfo];
    
    completionHandler(UNNotificationPresentationOptionSound | UNNotificationPresentationOptionAlert);
}

#pragma mark- JPUSHRegisterDelegate iOS10前台收到推送
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    // Required
    NSDictionary * userInfo = notification.request.content.userInfo;
    [self yfAlertPush:userInfo];
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    
    completionHandler(UNNotificationPresentationOptionAlert|UNNotificationPresentationOptionSound); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以选择设置
}

#pragma mark - iOS10点击推送执行方法
- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    
    NSDictionary *userInfo=[[NSDictionary alloc]init];
    userInfo=response.notification.request.content.userInfo;
    [self yfGotoPage:userInfo];
}

#pragma mark - ------------iOS10 后台点击通知栏的推送执行方法
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    
    // Required
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    [self yfGotoPage:userInfo];
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    
    completionHandler(UNNotificationPresentationOptionSound|UNNotificationPresentationOptionAlert);  // 系统要求执行这个方法
}

#pragma mark - iOS7——ios9系统，收到通知---iOS9前台收到推送执行方法【iOS9后台点击通知栏执行推送方法】
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    NSLog(@"iOS7——ios9系统，收到通知:%@", userInfo);
    if ([[UIDevice currentDevice].systemVersion floatValue] < 10.0 || application.applicationState>0) { //前台
        [self yfAlertPush:userInfo];
    } else {//后台
        [self yfGotoPage:userInfo];
    }
    [JPUSHService handleRemoteNotification:userInfo];
    completionHandler(UNNotificationPresentationOptionSound|UNNotificationPresentationOptionAlert);
}

#pragma mark - iOS9收到执行方法
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    //应用运行时的消息处理
    if ([[UIDevice currentDevice].systemVersion floatValue] <10.0 || application.applicationState > 0) { //前台
        [self yfAlertPush:userInfo];
    } else {//后台
        [self yfGotoPage:userInfo];
    }
    [JPUSHService handleRemoteNotification:userInfo];
}

/// 最老的版本，最好也写上
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
    if (!result) {
//        return [FLPAYMANAGER fl_handleUrl:url];
    }
    return result;
}
/// iOS 9.0 之前 会调用
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
    if (!result) {
//         return [FLPAYMANAGER fl_handleUrl:url];
    }
    NSLog(@"url=====%@ \n  sourceApplication=======%@ \n  annotation======%@", url, sourceApplication, annotation);
    NSString *str=[NSString stringWithFormat:@"%@",url];
    return result;
}

/// iOS 9.0 以上（包括iOS9.0）
- (BOOL)application:(UIApplication *)application openURL:(nonnull NSURL *)url options:(nonnull NSDictionary<NSString *,id> *)options{
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
    NSLog(@"url=====%@", url);
    NSString *str=[NSString stringWithFormat:@"%@",url];
    
    /// 判断返回链接是否是银联的返回
    if([str rangeOfString:@"uppayresult"].location != NSNotFound){
//        [XLUPPay uppay_handleUrl:url];
        return result;
    }
   
    if (!result) {
//        return [FLPAYMANAGER fl_handleUrl:url];
    }
    
    return result;
}




#pragma mark--注册devicetoken
- (void)application:(UIApplication *)app didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    NSLog(@"%@", [NSString stringWithFormat:@"Device Token: %@", deviceToken]);
    [JPUSHService registerDeviceToken:deviceToken];
}

#pragma mark--注册devicetoken 失败
- (void)application:(UIApplication *)app didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSString *error_str = [NSString stringWithFormat: @"%@", error];
    NSLog(@"Failed to get token, error:%@", error_str);
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
    [JPUSHService showLocalNotificationAtFront:notification identifierKey:nil];
}

#pragma mark - 提示处理推送消息
- (void)yfAlertPush:(NSDictionary *)userInfo {
    
    AppDelegate *delegete = (AppDelegate *)[UIApplication sharedApplication].delegate;
    UIViewController *vc = delegete.window.rootViewController;
    if ([UIApplication sharedApplication].applicationState == UIApplicationStateActive) {
        // app在前台给出alert
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"收到推送" message:userInfo[@"title"] preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {}]];
        
        [alert addAction:[UIAlertAction actionWithTitle:@"详情" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
      
            [self yfGotoPage:userInfo];
        }]];
        
        [vc presentViewController:alert animated:YES completion:nil];
    }else { //不是在前台就执行这个 通知栏收到推送加了右边的是不是后台判断反而不行 //if ([UIApplication sharedApplication].applicationState == UIApplicationStateBackground
        
        [self yfGotoPage:userInfo];
    }
}

- (void)yfGotoPage:(NSDictionary *)userInfo {
    NSString *idid = userInfo[@"id"];
    [self loadordersInfo:[idid integerValue]];
//    UINavigationController *nav;
//    AppDelegate *delegete = (AppDelegate *)[UIApplication sharedApplication].delegate;
//    UIViewController *currentVc = delegete.window.rootViewController;
//
//    if ([currentVc isKindOfClass:[CYLTabBarController class]]) {
//        CYLTabBarController *tabVC = [self fm_ifIsCYLTabBarControllerSoReturn];
//        [tabVC.view endEditing:YES];
//        nav = tabVC.selectedViewController;
//
//    } else if ([currentVc isKindOfClass:[UINavigationController class]]) {
//        nav = (UINavigationController*)currentVc;
//    }
//    FMMainModel *model = [FMMainModel mj_objectWithKeyValues:userInfo];
//
//    DetailsVC *vc = [[DetailsVC alloc]init];
//    model.module_type = model.type; //推送格type 对应  module_type
//    vc.model = model;
//    [nav pushViewController:vc animated:YES];
}

#pragma mark - 获取推送过来的订单详情
- (void)loadordersInfo:(NSInteger )idid{
    
}





- (CYLTabBarController *)fm_ifIsCYLTabBarControllerSoReturn{
    AppDelegate *delegete = (AppDelegate *)[UIApplication sharedApplication].delegate;
    UIViewController *vc = delegete.window.rootViewController;
    if ([vc isKindOfClass:[CYLTabBarController class]]) {
        return (CYLTabBarController *)vc;
    }else{
        return nil;
    }
}

#pragma mark - 监控tabbar的点击
//- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
//    [[self cyl_tabBarController] updateSelectionStatusIfNeededForTabBarController:tabBarController shouldSelectViewController:viewController];
//    FMBaseNavigationController *nav=(FMBaseNavigationController *)viewController;
//
//    if ([viewController.tabBarItem.title isEqualToString:@"文化商城"] &&[tabBarController.selectedViewController.tabBarItem.title isEqualToString:@"文化商城"]) {
//        FMWebViewVC *vc=(FMWebViewVC *)nav.visibleViewController;
//        [vc.webView reload];
//
//    }else if ([viewController.tabBarItem.title isEqualToString:@"首页"] &&[tabBarController.selectedViewController.tabBarItem.title isEqualToString:@"首页"]) {
//        FMHomeVC *vc=(FMHomeVC *)nav.visibleViewController;
//        [vc.table.mj_header beginRefreshing];
//        [vc headerRefresh];
//
//    }else if ([viewController.tabBarItem.title isEqualToString:@"社区"] &&[tabBarController.selectedViewController.tabBarItem.title isEqualToString:@"社区"]) {
//
//        FMCommunityVC *vc=(FMCommunityVC *)nav.visibleViewController;
//        [vc.topicList.table.mj_header beginRefreshing];
//        [vc.topicList headerRefresh];
//    }else if ([viewController.tabBarItem.title isEqualToString:@"活动"] &&[tabBarController.selectedViewController.tabBarItem.title isEqualToString:@"活动"]) {
//
//        FMActivityVC *vc=(FMActivityVC *)nav.visibleViewController;
//        [vc headerRefresh];
//    }
//    return YES;
//}
- (void)tabBarController:(UITabBarController *)tabBarController didSelectControl:(UIControl *)control {
  
}

#pragma mark - 此方法会在设备横竖屏变化的时候调用
//- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window {
//    if (_allowRotate == 1) {
//        return UIInterfaceOrientationMaskAll;
//    }else{
//        return UIInterfaceOrientationMaskPortrait;
//    }
//}
//
//// 返回是否支持设备自动旋转
//- (BOOL)shouldAutorotate {
//    if (_allowRotate == 1) {
//        return YES;
//    }
//    return NO;
//}

- (void)initJPushAfterFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // 3.0.0及以后版本注册可以这样写，也可以继续用旧的注册方式
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    BOOL apsForProduction = YES;
#ifdef DEBUG
    SWIZZ_IT    //点击页面会打印当前的控制器名称
    apsForProduction = NO;
#endif
    [JPUSHService setupWithOption:launchOptions appKey:keyJPushAppKey channel:@"AppStore"  apsForProduction:apsForProduction advertisingIdentifier:nil];
    //2.1.9版本新增获取registration id block接口。
    [JPUSHService registrationIDCompletionHandler:^(int resCode, NSString *registrationID) {
        if(resCode == 0){
            NSLog(@"registrationID获取成功：%@",registrationID);
            //JPush 监听登陆成功 后才能 设置推送别名
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(networkDidLogin:)  name:kJPFNetworkDidLoginNotification  object:nil];
        }else{
            NSLog(@"registrationID获取失败，code：%d",resCode);
        }
    }];
    
}
/**
 *  登录成功，设置别名，移除监听
 */
- (void)networkDidLogin:(NSNotification *)notification {
    
    User* bean = [User UserOb];
    if (bean.UserLogin) {
        NSSet *set=[[NSSet alloc] initWithObjects:[NSString stringWithFormat:@"%@",bean.type], nil];
        NSString *str=[NSString stringWithFormat:@"%@%@%@",bean.idid,bean.idid,bean.idid];
        NSString *str1=[NSString stringWithFormat:@"%@",bean.idid];
        
//        [JPUSHService setTags:set alias:str1 fetchCompletionHandle:^(int iResCode, NSSet *iTags, NSString *iAlias){
//            KKLog(@"rescode: %d, \ntags: %@, \nalias: %@\n", iResCode, iTags, iAlias);
//        }];
        [JPUSHService setAlias:str1 completion:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
            KKLog(@"rescode: %d,  \nalias: %@\n  seq:%d", iResCode, iAlias ,seq);
        } seq:1];
    }
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kJPFNetworkDidLoginNotification object:nil];
}


- (void)initBaseDataFrist{
    self.allowRotate = 0;
    [FMSingle shareSingle]; //初始化全局单例
    //建表,本地存储点赞
    self.fmdb = [[SQLfmdb alloc]init];
    [self.fmdb createsqlitedb];//创建数据库文件;
    [self.fmdb createTableName:@"Thumbup"];
}

#pragma mark-百度地图
//- (void)initBaiduMapSDK {
//    // 要使用百度地图，请先启动BaiduMapManager
//    _mapManager = [[BMKMapManager alloc]init];
//    // 如果要关注网络及授权验证事件，请设定     generalDelegate参数
//    BOOL ret = [_mapManager start:keyBaiduMap  generalDelegate:nil];
//    if (!ret) {
//        NSLog(@"BMKMapManager start failed!");
//    }
//}

@end
