//
//	ModelGuaideIma.h
//
//	Create by Mingo 袁凤鸣 on 5/6/2017
//	Copyright © 2017. All rights reserved.
//

//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

#import <UIKit/UIKit.h>

@interface ModelGuaideIma : NSObject

@property (nonatomic, strong) NSString * author;
@property (nonatomic, assign) NSInteger clicks;
@property (nonatomic, assign) NSInteger comments;
@property (nonatomic, assign) NSInteger favorites;
@property (nonatomic, assign) NSInteger idid;
@property (nonatomic, strong) NSString * imageUrl;
@property (nonatomic, strong) NSArray * images;
@property (nonatomic, assign) NSInteger isTop;
@property (nonatomic, strong) NSString * keywords;
@property (nonatomic, strong) NSString * link;
@property (nonatomic, assign) NSInteger linkType;
@property (nonatomic, strong) NSString * liveUrl;
@property (nonatomic, strong) NSString * source;
@property (nonatomic, strong) NSString * subtitle;
@property (nonatomic, strong) NSString * summary;
@property (nonatomic, strong) NSString * tags;
@property (nonatomic, strong) NSString * time;
@property (nonatomic, strong) NSString * timeTrans;
@property (nonatomic, strong) NSString * title;
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, strong) NSString * videoDuration;
@property (nonatomic, strong) NSString * videoUrl;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

- (NSDictionary *)toDictionary;
@end
