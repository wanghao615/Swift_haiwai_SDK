//
//  Statistics.m
//  KingNetSDK
//
//  Created by admin on 2020/12/10.
//  Copyright © 2020 niujf. All rights reserved.
//

#import "Statistics.h"
#import "StatisticalAnalysisTool.h"
#import <DanaAnalytic/DanaAnalytic.h>

@implementation Statistics

+ (void)configuration {
    [StatisticalAnalysisTool SWConfiguration];
}

+ (NSString *)getDataUUID {
    return [[DanaAnalyticsSDK sharedInstance] getDanaDid] ?: @"";
}

+ (void)registerWithDict: (NSDictionary *)dict {
    [[DanaAnalyticsSDK sharedInstance] registerSuperProperties:dict];
}

+ (void)activation {
    [StatisticalAnalysisTool EventTypeWithType:EventTypeActivation dict:nil];
}

+ (void)dupgrade {
    [StatisticalAnalysisTool EventTypeWithType:EventTypeDupgrade dict:nil];
}

+ (void)clickLoginWithDict: (NSDictionary *)dict {
    [StatisticalAnalysisTool EventTypeWithType:EventTypeClick_login dict:dict];
}

+ (void)clickRegister {
    [StatisticalAnalysisTool EventTypeWithType:EventTypeClick_register dict:@{@"type":@"1"}];
}

+ (void)upAccount {
    [StatisticalAnalysisTool EventTypeWithType:EventTypeUpAccount dict:@{@"type":@"1"}];
}

+ (void)startPayWithDict: (NSDictionary *)dict {
    [StatisticalAnalysisTool EventTypeWithType:EventTypeStartpay dict:dict];
}

+ (void)ecommerce_purchaseWithDict: (NSDictionary *)dict {
    [StatisticalAnalysisTool EventTypeWithType:EventTypeEcommerce_purchase dict: dict];
}

+ (void)fistPayWithDict: (NSDictionary *)dict {
    [StatisticalAnalysisTool EventTypeWithType:EventTypeFirstPay dict: dict];
}

+ (void)payFailWithDict: (NSDictionary *)dict {
    [StatisticalAnalysisTool EventTypeWithType:EventTypePayFail dict: dict];
}

+ (void)cancelPayWithDict: (NSDictionary *)dict {
    [StatisticalAnalysisTool EventTypeWithType:EventTypeCancelpay dict: dict];
}

+ (void)unitEvent:(NSString *)event dict:(NSDictionary *)dict {
    [StatisticalAnalysisTool EventTypeWithEvent:event?:@"" dict:dict];
}

@end
