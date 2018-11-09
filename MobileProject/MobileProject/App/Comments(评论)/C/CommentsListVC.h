//
//  CommentsListVC.h
//  MobileProject
//
//  Created by 向蕾 on 2018/11/5.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CommentsListVC : UIViewController
/** 列表page编号 */
@property(nonatomic, assign) NSInteger pageNum;
/** 列表page大小 */
@property(nonatomic, assign) NSInteger pageSize;

@property (nonatomic , strong)NSMutableDictionary *dic;
@property (nonatomic , strong)NSString *url;
@property (nonatomic , assign)NSInteger type;
@property (nonatomic , strong)NSString *deptId;
- (void)headerRefresh;
@end

NS_ASSUME_NONNULL_END
