//
//  CommentController.h
//  MobileProject
//
//  Created by zsgy on 17/2/28.
//  Copyright © 2017年 Mingoy. All rights reserved.
//

typedef NS_ENUM(NSInteger, ComeFrom) {
    ComeFromNative = 1, //从原生页面push来
    ComeFromH5 ,        //从H5页面push来
};
@class CommentBtn;
@interface CommentController : UIViewController
@property (nonatomic, strong)CommentBtn * commentBtn;
@property (nonatomic, strong) NSString * ID;
@property (nonatomic, assign) ComeFrom comefrom;

@end
