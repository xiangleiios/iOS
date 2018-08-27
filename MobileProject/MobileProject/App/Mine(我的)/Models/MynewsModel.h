//
//  MynewsModel.h
//  MobileProject
//
//  Created by zsgy on 17/2/27.
//  Copyright © 2017年 Mingoy. All rights reserved.
//

#import <Foundation/Foundation.h>
/*
 *"id": 10,
 "type": 1,
 "title": "Sit velit odio a.",
 "time": "2017-02-27 11:23:58"
 */
@interface MynewsModel : NSObject
@property (nonatomic , strong)NSString *idid;
@property (nonatomic , strong)NSString *type;
@property (nonatomic , strong)NSString *title;
@property (nonatomic , strong)NSString *time;
@end
