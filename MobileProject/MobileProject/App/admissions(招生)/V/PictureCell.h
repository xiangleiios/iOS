//
//  PictureCell.h
//  MobileProject
//
//  Created by 向蕾 on 2018/10/8.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol RemarksCellDelegate <NSObject>

- (void)remarksCellShowContrntWithDic:(NSDictionary *)dic andCellIndexPath:(NSIndexPath *)indexPath;

@end
@interface PictureCell : UITableViewCell
{
    NSIndexPath *_cellIndexPath;  // 当前Cell的下标
}
@property (nonatomic, weak) id<RemarksCellDelegate> delegate;
@property (nonatomic ,strong)FMMainModel *model;
@property (nonatomic , strong)UIImageView *head;
@property (nonatomic , strong)UILabel *name;
@property (nonatomic , strong)UILabel *frome;
@property (nonatomic , strong)UILabel *content;
@property (nonatomic , strong)UIButton *show;
@property (nonatomic , strong)UILabel *num;
@property (nonatomic , strong)XLView *imgbavk;
@property (nonatomic , strong)UILabel *biaoqian;
@property (nonatomic , strong)NSMutableArray *browseItemArray;
@property (nonatomic , strong)UIImageView *typeImg;

@property (nonatomic , strong)UILabel *lb;
- (void)setCellContent:(NSString *)contentStr andIsShow:(BOOL)isShow andCellIndexPath:(NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END
