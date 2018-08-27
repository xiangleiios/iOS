//
//  XLSmV.h
//  FSZX
//
//  Created by zsgy on 16/11/8.
//  Copyright © 2016年 王文辉. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface XLSmV : UIView
@property (nonatomic, strong) CALayer *basedLayer;
@property (nonatomic, strong) AVCaptureDevice *device;
/** 扫描动画线(冲击波) */
@property (nonatomic, strong) UIImageView *animation_line;
@property (nonatomic, strong) NSTimer *timer;



- (instancetype)initWithFrame:(CGRect)frame outsideViewLayer:(CALayer *)outsideViewLayer;

+ (instancetype)scanningQRCodeViewWithFrame:(CGRect )frame outsideViewLayer:(CALayer *)outsideViewLayer;

/** 移除定时器(切记：一定要在Controller视图消失的时候，停止定时器) */
- (void)removeTimer;
@end
