//
//  FMJS.h
//  MobileProject
//
//  Created by 向蕾 on 2018/9/14.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol AppJSObjectDelegate <JSExport>

-(void)submit:(NSString *)message ID:(NSString *)idid;

@end
@interface FMJS : NSObject<AppJSObjectDelegate>
@property(nonatomic,weak) id<AppJSObjectDelegate> delegate;
@end
