//
//  XLInformationV.h
//  MobileProject
//
//  Created by 向蕾 on 2018/8/17.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^SenterBlcok) ();
@interface XLInformationV : XLView
@property (nonatomic , copy)SenterBlcok senterBlock;
@property (nonatomic , strong)UITextField *subfield;
@property (nonatomic , strong)UILabel *titlelb;
@property (nonatomic , strong)UILabel *red;
/// 信息输入条 must:是否为必填 Click:是否可点击
-(instancetype)informationWithTitle:(NSString *)title SubTitle:(NSString *)subtitle TSSubTitle:(NSString *)tssubtitle Must:(BOOL)must Click:(BOOL)click;


/// 信息条 显示标题 副标题
-(instancetype)informationWithTitle:(NSString *)title SubTitle:(NSString *)subtitle;

/// 信息条 显示标题 副标题  副标题过长时自动换行
-(instancetype)informationHeightWithTitle:(NSString *)title SubTitle:(NSString *)subtitle;

/// 图片文字带点击的视图 标题，副标题上下分部
-(instancetype)informationWithTitle:(NSString *)title SubTitle:(NSString *)subtitle ImageName:(NSString *)img;

/// 图片文字带点击的视图 标题，副标题水平分部
-(instancetype)informationLevelWithTitle:(NSString *)title SubTitle:(NSString *)subtitle ImageName:(NSString *)img;

/// 信息头部标签
-(instancetype)informationWithTitle:(NSString *)title;

/// 白色信息头  可带按钮
-(instancetype)informationWithTitle:(NSString *)title ButTile:(NSString *)butTitle ButImg:(NSString *)img;

/// 课程信息
-(instancetype)informationWithTitle:(NSString *)title CarType:(NSString *)cartype SubTitle:(NSString *)subtitle Price:(NSString *)price;

/// 学员详情中的信息头
-(instancetype)informationStudentsWithTitle:(NSString *)title;

/// 分校详情的招生头部信息条
-(instancetype)informationWithTitle:(NSString *)title Subtitle:(NSString *)subtitle Must:(BOOL)must;
@end
