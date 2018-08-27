//
//  FMSubmodel.h
//  MobileProject
//
//  Created by Mingo on 2017/10/25.
//  Copyright © 2017年 ZSGY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FMSubmodel : NSObject

@property (nonatomic, assign) NSInteger idid;
@property (nonatomic, strong) NSString * description_field;
@property (nonatomic, strong) NSString * title;
@property (nonatomic, strong) NSString * url;
@property (nonatomic, assign) NSInteger amount;
@property (nonatomic, strong) NSString * image_url;
@property (nonatomic, assign) NSInteger percent;
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, assign) NSInteger branch;
@property (nonatomic, assign) NSInteger area;
@property (nonatomic, strong) NSString * file_url;
@property (nonatomic, strong) NSString * content;
@property (nonatomic, strong) NSString * content_title;
@property (nonatomic, strong) NSString * created_at;
@property (nonatomic, strong) NSString * ip;
@property (nonatomic, assign) NSInteger state;
@property (nonatomic, strong) NSString * updated_at;
@property (nonatomic, strong) NSString * username;

@property (nonatomic, strong) NSString * avatar_url;
@property (nonatomic, assign) NSInteger content_type;
@property (nonatomic, assign) NSInteger likes;
@property (nonatomic, strong) NSString * member_name;
@property (nonatomic, strong) NSString * nick_name;

@end
