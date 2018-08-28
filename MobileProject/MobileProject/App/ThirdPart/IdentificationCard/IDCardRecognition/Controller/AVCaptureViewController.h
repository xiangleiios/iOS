//
//  AVCaptureViewController.h
//  实时视频Demo
//
//  Created by HanJunqiang on 2017/2/16.
//  Copyright © 2017年 HaRi. All rights reserved.
//
//  

#import <UIKit/UIKit.h>
@class IDInfo;
@protocol AVCaptureViewControllerDelegate <NSObject>
- (void)cardInformationScanning:(IDInfo *)info;
@end

@interface AVCaptureViewController : UIViewController
@property (nonatomic , weak)id delegate;
@end

