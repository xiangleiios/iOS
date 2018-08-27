//
//  ConfigMacroSpecial.h
//  demo
//
//  Created by Mingo on 16/10/7.
//  Copyright © 2016年 袁凤鸣. All rights reserved.
//

#ifndef ConfigMacroSpecial_h
#define ConfigMacroSpecial_h

//▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼ 判断当前的iPhone设备/系统版本 ▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼

// 判断是否为iPhone 6/6s
#define iPhone6_6s [[UIScreen mainScreen] bounds].size.width == 375.0f && [[UIScreen mainScreen] bounds].size.height == 667.0f
// 判断是否为iPhone 6Plus/6sPlus
#define iPhone6Plus_6sPlus [[UIScreen mainScreen] bounds].size.width == 414.0f && [[UIScreen mainScreen] bounds].size.height == 736.0f

//判断 iOS 8 或更高的系统版本
#define iOS8above    (([[[UIDevice currentDevice] systemVersion] floatValue] >=8.0)? (YES):(NO))
#define isIOS10below    (([[[UIDevice currentDevice] systemVersion] floatValue] < 10.0)? (YES):(NO))
#define iOS7below    (([[[UIDevice currentDevice] systemVersion] floatValue] <=7.0)? (YES):(NO))

//APP版本号
#define kAppVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

//获取系统版本
#define KSystemVersionFloatValue    ([[[UIDevice currentDevice] systemVersion] floatValue])
#define kSystemVersionDoubleValue   ([[[UIDevice currentDevice] systemVersion] doubleValue])
#define kSystemVersion              ([[UIDevice currentDevice] systemVersion])

//获取当前语言
#define kCurrentLanguage ([[NSLocale preferredLanguages] objectAtIndex:0])
//判断是否为iPhone
#define kISiPhone (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)



//▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼ MBProgressHUD.h ▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼
//<><><>设置加载提示框（MBProgressHUD）<><><><><>
// 加载
#define kShowNetworkActivityIndicator() [UIApplication sharedApplication].networkActivityIndicatorVisible = YES
// 收起加载
#define HideNetworkActivityIndicator()      [UIApplication sharedApplication].networkActivityIndicatorVisible = NO
// 设置加载
#define NetworkActivityIndicatorVisible(x)  [UIApplication sharedApplication].networkActivityIndicatorVisible = x


#define kBackView         for (UIView *item in kWindow.subviews) { \
if(item.tag == 10000) \
{ \
[item removeFromSuperview]; \
UIView * aView = [[UIView alloc] init]; \
aView.frame = [UIScreen mainScreen].bounds; \
aView.tag = 10000; \
aView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:1]; \
[kWindow addSubview:aView]; \
} \
} \
//MB，在window层显示
#define kShowHUDAndActivity kBackView;[MBProgressHUD showHUDAddedTo:kWindow animated:YES];kShowNetworkActivityIndicator()
#define kHiddenHUD [MBProgressHUD hideAllHUDsForView:kWindow animated:YES]

#define kRemoveBackView         for (UIView *item in kWindow.subviews) { \
if(item.tag == 10000) \
{ \
[UIView animateWithDuration:0.4 animations:^{ \
item.alpha = 0.0; \
} completion:^(BOOL finished) { \
[item removeFromSuperview]; \
}]; \
} \
} \

#define kHiddenHUDAndAvtivity kRemoveBackView;kHiddenHUD;HideNetworkActivityIndicator()

//>>>>>>>>>>>>>>>>>>>>>>>>>
//<><><><><><><><><><>显示加载菊花
//显示的位置
#define kShowHUD(view) kBackView;[MBProgressHUD showHUDAddedTo:view animated:YES];kShowNetworkActivityIndicator()
//隐藏
#define kHideHUD(view) [MBProgressHUD hideAllHUDsForView:view animated:YES]
//<><><><><><><><><><>显示问题提醒
#define kShowLabel(view,text) MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];\
hud.labelText = text;\
hud.mode = MBProgressHUDModeText;\
hud.removeFromSuperViewOnHide = YES;\
[hud hide:YES afterDelay:1.0];\


//获取沙盒Document路径
#define kDocumentPath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]
//获取沙盒temp路径
#define kTempPath NSTemporaryDirectory()
//获取沙盒Cache路径
#define kCachePath [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]

#define PUSHPLIST [kDocumentPath stringByAppendingPathComponent:@"push.plist"]
//判断是真机还是模拟器
#if TARGET_OS_IPHONE
//真机
#endif

#if TARGET_IPHONE_SIMULATOR
//模拟器
#endif


//获取一段时间间隔
#define kStartTime CFAbsoluteTime start = CFAbsoluteTimeGetCurrent();
#define kEndTime   NSLog(@"EndTime - StartTime : %f", CFAbsoluteTimeGetCurrent() - start)

 

/*
 
 //▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼    ▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼
 //设置 view 圆角和边框
 #define k_SET_ViewBorderRadius(View, Radius, Width, Color)\
 \
 [View.layer setCornerRadius:(Radius)];\
 [View.layer setMasksToBounds:YES];\
 [View.layer setBorderWidth:(Width)];\
 [View.layer setBorderColor:[Color CGColor]]
 
 
 #define kDegreesToRadian(x) (M_PI * (x) / 180.0)           //由角度转换弧度
 #define kRadianToDegrees(radian) (radian*180.0)/(M_PI)     //由弧度转换角度
 
 //▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼ Frame操作相关 ▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼
 //获取垂直居中的x（父的高度/2-子的高度/2）
 #define CENTER_VERTICALLY(parent,child) floor((parent.frame.size.height - child.frame.size.height) / 2)
 //获取水平居中的y（父的宽度/2-子的宽度/2）
 #define CENTER_HORIZONTALLY(parent,child) floor((parent.frame.size.width - child.frame.size.width) / 2)
 
 // example: [[UIView alloc] initWithFrame:(CGRect){CENTER_IN_PARENT(parentView,500,500),CGSizeMake(500,500)}];
 #define CENTER_IN_PARENT(parent,childWidth,childHeight) CGPointMake(floor((parent.frame.size.width - childWidth) / 2),floor((parent.frame.size.height - childHeight) / 2))
 #define CENTER_IN_PARENT_X(parent,childWidth) floor((parent.frame.size.width - childWidth) / 2)
 #define CENTER_IN_PARENT_Y(parent,childHeight) floor((parent.frame.size.height - childHeight) / 2)
 
 
 
 //是否为empty
 static inline BOOL IsEmpty(id thing) {
 return thing == nil || [thing isEqual:[NSNull null]]
 || ([thing respondsToSelector:@selector(length)]
 && [(NSData *)thing length] == 0)
 || ([thing respondsToSelector:@selector(count)]
 && [(NSArray *)thing count] == 0);
 }
 
 //未知字符串（nil）转为字符串（非nil）；在不确定字符串是否为nil的情况下使用
 static inline NSString *StringFromObject(id object) {
 if (object == nil || [object isEqual:[NSNull null]]) {
 return @"";
 } else if ([object isKindOfClass:[NSString class]]) {
 return object;
 } else if ([object respondsToSelector:@selector(stringValue)]){
 return [object stringValue];
 } else {
 return [object description];
 }
 }
 
 //// http://www.xuebuyuan.com/1225078.html 解读一些两个宏定义
 //#define UNICODE_TO_UTF16(x) (((((x - 0x10000) >>10) | 0xD800) << 16)  | (((x-0x10000)&3FF) | 0xDC00))
 //
 ////使用UTF16转回为大于0x10000 的Unicode码
 //#define MULITTHREEBYTEUTF16TOUNICODE(x,y) (((((x ^ 0xD800) << 2) | ((y ^ 0xDC00) >> 8)) << 8) | ((y ^ 0xDC00) & 0xFF)) + 0x10000
 
 */

#endif /* ConfigMacroSpecial_h */
