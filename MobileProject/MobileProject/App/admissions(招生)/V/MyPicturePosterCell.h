//
//  MyPicturePosterCell.h
//  MobileProject
//
//  Created by 向蕾 on 2018/10/9.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyPicturePosterCell : UICollectionViewCell
@property (nonatomic ,strong)UIImageView *img;
@property (nonatomic , strong)UILabel *title;
@property (nonatomic , strong)UILabel *sub;
@property (nonatomic , strong)UIImageView *typeimg;
@property (nonatomic , strong)FMMainModel *model;
@property (nonatomic , strong)UIButton *share;
@end

NS_ASSUME_NONNULL_END
