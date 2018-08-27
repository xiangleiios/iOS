//
//  PublicModel.h
//  MobileProject
//
//  Created by zsgy on 17/2/27.
//  Copyright © 2017年 Mingoy. All rights reserved.
//

#import <Foundation/Foundation.h>
/*
 *"favorite_id": 1,
 "id": 11,
 "category_id": 7,
 "title": "洪城交通：加油站前违章乱停 红谷滩交警严肃查处",
 "subtitle": "《政法报道》",
 "author": "",
 "tags": "",
 "image_url": "http://zsnc.nctv.net.cn/uploads/images/2017/0108/20170108072032636.jpg",
 "video_url": "http://videofile1.nc.cutv.com/originfile/hls/020052_t/2017/01/07/A14/A14egeejgfimhlngeglvpd_cug.m3u8",
 "images": [],
 "clicks": 0,
 "comments": 0,
 "favorites": 1,
 "time": "2017-01-10 16:56:03"
 */
@interface PublicModel : NSObject
@property (nonatomic , strong)NSString *favorite_id;
@property (nonatomic , strong)NSString *idid;
@property (nonatomic , strong)NSString *category_id;
@property (nonatomic , strong)NSString *title;
@property (nonatomic , strong)NSString *subtitle;
@property (nonatomic , strong)NSString *author;
@property (nonatomic , strong)NSString *tags;
@property (nonatomic , strong)NSString *image_url;
@property (nonatomic , strong)NSString *video_url;
@property (nonatomic , strong)NSArray *images;
@property (nonatomic , strong)NSString *clicks;
@property (nonatomic , strong)NSNumber *comments;
@property (nonatomic , strong)NSString *favorites;
@property (nonatomic , strong)NSString *time;
@end
