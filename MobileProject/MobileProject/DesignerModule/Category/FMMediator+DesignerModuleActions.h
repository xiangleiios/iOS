//
//  FMMediator+DesignerModuleActions.h
//  MobileProject
//
//  Created by Mingoy on 16/9/13.
//  Copyright © 2016年 Mingoy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FMMediator.h"
#import "headerDesignerConfig.h"


@interface FMMediator (DesignerModuleActions)

- (UIViewController *)FMMediator_Designer_viewControllerForDetail;

- (UIViewController *)FMMediator_Designer_viewControllerForDetail:(NSDictionary *)params;

@end
