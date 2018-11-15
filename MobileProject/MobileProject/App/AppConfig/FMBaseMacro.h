//
//  FMBaseMacro.h
//  MobileProject
//
//  Created by Mingo on 2017/7/5.
//  Copyright © 2017年 ZSGY. All rights reserved.
//

#ifndef FMBaseMacro_h
#define FMBaseMacro_h
#define appcoloer  kColor_N(90, 189, 135)
#define appcoloer_line [UIColor colorWithWhite:232/255.0 alpha:1]
//一些缩写
#define kApplication        [UIApplication sharedApplication]
#define kWindow             [UIApplication sharedApplication].keyWindow
#define kAppDelegate        [UIApplication sharedApplication].delegate
#define kUserDefaults       [NSUserDefaults standardUserDefaults]
#define kNotificationCenter [NSNotificationCenter defaultCenter]

#define kScreenW    [UIScreen mainScreen].bounds.size.width       //屏幕宽度
#define kScreenH    [UIScreen mainScreen].bounds.size.height      //屏幕高度

//获取屏幕宽度与高度
#define kScreenWidth \
([[UIScreen mainScreen] respondsToSelector:@selector(nativeBounds)] ? [UIScreen mainScreen].nativeBounds.size.width/[UIScreen mainScreen].nativeScale : [UIScreen mainScreen].bounds.size.width)
#define kScreenHeight \
([[UIScreen mainScreen] respondsToSelector:@selector(nativeBounds)] ? [UIScreen mainScreen].nativeBounds.size.height/[UIScreen mainScreen].nativeScale : [UIScreen mainScreen].bounds.size.height)
#define kScreenSize \
([[UIScreen mainScreen] respondsToSelector:@selector(nativeBounds)] ? CGSizeMake([UIScreen mainScreen].nativeBounds.size.width/[UIScreen mainScreen].nativeScale,[UIScreen mainScreen].nativeBounds.size.height/[UIScreen mainScreen].nativeScale) : [UIScreen mainScreen].bounds.size)

//fit 屏幕适配
#define KFit_W6P(WIDTH)     ((WIDTH) /(1920.0/2208.0))/3.0 * ((kScreenW)/414.0)
#define KFit_H6P(HEIGHT)    ((HEIGHT) /(1920.0/2208.0))/3.0 * ((kScreenH /736.0))
#define KFit_W6S(WIDTH)     ((WIDTH)/2.0*((kScreenW)/375.0))
#define KFit_H6S(HEIGHT)    ((HEIGHT)/2.0*((kScreenH)/667.0))
#define kFit_Font6(x)       (kScreenW*((x)/375.0))

//kFont
#define kFont18         [UIFont systemFontOfSize:18.f]
#define kFont17         [UIFont systemFontOfSize:17.f]
#define kFont16         [UIFont systemFontOfSize:16.f]
#define kFont15         [UIFont systemFontOfSize:15.f]
#define kFont14         [UIFont systemFontOfSize:14.f]
#define kFont12         [UIFont systemFontOfSize:12.f]
#define kFont(Num)      [UIFont systemFontOfSize:Num]
#define kFontBold(Num)  [UIFont boldSystemFontOfSize:NUm]

//状态栏样式 he 颜色
#define KStatusBarHidden(StatusBool) [UIAppliction sharedApplication] setStatusBarHidden :StatusBool];
#define KStatusBarStyle(UIStatusBarStyleLightContent) [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];

//主题颜色
#define kNavBarColor kRGBColor(238,231,215)
#define kMianRed kRGBColor(223,56,73)
#define kMainTitleColor kRGBColor(46,47,48)
#define kTitleColor     kRGBColor(151,152,153)
#define kBgGreyColor kRGBColor(246, 247, 248)

//▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼ 颜色 ▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼
//颜色
#define kRGBColor(r, g, b)   [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define kRGBAColor(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]

#define kRandomColor  [UIColor colorWithRed:(arc4random_uniform(256))/255.0 green:arc4random_uniform(256)/255.0 blue:(arc4random_uniform(256))/255.0 alpha:1.0]

#define kHexColor(hex) [UIColor colorWithRed:((float)((hex & 0xFF0000) >> 16)) / 255.0 green:((float)((hex & 0xFF00) >> 8)) / 255.0 blue:((float)(hex & 0xFF)) / 255.0 alpha:1]
#define UIColorFromRGB(argbValue) [UIColor colorWithRed:((float)((argbValue & 0x00FF0000) >> 16))/255.0 green:((float)((argbValue & 0x0000FF00) >> 8))/255.0 blue:((float)(argbValue & 0x000000FF))/255.0 alpha:((float)((argbValue & 0xFF000000) >> 24))/255.0]

//kColor
#define kGreyColor  [UIColor colorWithRed:0.717647 green:0.717647 blue:0.717647 alpha:1.0]
#define kGreyColor1 [UIColor colorWithRed:0.662745 green:0.650980 blue:0.650980 alpha:1.0]
#define kGreyColor2 [UIColor colorWithRed:0.423529 green:0.423529 blue:0.423529 alpha:1.0]
#define kGreyColor3 [UIColor colorWithRed:0.929412 green:0.929412 blue:0.929412 alpha:1.0]
#define kGreyColor4 [UIColor colorWithRed:0.878431 green:0.878431 blue:0.878431 alpha:1.0]
#define kGreyColorN [UIColor colorWithRed:0.509804 green:0.509804 blue:0.509804 alpha:1.0]
#define kWhiteColor  [UIColor whiteColor]
#define kRedColor    [UIColor colorWithRed:0.878431 green:0.003922 blue:0.003922 alpha:1.0]
#define kOrangeColor [UIColor colorWithRed:0.949020 green:0.447059 blue:0.109804 alpha:1.0]
#define kBlackColor  [UIColor blackColor]
#define kBlueColor   [UIColor colorWithRed:0.235294 green:0.556863 blue:0.894118 alpha:1.0]
#define kBorderColor [UIColor colorWithRed:0.815686 green:0.815686 blue:0.815686 alpha:1.0]
#define KGreenColor  [UIColor colorWithRed:0.364706 green:0.635294 blue:0.215686 alpha:1.0]

//颜色
#define C202020  kRGBAColor(32,32,32,1)
#define C030303  kRGBAColor(3,3,3,1)
#define Cf4f4f4  kRGBAColor(244,244,244,1)
#define Cffffff  kRGBAColor(255,255,255,1)
#define C868686  kRGBAColor(134,134,134,1)
#define C404040  kRGBAColor(64,64,64,1)
#define Cfc0f1d  kRGBAColor(252,15,29,1)
#define C25e135  kRGBAColor(37,225,53,1)
#define C2cf8f7  kRGBAColor(44,248,247,1)
#define Cb1b1b1  kRGBAColor(177,177,177,1)
#define C252525  kRGBAColor(37,37,37,1)
#define C3883e0  kRGBAColor(56,131,224,1)
#define C2576db  kRGBAColor(37,119,219,1)
#define Cbfbfbf  kRGBAColor(191,191,191,1)

#define kDefaultUserIcon @"head_nor"
#define kNavBarH (SCREEN_HEIGHT == 812.0 ?88.0f : 64.0f)
#define iPhoneX (SCREEN_HEIGHT == 812.0 ?34 : 0)
#define kNavStateBarH 20.0f
#define kTabBarH 49.0f

#define ZTColor kColor_N(117, 127, 149)

#define USERFZR [[User UserOb].type  isEqual: @"1"]
#endif /* FMBaseMacro_h */
