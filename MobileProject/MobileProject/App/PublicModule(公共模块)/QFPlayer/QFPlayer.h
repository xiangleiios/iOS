//
//  QFPlayer.h
//
//  QFPlayer
//


#define iPhone4s ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
// 监听TableView的contentOffset
#define kQFPlayerViewContentOffset          @"contentOffset"
// player的单例
#define QFPlayerShared                      [QFBrightnessView sharedBrightnessView]
// 屏幕的宽
#define ScreenWidth                         [[UIScreen mainScreen] bounds].size.width
// 屏幕的高
#define ScreenHeight                        [[UIScreen mainScreen] bounds].size.height
// 颜色值RGB
#define RGBA(r,g,b,a)                       [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
// 图片路径
#define QFPlayerSrcName(file)               [@"QFPlayer.bundle" stringByAppendingPathComponent:file]

#import "QFPlayerView.h"
#import "QFPlayerControlView.h"
#import "QFBrightnessView.h"
#import "QFDownloadManager.h"
#import <Masonry/Masonry.h>
