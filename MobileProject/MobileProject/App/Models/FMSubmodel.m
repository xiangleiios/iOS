//
//  FMSubmodel.m
//  MobileProject
//
//  Created by Mingo on 2017/10/25.
//  Copyright © 2017年 ZSGY. All rights reserved.
//

#import "FMSubmodel.h"

@implementation FMSubmodel
//- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
//    if([key isEqualToString:@"id"])  {
//        self.idid = [value integerValue];
//    }else if([key isEqualToString:@"description"])  {
//        self.descriptionField = value;
//    }
//}
+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"idid":@"id",
             @"description_field":@"description",
             };
}

//- (id)valueForUndefinedKey:(NSString *)key {
//    return nil;
//}

@end
