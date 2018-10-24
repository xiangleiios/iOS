//
//  FMMainModel.m
//  MobileProject
//
//  Created by Mingo on 2017/10/25.
//  Copyright © 2017年 ZSGY. All rights reserved.
//

#import "FMMainModel.h"


@implementation MineModel

@end

@implementation HomeModel

@end
@implementation TageModel

@end
@implementation FMMainModel
//- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
//    if([key isEqualToString:@"id"]) {
//        self.idid = [value integerValue];
//    }else if([key isEqualToString:@"description"])  {
//        self.descriptionField = value;
//    }
//}
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"idid":@"id",
//             @"description_field":@"description",
             };
}

//+ (NSDictionary *)objectClassInArray {
//    return @{@"images" : [FMSubmodel class],
//             @"replies" : [FMSubmodel class],
//             @"items" : [FMSubmodel class],
//             @"logs" : [FMSubmodel class]
//             };
//}


//- (id)valueForUndefinedKey:(NSString *)key {
//    return nil;
//}
@end


@implementation FMSubmodel
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"idid":@"id",
             @"description_field":@"description",
             };
}
@end





