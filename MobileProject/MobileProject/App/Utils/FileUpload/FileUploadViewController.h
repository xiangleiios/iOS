//
//  FileUploadViewController.h
//  TideNews
//
//  Created by 王文辉 on 14-4-26.
//  Copyright (c) 2014年 王文辉. All rights reserved.
//

#import "FMBaseViewController.h"

@protocol FileUploadViewControllerDelegate;

@interface FileUploadViewController : FMBaseViewController

@property (nonatomic, strong) NSURL *mediaUrl;
@property (nonatomic, strong) UIImage *contentImage;
@property (strong, nonatomic)  UIImageView *contentImageView;
@property (nonatomic, weak) id<FileUploadViewControllerDelegate> delegate;

- (void)actionUpload:(id)sender;

@end



@protocol FileUploadViewControllerDelegate <NSObject>

- (void) fildUploadDone:(NSString *)fileUrl controller:(FileUploadViewController *)fileVC;

@end
