//
//  UIDevice+Adaptation.m
//  MemoryCard
//
//  Created by 王文辉 on 12-9-22.
//
//

#import "UIDevice+Adaptation.h"

@implementation UIDevice (Adaptation)

+ (BOOL) is_iPhone5
{
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 4.3f) {
        return CGSizeEqualToSize([[UIScreen mainScreen] preferredMode].size,CGSizeMake(640.f, 1136.f));
    }
    return NO;
}

+ (BOOL) is_iOS7
{
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 7.0f) {
        return YES;
    }
    return NO;
}

@end
