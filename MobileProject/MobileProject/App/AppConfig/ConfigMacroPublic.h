//
//  ConfigMacro.h
//  demo
//
//  Created by Mingo on 16/10/2.
//  Copyright © 2016年 袁凤鸣. All rights reserved.
//↓↑‖◈▣✄▼▼▼▼▼▲▲▲▲▲↖↖↖↘↘↙↙↗↗➹➹➹☠▽▽▽△△♤♡

#ifndef ConfigMacro_h
#define ConfigMacro_h

//开发的时候打印，但是发布的时候不打印的NSLog
#ifdef DEBUG

#define kNeedDebugBackgroundColor 0
#define KKLog(...) NSLog(@"%s 第%d行 \n %@\n\n",__func__,__LINE__,[NSString stringWithFormat:__VA_ARGS__])
#define NSLog(...) NSLog(@"%s 第%d行 \n %@\n\n",__func__,__LINE__,[NSString stringWithFormat:__VA_ARGS__])

#else
#define kNeedDebugBackgroundColor 0
#define KKLog(...)
#define NSLog(...)
#endif
#define SCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width       //屏幕宽度
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height      //屏幕高度

//弱引用/强引用
#define kWeakSelf(type)   __weak typeof(type) weak##type = type;

//字符串是否为空
#define kStringIsEmpty(str) ([str isKindOfClass:[NSNull class]] || str == nil || [str length] < 1 ? YES : NO )
//数组是否为空
#define kArrayIsEmpty(array) (array == nil || [array isKindOfClass:[NSNull class]] || array.count == 0)
//字典是否为空
#define kDictIsEmpty(dic) (dic == nil || [dic isKindOfClass:[NSNull class]] || dic.allKeys == 0)
//是否是空对象
#define kObjectIsEmpty(_object) (_object == nil \
|| [_object isKindOfClass:[NSNull class]] \
|| ([_object respondsToSelector:@selector(length)] && [(NSData *)_object length] == 0) \
|| ([_object respondsToSelector:@selector(count)] && [(NSArray *)_object count] == 0))


//▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼ 图片 ▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼
//读取本地NSBundle图片
#define kImageFromBundleWithEndType(imageName) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:imageName ofType:nil]]
//获取图片；前面2种性能比这个高，但这个常用，assets.xcassets里的用这个吧
#define kImage(imageName) [UIImage imageNamed:[NSString stringWithFormat:@"%@",imageName]]

//▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼ ALERT 弹框 ▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼
// alert弹框,只需要一行代码就能完成弹窗提醒
#define alert(string, detail) UIAlertController *alertController = [UIAlertController alertControllerWithTitle:string message:detail preferredStyle:UIAlertControllerStyleAlert]; \
UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil]; \
[alertController addAction:okAction]; \
[self presentViewController:alertController animated:YES completion:nil];

//普通的alert view
#define kALERT(info)\
UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:info delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];\
[alert show];
//普通的alert view 该功能正在开发中ing,稍后开放！
#define k_ALERT_FEATURE_DEVELOPMENT UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"该功能正在开发中ing,稍后开放！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];\
[alert show];


//▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼ GCD ▼▼▼▼▼▼ 使用时()括号内需要自己加上 ^{}
//GCD - 一次性执行
#define kDISPATCH_ONCE_BLOCK(onceBlock) static dispatch_once_t onceToken; dispatch_once(&onceToken, onceBlock);
//GCD - 在Main线程上运行
#define kDISPATCH_MAIN_THREAD(mainQueueBlock) dispatch_async(dispatch_get_main_queue(), mainQueueBlock);
//GCD - 开启异步线程
#define kDISPATCH_GLOBAL_QUEUE_DEFAULT(globalQueueBlock) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), globalQueueBlocl);

#define keyPath(objc,keyPath) @(((void)objc.keyPath, #keyPath))


//=========================== Mingo ADD
#define kAllocInit(className) [[className alloc] init]
#define kPushToVC(vc)  [self.navigationController pushViewController:vc animated:YES]
#define kPushToVcNotAnimated(ObjectName)  [self.navigationController pushViewController:ObjectName animated:NO]
#define kHudShowResponseObjectMessage [MBProgressHUD showAutoMessage:responseObject[@"message"]];
#define kResponseObjectStatusCodeIsEqual(Num) [responseObject[@"code"] integerValue] == Num
#define kResponseObjectMessage responseObject[@"message"]


//防止重复调用跳转, 每xx秒内只能执行一次
#define kAfterOnceTimer(AfterTimerTime) static BOOL onece = NO; dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(AfterTimerTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{onece = NO;});if (onece) {    return;} onece = YES;



#endif /* ConfigMacro_h */
