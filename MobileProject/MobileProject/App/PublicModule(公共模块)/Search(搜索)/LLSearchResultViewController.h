//
//  LLSearchResultViewController.h
//  LLSearchView
//
//  Created by 王龙龙 on 2017/7/25.
//  Copyright © 2017年 王龙龙. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LLSearchResultViewController : UIViewController

@property (nonatomic, copy) NSString *searchStr;
@property (nonatomic, strong) NSMutableArray *hotArray;
@property (nonatomic, strong) NSMutableArray *historyArray;
@property (nonatomic , assign)BOOL PayCost;
@property (nonatomic , assign)SearchType type; /// 搜索类型  
@end
