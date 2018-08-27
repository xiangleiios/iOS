//
//  FMPlaceholdTextView.h
//  MobileProject
//
//  Created by Mingo on 2017/9/5.
//  Copyright © 2017年 ZSGY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FMPlaceholdTextView : UITextView
@property(nonatomic, copy) NSString *placeholderText;
@property (nonatomic, strong) UIColor *placeholderColor;
@end
