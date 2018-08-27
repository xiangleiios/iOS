//
//  CommentsModel.h
//  SmallDemo
//
//  Created by 菜鸟 on 15/7/10.
//  Copyright (c) 2015年 菜鸟. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommentsModel : NSObject
@property (nonatomic, strong) NSString * ID;
//@property (nonatomic, strong) NSString * userid;
@property (nonatomic, strong) NSString * member_name;
@property (nonatomic, strong) NSString * content;
@property (nonatomic, strong) NSString * time;
@property (nonatomic, strong)NSString *nick_name;
@property (nonatomic, strong)NSString *avatar_url;

@end
