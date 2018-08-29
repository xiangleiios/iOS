//
//  AVCaptureViewController.h
//  实时视频Demo
//
//  Created by HanJunqiang on 2017/2/16.
//  Copyright © 2017年 HaRi. All rights reserved.
//

#import <UIKit/UIKit.h>
@class IDInfo;
@protocol JQAVCaptureViewControllerDelegate <NSObject>
- (void)cardInformationScanningFM:(IDInfo *)info;
@end
@interface JQAVCaptureViewController : UIViewController
@property (nonatomic , weak)id delegate;
@end

