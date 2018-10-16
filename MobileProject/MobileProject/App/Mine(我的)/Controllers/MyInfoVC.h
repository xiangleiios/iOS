//
//  MyInfoVC.h
//  MobileProject
//
//  Created by zsgy on 2017/10/30.
//  Copyright © 2017年 ZSGY. All rights reserved.
//

#import "FMBaseViewController.h"
#import "FMMineVC.h"
@protocol MyInfoVCDelegate <NSObject>//协议

- (void)headerImageOrNikeNameChange:(NSInteger)type;//协议方法 0/toux 1/name

@end
@interface MyInfoVC : FMBaseViewController
@property (nonatomic , strong)id<MyInfoVCDelegate> delegate;
@property (nonatomic , strong)FMMineVC *vc;
@end
