//
//  UploadPicturesV.h
//  MobileProject
//
//  Created by 向蕾 on 2018/10/31.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import "XLView.h"

NS_ASSUME_NONNULL_BEGIN

@interface UploadPicturesV : XLView
@property (nonatomic , strong)NSMutableArray *dataArr;
@property (nonatomic , strong)NSMutableArray *butArr;
@property (nonatomic , strong)NSMutableArray *imageviewArr;
@property (nonatomic , strong)UIButton *addBut;
@property (nonatomic , assign)int num;
@property (nonatomic , strong)UIViewController *vc;
@property (nonatomic , assign)NSInteger type;  /// 1 可裁剪   0 不可裁剪
- (void)relodData;
@end

NS_ASSUME_NONNULL_END
